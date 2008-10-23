(defpackage :rameau-test
  (:shadowing-import-from #:cl #:defgeneric #:defclass #:defun #:defmacro #:defparameter #:defvar #:defstruct)
  (:import-from #:arnesi "AIF" "AWHEN" "IT" "LAST1" "ENABLE-SHARP-L-SYNTAX")
  (:use #:cl #:cl-lily #:rameau #:genos-utils :musiclib #:rameau #:iterate #:fiveAM))

(in-package :rameau-test)