;;; -*- Mode: LISP; Syntax: COMMON-LISP; Package: CL-USER; Base: 10 -*-

(asdf:defsystem :rameau
  :name "rameau"
  :version "4.0"
  :author "Alexandre Passos e Pedro Kroger"
  :depends-on (:yacc :lexer :cl-fad :cl-ppcre :lisp-unit :arnesi :cffi :alexandria :ltk :iterate)
  :serial t
  :components (
               (:file "rameau-base")
               (:file "utils")
               (:file "musiclib")
               (:file "packages")
               #+sbcl(:file "sbcl")
               (:file "formato")
               (:file "segment")
               (:file "parser")
               (:file "parser-grammar")
               (:file "chords")
               (:file "tools")
               (:file "options")
               (:module "algorithms"
                        :components
                        ((:file "neural")
                         (:file "pardo")
                         (:file "knn")
                         (:file "tree-enarm")))
               (:file "terminal")
               (:file "main")))

(asdf:defsystem :rameau-tests
  :depends-on (:rameau)
  :components ((:file "test-utils")
               (:file "test-musiclib")
               (:file "test-formato")
               (:file "test-parser")
               (:file "test-segment")
               (:file "test-chords")
               (:file "test-tools")
               (:file "test-main")))
