;;; -*- Mode: LISP; Syntax: COMMON-LISP; Package: CL-USER; Base: 10 -*-
(asdf:defsystem :rameau-base
  :depends-on (:yacc :lexer :cl-fad :cl-ppcre :cl-store :lisp-unit :arnesi :cffi :alexandria :ltk :iterate :swank :fann :cl-who)
  :components ((:file "rameau-base")))

(asdf:defsystem :genoslib
  :depends-on (:rameau-base)
  :components ((:file "utils")
               (:file "musiclib" :depends-on ("utils"))))

(asdf:defsystem :rameau-pkg
  :depends-on (:rameau-base :genoslib :cl-store :cl-fad :vecto :cl-cairo2)
  :serial t
  :components ((:module cl-lily
                        :serial t
                        :components ((:file "formato")
                                     (:file "segment")
                                     (:file "parser")
                                     (:file "parser-grammar")))
               (:file "packages")
               #+sbcl(:file "sbcl")
               (:file "chords")
               (:file "chords-functional")
               (:file "tools")
               (:file "commands")
               (:file "terminal")
               (:file "analysis")
               (:file "lily")
               ))


(asdf:defsystem :algorithms
  :depends-on (:rameau-pkg :cl-store :vecto)
  :components ((:module algorithms
                        :components ((:file "hmm")
                                     (:file "neural")
                                     (:file "pardo")
                                     (:file "knn")
                                     (:file "tree-enarm")
                                     (:file "fhmm")
                                     ))))

(asdf:defsystem :commands
  :depends-on (:rameau-pkg :cl-store :vecto :cl-who :algorithms :hunchentoot :md5 :cl-fad :cl-base64 :cl-store)
  :serial t
  :components ((:module commands
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
    :depends-on (:rameau-pkg :algorithms :commands)
    :components ((:file "main")
                 ))
