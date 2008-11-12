(defpackage :rameau-noisy
  (:import-from #:arnesi "AIF" "AWHEN" "IT" "LAST1" "ENABLE-SHARP-L-SYNTAX")
  (:use :rameau :cl-utils :cl-music :cl :iterate :cl-lily)
  (:documentation "The command to evaluate the experts' frequency of
  agreement."))

(in-package :rameau-noisy)

(defun fchord->mode (fchord)
  (list (fchord-key fchord) (fchord-roman-function fchord)))

(defun count-fchord (answer-sheets)
  (let ((counts (make-hash-table :test #'equalp)))
    (iter (for as in answer-sheets)
          (when (eql :not-there (gethash (fchord->mode as)
                                         counts
                                         :not-there))
            (setf (gethash (fchord->mode as) counts) 0))
          (incf (gethash (fchord->mode as) counts)))
    (all-elements-hash counts)))

(defun maximum-fchord (answer-sheets)
  (iter (for (mode count) in (count-fchord answer-sheets))
        (finding (list count mode) maximizing count)))

(defun calibrate-experts (options)
  (let ((answer-sheets (mapcar #'path-parse-functional-answer-sheet
                               (arg :files options)))
        (size (hline-size (length (arg :files options)) options)))
    (print-line-term options "#" "" "")
    (iter (for file in (arg :files options))
          (print-chord-column options (pathname-name file)))
    (print-hline-term size)
    (iter (with n = (length answer-sheets))
          (with corrects = 0)
          (with totals = 0)
          (for numero from 0)
          (for i in (apply #'zip answer-sheets))
          (for (count mode) = (maximum-fchord i))
          (incf corrects count)
          (incf totals n)
          (print-line-term options numero "" "")
          (iter (for a in i)
                (print-color-terminal a (equalp (fchord->mode a) mode) options))
          (finally
           (let ((ci (rameau-stat::beta-ci 0.95 corrects totals)))
             (format t "~%Ci: 95% confidence between ~,1f% ~,1f%~%"
                     (* 100 (first ci))
                     (* 100 (second ci))))))))



(register-command :name "calibrate-experts"
                  :documentation "Compute posterior probabilities for
                  agreement between the experts passed as files."
                  :action #'calibrate-experts
                  :options *terminal-options*)