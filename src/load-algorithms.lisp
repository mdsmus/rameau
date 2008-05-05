(in-package :rameau)

(defun load-algorithms ()
  "[DONTCHECK]"
  (loop
     for file in (directory (concat *rameau-path* "src/algoritmos/*.lisp"))
     unless *ignore-algorithms-files*
     do (load (compile-file file))))

(load-algorithms)
