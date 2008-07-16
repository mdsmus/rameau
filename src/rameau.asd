;;; -*- Mode: LISP; Syntax: COMMON-LISP; Package: CL-USER; Base: 10 -*-

(asdf:defsystem :rameau-base
  :depends-on (:yacc :lexer :cl-fad :cl-ppcre :lisp-unit :arnesi :cffi :alexandria :ltk :iterate :fann)
  :components ((:file "rameau-base")))

(asdf:defsystem :genoslib
  :depends-on (:rameau-base)
  :components ((:file "utils")
               (:file "musiclib" :depends-on ("utils"))))

(asdf:defsystem :rameau-pkg
  :depends-on (:rameau-base :genoslib :cl-store :cl-fad :swank)
  :serial t
  :components ((:file "packages")
               #+sbcl(:file "sbcl")
               (:file "formato")
               (:file "segment")
               (:file "parser")
               (:file "parser-grammar")
               (:file "chords")
               (:file "tools")
               (:file "doc")
               ))

(asdf:defsystem :options
  :depends-on (:rameau-pkg)
  :components ((:file "options")
               ))

(asdf:defsystem :algorithms
  :depends-on (:rameau-pkg :options :cl-store :vecto)
  :components ((:module algorithms
                        :components ((:file "hmm")
                                     (:file "neural")
                                     (:file "pardo")
                                     (:file "knn")
                                     (:file "tree-enarm")
                                     ))))

(asdf:defsystem :backends
  :depends-on (:rameau-pkg :algorithms :options)
  :components ((:file "terminal")
               (:file "lily")))


(asdf:defsystem :rameau-web
  :name "rameau-web"
  :version "0.0"
  :author "Alexandre Passos e Pedro Kroger"
  :depends-on (:rameau-pkg :options :algorithms :hunchentoot :cl-who :backends
                           :md5 :cl-fad :cl-base64 :backends :cl-store)
  :components ((:file "web")))

(asdf:defsystem :rameau
  :name "rameau"
  :version "4.0"
  :author "Alexandre Passos e Pedro Kroger"
  :depends-on (:rameau-pkg :algorithms :options :rameau-web :backends)
  :components ((:file "main")
               ))


