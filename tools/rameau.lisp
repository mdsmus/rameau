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

(defconstant max-print-error 10
  "Quando o numero de arquivos que não são parseados é maior que essa
  constante, rameau mostra apenas o inicio da lista.")

(defparameter *comandos* '("teste" "analise" "cifra"))

(defparameter *lily-dir-list* '(("corais" "literatura/bach-corais/")
                                ("kostka" "literatura/kostka-payne/")
                                ("sonatas" "literatura/beethoven-sonatas/")
                                ("exemplos" "exemplos/")
                                ("regressao" "regressao/")
                                ("lily" "regressao-lily/")))

(defparameter *dados* '((teste ("unidade" "regressao" "lily"))
                        (analise ("corais" "kostka" "sonatas" "exemplos"))))

(defun get-item (item lista &optional (test #'eql))
  (second (assoc item lista :test test)))

(defun split-word (word)
  (loop for char across word collect (char->symbol char)))

(defun char->symbol (char)
  (intern (string-upcase (string char))))

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

(defun print-condition (status file expr)
  (format t "[~a] ~a: ~a~%" status (pathname-name file) expr))

(defun print-ok/no-list (list)
  (destructuring-bind (ok no) list
    (let* ((s2 (length no))
           (no-string
            (if (> s2 max-print-error)
                (format nil "~a ..." (subseq no 0 max-print-error))
                no)))
      (format t "  [OK]: ~a [NO]: ~a ~@[~a ~]~%" (length ok) s2 no-string))))

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

(defun files-range (list)
  (loop for x from (parse-integer (first list)) to (parse-integer (second list))
     collect (cond ((< x 10)  (format nil "00~a" x))
                   ((< x 100) (format nil "0~a" x))
                   (t (format nil "~a" x)))))
                   

(defun processa-files (item f &optional (ext ".ly"))
  (let* ((path (concat (rameau-path) (get-item item *lily-dir-list*  #'equal)))
         (file-name (format nil "~a" (first f)))
         (files (if (search ".." file-name)
                    (files-range (cl-ppcre:split "\\.\\." file-name))
                    f)))
    (if files
        (mapcar (lambda (file) (concat path file ext)) files)
        (mapcar (lambda (file) (format nil "~a" file)) (directory (concat path "*" ext))))))

(defun run-analise-harmonica (files)
  (dolist (file files)
    (let ((resultado (with-system rameau:tempered
                       (gera-gabarito-pardo (parse-file file)))))
      (format t "~%  * ~a: [pardo] ~(~a~) ~%" (pathname-name file) resultado))))

(defun print-gabarito (file gabarito algoritmo comparacao flags &key notas dur)
  (let ((*package* (find-package :rameau)))
    (progn
      (format t "~% * ~a~%" file)
      (format t "gabarito (tamanho: ~a): ~(~s~) ~%" (length gabarito) gabarito)
      (format t "   pardo (tamanho: ~a): ~(~s~) ~%" (length algoritmo) algoritmo)
      (when (member 'n flags) (format t "   notas: ~(~s~) ~%" notas))
      (when (member 'd flags) (format t "   dur: ~(~s~) ~%" dur))
      (format t "correto?: ~:[não~;sim~]~%" comparacao))))

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
            ((member 'w flags)
             (unless comparacao
               (print-gabarito file-name gabarito algoritmo comparacao
                               flags :dur duracoes :notas notas)))
            ((member 'c flags)
             (push 'v flags)
             (when gabarito
               (print-gabarito file-name gabarito algoritmo comparacao
                               flags :dur duracoes :notas notas)))
            ((not gabarito)
             (format t "~&[ERRO] o gabarito de ~a não existe~%" file-name))
            ((or (member 'v flags) (member 'n flags) (member 'd flags))
             (push 'v flags)
             (print-gabarito file-name gabarito algoritmo comparacao
                             flags :dur duracoes :notas notas))
            (gabarito
             (if comparacao (push file-name ok) (push file-name no)))
            (t (error "não sei o que fazer!"))))))
    (unless (member 'v flags)
      (print-ok/no-list (list (reverse ok) (reverse no))))))

(defun run-analise (flags files)
  (when (and (member 'a flags) (member 'g flags))
    (write-line "As opções -a e -g não podem ser dadas ao mesmo tempo")
    (rameau-quit))

  (if (member 'g flags)
      (run-compara-gabarito flags files)
      (run-analise-harmonica files)))

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
                    (format t "[AVISO!] ~a não é um comando de '~(~a~)'.~%" item ',nome)
                    (format t "comandos possíveis são: all ~{~a ~}~%" dados-list))))))))

(defcomando teste dados flags files
    (if (string= item "unidade")
        (run-unidade flags (processa-files item files))
        (run-regressao flags (processa-files item files))))

(defcomando analise dados flags files
  (run-analise flags (processa-files item files)))

(defun cifra (dados flags files)
  (print 3))

(defun first-string (string list)
  (let ((tmp (loop for s in list do
                  (if (string= (subseq s 0 1) string)
                      (return s)))))
    (if tmp tmp string)))

(defun print-help ()
  (format t "comandos possíveis são: ~{~a ~}~%" *comandos*)
  (rameau-quit))

(defun next-flag (list)
  (loop for x in (rest list) do
       (if (search "-" x)
           (return x))))

(defun pos (list)
  (let ((p (position (next-flag list) list :test #'string=)))
    (if p p 0)))

(defun arg->list (list)
  (when list
    (if (next-flag list)
        (let ((p (pos list)))
          (cons (subseq list 0 p)
                (arg->list (subseq (subseq list p) 0))))
        (list list))))

(defun get-lone-flags (list)
  (exclude-repetition
   (mapcan (lambda (item) (split-opts (first item)))
           (remove-if-not (lambda (item) (= (length item) 1)) list))))

(defun get-flag-list (flag list)
  (rest (assoc flag list :test #'string=)))

(defun main ()
  (let* ((args (rameau-args))
         (comando (first args))
         (dados (second args))
         (string (if comando (first-string comando *comandos*)))
         (flags-list (if (> (length args) 2) (arg->list (subseq args 2))))
         (files (get-flag-list "-f" flags-list))
         (trace (get-flag-list "-t" flags-list))
         (flags (if flags-list (get-lone-flags flags-list))))
    (cond ((null comando) (print-help))
          ((equal comando "help") (print-help))
          ((equal comando "-h") (print-help))
          ((and comando (null dados))
           (format t "você deve entrar dados para o comando ~a~%" comando)
           (format t "dados possíveis são: all ~{~a~^ ~}~%"
                   (get-item (read-from-string comando) *dados* #'string=)))
          ((member string *comandos* :test #'string=)
          (funcall (read-from-string string) dados flags files))
          (t (format t "comando não conhecido: ~(~a~)~%" comando)
             (format t "você deve entrar um dos comandos: ~{~(~a~)~^ ~}~%" *comandos*))))
  0)
