
(in-package :rameau)



(lisp-unit:define-test compara-gabarito-pardo
  (lisp-unit:assert-true
   (compara-gabarito-pardo '(c maj 0 7)
                           '(c maj 0 7))
  (lisp-unit:assert-false
   (compara-gabarito-pardo '(c maj 0)
                           '(c maj 0 7)))))



    