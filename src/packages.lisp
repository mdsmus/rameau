(in-package #:cl-user)

(defpackage #:rameau
  (:import-from #:arnesi "AIF" "AWHEN" "IT" "LAST1" "ENABLE-SHARP-L-SYNTAX")
  (:import-from #:alexandria "SWITCH" "FLATTEN")
  (:shadowing-import-from #:rameau-base #:defun #:defmacro #:defgeneric
                          #:defparameter #:defvar #:defstruct #:defclass)
  (:use #:genoslib  #:cl #:lisp-unit))

(in-package :rameau)

(defstruct algorithm
  name
  classify
  tempered?)

(defparameter *algorithms* nil)

(defun register-algorithm (nome processa &optional tempered?)
  "[DONTCHECK]"
  (push (make-algorithm :name nome :classify processa :tempered? tempered?)
        *algorithms*))

(defun filter-algorithms (algoritmos)
  "[DONTCHECK]"
  (if algoritmos
      (remove-duplicates
       (loop for alg in algoritmos
          append (loop for i in *algorithms*
                    when (> (count-subseq alg (string-downcase (algorithm-name i))) 0)
                    collect i)))
    *algorithms*))
