(defpackage :rameau-noisy
  (:import-from #:arnesi "AIF" "AWHEN" "IT" "LAST1" "ENABLE-SHARP-L-SYNTAX")
  (:use :rameau :cl-utils :cl-music :cl :iterate :cl-lily)
  (:documentation "The command to evaluate the experts' frequency of
  agreement."))

(in-package :rameau-noisy)

(enable-sharp-l-syntax)

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
             (format t "~%Confidence interval:
with 95% confidence the real accuracy of the answer sheets
lies between ~,1f% and ~,1f%~%"
                     (* 100 (first ci))
                     (* 100 (second ci))))))))

(register-command :name "calibrate-experts"
                  :documentation "Compute posterior probabilities for
                  agreement between the experts passed as files."
                  :action #'calibrate-experts
                  :options *terminal-options*)

(let* ((natural-pitches (mapcar #'parse-note '("a" "b" "c" "d" "e" "f" "g")))
       (key-pitches (mapcan #L(list (1- !1) !1 (1+ !1)) natural-pitches))
       (key-modes (list :major :minor))
       (keys (iter (for (mode pitch) in (cartesian-product key-modes key-pitches))
                   (collect (make-tonal-key :mode mode
                                            :center-pitch pitch))))
       (degree-numbers (list 1 2 3 4 5 6 7))
       (degree-modes (list :major :minor :augmented :diminished
                           :half-diminished :german-sixth :french-sixth
                           :italian-sixth))
       (degree-accidentals (list -1 0 1))
       (degrees (iter (for (n m a) in (cartesian-product degree-numbers
                                                         degree-modes
                                                         degree-accidentals))
                      (collect (make-roman-function :degree-number n
                                                    :degree-accidentals a
                                                    :mode m))))
       (analysis (cartesian-product keys degrees))
       (number->analysis (coerce analysis 'vector))
       (analysis->number (make-number-hash-table #'equalp analysis)))

  (defun number->analysis (number)
    (svref number->analysis number))
  (defun analysis->number (vit)
    (gethash vit analysis->number 0))

  (defparameter *n* (length number->analysis))
  )

;; quero maximizar
;;  P(p=f|Dados=d) = P(p=f) \prod_{j=1}^m \sum_{i=1}^n P(Correta=c_i|Dados=d_j,p=f).

(defun p-correta-dado-dados-freq (cor dados freq)
  (iter (for j in dados)
        (multiply (if (= cor j)
                      (- 1 freq)
                      (/ freq
                         (- *n* 1))))))

(defun p-freq-given-data (freq data)
 (iter (for j in data)
       (multiply (iter (for i from 0 below *n*)
                       (summing (p-correta-dado-dados-freq i j freq))))))

(defun fchord->number (fchord)
  (analysis->number (fchord->mode fchord)))

(defun plot-likelihoods (options)
  (let* ((answer-sheets (mapcar #'path-parse-functional-answer-sheet
                                (arg :files options)))
         (data (mapcar #L(mapcar #'fchord->number !1)
                       (apply #'zip answer-sheets)))
         (likelihoods (iter (for i from 0.1d0 below 1d0 by 0.01d0)
                            (for log-likelihood = (p-freq-given-data i data))
                            (collect (list log-likelihood i))))
         (values (coerce (mapcar #'second likelihoods) 'vector))
         (likes (coerce (mapcar #'first likelihoods) 'vector))
         (total (iter (for l in-vector likes) (sum l)))
         (mode (iter (for like in-vector likes)
                     (for i from 0)
                     (finding i maximizing like)))
         (confidence 0.95d0))
    (iter (for i from 0 below (length likes))
          (setf (aref likes i) (/ (aref likes i) total)))
    (format t "Mode ~,1f~%" (aref values mode))
    (iter (with up = mode)
          (with down = mode)
          (with all = nil)
          (for mass = (iter (for i from down to up) (summing (aref likes i))))
          (while (and (< mass confidence) (not all)))
          (cond ((and (< 0 down)
                      (< up (1- (length likes))))
                 (if (> (aref likes (1- down)) (aref likes (1+ up)))
                     (decf down)
                     (incf up)))
                ((< 0 down)
                 (decf down))
                ((< up (1- (length likes)))
                 (incf up))
                (t (setf all t)))
          (finally
           (format t "95% confidence interval for the frequency is ~,1f% ~,1f%~%"
                   (* 100 (- 1 (aref values up)))
                   (* 100 (- 1 (aref values down))))))))

(register-command :name "plot-likelihoods"
                  :documentation "Compute confidence interval for
agreement among experts using a bayesian information-theoretical
calculation (work in progress)."
                  :action #'plot-likelihoods
                  :options nil)
