;;; -*- Mode: LISP; Syntax: COMMON-LISP; Package: CL-USER; Base: 10 -*-
(asdf:defsystem :rameau-base
  :depends-on (:yacc :lexer :cl-fad :cl-ppcre :cl-store :arnesi :cffi :alexandria :ltk :iterate :swank :fann :cl-who :fiveam)
  :components ((:file "rameau-base")))

(asdf:defsystem :genoslib
  :depends-on (:rameau-base)
  :components ((:file "utils")
               (:file "musiclib" :depends-on ("utils"))))

(asdf:defsystem :cl-lily
  :depends-on (:rameau-base :genoslib)
  :components ((:module cl-lily
                        :serial t
                        :components ((:file "formato")
                                     (:file "segment")
                                     (:file "parser")
                                     (:file "parser-grammar")))))

(asdf:defsystem :rameau-pkg
  :depends-on (:rameau-base :genoslib :cl-store :cl-fad :vecto :cl-cairo2 :cl-lily)
  :serial t
  :components ((:file "packages")
               #+sbcl(:file "sbcl")
               (:file "chords")
               (:file "chords-functional")
               (:file "rameau")
               (:file "commands")
               (:file "terminal")
               (:file "analysis")
               (:file "lily")
               (:file "main")
               ))


(asdf:defsystem :algorithms
  :depends-on (:rameau-pkg :cl-store :vecto :cl-lily)
  :components ((:module algorithms
                        :components ((:file "hmm")
                                     (:file "neural")
                                     (:file "pardo")
                                     (:file "knn")
                                     (:file "tree-enarm")
                                     (:file "fhmm")
                                     ))))

(asdf:defsystem :commands
  :depends-on (:rameau-pkg :cl-lily :cl-store :vecto :cl-who :algorithms :hunchentoot :md5 :cl-fad :cl-base64 :cl-store)
  :serial t
  :components ((:file "package-test")
               (:module commands
                        :serial t
                        :components ((:file "analysis-command")
                                     (:file "cadences")
                                     (:file "web")
                                     (:file "doc")
                                     (:file "stat")
                                     (:file "algorithms")
                                     (:file "musicology")
                                     (:file "test")
                                     ))))

(asdf:defsystem :rameau
    :name "rameau"
    :version "4.0"
    :author "Alexandre Passos e Pedro Kroger"
    :depends-on (:rameau-pkg :algorithms :commands :cl-lily)
    :serial t
    :components ((:file "setup")
                 (:file "package-test")
                 (:module tests
                          :serial t
                          :components (;;(:file "packages")
                                       (:file "utils")
                                       ;(:file "musiclib")
                                       ;(:file "formato")
                                       ;(:file "parser")
                                       ;(:file "segment")
                                       ;(:file "chords")
                                       ;(:file "tools")
                                       ))))
