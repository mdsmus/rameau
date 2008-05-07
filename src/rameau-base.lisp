(defpackage :rameau-base
  (:use #:cl)
  (:export #:*simbolos* #:export-rameau-symbols #:register-and-export-symbols))

(in-package :rameau-base)

(defparameter *simbolos* nil)

(defun export-rameau-symbols ()
  "[DONTCHECK]"
  (mapcar #'export *simbolos*))

(defun register-and-export-symbols (simbolos)
  "[DONTCHECK]"
  (setf *simbolos* (append simbolos *simbolos*))
  (mapcar #'export simbolos))
