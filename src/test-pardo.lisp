
(in-package :rameau)

(lisp-unit:define-test compara-gabarito-pardo
  (lisp-unit:assert-true
   (compara-gabarito-pardo '((c maj) (c maj) (c dim 7))
                           '((c maj 0) (c maj 1) (c dim 2 7))))
  (lisp-unit:assert-true
   (compara-gabarito-pardo '((c maj) (c maj) (c dim 7))
                           '((c maj 0) ((fis maj 0 6 8) (c maj 1)) (c dim 2 7))))
  (lisp-unit:assert-false
   (compara-gabarito-pardo '((c maj) (c maj) (c dim 7))
                           '((c maj 1) (c maj 0 7) (c dim 7)))))


(lisp-unit:define-test compara-gabarito-pardo-individual
  (lisp-unit:assert-true
   (compara-gabarito-pardo-individual '(c maj 7)
                                      '(c maj 0 7))
  (lisp-unit:assert-false
   (compara-gabarito-pardo-individual '(c maj)
                                      '(c maj 0 7)))))



    