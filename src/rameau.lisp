(defpackage :rameau-tools
  (:use #:cl #:rameau #:it.bese.arnesi)
  (:export #:main)
  #+sbcl(:import-from #:sb-ext #:*posix-argv*))
(in-package :rameau-tools)

;;; As funções dependentes de implementação devem ficar aqui
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun rameau-args ()
  (let ((sbcl-args #+sbcl *posix-argv*)
        (cmu-args #+cmu extensions:*command-line-strings*)
        (clisp-args #+clisp *args*))
    (cond (sbcl-args (rest sbcl-args))
          (cmu-args (subseq cmu-args (1+ (position "cmurameau" cmu-args :test #'string=))))
          (clisp-args clisp-args)
          (t (error "algum problema com argumentos")))))

(defun rameau-path ()
  (format nil "~a" (or #+sbcl *default-pathname-defaults*
                       #+cmu (first (ext:search-list "default:"))
                       #+clisp (ext:default-directory))))

(defun rameau-profile ()
  #+sbcl(progn
         (setf sb-profile::*print-functions-not-called* nil)
         (sb-profile:profile "RAMEAU")
         (sb-profile:profile "RAMEAU-TEMPERLEY")
         (sb-profile:profile "RAMEAU-PARDO")
         (sb-profile:profile "GENOSLIB"))
  #+cmu (progn
          (profile:profile-all :package "RAMEAU")
          (profile:profile-all :package "RAMEAU-TEMPERLEY")
          (profile:profile-all :package "RAMEAU-PARDO")
          (profile:profile-all :package "GENOSLIB")))

(defun rameau-report ()
  #+sbcl(sb-profile:report)
  #+cmu(profile:report-time))

(defun rameau-quit ()
  #+clisp(ext:exit)
  #+sbcl(quit))

(defun read-user-config ()
  (aif (cl-fad:file-exists-p (concat "/home/" #+sbcl(sb-ext:posix-getenv "USER") "/.rameaurc"))
       ;; TODO: checa se arquivo está vazio
       (with-open-file (s it)
         (read s))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defparameter max-print-error 10
  "Quando o numero de arquivos que não são parseados é maior que essa
  constante, rameau mostra apenas o inicio da lista.")

(defparameter *help* '((todos
                        (("-h" "ajuda")
                         ("-f" "arquivos")
                         ("-p" "profile")
                         ("-a <algoritmos>" "Usa <algoritmos> para fazer a análise")
                         ("-x i" "ativa código de depuração para os itens i")
                         ("-v" "verbose")
                         ("-t <funções>" "mostra o trace de <funções>")
                         ("-m n" "o número de testes errados para imprimir")))
                       (análise
                        (("-l" "mostra formato de gabarito como listas")
                         ("-i" "ignora (não imprime) corais sem gabaritos")))
                       (partitura)))

(defparameter *lily-dir-list*
  (aif (read-user-config)
       it
       '(("corais" "corais/")
         ("kostka" "literatura/kostka-payne/")
         ("sonatas" "literatura/beethoven-sonatas/")
         ("exemplos" "exemplos/")
         ("regressao" "regressao/")
         ("lily" "regressao-lily/")
         ("corais-include" "literatura/bach-corais/"))))

(defparameter *gabarito-dir-list*
  (aif (read-user-config)
       it
       '(("corais" "gabaritos/bach-corais/"))))

(defparameter *dados* '((teste ("unidade" "regressao" "lily"))
                        (analise ("corais" "kostka" "sonatas" "exemplos"))
                        (partitura ("corais"))))


(defun percent (x total)
  (unless (= 0 total)
    (/ (* x 100.0) total)))

(defun get-item (item lista &optional (test #'eql))
  "Pega um item em uma lista de associação."
  (second (assoc item lista :test test)))

(defun char->symbol (char)
  "Retorna o símbolo representado pelo caractere char.
Exemplo: (char->symbol #\a) => A"
  (intern (string-upcase (string char)) :rameau-tools))

(defun split-word (word)
  "Retorna uma lista de símbolos para cada letra da palavra 'word'.
Exemplo: (split-word \"foo\") => (F O O)"
  (loop for char across word collect (char->symbol char)))

(defun split-opts (string)
  (mapcan (lambda (s) (split-word (delete #\- s)))
          (cl-ppcre:split #\Space string)))

(defun split-dados (dados)
  (cl-ppcre:split "," dados))

(defmacro with-profile (var &body body)
  `(progn
     (when (member 'p ,var)
       (rameau-profile))
     ,@body
     (when (member 'p ,var)
       (rameau-report))))

(defun next-flag (list)
  (loop for x in (rest list) do
       (if (equal #\- (aref x 0))
           (return x))))

(defun pos (list)
  (aif (position (next-flag list) list :test #'string=) it 0))

(defun arg->list (list)
  (when list
    (if (next-flag list)
        (let ((p (pos list)))
          (cons (subseq list 0 p)
                (arg->list (nthcdr p list))))
        (list list))))

(defun get-lone-flags (list)
  (exclude-repetition
   (mapcan (lambda (item) (split-opts (first item)))
           (remove-if-not (lambda (item) (= (length item) 1)) list))))

(defun get-flag-list (flag list)
  (rest (assoc flag list :test #'string=)))

(defun maptrace (lista-string)
  (eval (append '(trace) (mapcar (compose #'read-from-string #'string-upcase) lista-string))))

(defun get-comandos ()
  (mapcar #'(lambda (item) (format nil "~(~a~)" (first item))) *dados*))

(defun parse-verbose (files)
  (dolist (file files)
    (handler-case (parse-file file)
      (serious-condition (expr) (print-condition 'no file expr))
      (:no-error (&rest rest) (print-condition 'ok file rest)))))

(defun parse-summary (files)
  (let (ok no)
    (dolist (file files)
      (handler-case (parse-file file)
        (serious-condition (expr)
          (declare (ignore expr))
          (push (pathname-name file) no))
        (:no-error (&rest rest)
          (declare (ignore rest))
          (push (pathname-name file) ok))))
    (list (reverse ok) (reverse no))))

(defun files-range (list)
  (loop for x from (parse-integer (first list)) to (parse-integer (second list))
     collect (cond ((< x 10)  (format nil "00~a" x))
                   ((< x 100) (format nil "0~a" x))
                   (t (format nil "~a" x)))))

(defun first-string (string list)
  (let ((tmp (loop for s in list do
                  (if (string= (subseq s 0 1) string)
                      (return s)))))
    (if tmp tmp string)))

(defun print-condition (status file expr)
  (format t "[~a] ~a: ~a~%" status (pathname-name file) expr))

(defun print-ok/no-list (list)
  (destructuring-bind (ok no) list
    (let* ((s2 (length no))
           (no-string
            (cond ((= max-print-error 0) no)
                  ((> s2 max-print-error)
                   (format nil "~a ..." (subseq no 0 max-print-error)))
                  (t no))))
      (format t "  [OK]: ~a [NO]: ~a ~@[~a ~]~%" (length ok) s2 no-string))))

(defun print-chord (list flags)
  (if (member 'l flags)
      list
      (acorde->cifra list)))

;; BUG: ok? não imprime por cause do (not f)
(defun print-gab-columns (a b c d flags)
  (let ((string (if (member 'l flags)
                    "~4a~@[~15a~]~(~15a~)~@[~10a~]|"
                    "~4a~@[~15a~]~10a~@[~10a~]|")))
    (format t string
            a
            (when (member 'v flags) b)
            c
            (when (member 'v flags) (if (listp d) (second d) d)))))

(defun print-res-alg (alg res flags)
  (let ((string (if (member 'l flags)
                    "~(~15a~)~:[*~; ~]|"
                    "~10a~:[*~; ~]|")))
    (format t string
            alg
            res)))

(defun frac->dur-lily (dur)
  "Converte de fração para duração em lilypond. É muito simples, não
lida com quiáltera nem mais que 1 ponto, felizmente não tem mais de 1
ponto nos corais de bach."
  (let ((numer (numerator dur))
        (denom (denominator dur)))
    (cond ((= numer 1) (format nil "~a" denom))
          ((= numer 3) (format nil "~a." (/ denom 2)))
          (t (split-dur numer denom)))))

(defun intervalo (s1 s2)
  "Retorna o intervalo entre dois segmentos."
  (if (null s2)
      0
      (- (evento-inicio (first s2))
         (fim-evento (first s1)))))

(defun print-duracoes (segmento)
  (loop for s = segmento then (rest s)
     unless s return res
     collect (frac->dur-lily (evento-dur (first (first s)))) into res
     unless (= 0 (intervalo (first s) (second s)))
       collect (frac->dur-lily (intervalo (first s) (second s))) into res))
       

(defun print-score (stream lyric)
  (format stream "\\score {
  <<
    \\new Staff {
      <<
        \\global
        \\new Voice = \"soprano\" { \\voiceOne \\soprano }
        \\new Voice = \"alto\" { \\voiceTwo \\alto }
      >>
    }
    \\new Staff {
      <<
        \\global
        \\clef \"bass\"
        \\new Devnull= \"nowhere\" \\texto
        \\new Voice = \"tenor\" {\\voiceOne \\tenor }
        \\new Voice = \"baixo\" { \\voiceTwo \\baixo \\bar \"|.\"}
      >>
    }
   ~a
  >>

  \\layout {
    \\context {
      \\Lyrics
      \\override LyricSpace #'minimum-distance = #1.0
      \\override LyricText #'font-size = #-1
      %\\override LyricText #'font-name = #\"Bitstream Vera Serif\"
    }
  }
  \\midi {}
}~%~%" lyric))

(defun print-lyric (name)
  (format nil "\\new Lyrics \\lyricsto \"nowhere\" \\~a~%" name))

(defmacro with-print-cifra ((stream name) &body body)
  `(progn
     (format ,stream "~a = \\lyricmode {
  \\set stanza = \"~a:\"
" ,name ,name)
     ,@body
     (format ,stream "~%}~%~%")))

(defun print-lily (file gabarito resultados  flags notas)
  (let* ((*package* (find-package :rameau))
         (path (concat (rameau-path)
                       (get-item "corais-include" *lily-dir-list*  #'equal)))
         (file-name (pathname-name file))
         (dir (get-item "corais" *lily-dir-list* #'equal))
         (out-file (format nil "~a/~a/coral-~a.ly" (rameau-path) dir file-name)))
    (with-open-file (stream out-file :direction :output :if-exists :supersede)
      (format stream "~a~%" (file-string (concat path file-name ".lyi")))
      (format stream "texto = {~{c~a ~}}~%~%" (print-duracoes notas))
      (when gabarito
        (with-print-cifra (stream "gabarito")
          (loop for i in gabarito
             for s = notas then (rest s)
             unless s return it
             do (format stream "\"~a\" " (acorde->cifra i))
             unless (= 0 (intervalo (first s) (second s)))
             do (format stream "\" \" "))))
      (loop for a in *algoritmos*
         for r in resultados do
           (with-print-cifra (stream (algoritmo-nome a))
             (loop
                for alg-lista = r then (rest alg-lista)
                for gab-lista = gabarito then (rest gab-lista)
                for s = notas then (rest s)
                for res = (first alg-lista) then (first alg-lista)
                for gab = (first gab-lista) then (first gab-lista)
                unless s return 0
                unless alg-lista return 0
                if (funcall (algoritmo-compara a) res gab) do
                  (format stream "\"~a\" " (if res (acorde->cifra res) " "))
                else do
                  (format stream "\\markup{\\with-color #(x11-color 'red) \"~a\"}"
                          (if res (acorde->cifra res) " "))
                unless (= 0 (intervalo (first s) (second s))) do
                  (format stream "\" \""))))
      (with-print-cifra (stream "particoes")
        (loop for x from 1
           for s = notas then (rest s)
           unless s return 0
           do (format stream "\"~a\" " x)
           unless (= 0 (intervalo (first s) (second s)))
           do (format stream "\"~a\" " x)))
      (print-score stream (reduce #'concat
                                  (append
                                   (list (print-lyric "particoes"))
                                   (loop for a in *algoritmos* collect
                                        (print-lyric (algoritmo-nome a)))
                                   (list
                                    (when gabarito
                                      (print-lyric "gabarito")))))))))

(defun print-gabarito (gabarito resultados flags &key notas dur)
  (let ((*package* (find-package :rameau))
        (size-gab (length gabarito)))
    (print-gab-columns "#" "notas" "gab" "dur" flags)
    (loop for a in *algoritmos*
       do (print-res-alg (algoritmo-nome a) "ok?" flags))
    (format t "~%")
    (write-line (repeat-string 80 "-"))
    (let ((counts (repeat-list (length *algoritmos*) 0)))
      (loop
         for n in notas
         for d in dur
         for numero-seg from 0
         for gab-lista = gabarito then (cdr gab-lista)
         for gab = (car gab-lista) then (car gab-lista)
         for res = resultados then (avanca-todos res)
         do
           (print-gab-columns (1+ numero-seg) n (if gab (print-chord gab flags)) d flags)
           (loop
              for a in *algoritmos*
              for i from 0
              for r in res
              for alg = (first r) then (first r)
              for certo? = (funcall (algoritmo-compara a) alg gab)
              then (funcall (algoritmo-compara a) alg gab)
              do (print-res-alg (if alg (print-chord alg flags)) certo? flags)
              when certo? do (incf (nth i counts)))
           (format t "~%"))
      (format t "~% correto:~%")
      (loop  for i in counts
         for a in *algoritmos* do
           (format t "  ~a: ~a%~%" (algoritmo-nome a) (percent i size-gab))))))

(defun print-help-item (item)
  (format t "~%~(* [~a]~)~%" item)
  (dolist (line (get-item item *help*))
    (destructuring-bind (flag string &optional v) line
      (format t "  ~6a~a ~@[(implica em ~a)~]~%" flag string v))))
  
(defun print-help ()
  (format t "USO: rameau <ação> [dados] [opções]~%~%")
  (dolist (item *dados*)
    (format t "     ~13a~{~a~^,~}~%" (first item) (second item)))
  (dolist (item (mapcar #'first *help*))
    (print-help-item item))
  (rameau-quit))

(defun run-regressao (flags files)
  (if (member 'v flags)
      (parse-verbose files)
      (print-ok/no-list (parse-summary files))))

(defun run-unidade (flags files)
  (declare (ignore files))
  (let ((string-result
         (with-output-to-string (string)
           (let ((*standard-output* string))
             (lisp-unit:run-all-tests :rameau)
             (format t "~%")))))    
    (if (member 'v flags)
        (write-line string-result)
        (write-line (subseq (last1 (cl-ppcre:split "\\n" string-result)) 34)))))

(defun processa-gabarito (file)
  "Transforma um gabarito de texto em sexp."
  (let* ((*package* (find-package :rameau))
         (nome-pop (concat (get-item "corais" *gabarito-dir-list* #'equal)
                           (add-pop-ext (pathname-name file)))))
    (when (cl-fad:file-exists-p nome-pop)
      (read-file-as-sexp nome-pop))))

(defun run-compara-gabarito (flags files)
  (with-system rameau:tempered
    (let (ok no)
      (dolist (file files)
        (let* ((musica (parse-file file))
               (segmentos (segmentos-minimos musica))
               (resultados (loop for a in *algoritmos* collect
                                (funcall (algoritmo-processa a) segmentos)))
               (gabarito (processa-gabarito (tira-extensao file)))
               (file-name (pathname-name file))
               (notas (mapcar #'lista-notas segmentos))
               (duracoes (calcula-duracoes segmentos)))
          (format t "tamanhos:~%  gabarito: ~a~%" (length gabarito))
          (loop for i in resultados
             for a in *algoritmos*
             do (format t "  ~a: ~a~%" (algoritmo-nome a) (length i)))
          (cond
            ((and (not gabarito) (not (member 'i flags)))
             (format t "~&[ERRO] o gabarito de ~a não existe~%" file-name))
            ((member 'v flags)
             (print-gabarito gabarito resultados
                             flags :dur duracoes :notas notas)))))
      (unless (member 'v flags)
        (print-ok/no-list (list (reverse ok) (reverse no)))))))

(defun run-partitura (flags files)
  (when (member 'v flags) (format t "gerando "))
  (with-system rameau:tempered
    (dolist (file files)
      (when (member 'v flags) (format t "~a " (pathname-name file)))
      (let* ((gabarito (processa-gabarito (tira-extensao file)))
             (segmento (segmentos-minimos (parse-file file)))
             (resultados (loop for a in *algoritmos* collect
                               (funcall (algoritmo-processa a) segmento))))
        (print-lily file gabarito resultados flags segmento)))))
  
(defun processa-files (item f &optional (ext ".ly"))
  (let* ((path (concat (rameau-path) (get-item item *lily-dir-list*  #'equal)))
         (file-name (format nil "~a" (first f)))
         (files (if (search ".." file-name)
                    (files-range (cl-ppcre:split "\\.\\." file-name))
                    f)))
    (if files
        (mapcar (lambda (file) (concat path file ext)) files)
        (mapcar (lambda (file) (format nil "~a" file)) (directory (concat path "*" ext))))))

(defmacro defcomando (nome dados flags files &body body)
  `(defun ,nome (,dados ,flags ,files)
     (let* ((dados-list (get-item ',nome *dados*))
            (comandos-lista (if (string= ,dados "all") dados-list (split-dados ,dados))))
       (with-profile ,flags
         (loop
            for i in comandos-lista
            for item = (first-string i dados-list) do
              (if (member item dados-list :test #'string=)
                  (progn
                    (format t "~%* ~(~a~): ~(~a~)~%" ',nome item)
                    ,@body)
                  (progn
                    (format t "~a não é um comando de ~(~a~).~%" item ',nome)
                    (format t "comandos possíveis são: all ~{~a ~}~%" dados-list))))))))

(defcomando teste dados flags files
    (if (string= item "unidade")
        (run-unidade flags (processa-files item files))
        (run-regressao flags (processa-files item files))))

(defcomando analise dados flags files
  (run-compara-gabarito flags (processa-files item files)))

(defcomando partitura dados flags files
  (run-partitura flags (processa-files item files)))

(defun main ()
  (let* ((args (rameau-args))
         (string (first args))
         (dados (second args))
         (comando (if string (first-string string (get-comandos))))
         (flags-list (if (> (length args) 2) (arg->list (subseq args 2))))
         (files (get-flag-list "-f" flags-list))
         (trace (get-flag-list "-t" flags-list))
         (algoritmos (get-flag-list "-a" flags-list))
         (debug (get-flag-list "-x" flags-list))
         (max-error (first (get-flag-list "-m" flags-list)))
         (flags (if flags-list (get-lone-flags flags-list))))

    (when debug
      (loop for item in debug do
           (rameau-debug (intern (string-upcase item) :rameau))))
    (when trace (maptrace trace))
    (when max-error (setf max-print-error (read-from-string max-error)))
    (when (member 'h flags) (print-help))
    (when algoritmos
      (setf *algoritmos* (filtra-algoritmos algoritmos)))
    (cond ((null comando) (print-help))
          ((equal comando "help") (print-help))
          ((equal comando "-h") (print-help))
          ((and (null dados) (string= comando "teste"))
           (teste "all" flags files))
          ((and comando (null dados))
           (if (member comando (get-comandos) :test #'string=)
               (format t "as opções de ~a são: ~{~a ~}~%"
                       comando
                       (get-item (intern (string-upcase comando)) *dados*))
               (progn
                 (format t "comando ~a não reconhecido~%" comando)
                 (format t "você deve entrar um dos comandos: ~{~(~a~)~^ ~}~%"
                         (get-comandos)))))
          ((member comando (get-comandos) :test #'string=)
           (funcall (symbol-function (intern (string-upcase comando) :rameau-tools)) dados flags files))
          (t (format t "comando ~a não reconhecido~%" comando)
             (format t "você deve entrar um dos comandos: ~{~(~a~)~^ ~}~%"
                     (get-comandos)))))
  0)

