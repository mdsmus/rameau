#+sbcl(declaim (sb-ext:muffle-conditions warning style-warning sb-ext:compiler-note))

#+cmu(setf ext::*complain-about-illegal-switches* nil)

(declaim (optimize (compilation-speed 0)
                   (debug 3)
                   (safety 3)
                   (space 1)
                   (speed 1)))

(asdf:oos 'asdf:load-op :rameau :verbose nil)

(use-package :rameau)

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
                         ("-t" "roda metrica de temperley na musica (debug)")))))

(defparameter *lily-dir-list* '(("corais" "literatura/bach-corais/")
                                ("kostka" "literatura/kostka-payne/")
                                ("sonatas" "literatura/beethoven-sonatas/")
                                ("exemplos" "exemplos/")
                                ("regressao" "regressao/")
                                ("lily" "regressao-lily/")))

(defparameter *dados* '((teste ("unidade" "regressao" "lily"))
                        (analise ("corais" "kostka" "sonatas" "exemplos"))))

(defun percent (x total)
  (/ (* x 100.0) total))

(defun get-item (item lista &optional (test #'eql))
  "Pega um item em uma lista de associação."
  (second (assoc item lista :test test)))

(defun char->symbol (char)
  "Retorna o símbolo representado pelo caractere char.
Exemplo: (char->symbol #\a) => A"
  (intern (string-upcase (string char))))

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

(defun print-gabarito (file gabarito algoritmo comparacao flags &key notas dur)
  (let ((*package* (find-package :rameau)))
    (print-gab-columns "#" "notas" "gab" "pardo" "dur" "ok?" flags)
    (write-line (repeat-string 80 "-"))
    (let ((count-ok 0)
          (size-gab (length gabarito))
          (size-algo (length algoritmo))
          (wrong-list))
      (loop
         for gab in gabarito
         for pardo in algoritmo
         for n in notas
         for d in dur
         for numero-seg from 1
         for result = (compara-gabarito-pardo-individual pardo gab)
         if result do (incf count-ok)
         else do (push numero-seg wrong-list)
         do
           (print-gab-columns numero-seg n (print-chord gab flags)
                              (print-chord (pardo->gabarito pardo) flags)
                              d result flags))
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
    (format t "     ~10a~{~a~^,~}~%" (first item) (second item)))
  (print-help-item 'todos)
  (print-help-item 'análise)
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
              (mapcar (lambda (x) (print-chord (pardo->gabarito x)  flags))
                      resultado)))))

(defun run-compara-gabarito (flags files)
  (let (ok no)
    (dolist (file files)
      (multiple-value-bind (algoritmo segmento)
          (with-system rameau:tempered (gera-gabarito-pardo (parse-file file)))
        (let* ((file-name (pathname-name file))
               (gabarito (processa-gabarito (tira-extensao file)))
               (notas (with-system rameau:tempered (mapcar #'lista-notas segmento)))
               (comparacao (with-system rameau:tempered
                             (compara-gabarito-pardo algoritmo gabarito)))
               (duracoes (mapcar (lambda (x y) (list y (evento-dur (first x))))
                                 segmento algoritmo)))
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

(defun print-analise-temperley (files)
  (dolist (file files)
    (format t "~% * ~a~%" (pathname-name file))
    (format t "   temperley: ~(~a~) ~%" (temperley-metrifica (parse-file file)))))

(defun run-analise (flags files)
  (cond ((member 'g flags)
         (run-compara-gabarito flags files))
        ((member 't flags)
         (print-analise-temperley flags files))
        (t  ; -a implicito
         (run-analise-harmonica flags files))))

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
           (funcall (read-from-string comando) "all" flags files))
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
           (funcall (read-from-string comando) dados flags files))
          (t (format t "comando ~a não reconhecido~%" comando)
             (format t "você deve entrar um dos comandos: ~{~(~a~)~^ ~}~%"
                     (get-comandos)))))
  0)
