(declaim (sb-ext:muffle-conditions warning style-warning sb-ext:compiler-note))

(asdf:oos 'asdf:load-op 'lexer :verbose nil)
(asdf:oos 'asdf:load-op 'yacc :verbose nil)

(defun load-all (files)
  (loop for file in files do (load (format nil "src/~(~a~)" file))))

(load-all '(lisp-unit formato parser segmento pardo))

(defun tira-extensao (file)
  (subseq file 0 (position #\. file)))

(defun troca-extensao (file ext)
  (concatenate 'string (tira-extensao file) ext))

(defun print-gabarito-pardo (file)
  (let ((pardo (gera-gabarito-pardo (parse-file file)))
        (gabarito (gabarito->sexp (troca-extensao file ".gab"))))
    (format t "~% arquivo: ~a~%" file)
    (format t "   pardo: ~{~(~a~) ~}~%" pardo)
    (format t "gabarito: ~{~(~a~) ~}~%" gabarito)
    (format t "correto?: ~:[não~;sim~]~%" (equal pardo gabarito))))

(defun test-all (arquivos)
  (dolist (f arquivos)
    (handler-case (print-gabarito-pardo f)
      (serious-condition (expr) (format t "~%=> ERRO em ~a~%" (pathname-name f))))))

(defun test-one (f)
  (handler-case (print-gabarito-pardo f)
    (serious-condition (expr) (format t "~%=> ERRO em ~a~%~a~%" (pathname-name f) expr))))

(let ((args (rest *posix-argv*)))
  (if (> (length args) 1)
      (test-all args)
      (test-one (first args))))

(quit)
