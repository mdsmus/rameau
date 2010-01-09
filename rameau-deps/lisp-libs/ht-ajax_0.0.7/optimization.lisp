;;; -*- Mode: LISP; Syntax: COMMON-LISP; Base: 10 -*-
;;;
;;; Copyright (c) 2007, Ury Marshak
;;; The code comes with a BSD-style license, so you can basically do
;;; with it whatever you want. See the file LICENSE for details.
;;;

(in-package #:ht-ajax)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defvar *optimization* '(optimize (space 0) (speed 0) (safety 3) (debug 3))))



