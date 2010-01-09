;;; -*- Mode: lisp -*-
;;;
;;; Contributed by Tom Mitchell

(in-package :asdf)

(defsystem :machine-learning
    :name "Simple Common Lisp Decision Tree Library."
    :author "Tom Mitchell"
    :version "1.0"
    :depends-on (:arnesi)
    :components ((:file "tree")))
