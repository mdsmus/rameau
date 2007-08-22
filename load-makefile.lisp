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

(defun print-gabarito-pardo (file &optional (print-only-if-incorrect? nil))
  (let* ((pardo (gera-gabarito-pardo (parse-file file)))
         (gabarito (gabarito->sexp (troca-extensao file ".gab")))
         (comparacao (equal pardo gabarito)))
    (if print-only-if-incorrect?
        (unless comparacao
          (format t "~% arquivo: ~a~%" file)
          (format t "   pardo: ~{~(~a~) ~}~%" pardo)
          (format t "gabarito: ~{~(~a~) ~}~%" gabarito)
          (format t "correto?: ~:[não~;sim~]~%" comparacao))
        (progn
          (format t "~% arquivo: ~a~%" file)
          (format t "   pardo: ~{~(~a~) ~}~%" pardo)
          (format t "gabarito: ~{~(~a~) ~}~%" gabarito)
          (format t "correto?: ~:[não~;sim~]~%" comparacao)))))

(defun test-all (arquivos &optional (print-only-if-incorrect? nil))
  (dolist (f arquivos)
    (handler-case (print-gabarito-pardo f print-only-if-incorrect?)
      (serious-condition (expr) (format t "~%=> ERRO em ~a~%" (pathname-name f))))))

(defun test-one (f)
  (handler-case (print-gabarito-pardo f)
    (serious-condition (expr) (format t "~%=> ERRO em ~a~%~a~%" (pathname-name f) expr))))

(let ((args (rest *posix-argv*)))
  (cond ((string= (first args) "only-wrong")
         (test-all (rest args) 'print-only-wrong))
        ((> (length args) 1)
         (test-all args))
        ((= (length args) 1)
         (test-one (first args)))
        (t (error "não sei o que fazer"))))

(quit)
