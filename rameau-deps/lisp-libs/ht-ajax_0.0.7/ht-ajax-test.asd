;;; -*- Mode: LISP; Syntax: COMMON-LISP; Base: 10 -*-
;;;
;;; Copyright (c) 2007, Ury Marshak
;;; The code comes with a BSD-style license, so you can basically do
;;; with it whatever you want. See the file LICENSE for details.
;;;


(asdf:defsystem :ht-ajax-test
  :description "Test files for HT-AJAX"
  :version "0.0.1"
  :serial t
  :components ((:module "test"
                        :serial t
                        :components ( (:file "packages")
                                      (:file "test-ht-ajax"))))
  :depends-on (:html-template
               :ht-ajax))
