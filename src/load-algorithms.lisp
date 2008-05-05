(in-package :rameau)

(defun load-algorithms ()
  "[DONTCHECK]"
  (loop
     for file in (directory (concat *rameau-path* "src/algoritmos/*.lisp"))
     do (load (compile-file file))))

(load-algorithms)
