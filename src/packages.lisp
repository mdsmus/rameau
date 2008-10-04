(in-package #:cl-user)

(defpackage #:rameau
  (:import-from #:arnesi "AIF" "AWHEN" "IT" "LAST1" "ENABLE-SHARP-L-SYNTAX")
  (:import-from #:alexandria "SWITCH" "FLATTEN")
  (:export #:tonal
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
           #:type-list
           #:type-integer
           #:*commands*
           #:parse-file-name
           #:*command-names*
           )
  (:shadowing-import-from #:rameau-base #:defun #:defmacro #:defgeneric
                          #:defparameter #:defvar #:defstruct #:defclass)
  (:use #:genoslib #:cl #:iterate #:cl-who #:cl-lily)
  (:documentation "The core \\texttt{rameau} framework."))

(in-package :rameau)

