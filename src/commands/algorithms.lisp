(defpackage :rameau-alg-commands
  (:import-from #:arnesi "AIF" "AWHEN" "IT" "LAST1" "ENABLE-SHARP-L-SYNTAX")
  (:use :rameau :cl-utils :cl-music :cl :iterate :cl-lily)
  (:documentation "The algorithm training commands for @rameau"))

(in-package :rameau-alg-commands)

(defun make-training-data (options)
  "Make training data using the information in @var{options} for chord
labeling algorithms."
  (setf *training-data*
        (iter (for f in (arg :files options))
              (awhen (path-parse-answer-sheet (format nil "~a" f))
                (collect (list (sonorities (parse-file f))
                               it))))))

(defun make-functional-training-data (options)
  "Make training data using the information in @var{options} for roman
numeral functional analysis algorithms."
  (setf *training-data*
        (iter (for f in (arg :files options))
              (awhen (path-parse-functional-answer-sheet (format nil "~a" f))
                (collect (list (sonorities (parse-file f))
                               it))))))

(defun %load-algs (options &key type)
  (mapcar #'load-alg (filter-algorithms (arg :algorithms options)
                                        (case type
                                          (:func *functional-algorithms*)
                                          (t *algorithms*)))))

(defun algorithms (options)
  "Gives the command-line options in options to the algorithms."
  (make-training-data options)
  (setf (arg :algorithms options) (%load-algs options)
        (arg :options options) (process-option-list (arg :options options)))
  (iter (for alg in (arg :algorithms options))
        (do-options alg options)
        (save-alg alg))
  (setf (arg :algorithms options) nil
        *training-data* nil))

(register-command :name "algorithms"
                  :documentation "Give the specified chord-labeling
                  algorithms the options passed with -o. Used for
                  training."
                  :action #'algorithms)

(defun funalg (options)
  "Give the command-line options to the functional algorithms."
  (make-functional-training-data options)
  (setf (arg :algorithms options) (%load-algs options :type :func)
        (arg :options options) (process-option-list (arg :options options)))
  (iter (for alg in (arg :algorithms options))
        (format t "Options for ~a~%" (alg-name alg))
        (do-options alg options)
        (save-alg alg))
  (setf (arg :algorithms options) nil
        *training-data* nil))

(register-command :name "funalg"
                  :documentation "Give the specified roman numeral
                  functional analysis algorithms the options passed
                  with -o. Used for training."
                  :action #'funalg)
