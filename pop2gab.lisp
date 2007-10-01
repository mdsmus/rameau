(declaim (sb-ext:muffle-conditions warning style-warning sb-ext:compiler-note))

(declaim (optimize (compilation-speed 0)
                   (debug 1)
                   (safety 1)
                   (space 3)
                   (speed 3)))

(asdf:oos 'asdf:load-op 'rameau :verbose nil)
(use-package :rameau)

(defun main ()
  (let ((file (format nil "~a~a~a" *default-pathname-defaults*
                      "literatura/bach-corais/" (second sb-ext:*posix-argv*))))
    (if (cl-fad:file-exists-p (concatenate 'string file ".gab"))
        (progn (gera-gabarito-file file)
               0)
        (progn
          (format t "arquivo ~a.pop não existe" file)
          1))))

(sb-ext:save-lisp-and-die "pop2gab"
                          :executable t
                          :toplevel #'main)