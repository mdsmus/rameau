;;; -*- Mode: LISP; Syntax: COMMON-LISP; Package: CL-USER; Base: 10 -*-

(asdf:defsystem :rameau
  :name "rameau"
  :version "0.2"
  :author "Alexandre Passos e Pedro Kroger"
  :serial t
  :depends-on (:yacc :lexer :cl-fad :cl-ppcre :lisp-unit)
  :components (
               (:file "packages")
               (:file "utils")
               (:file "musiclib")
               (:file "formato")
               (:file "parser")
               (:file "segmento")
               (:file "pardo")
               ))
