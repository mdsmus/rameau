(defpackage :rameau-fhmm
  (:import-from #:arnesi "AIF" "IT" "LAST1" "ENABLE-SHARP-L-SYNTAX" "AWHEN")
  (:shadowing-import-from #:rameau-base #:defun #:defmacro #:defparameter #:defvar #:defstruct)
  (:use #:cl #:rameau #:genoslib #:rameau-options #:iterate)
  (:documentation "A hidden markov model and a bayesian roman numeral functional analysis thingies."))

(in-package :rameau-fhmm)

(enable-sharp-l-syntax)

;;; The plan, so far, is to try to cut as much as humanly possible the
;;; size of the stochastic matrices. This is hard. So, for the
;;; transition matrix, we're doing the following:
;;;
;;; (degree * key-mode) -> module(new-key-pitch - current-key-pitch) * degree * key-mode
;;;
;;; This allows us to have "only" 926100 entries in this matrix ---
;;; far too much, if you ask me, but I have no idea about how can I
;;; break this further down. Probably there will be many virtual 0s in
;;; the modulation parts, but I've got to look at the data to figure
;;; this out.
;;;
;;; The output matrix will be
;;;
;;; key-mode * degree -> (note-pitch - key-pitch)
;;;
;;; Which has the unfortunate 8820 entries, also far too many. I don't
;;; think we have enough data to reliably estimate these values, but I
;;; will need to check.

(let* ((natural-pitches (mapcar #'parse-note '("a" "b" "c" "d" "e" "f" "g")))
       (key-pitches (mapcan #L(list (1- !1) !1 (1+ !1)) natural-pitches))
       (key-modes (list :major :minor))
       (keys (iter (for mode in key-modes)
                   (nconcing (iter (for pitch in key-pitches)
                                   (collect (make-tonal-key :mode mode :center-pitch pitch))))))
       (degree-numbers (list 1 2 3 4 5 6 7))
       (degree-modes (list :major :minor :augmented :diminished :half-diminished))
       (degree-accidentals (list -1 0 1))
       (degrees (iter (for n in degree-numbers)
                      (nconcing
                       (iter (for m in degree-modes)
                             (nconcing
                              (iter (for a in degree-accidentals)
                                    (collect
                                        (make-roman-function :degree-number n
                                                             :degree-accidentals a
                                                             :mode m))))))))
       (total (* (length degrees) (length keys)))
       (totsq (* total 2 (length degrees)))
       (notes (* 2 total)))
  (format t "Estdos internos ~a, transição ~a, output ~a~%" total totsq notes))