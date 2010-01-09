;;; -*- Mode: LISP; Syntax: COMMON-LISP; Base: 10 -*-
;;;
;;; Copyright (c) 2007, Ury Marshak
;;; The code comes with a BSD-style license, so you can basically do
;;; with it whatever you want. See the file LICENSE for details.
;;;


(cl:in-package #:cl-user)

(defpackage #:ht-ajax-test
  (:use #:cl
        #:hunchentoot
        #:cl-ppcre
        #:ht-ajax
        #:html-template))

