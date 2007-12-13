(in-package :rameau-neural)

(eval-when (:compile-toplevel :load-toplevel)
  (defun treina-simple-net-inicial ()
    (format t "Agora treinando a rede neural: ~%")
    (with-system rameau:tempered
      (loop for i in '("001" "003" "004" "006" "012" "018" "136" "050")
         for f = (first (rameau-tools::processa-files "corais" (list i)))
         then (first (rameau-tools::processa-files "corais" (list i)))
         for g = (rameau-tools::processa-gabarito f "corais")
         then (rameau-tools::processa-gabarito f "corais")
         do (format t "  no coral ~a~%" i)
         do (treina-simple-net f g)))
    (format t "Treinada.~%"))
        

  (treina-simple-net-inicial))