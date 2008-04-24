;; Carrega os algoritmos dentro de rameau durante a compilação
(in-package :rameau)

(defun load-algorithms ()
  (let ((path (concat *rameau-path* "src/algoritmos/")))
    (loop for alg in (cl-fad:list-directory path)
       when (count-subseq "lisp" (pathname-name alg))
       do (aif (compile-file alg)
               (load it)))))

;(load-algorithms)

(do-not-test load-algorithms)