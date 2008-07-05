(defpackage :rameau-hmm
  (:import-from #:arnesi "AIF" "IT" "LAST1" "ENABLE-SHARP-L-SYNTAX" "AWHEN")
  (:shadowing-import-from #:rameau-base #:defun #:defmacro #:defparameter #:defvar #:defstruct)
  (:use #:cl #:rameau #:genoslib #:rameau-options))

(in-package :rameau-hmm)


;;; Implementação de um algoritmo para análise harmônica automática
;;; usando modelos de Markov escondidos. A descrição do modelo usado
;;; está em docs/hmm.tex.

