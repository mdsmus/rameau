;;; -*- Mode: LISP; Syntax: COMMON-LISP; Base: 10 -*-
;;;
;;; Copyright (c) 2007, Ury Marshak
;;; The code comes with a BSD-style license, so you can basically do
;;; with it whatever you want. See the file LICENSE for details.
;;;


(asdf:defsystem :ht-ajax
  :description "AJAX for Hunchentoot"
  :version "0.0.7"
  :serial t
  :components ((:file "packages")
               (:file "optimization")
               (:file "version")
               (:file "jsmin")
               (:file "ht-ajax")
               (:file "utils")
               (:file "join-strings")
               (:file "processor-simple")
               (:file "processor-lokris")
               (:file "processor-prototype")
               (:file "processor-dojo")
               (:file "processor-yui")
               )
  :depends-on (:hunchentoot
               :cl-ppcre))
