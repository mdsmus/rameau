;;;; -*- Mode: lisp; indent-tabs-mode: nil -*-
;;;
;;; asdf-upgrade.asd --- System definition for ASDF-UPGRADE.
;;;
;;; Copyright (C) 2005, James Bielman  <jamesjb@jamesjb.com>
;;;
;;; Permission is hereby granted, free of charge, to any person
;;; obtaining a copy of this software and associated documentation
;;; files (the "Software"), to deal in the Software without
;;; restriction, including without limitation the rights to use, copy,
;;; modify, merge, publish, distribute, sublicense, and/or sell copies
;;; of the Software, and to permit persons to whom the Software is
;;; furnished to do so, subject to the following conditions:
;;;
;;; The above copyright notice and this permission notice shall be
;;; included in all copies or substantial portions of the Software.
;;;
;;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
;;; NONINFRINGEMENT.  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
;;; HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
;;; WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
;;; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
;;; DEALINGS IN THE SOFTWARE.
;;;

(defpackage #:asdf-upgrade-system
  (:use #:cl #:asdf))
(in-package #:asdf-upgrade-system)

(defsystem asdf-upgrade
  :description "Upgrade packages installed via ASDF-INSTALL"
  :author "James Bielman  <jamesjb@jamesjb.com>"
  :version "0.1.0"
  :licence "MIT"
  :serial t
  :components ((:file "package")
               (:file "asdf-upgrade"))
  :depends-on (asdf-install split-sequence cl-fad net-telent-date))
