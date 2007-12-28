(in-package :rameau-tree)

(eval-when (:compile-toplevel)
  (defun treina-tree ()
    (format t "Agora treinando a arvore de decisao: ~%")
    (with-system rameau:tempered
      (multiple-value-bind (corais gabaritos)
          (unzip(loop for i in '("001" "003" "004" "006" "012" "018" "136")
                   for f = (first (rameau-tools::processa-files "corais" (list i)))
                   then (first (rameau-tools::processa-files "corais" (list i)))
                   for g = (rameau-tools::processa-gabarito f "corais")
                   then (rameau-tools::processa-gabarito f "corais")
                   collect (list (segmentos-minimos (parse-file f)) g)))
        (treina-decision-tree corais gabaritos)))
    (format t "Treinada.~%"))

  (treina-tree))