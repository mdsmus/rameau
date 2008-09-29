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
  :components ((:file "packages")
               #+sbcl(:file "sbcl")
               (:file "formato")
               (:file "segment")
               (:file "parser")
               (:file "parser-grammar")
               (:file "chords")
               (:file "chords-functional")
               (:file "tools")
               (:file "options")
               (:file "terminal")
               (:file "lily")
               (:file "analysis")
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
  :components ((:module commands
                        :components ((:file "analysis-command")
                                     (:file "cadences")
                                     (:file "web")
                                     (:file "doc")
                                     ))))

(asdf:defsystem :rameau
    :name "rameau"
    :version "4.0"
    :author "Alexandre Passos e Pedro Kroger"
    :depends-on (:rameau-pkg :algorithms :commands)
    :components ((:file "main")
                 ))
