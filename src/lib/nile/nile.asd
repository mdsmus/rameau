;;; -*- Mode: LISP; Syntax: COMMON-LISP; Package: CL-USER; Base: 10 -*-

(asdf:defsystem :nile
  :name "Nile"
  :version "1.0"
  :author "Nils Goroll"
  :serial t
  :components (
               (:file "nile_run-net-lib")
               (:file "nile_c2ompile-net-lib")
               (:file "nile_compile-net-lib")
               (:file "nile_demos")
               ))