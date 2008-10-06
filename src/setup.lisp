; Setup
;;; Define rameau-setup package
(defpackage :rameau-setup
  (:import-from #:arnesi "AIF" "AWHEN" "IT" "LAST1" "ENABLE-SHARP-L-SYNTAX")
  (:shadowing-import-from #:rameau-base #:defun #:defmacro #:defparameter #:defvar #:defstruct)
  (:use :rameau :cl :cl-ppcre :iterate :genoslib :rameau-test)
  (:documentation "Code for the setup program that drives @rameau"))

(in-package :rameau-setup)



(format t "Algorithms: ~a~%" (mapcar #'alg-name *algorithms*))
(main "algorithms -o train -a net -f chor:1..6 exa:11..13 exa:23..28")
(main "algorithms -o train -a hmm tree bay knn -f chor:1..10 exa:11..13 exa:23..28 chor:12 chor:14 chor:17..33 ")
(format t "FAlgorithms: ~a~%" (mapcar #'alg-name *functional-algorithms*))
(main "funalg -o train -f chor:1..3 exa:001 chor:1..3 chor:006")

