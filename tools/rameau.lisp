#+sbcl(declaim (sb-ext:muffle-conditions warning style-warning sb-ext:compiler-note))

#+cmu(setf ext::*complain-about-illegal-switches* nil)

(declaim (optimize (compilation-speed 0)
                   (debug 3)
                   (safety 3)
                   (space 1)
                   (speed 1)))


(asdf:oos 'asdf:load-op :rameau :verbose nil)

(defpackage :rameau-tools
  (:use #:cl #:rameau #:it.bese.arnesi #:rameau-pardo #:rameau-temperley)
  (:export #:main)
  (:import-from #:sb-ext #:*posix-argv*))
(in-package :rameau-tools)

;;; As funções dependentes de implementação devem ficar aqui
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun rameau-args ()
  (let ((sbcl-args #+sbcl *posix-argv*)
        (cmu-args #+cmu extensions:*command-line-strings*)
        (clisp-args #+clisp *args*))
    (cond (sbcl-args (rest sbcl-args))
          (cmu-args (subseq cmu-args 3))
          (clisp-args clisp-args)
          )))

(defun rameau-path ()
  (format nil "~a" (or #+sbcl *default-pathname-defaults*
                       #+cmu (first (ext:search-list "default:"))
                       #+clisp (ext:default-directory))))

(defun rameau-profile ()
  #+sbcl(sb-profile:profile "RAMEAU")
  #+cmu(profile:profile-all :package "RAMEAU"))

(defun rameau-report ()
  #+sbcl(sb-profile:report)
  #+cmu(profile:report-time))

(defun rameau-quit ()
  #+clisp(ext:exit)
  #+sbcl(quit))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defparameter max-print-error 10
  "Quando o numero de arquivos que não são parseados é maior que essa
  constante, rameau mostra apenas o inicio da lista.")

(defparameter *help* '((todos
                        (("-h" "ajuda")
                         ("-f" "arquivos")
                         ("-p" "profile")
                         ("-d" "debug")
                         ("-v" "verbose")
                         ("-m n" "o número de testes errados para imprimir")))
                       (análise
                        (("-g" "compara com gabarito")
                         ("-n" "mostra as notas de cada segmento" "-v")
                         ("-d" "mostra as durações de cada segmento" "-v")
                         ("-l" "mostra formato de gabarito como listas" "-v")
                         ("-e" "só mostra os testes que tem erro" "-v")
                         ("-c" "só mostra os testes corretos" "-v")
                         ("-i" "ignora (não imprime) corais sem gabaritos")
                         ("-t" "roda metrica de temperley na musica (debug)")))
                       (partitura
                        (("-n" "imprime número de partições")
                         ("-g" "imprime gabarito")
                         ("-a" "imprime análise (pardo)")
                         ("-t" "imprime tudo")))))

(defun read-user-config ()
  (aif (cl-fad:file-exists-p (concat "/home/" (sb-ext:posix-getenv "USER") "/.rameaurc"))
       ;; TODO: checa se arquivo está vazio
       (with-open-file (s it)
         (read s))))

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

(defparameter *dados* '((teste ("unidade" "regressao" "lily"))
                        (analise ("corais" "kostka" "sonatas" "exemplos"))
                        (partitura ("corais"))))

(defun percent (x total)
  (/ (* x 100.0) total))

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
  (eval (append '(trace) (mapcar #'string->symbol lista-string))))

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
(defun print-gab-columns (a b c d e f flags)
  (let ((string (if (member 'l flags)
                    "~4a~@[~15a~]~(~30a~)~(~15a~)~@[~10a~]~@[*~]~%"
                    "~4a~@[~15a~]~10a~10a~@[~10a~]~@[*~]~%")))
    (format t string
            a
            (when (member 'n flags) b)
            c
            d
            (when (member 'd flags) (if (listp e) (second e) e))
            (not f))))

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

(defun print-lily (flags file gabarito algoritmo comparacao segmento)
  (let* ((*package* (find-package :rameau))
         (path (concat (rameau-path)
                       (get-item "corais-include" *lily-dir-list*  #'equal)))
         (file-name (pathname-name file))
         (dir (get-item "corais" *lily-dir-list* #'equal))
         (out-file (format nil "~a/~a/coral-~a.ly" (rameau-path) dir file-name)))
    (with-open-file (stream out-file :direction :output :if-exists :supersede)
      (format stream "~a~%" (file-string (concat path file-name ".lyi")))
      (format stream "texto = {~{c~a ~}}~%~%" (print-duracoes segmento))
      (when (member 't flags)
        (push 'g flags)
        (push 'a flags)
        (push 'n flags))
      (when (and gabarito (member 'g flags))
        (with-print-cifra (stream "gabarito")
          (loop for i in gabarito
             for s = segmento then (rest s)
             unless s return it
             do (format stream "\"~a\" " (acorde->cifra i))
             unless (= 0 (intervalo (first s) (second s)))
             do (format stream "\" \" "))))
      (when (member 'a flags)
        (with-print-cifra (stream "pardo")
          (loop 
             for pardo-lista = algoritmo then (rest pardo-lista)
             for gab-lista = gabarito then (rest gab-lista)
             for s = segmento then (rest s)
             for pardo = (first pardo-lista) then (first pardo-lista)
             for gab = (first gab-lista) then (first gab-lista)
             unless s return 0
             unless pardo-lista return 0
             if (compara-gabarito-pardo pardo gab) do
               (format stream "\"~a\" " (if pardo (acorde->cifra pardo) " "))
             else do
               (format stream "\\markup{\\with-color #(x11-color 'red) \"~a\"}"
                       (if pardo (acorde->cifra pardo) " "))
             unless (= 0 (intervalo (first s) (second s)))
               do (format stream "\" \""))))
      (when (member 'n flags)
        (with-print-cifra (stream "particoes")
          (loop for x from 1
             for s = segmento then (rest s)
             unless s return 0
             do (format stream "\"~a\" " x)
             unless (= 0 (intervalo (first s) (second s)))
             do (format stream "\"~a\" " x))))
      (print-score stream (concat (when (member 'n flags) (print-lyric "particoes"))
                                  (when (member 'a flags) (print-lyric "pardo"))
                                  (when (and gabarito (member 'g flags))
                                        (print-lyric "gabarito")))))))

(defun print-gabarito (file gabarito algoritmo comparacao flags &key notas dur)
  (let ((*package* (find-package :rameau)))
    (print-gab-columns "#" "notas" "gab" "pardo" "dur" "ok?" flags)
    (write-line (repeat-string 80 "-"))
    (let ((count-ok 0)
          (size-gab (length gabarito))
          (size-algo (length algoritmo))
          (wrong-list))
      (loop
         for n in notas
         for d in dur
         for numero-seg from 0
         for pardo in algoritmo
         for gab in gabarito
         for result = (when (and pardo gab)
                        (compara-gabarito-pardo pardo gab))
         then (when (and pardo gab)
                (compara-gabarito-pardo pardo gab))
         if result do (incf count-ok)
         else do (push numero-seg wrong-list)
         do
           (print-gab-columns
            (1+ numero-seg)
            n
            (if gab (print-chord gab flags))
            (if pardo (print-chord pardo flags))
            d
            result
            flags))
      (format t "~%~$ % correto, gab: ~a, pardo: ~a~%"
              (percent count-ok size-gab) size-gab size-algo)
      (format t "segmentos errados: ~a~%" (nreverse wrong-list)))))

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
  (let ((string-result
         (with-output-to-string (string)
           (let ((*standard-output* string))
             (lisp-unit:run-all-tests :rameau)
             (format t "~%")))))    
    (if (member 'v flags)
        (write-line string-result)
        (write-line (subseq (last1 (cl-ppcre:split "\\n" string-result)) 34)))))

(defun run-analise-harmonica (flags files)
  (dolist (file files)
    (let ((resultado (with-system rameau:tempered
                       (gera-gabarito-pardo (parse-file file)))))
      (format t "~%  * ~a: [pardo] ~(~a~) ~%"
              (pathname-name file)
              (mapcar (lambda (x) (print-chord x  flags))
                      resultado)))))

(defun processa-gabarito-pop (file)
  (processa-cifras (read-pop-file file)))

(defun processa-gabarito (file)
  "Transforma um gabarito de texto em sexp."
  (let* ((*package* (find-package :rameau))
         (nome-gab (concat file ".gab"))
         (nome-pop (concat file ".pop"))
         (gabarito (cond ((cl-fad:file-exists-p nome-gab) 
                          (read-from-string (format nil "(~a)" (file-string nome-gab))))
                         ((cl-fad:file-exists-p nome-pop)
                          (processa-gabarito-pop nome-pop))
                         (t nil))))
    (expande-multiplicacoes gabarito)))

(defun run-compara-gabarito (flags files)
  (let (ok no)
    (dolist (file files)
      (multiple-value-bind (algoritmo segmento)
          (with-system rameau:tempered (gera-gabarito-pardo (parse-file file)))
        (format t "tamanhos pardo: ~a gabarito: ~a ~%" (length algoritmo) (length segmento))
        (let* ((file-name (pathname-name file))
               (gabarito (processa-gabarito (tira-extensao file)))
               (notas (with-system rameau:tempered (mapcar #'lista-notas segmento)))
               (comparacao (with-system rameau:tempered
                             (compara-gabarito-pardo algoritmo gabarito)))
               (duracoes (calcula-duracoes segmento algoritmo)))
          (cond
            ((member 'e flags)
             (unless comparacao
               (push 'v flags)
               (print-gabarito file-name gabarito algoritmo comparacao
                               flags :dur duracoes :notas notas)))
            ((member 'c flags)
             (push 'v flags)
             (when comparacao
               (print-gabarito file-name gabarito algoritmo comparacao
                               flags :dur duracoes :notas notas)))
            ((and (not gabarito) (not (member 'i flags)))
             (format t "~&[ERRO] o gabarito de ~a não existe~%" file-name))
            ((or (member 'v flags) (member 'n flags) (member 'd flags))
             (push 'v flags)
             (print-gabarito file-name gabarito algoritmo comparacao
                             flags :dur duracoes :notas notas))
            (gabarito
             (if comparacao (push file-name ok) (push file-name no)))))))
    (unless (member 'v flags)
      (print-ok/no-list (list (reverse ok) (reverse no))))))

(defun print-analise-temperley (flags files)
  (dolist (file files)
    (format t "~% * ~a~%" (pathname-name file))
    (format t "   temperley: ~(~a~) ~%" (with-system rameau:tempered (temperley (parse-file file))))))

(defun run-analise (flags files)
  (cond ((member 'g flags)
         (run-compara-gabarito flags files))
        ((member 't flags)
         (print-analise-temperley flags files))
        (t  ; -a implicito
         (run-analise-harmonica flags files))))

(defun run-partitura (flags files)
  (when (member 'v flags) (format t "gerando "))
  (dolist (file files)
    (when (member 'v flags) (format t "~a " (pathname-name file)))
    (multiple-value-bind (algoritmo segmento)
        (with-system rameau:tempered (gera-gabarito-pardo (parse-file file)))
      (let* ((gabarito (processa-gabarito (tira-extensao file)))
             (comparacao (with-system rameau:tempered
                           (compara-gabarito-pardo algoritmo gabarito))))
        (print-lily flags file gabarito algoritmo comparacao segmento)))))

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
  (run-analise flags (processa-files item files)))

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
         (max-error (first (get-flag-list "-m" flags-list)))
         (flags (if flags-list (get-lone-flags flags-list))))

    (when trace (maptrace trace))
    (when max-error (setf max-print-error (read-from-string max-error)))
    (when (member 'h flags) (print-help))
    
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

