(declaim (sb-ext:muffle-conditions warning style-warning sb-ext:compiler-note))
(asdf:oos 'asdf:load-op 'rameau :verbose nil)

(in-package :rameau)

(defun main ()
  (let* ((arg sb-ext:*posix-argv*)
         (pwd *default-pathname-defaults*))
    (if (string= "./pop2gab" (first arg))
        (gera-gabarito-file (format nil "~a~a~a" pwd "literatura/bach-corais/" (second arg)))
        (gera-gabarito-file (format nil "~a~a~a" pwd "literatura/bach-corais/" (third arg))))))

(main)
(sb-ext:quit)
