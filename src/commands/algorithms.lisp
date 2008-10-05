(defpackage :rameau-alg-commands
  (:shadowing-import-from #:rameau-base #:defun #:defmacro #:defgeneric
                          #:defparameter #:defvar #:defstruct #:defclass)
  (:import-from #:arnesi "AIF" "AWHEN" "IT" "LAST1" "ENABLE-SHARP-L-SYNTAX")
  (:use :rameau :genoslib :cl :iterate :cl-lily)
  (:documentation "The algorithm training commands for @var{rameau}"))

(in-package :rameau-alg-commands)

(defun make-training-data (options)
  (setf *training-data*
        (iter (for f in (arg :files options))
              (awhen (path-parse-answer-sheet (format nil "~a" f))
                (collect (list (sonorities (parse-file f))
                               it))))))

(defun make-functional-training-data (options)
  (setf *training-data*
        (iter (for f in (arg :files options))
              (awhen (path-parse-functional-answer-sheet (format nil "~a" f))
                (collect (list (sonorities (parse-file f))
                               it))))))

(defun algorithms (options)
  (make-training-data options)
  (setf (arg :algorithms options) (mapcar #'load-alg (filter-algorithms (arg :algorithms options) *algorithms*))
        (arg :options options) (process-option-list (arg :options options)))
  (iter (for alg in (arg :algorithms options))
        (do-options alg options)
        (save-alg alg))
  (setf (arg :algorithms options) nil
        *training-data* nil))

(register-command :name "algorithms"
                  :documentation   "Give the specified chord-labeling algorithms the options passed with -o. Used for training."
                  :action #'algorithms)

(defun funalg (options)
  (make-functional-training-data options)
  (setf (arg :algorithms options) (mapcar #'load-alg (filter-algorithms (arg :algorithms options) *functional-algorithms*))
        (arg :options options) (process-option-list (arg :options options)))
  (iter (for alg in (arg :algorithms options))
        (format t "Options for ~a~%" (alg-name alg))
        (do-options alg options)
        (save-alg alg))
  (setf (arg :algorithms options) nil
        *training-data* nil))

(register-command :name "funalg"
                  :documentation "Give the specified roman numeral functional analysis algorithms the options passed with -o. Used for training."
                  :action #'algorithms)
