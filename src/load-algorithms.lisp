;; Carrega os algoritmos dentro de rameau durante a compilação
(in-package :rameau)

(defun carrega-algoritmos ()
  (let ((path (concat (rameau-path) "src/algoritmos/")))
    (loop for alg in (cl-fad:list-directory path)
       do (load alg))))

(carrega-algoritmos)

