;;; -*- Mode: LISP; Syntax: COMMON-LISP; Package: CL-USER; Base: 10 -*-

(asdf:defsystem :rameau-base
  :depends-on (:yacc :lexer :cl-fad :cl-ppcre :lisp-unit :arnesi :cffi :alexandria :ltk :iterate)
  :components ((:file "rameau-base")))

(asdf:defsystem :genoslib
  :depends-on (:rameau-base)
  :components ((:file "utils")
               (:file "musiclib" :depends-on ("utils"))))

(asdf:defsystem :rameau-pkg
  :depends-on (:rameau-base :genoslib)
  :serial t
  :components ((:file "packages")
               #+sbcl(:file "sbcl")
               (:file "formato")
               (:file "segment")
               ;;(:file "parser-grammar")
               ;;(:file "parser")
               (:file "chords")
               (:file "tools")))

(asdf:defsystem :options
  :depends-on (:rameau-pkg)
  :components ((:file "options")))

(asdf:defsystem :algorithms
  :depends-on (:rameau-pkg :options)
  :components ((:module algorithms
                        :components ((:file "neural")
                                     (:file "pardo")
                                     (:file "knn")
                                     (:file "tree-enarm")))))

(asdf:defsystem :tests
  :depends-on (:rameau)
  :components ((:file "test-utils")
               (:file "test-musiclib")
               (:file "test-formato")
               (:file "test-parser")
               (:file "test-segment")
               (:file "test-chords")
               (:file "test-tools")
               (:file "test-main")))

(asdf:defsystem :rameau
  :name "rameau"
  :version "4.0"
  :author "Alexandre Passos e Pedro Kroger"
  :depends-on (:rameau-pkg :algorithms :options)
  :components ((:file "terminal" :depends-on ("main"))
               (:file "main")))
