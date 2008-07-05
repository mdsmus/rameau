(defpackage :rameau-hmm
  (:import-from #:arnesi "AIF" "IT" "LAST1" "ENABLE-SHARP-L-SYNTAX" "AWHEN")
  (:shadowing-import-from #:rameau-base #:defun #:defmacro #:defparameter #:defvar #:defstruct)
  (:use #:cl #:rameau #:genoslib #:rameau-options #:iterate))

(in-package :rameau-hmm)

(enable-sharp-l-syntax)

;;; Implementação de um algoritmo para análise harmônica automática
;;; usando modelos de Markov escondidos. A descrição do modelo usado
;;; está em docs/hmm.tex.

(defclass hmm (rameau-algorithm)
  ((transitions :accessor trans :initform nil)
   (initial-transitions :accessor start-trans :initform nil)
   (chord-notes :accessor notes :initform nil)))

(defparameter *chords*
  (iter (for root from 0 to 95)
        (appending (iter (for mode in '("" "m" "+" "°" "ø" "!"))
                         (appending (iter (for seventh in '("" "7" "7-" "7+"))
                                          (collect (make-chord :root (print-note (code->notename root) 'latin)
                                                               :mode mode
                                                               :7th seventh))))))))

(defparameter *nct* (list (make-melodic-note)))
(defparameter *aug6s* (iter (for type in '("al" "fr" "it"))
                            (collect (make-augmented-sixth :type type))))

(defparameter *labels* (append *chords* *nct* *aug6s*))
(defparameter *nlabels* (length *labels*))

(defun label->list (label)
  (cond ((chord-p label)
         (list :chord (chord-mode label) (chord-root label) (chord-7th label)))
        ((melodic-note-p label)
         (list :melodic-note))
        ((augmented-sixth-p label)
         (list :augmented-sixth (augmented-sixth-type label)))
        (t (list :other))))

(defparameter *llabels* (mapcar #'label->list *labels*))
         
(defun label->number (label)
  (position (label->list label) *llabels* :test #'equal))

(defun number->label (number)
  (nth number *labels*))

(defun transpose-96 (data)
  (destructuring-bind (coral gabarito) data
    (iter (for i from 0 to 95)
          (collect (list (transpose-segmentos coral i)
                         (transpose-chords gabarito i))))))

(defun collect-pairs (data)
  (iter (for (chorale answer) in data)
        (nconcing (iter (for c in chorale)
                        (for a in answer)
                        (collect (list c a))))))

(defun estimate-transitions (chords)
  (let ((chords (mapcar #'label->number chords))
        (transitions (make-array (list *nlabels* *nlabels*) :initial-element 1.0d0 :element-type 'double-float)))
    (iter (for c in chords)
          (for p previous c)
          (when (and p c)
            (incf (aref transitions p c))))
    (iter (for c from 0 below *nlabels*)
          (let ((sum (iter (for j from 0 below *nlabels*) (sum (aref transitions c j)))))
            (iter (for j from 0 below *nlabels*)
                  (setf (aref transitions c j) (log (/ (aref transitions c j) sum))))))
    transitions))

(defun estimate-chord-probabilities (chords)
  (let ((chords (mapcar #'label->number chords))
        (probs (make-array (list *nlabels*) :initial-element 1d0 :element-type 'double-float)))
    (iter (for c in chords)
          (incf (aref probs c)))
    (let ((sum (iter (for c from 0 below *nlabels*) (sum (aref probs c)))))
      (iter (for c from 0 below *nlabels*)
            (setf (aref probs c) (log (/ (aref probs c) sum)))))
    probs))

(defun estimate-chord-notes (pairs)
  (let ((pairs (mapcar #L(list (label->number (second !1)) (mapcar #'event-pitch (first !1)))
                       pairs))
        (probs (make-array (list *nlabels* 96) :initial-element 1d0 :element-type 'double-float)))
    (iter (for (label notes) in pairs)
          (iter (for n in notes)
                (incf (aref probs label n))))
    (iter (for i from 0 below *nlabels*)
          (let ((sum (iter (for j from 0 below 96) (sum (aref probs i j)))))
            (iter (for j from 0 below 96)
                  (setf (aref probs i j) (log (/ (aref probs i j) sum))))))
    probs))

(defun train-hmm (alg)
  (let* ((training-data (mapcan #'transpose-96 *training-data*))
         (chords (mapcar #'second training-data))
         (pairs (collect-pairs training-data)))
    (setf (trans alg) (estimate-transitions chords)
          ;(start-trans alg) (estimate-chord-probabilities chords)
          (notes alg) (estimate-chord-notes pairs))))

(defmethod do-options ((alg hmm) options)
  (when (aget :train (arg :options options))
    (train-hmm alg)))

(defun notes-probabilities (segment notes chord)
  (let ((pitches (mapcar #'event-pitch segment)))
    (iter (for p in pitches)
          (sum (aref notes chord p)))))

(defun viterbi-decode (segments alg)
  (let* ((tran (trans alg))
         ;(ini (start-trans alg))
         (notes (notes alg))
         (size (length segments))
         (tp (make-array (list size *nlabels*) :element-type 'double-float))
         (m (make-array (list size *nlabels*) :element-type 'integer)))
    (iter (for j from 0 below *nlabels*)
          (setf (aref tp 0 j) (notes-probabilities (first segments) notes j)))
    (iter (for i from 1 below size)
          (for seg in (cdr segments))
          (iter (for j from 0 below *nlabels*)
                (let ((maxjp 0)
                      (maxp most-negative-double-float)
                      (np (notes-probabilities seg notes j)))
                  (iter (for jp from 0 below *nlabels*)
                        (let ((p (+ (aref tp (1- i) jp)
                                    (aref tran jp j)
                                    np)))
                          (when (> p maxp)
                            (setf maxp p
                                  maxjp jp))))
                  (setf (aref tp i j) maxp)
                  (setf (aref m i j) maxjp))))
    (let ((chords (let ((maxp most-negative-double-float)
                        (maxj 0)
                        (i (1- size)))
                    (iter (for j from 0 below *nlabels*)
                          (when (> (aref tp i j) maxp)
                            (setf maxp (aref tp i j)
                                  maxj j)))
                    (list maxj)))
          j)
      (setf j (first chords))
      (iter (for i from (1- size) downto 1)
            (push (aref m i j) chords)
            (setf j (aref m i j)))
      (mapcar #'number->label chords))))

(defmethod perform-analysis (segments options (alg hmm))
  (declare (ignore options))
  (add-inversions segments (viterbi-decode segments alg)))

(add-algorithm (make-instance 'hmm
                              :name "EC-Hmm"
                              :description "A Hidden Markov Model for chord labeling."))