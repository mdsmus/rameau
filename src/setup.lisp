; Setup
;;; Define rameau-setup package
(defpackage :rameau-setup
  (:import-from #:arnesi "AIF" "AWHEN" "IT" "LAST1" "ENABLE-SHARP-L-SYNTAX")
  (:shadowing-import-from #:rameau-base #:defun #:defmacro #:defparameter #:defvar #:defstruct)
  (:use :rameau :cl :cl-ppcre :iterate :genoslib :rameau-runtests)
  (:documentation "Code for the setup program that drives \\texttt{rameau}"))

(in-package :rameau-setup)


