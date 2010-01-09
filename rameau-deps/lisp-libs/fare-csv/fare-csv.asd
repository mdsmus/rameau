;;; -*- Lisp -*-
(in-package :cl)

(asdf:defsystem #:fare-csv
  :depends-on (:parse-number)
  :components ((:file "package") (:file "csv"))
  :serial t)
