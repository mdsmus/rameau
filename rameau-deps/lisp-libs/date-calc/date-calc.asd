(in-package #:cl-user)


(eval-when (:compile-toplevel :load-toplevel :execute)
  (unless (find-package 'date-calc.system)
    (defpackage #:date-calc.system
      (:use #:cl
	    #:asdf))))

(in-package #:date-calc.system)

(defsystem #:date-calc
  :description "Package for simple date calculation"
  :author "schroete@iup.physik.uni-bremen.de"
  :licence "GPL or Artistic"
  :version "0.2"
  :components
  ((:file "date-calc")))
