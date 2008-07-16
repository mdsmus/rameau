(in-package #:cl-user)

(defpackage #:rameau
  (:import-from #:arnesi "AIF" "AWHEN" "IT" "LAST1" "ENABLE-SHARP-L-SYNTAX")
  (:import-from #:alexandria "SWITCH" "FLATTEN")
  (:export
   #:tonal
   #:tempered
   #:a
   #:b
   #:c
   #:d
   #:e
   #:f
   #:g
   #:aes
   #:bes
   #:ces
   #:des
   #:ees
   #:fes
   #:gis
   #:ais
   #:bis
   #:cis
   #:dis
   #:eis
   #:fis
   #:gis
   #:staff
   #:score
   #:no-op-node
   #:ast-node
   #:layout
   #:node-text
   #:node-expr
   #:alg-name
   #:alg-description
   )
  (:shadowing-import-from #:rameau-base #:defun #:defmacro #:defgeneric
                          #:defparameter #:defvar #:defstruct #:defclass)
  (:use #:genoslib  #:cl #:lisp-unit #:iterate)
  (:documentation "The core \\texttt{rameau} framework."))

(in-package :rameau)

(enable-sharp-l-syntax)

(defclass rameau-algorithm ()
    ((name :accessor alg-name :initarg :name)
     (tempered? :accessor alg-tempered? :initarg :tempered?)
     (description :accessor alg-description :initarg :description)))

(defgeneric perform-analysis (segments options algorithm)
  (:documentation "Perform harmonic analysis"))

(defmethod perform-analysis (segments options (algorithm rameau-algorithm))
  (declare (ignore options algorithm))
  (mapcar #L(make-chord :root (print-event-note (first !1))) segments))

(defgeneric do-options (algorithm options)
  (:documentation "Process algorithm-specific options"))

(defmethod do-options ((algorithm rameau-algorithm) options))
  
(defparameter *algorithms* nil)

(defun add-algorithm (alg)
  (push alg *algorithms*))

(defun filter-algorithms (algoritmos)
  "[DONTCHECK]"
  (if algoritmos
      (remove-duplicates
       (loop for alg in algoritmos
          append (loop for i in *algorithms*
                    when (> (count-subseq alg (string-downcase (alg-name i))) 0)
                    collect i)))
    *algorithms*))
