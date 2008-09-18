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
;;; The output matrix will be:
;;;
;;; (degree * key-mode) -> module(note-pitch - key-pitch)
;;;
;;; Which has the unfortunate 8820 entries, also far too many. I don't
;;; think we have enough data to reliably estimate these values, but I
;;; will need to check.
;;;
;;; The keyword :out stands for the beggining/end of a piece. It's the
;;; thing responsible for making sure cadences do happen, for example.

(defun make-number-hash-table (function list)
  (let ((table (make-hash-table :test function)))
    (iter (for i from 0)
          (for el in list)
          (setf (gethash el table) i))
    table))


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
       (transition-inputs (append
                           (list :out)
                           (iter (for d in degrees)
                                (nconcing (iter (for m in key-modes)
                                                (collect (list m d)))))))
       (number->input (vector transition-inputs))
       (input->number (make-number-hash-table #'equalp transition-inputs))
       (transition-outputs (append
                            (list :out)
                            (iter (for pitch from 0 to 95)
                                  (nconcing
                                   (iter (for m in key-modes)
                                         (nconcing
                                          (iter (for d in degrees)
                                                (collect (list pitch m d)))))))))
       (number->toutput (vector transition-outputs))
       (toutput->number (make-number-hash-table #'equalp transition-outputs)))
  (defun number->input (number)
    (svref number->input number))
  (defun input->number (inp)
    (gethash inp input->number :out))
  (defun number->toutput (number)
    (svref number->toutput number))
  (defun toutput->number (toup)
    (gethash toup toutput->number :out))
  (defparameter *ninputs* (length number->input))
  (defparameter *ntoutputs* (length number->toutput))
  (defparameter *nnotes* (get-module))

  (defun make-input (fchord)
    (if (eq :out fchord)
        :out
        (list (tonal-key-mode (fchord-key fchord)) (fchord-roman-function fchord))))
  
  (defun make-toutput (fchord prev)
    (let ((pitch-difference (interval (tonal-key-center-pitch (fchord-key prev))
                                      (tonal-key-center-pitch (fchord-key fchord)))))
      (if (eq :out fchord)
          :out
          (list pitch-difference (tonal-key-mode (fchord-key fchord)) (fchord-roman-function fchord)))))
  
  )

(defun good-turing-reestimate (vector xdim ydim)
  
  )

(defun log-normalize (vec xd yd)
  (let ((pvec (make-array (list xd yd) :initial-element 0d0 :element-type 'double-float))
        (n 0))
    (iter (for i from 0 below xd)
          (iter (for j from 0 below yd)
                (incf n (aref vec i j))))
    (iter (for i from 0 below xd)
          (iter (for j from 0 below yd)
                (setf (aref pvec i j)
                      (log (coerce (/ (aref vec i j) n) 'double-float)))))
    pvec))

(defun estimate-transition-probabilities (fchords)
  (let ((pvec (make-array (list *ninputs* *ntoutputs*) :initial-element 0)))
    (iter (for chorale in fchords)
          (iter (for chord in (append (list :out) chorale (list :out)))
                (for prev previous chord)
                (when (and prev chord)
                  (let ((in (input->number (make-input prev)))
                        (out (toutput->number (make-toutput chord))))
                    (incf (aref pvec in out))))))
    (good-turing-reestimate pvec *ninputs* *ntoutputs*)
    (log-normalize pvec *ninputs* *ntoutputs*)))