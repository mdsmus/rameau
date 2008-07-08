(defpackage :rameau-save
  (:import-from #:arnesi "AIF" "IT" "LAST1")
  (:shadowing-import-from #:rameau-base #:defun #:defmacro #:defparameter #:defvar #:defstruct)
  (:use #:cl #:rameau #:genoslib))

(in-package :rameau-save)

(defparameter *algs-path* (concat *rameau-path* "algorithms/algorithms.store"))

(defun store-algorithms ()
  (cl-store:store *algorithms* *algs-path*))

(defun load-algorithms ()
  (setf *algorithms* (cl-store:restore *algs-path*)))

(eval-when (:load-toplevel)
  (store-algorithms))