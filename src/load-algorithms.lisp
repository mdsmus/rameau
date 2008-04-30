(in-package :rameau)

(defun load-algorithms ()
  (loop
     for file in (directory (concat *rameau-path* "src/algoritmos/*.lisp"))
     unless *ignore-algorithms-files*
     do (load (compile-file file))))

(load-algorithms)

(do-not-test load-algorithms)