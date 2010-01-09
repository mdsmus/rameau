(defpackage #:f-underscore-system
  (:use :cl :asdf))

(in-package #:f-underscore-system)

(defsystem f-underscore
  :name "f-underscore"
  :description 

"a tiny library of functional programming utils placed into the public domain.

the idea is to make functional programs shorter and easier to read without resorting
to syntax [like arc's square bracket unary function syntax]"

  :author "Nick Allen <nallen05@gmail.com>"
  :version "0.1"
  :components ((:file "f-underscore")))
