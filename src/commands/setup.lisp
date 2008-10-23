; Setup
;;; Define rameau-setup package
(defpackage :rameau-setup
  (:use :rameau :cl :iterate)
  (:documentation "Code for the setup program that drives @rameau"))

(in-package :rameau-setup)

(defun setup (options)
  (declare (ignore options))
  (ensure-directories-exist "rameau:algorithms;")
  (format t "Algorithms: ~{~a~^ ~}~%" (mapcar #'alg-name *algorithms*))
  (main "algorithms -o train -a net -f chor:1..6 exa:11..13 exa:23..28")
  (main "algorithms -o train -a hmm tree bay knn -f chor:1..10 exa:11..13 exa:23..28 chor:12 chor:14 chor:17..33 ")
  (format t "Functional Algorithms: ~{~a~^ ~}~%" (mapcar #'alg-name *functional-algorithms*))
  (main "funalg -o train -f chor:1..3 exa:001 chor:1..3 chor:006"))

(register-command :name "setup"
                  :documentation "Train using the default options."
                  :action #'setup)

; (main "setup")
