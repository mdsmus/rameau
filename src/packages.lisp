(in-package #:cl-user)

(defpackage #:rameau
  (:import-from #:arnesi "AIF" "AWHEN" "IT" "LAST1" "ENABLE-SHARP-L-SYNTAX")
  (:import-from #:alexandria "SWITCH" "FLATTEN")
  (:export #:alg-name
           #:alg-description
           #:type-list
           #:type-integer
           #:*commands*
           #:parse-file-name
           #:*command-names*
           )
  (:shadowing-import-from #:genos-base #:defun #:defmacro #:defgeneric
                          #:defparameter #:defvar #:defstruct #:defclass)
  (:use #:genos-utils :musiclib #:cl #:iterate #:cl-lily)
  (:documentation "The core @rameau framework."))

(in-package :rameau)

