;;; -*- Mode: LISP; Syntax: COMMON-LISP; Package: CL-USER; Base: 10 -*-

(asdf:defsystem :rameau
  :name "rameau"
  :version "0.2"
  :author "Alexandre Passos e Pedro Kroger"
  :serial t
  :depends-on (:yacc :lexer :cl-fad :cl-ppcre :lisp-unit :arnesi :cffi :string-case)
  :components (
	       #+sbcl(:file "sbcl")
               (:file "rameau-base")
               (:file "utils")
               (:file "musiclib")
               (:file "packages")
               (:file "formato")
               (:file "segment")
               (:file "parser")
               (:file "parser-grammar")
               (:file "chords")
               (:file "tools")
               (:file "kern2lily")
               (:file "load-algorithms")
               (:file "main")
               (:file "test-utils")
               (:file "test-musiclib")
               (:file "test-formato")
               (:file "test-parser")
               (:file "test-segment")
               (:file "test-chords")
               (:file "test-tools")
               (:file "test-main")
               ))
