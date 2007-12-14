;;; -*- Mode: LISP; Syntax: COMMON-LISP; Package: CL-USER; Base: 10 -*-

(asdf:defsystem :rameau
  :name "rameau"
  :version "0.2"
  :author "Alexandre Passos e Pedro Kroger"
  :serial t
  :depends-on (:yacc :lexer :cl-fad :cl-ppcre :lisp-unit :arnesi :nile)
  :components (
               (:file "rameau-base")
               (:file "utils")
               (:file "musiclib")
               (:file "packages")
               (:file "formato")
               (:file "segmento")
               (:file "parser")
               (:file "parser-grammar")
               (:file "pardo")
               (:file "temperley")
               (:file "cifras")
               #+sbcl(:file "sbcl")
               (:file "rameau")
               (:file "neural")
               (:file "neural-train")
               (:file "kern2lily")
               (:file "test-utils")
               (:file "test-musiclib")
               (:file "test-formato")
               (:file "test-parser")
               (:file "test-cifras")
               ;;(:file "test-segmento")
               (:file "test-pardo")
               ))
