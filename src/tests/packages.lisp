(in-package #:cl-user)

(defpackage :rameau-test
  (:shadowing-import-from #:cl #:defgeneric #:defclass #:defun #:defmacro #:defparameter #:defvar #:defstruct)
  (:use #:cl #:rameau #:genoslib #:rameau-main #:lisp-unit))
