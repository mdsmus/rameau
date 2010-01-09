(defpackage #:dynamic-classes-system (:use #:common-lisp #:asdf))
(in-package #:dynamic-classes-system)

(defsystem dynamic-classes
  :author "Gary Warren King <gwking@metabang.com>"
  :version "1.0.1"
  :maintainer "Gary Warren King <gwking@metabang.com>"
  :licence "MIT Style license"
  :components ((:module 
		"dev"
		:serial t
		:components ((:file "package")
			     (:file "utilities")
			     (:file "define-class")
			     (:file "dynamic-class"))))
  :depends-on (:metatilities-base))

