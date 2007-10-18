#+sbcl(declaim (sb-ext:muffle-conditions warning style-warning sb-ext:compiler-note))

#+cmu(setf ext::*complain-about-illegal-switches* nil)

(declaim (optimize (compilation-speed 0)
                   (debug 3)
                   (safety 3)
                   (space 1)
                   (speed 1)))

(asdf:oos 'asdf:load-op :rameau :verbose nil)
(asdf:oos 'asdf:load-op :getopt :verbose nil)

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
  #+clisp(ext:exit))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defparameter *comandos* '("teste" "analise" "cifra"))

(defparameter *lily-dir-list* '(("corais" "literatura/bach-corais/")
                                ("kostka" "literatura/kostka-payne/")
                                ("sonatas" "literatura/beethoven-sonatas/")
                                ("exemplos" "exemplos/")
                                ("regressao" "regressao/")
                                ("lily" "regressao-lily/")))


(defun split-word (word)
  (loop for char across word collect (char->symbol char)))

(defun char->symbol (char)
  (intern (string-upcase (string char))))

(defun parse-opts (string)
  (exclude-repetition (mapcan (lambda (s) (split-word (delete #\- s)))
                              (cl-ppcre:split #\Space string))))

(defun split-dados (dados)
  (cl-ppcre:split "," dados))

(defun run-unit (flags files)
  (declare (ignore flags files))
  (lisp-unit:run-all-tests :rameau)
  (format t "~%"))

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

(defun print-condition (status file expr)
  (format t "[~a] ~a: ~a~%" status (pathname-name file) expr))

(defun parse-verbose (files)
  (dolist (file files)
    (handler-case (parse-file file)
    (serious-condition (expr) (print-condition 'no file expr))
    (:no-error (&rest rest) (print-condition 'ok file rest)))))

(defun print-ok/no-list (list)
  (destructuring-bind (ok no) list
    (format t "[OK]: ~a [NO]: ~a ~@[~a ~]~%" (length ok) (length no) no)))

(defmacro with-profile (var &body body)
  `(progn
     (when (member 'p ,var)
       (rameau-profile))
     ,@body
     (when (member 'p ,var)
       (rameau-report))))

(defun run-regressao (flags files)
  ;;;; TODO checa flags
  (with-profile flags
      (if (member 'v flags)
          (parse-verbose files)
          (print-ok/no-list (parse-summary files)))))

(defun run-lily (flags files)
  )

(defun run-exemplos (flags files)
  )

(defun processa-files (item files &optional (ext ".ly"))
  (let ((path (concat (rameau-path) (second (assoc item *lily-dir-list* :test #'equal)))))
    (if files
        (mapcar (lambda (file) (concat path file ext)) files))))

(defun teste (dados flags files)
  (let* ((dados-list '("unit" "regressao" "lily" "exemplos"))
         (comandos-lista (if (string= dados "all") dados-list (split-dados dados))))                           
    (loop for item in comandos-lista do
         (if (member item dados-list :test #'string=)
             (funcall-string (concat "run-" item) flags (processa-files item files))
             (format t "[AVISO!] ~a não é um comando de 'teste'.~%" item)))))

(defun analise (dados flags files)
  (print 2))

(defun cifra (dados flags files)
  (print 3))

(defun first-string (string)
  (loop for s in *comandos* do
       (if (string= (subseq s 0 1) string)
           (return s))))

(defun funcall-string (string &rest args)
  (apply (intern (string-upcase string)) args))

(defun main ()
  (destructuring-bind (comando dados &optional flags &rest files) (rameau-args)
    (let ((string (first-string comando)))
      (cond (string (funcall-string string dados (parse-opts flags) files))
            ((member comando *comandos* :test #'string=)
             (funcall-string comando dados (parse-opts flags) files))
            (t (format t "comando não conhecido: ~(~a~)~%" comando)
               (format t "você deve entrar um dos comandos: ~{~(~a~)~^ ~}~%" *comandos*)))))
  0)

;; ("testes" "unit,regressao" "-p" ("001")) 

(main)
(quit)