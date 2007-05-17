;;; -*- Mode: LISP; Syntax: COMMON-LISP; Package: CL-USER; Base: 10 -*-

(asdf:defsystem :parser
  :version "0.1"
  :serial t
  :depends-on (:yacc :lexer)
  :components ((:file "packages")
               (:file "parser")
               (:file "formato")
               (:file "segmento")
               ))