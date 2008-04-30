;; Carrega os algoritmos dentro de rameau durante a compilação
(in-package :rameau)

(defun load-algorithms ()
  (loop
     for file in (directory (concat *rameau-path* "src/algoritmos/*.lisp"))
     do (load (compile-file file))))

(load-algorithms)

(do-not-test load-algorithms)