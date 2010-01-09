;;; -*- Mode: Lisp ; Base: 10 ; Syntax: ANSI-Common-Lisp -*-
;;;;; Miscellaneous utilities related to hash-tables

(in-package :fare-utils)

(defun alist->hash-table (alist &key (test #'eql))
  (loop
      with h = (make-hash-table :test test :size (length alist))
      for (k . v) in alist
      do (setf (gethash k h) v)
      finally (return h)))

(defun hash-table->alist (table)
  (loop for key being the hash-keys of table using (hash-value value)
	collect (cons key value)))

(defmacro hashmacro (name &rest rest)
  (with-gensyms (hashname)
  `(let ((,hashname (make-hash-table ,@rest)))
     (defmacro ,name (obj) `(gethash ,obj ,,hashname)))))

(defmacro hashmacros (&rest names)
  `(mapmacro hashmacro ,names))
