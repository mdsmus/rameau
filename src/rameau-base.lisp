
(defpackage :rameau-base
  (:use #:cl)
  (:export #:*simbolos* #:do-not-test #:*do-not-test* #:export-rameau-symbols #:register-and-export-symbols))

(in-package :rameau-base)

(defparameter *simbolos* nil)

(defun export-rameau-symbols ()
  (mapcar #'export *simbolos*))

(defun register-and-export-symbols (simbolos)
  (setf *simbolos* (append simbolos *simbolos*))
  (mapcar #'export simbolos))

(defparameter *do-not-test* nil)

(defmacro do-not-test (&rest funcs)
  `(progn ,@(mapcar (lambda (x) `(push ',x *do-not-test*)) funcs)))

(do-not-test export-rameau-symbols register-and-export-symbols)