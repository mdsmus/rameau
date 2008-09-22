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
;;;
;;; The by far biggest table is the viterbi table. It has to really
;;; encompass all possibilities for each sonority (as far as I can
;;; tell there is no trivial way of cutting it down). Its dimensions
;;; are:
;;;
;;; (key * degree) -> sonority

(defparameter *version* 6)

(eval-when (:compile-toplevel :load-toplevel)
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
                           (list (list :out))
                           (iter (for d in degrees)
                                (nconcing (iter (for m in key-modes)
                                                (collect (list m d)))))))
       (number->input (coerce transition-inputs 'vector))
       (input->number (make-number-hash-table #'equalp transition-inputs))
       (transition-outputs (append
                            (list (list :out))
                            (iter (for pitch from 0 to 95)
                                  (nconcing
                                   (iter (for m in key-modes)
                                         (nconcing
                                          (iter (for d in degrees)
                                                (collect (list pitch m d)))))))))
       (number->toutput (coerce transition-outputs 'vector))
       (toutput->number (make-number-hash-table #'equalp transition-outputs))
       (viterbi-degrees (append (list (list :out))
                                (iter (for k in keys)
                                      (nconcing
                                       (iter (for d in degrees)
                                             (collect (list k d)))))))
       (number->viterbi (coerce viterbi-degrees 'vector))
       (viterbi->number (make-number-hash-table #'equalp viterbi-degrees)))
  (defun number->input (number)
    (svref number->input number))
  (defun input->number (inp)
    (gethash inp input->number 0))
  (defun number->toutput (number)
    (svref number->toutput number))
  (defun toutput->number (toup)
    (gethash toup toutput->number 0))
  (defun number->viterbi (number)
    (svref number->viterbi number))
  (defun viterbi->number (vit)
    (gethash vit viterbi->number 0))

  (defparameter *ninputs* (length number->input))
  (defparameter *ntoutputs* (length number->toutput))
  (defparameter *nnotes* (get-module))
  (defparameter *nviterbis* (length number->viterbi))
  ))

(defun nviterbi->ninput (viterbi)
  (destructuring-bind (key &optional degree) (number->viterbi viterbi)
    (if (eq :out key)
        (input->number (list :out))
        (input->number (list (tonal-key-mode key) degree)))))

(defun nviterbi->toutput (viterbi prev-viterbi)
  (destructuring-bind (key &optional degree) (number->viterbi viterbi)
    (destructuring-bind (pkey &optional pdegree) (number->viterbi prev-viterbi)
      (declare (ignore pdegree))
      (let ((pitch (cond ((and (eq key pkey) (eq :out key)) 0)
                         ((eq :out key) (tonal-key-center-pitch pkey))
                         ((eq :out pkey) (tonal-key-center-pitch key))
                         (t (interval (tonal-key-center-pitch key) (tonal-key-center-pitch pkey)))))
            (mode (if (eq :out key)
                      :major
                      (tonal-key-mode key))))
        (toutput->number (list pitch mode degree))))))

(defun nviterbi->first-toutput (viterbi)
  (destructuring-bind (key &optional degree) (number->viterbi viterbi)
    (if (eq :out key)
        0
        (let ((pitch (tonal-key-center-pitch key))
              (mode (tonal-key-mode key)))
          (toutput->number (list pitch mode degree))))))

(defun nviterbi->base-pitch (viterbi)
    (destructuring-bind (key &optional degree) (number->viterbi viterbi)
      (declare (ignore degree))
      (tonal-key-center-pitch key)))

(defun nviterbi->fchord (nviterbi)
  (destructuring-bind (key &optional degree) (number->viterbi nviterbi)
    (make-fchord :key key :roman-function degree)))

(defun make-input (fchord)
  (if (eq :out fchord)
      (list :out)
      (list (tonal-key-mode (fchord-key fchord)) (fchord-roman-function fchord))))

(defun pitch-difference (fchord prev)
  (cond ((and (fchord-p fchord) (fchord-p prev))
         (interval (tonal-key-center-pitch (fchord-key prev))
                   (tonal-key-center-pitch (fchord-key fchord))))
        ((and (not (fchord-p fchord))
              (not (fchord-p prev)))
         0)
        ((not (fchord-p fchord))
         (tonal-key-center-pitch (fchord-key prev)))
        (t (tonal-key-center-pitch (fchord-key fchord)))))
  
(defun make-toutput (fchord prev)
  (let ((pitch-difference (pitch-difference fchord prev)))
    (if (eq :out fchord)
        (list :out)
        (list pitch-difference (tonal-key-mode (fchord-key fchord)) (fchord-roman-function fchord)))))

(defun notes-probs (vector nviterbi sonority)
  (destructuring-bind (key &optional degree) (number->viterbi nviterbi)
    (declare (ignore degree))
    (if (eq :out key)
        0
        (let ((center-pitch (tonal-key-center-pitch key))
              (input (nviterbi->ninput nviterbi)))
          (iter (for pitch in sonority)
                (sum (aref vector input (interval center-pitch pitch))))))))

(defun not-zero (value not-zero)
  (if (= 0d0 value)
      not-zero
      value))

(defun dirichlett-smooth (array sizea sizeb)
  (iter (for i from 0 below sizea)
        (declare (fixnum i))
        (let ((sum (iter (for j from 0 below sizeb) (sum (aref array i j))))
              (zeros (iter (for j from 0 below sizeb) (counting (= 0 (aref array i j))))))
          (iter (for j from 0 below sizeb)
                (setf (aref array i j)
                      (log (/ (not-zero (aref array i j) (/ 1 (+ 0.00000001d0 zeros))) (1+ sum)))))))
  array)

(defun get-tran (vector vit pvit)
  (aref vector (nviterbi->ninput pvit) (nviterbi->toutput vit pvit)))

(defun estimate-transition-probabilities (fchords)
  (let ((pvec (make-array (list *ninputs* *ntoutputs*) :initial-element 0)))
    (iter (for chorale in fchords)
          (iter (for chord in (append (list :out) chorale (list :out)))
                (for prev previous chord)
                (when (and prev chord)
                  (let ((in (input->number (make-input prev)))
                        (out (toutput->number (make-toutput chord prev))))
                    (incf (aref pvec in out))))))
    (dirichlett-smooth pvec *ninputs* *ntoutputs*)))

(defun estimate-note-probabilities (fchords chorales)
  (let ((pvec (make-array (list *ninputs* *nnotes*) :initial-element 0)))
    (iter (for chords in fchords)
          (for chorale in chorales)
          (iter (for chord in chords)
                (for sonority in chorale)
                (iter (for p in (mapcar #'event-pitch sonority))
                      (incf (aref pvec
                                  (input->number (make-input chord))
                                  (interval (tonal-key-center-pitch (fchord-key chord)) p))))))
    (dirichlett-smooth pvec *ninputs* *nnotes*)))

(defun train-functional-hmm (alg)
  (let ((fchords (mapcar #'second *training-data*))
        (segments (mapcar #'first *training-data*)))
    (setf (trans alg) (estimate-transition-probabilities fchords)
          (out alg) (estimate-note-probabilities fchords segments))
    alg))

(defclass functional-hmm (rameau-algorithm)
  ((transitions :accessor trans :initform nil)
   (outputs :accessor out :initform nil)
   (version :accessor version :initform 0)))

(defmethod do-options ((alg functional-hmm) options)
  (when (and (aget :train (arg :options options))
             (not (eql *version* (version alg))))
    (train-functional-hmm alg)
    (setf (version alg) *version*)))

(defun viterbi-decode (alg segments)
  (let* ((tran (trans alg))
         (out (out alg))
         (nsegs (length segments))
         (table (make-array (list (1+ nsegs) *nviterbis*)  :initial-element 0d0))
         (mtable (make-array (list (1+ nsegs) *nviterbis*) :initial-element 0d0))
         cache)
    (dbg :fhmm "Tran ~a, out ~a, nseg ~a, table ~a, mtable ~a, version ~a~%"
         (type-of tran) (type-of out) nsegs (type-of table) (type-of mtable) (version alg))
    (iter (for j from 0 below *nviterbis*)
          (for s = (mapcar #'event-pitch (first segments)))
          (setf (aref table 0 j)
                (+ (aref tran (input->number (list :out)) (nviterbi->first-toutput j))
                   (notes-probs out j s)))
          (setf cache (clip 10 (insert (list (aref table 0 j) (aref mtable 0 j) 0 j) cache :less #'> :key #'first))))
    (dbg :fhmm "Done setting the first row.~%")
    (iter (for i from 0)
          (for seg in segments)
          (for s = (mapcar #'event-pitch seg))
          (for pseg previous seg)
          (for newcache = nil)
          (when (and seg pseg)
            (dbg :fhmm "Doing row ~a~%" i)
            (iter (for j from 1 below *nviterbis*)
                  (dbg :fhmm "  Doing column ~a~%" j)
                  (let ((probabilities (notes-probs out j s))
                        (values (iter (for (vtab vmtab previ jj) in cache)
                                      ;(dbg :fhmm "    Doing pre-column ~a~%" jj)
                                      (finding (list (+ (aref table (1- i) jj)
                                                        (get-tran tran j jj))
                                                     jj)
                                               maximizing (+ (aref table (1- i) jj)
                                                             (get-tran tran j jj))))))
                    (setf (aref table i j) (+ (* 2 probabilities) (first values))
                          (aref mtable i j) (second values)
                          newcache (clip 10 (insert (list (aref table i j) (aref mtable i j) i j) newcache :less #'> :key #'first)))))
            (setf cache newcache)))
    (dbg :fhmm "Done building table~%")
    (let ((chords (iter (for (vtab vmtab previ jj) in cache)
                        (finding (list jj)
                                 maximizing (+ (aref table (1- nsegs) jj)
                                               (get-tran tran 0 jj))))))
      (dbg :fhmm "Chords: ~a ~%" chords)
      (iter (for i from (- nsegs 1) downto 1)
            (push (aref mtable i (first chords)) chords)
            (dbg :fhmm "  now: ~a ~%" chords))
      (mapcar #'nviterbi->fchord chords))))

(defmethod functional-analysis (segments options (alg functional-hmm))
  (viterbi-decode alg segments))

(add-falgorithm (make-instance 'functional-hmm
                               :name "F-Hmm"
                               :description "A roman numeral functional analysis algorithm based on Raphael and Stoddard."))

;; (trace train-functional-hmm)
;; (rameau-main:main "functional -f chor:006")
;; (trans (load-alg(first *functional-algorithms*)))