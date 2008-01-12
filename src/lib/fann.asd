;;; -*- Mode: Lisp

(in-package :asdf)

(defsystem :fann
    :name "Fast Artificial Neural Network Library."
    :author "Fann"
    :version ""
    :depends-on (:cffi)
    :components ((:file "fann")))
