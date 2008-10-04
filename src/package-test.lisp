(defpackage :rameau-test
  (:shadowing-import-from #:cl #:defgeneric #:defclass #:defun #:defmacro #:defparameter #:defvar #:defstruct)
  (:import-from #:arnesi "AIF" "AWHEN" "IT" "LAST1" "ENABLE-SHARP-L-SYNTAX")
  (:use #:cl #:cl-lily #:rameau #:genoslib #:rameau #:iterate #:fiveAM))

(in-package :rameau-test)