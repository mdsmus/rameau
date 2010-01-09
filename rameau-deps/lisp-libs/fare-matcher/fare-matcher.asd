;;; -*- Lisp -*-
(in-package :cl)

(asdf:defsystem :fare-matcher
  :depends-on (:fare-utils)
  :serial t
  :components ((:file "packages")
	       (:file "matcher")
	       #-gcl ; it currently fails. quasiquote necessitates a big revamp anyway
               (:file "quasiquote")
               ;;#-gcl ; 2.7.0-64.1 cannot defgeneric in a eval-now
	       (:file "clos-match")
	       (:file "mrd-extensions")))
