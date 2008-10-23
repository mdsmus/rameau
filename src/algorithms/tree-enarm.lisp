(defpackage :rameau-tree-enarm
  (:import-from #:arnesi "AIF" "IT" "LAST1" "ENABLE-SHARP-L-SYNTAX")
  (:use #:cl #:rameau #:machine-learning #:musiclib #:genos-utils :cl-lily)
  (:documentation "A decision tree for chord labeling.

One problem with this implementation is that it is not scalable at
all. It only supports sonorities of exactly four pitches. I'll be glad
when it leaves @rameau.
"))

(in-package :rameau-tree-enarm)

(enable-sharp-l-syntax)

(defparameter *attributes* (list
                            (cons 'pitch1 (loop for i from 0 to 95 collect i))
                            (cons 'pitch2 (loop for i from 0 to 95 collect i))
                            (cons 'pitch3 (loop for i from 0 to 95 collect i))
                            (cons 'pitch4 (loop for i from 0 to 95 collect i))
                            ))

(defparameter *names* '(pitch1 pitch2 pitch3 pitch4))
(defparameter *version* 1)

(defparameter *chords*
  (loop for modo in '("" "m" "+" "°" "ø" "!")
        append
        (loop for setima in '("" "7" "7-" "7+")
              append
              (loop for root from 0 to 95 collect
                    (make-chord :root (print-note (code->notename root))
                                :mode modo
                                :7th setima)))))

(defparameter *chord-classes* (mapcar #'make-keyword (mapcar #'stringify (append (list '— 'al+6 'fr+6 'it+6)
                                                                                 *chords*))))

(defun prepare-sonority (segmento)
  (loop for nota in segmento
        for n in *names* collect (cons n (event-pitch nota))))

(defun extract-class (acorde)
  (if (and (chord-p acorde)
           (member (chord-mode acorde) (list "" "m" "°" "!" "+" "ø") :test #'equal))
      (make-keyword
       (stringify
        (make-chord :root (chord-root acorde)
                    :7th (chord-7th acorde)
                    :mode (chord-mode acorde))))
      (if (melodic-note-p acorde)
          (make-keyword "—")
          (make-keyword (stringify acorde)))))

(defun prepare-training-sample (coral gabarito)
  (loop for s in coral
        for g in gabarito
        collect (make-example :name "foo"
                              :class (extract-class g)
                              :values (prepare-sonority s))))

(defun prepare-training-song (corais gabaritos)
  (loop for c in corais
        for g in gabaritos
        nconc (loop for i in *notas-interessantes-tonal*
                    nconc (prepare-training-sample (transpose-segmentos c i)
                                                   (transpose-chords g i)))))

(defun train-chord-tree (alg corais gabaritos)
  (setf (tree-tree alg)
        (id3 (prepare-training-song corais gabaritos) *attributes* *chord-classes*)))

(defun chord-tree-classify (alg segmento)
  (let ((res (classify (make-example :values (prepare-sonority segmento)) (tree-tree alg))))
    (aif (parse-chord res)
         it
         (make-melodic-note))))

(defun do-classification (coral options alg)
  (declare (ignore options))
  (add-inversions coral (mapcar #L(chord-tree-classify alg !1) coral)))

(defclass tree (rameau-algorithm)
  ((tree :accessor tree-tree :initform nil)
   (version :accessor tree-version :initform 0)))

(defmethod you-ok-p ((alg tree))
  (tree-tree alg))

(defun do-train-chord-tree (alg)
  (when *training-data*
    (unless (tree-tree alg)
      (multiple-value-bind (corais gabaritos)
          (unzip *training-data*)
        (train-chord-tree alg corais gabaritos)))))

(defmethod perform-analysis (segments options (alg tree))
  (do-classification segments options alg))

(defmethod do-options ((alg tree) options)
  (when (and (aget :train (arg :options options))
             (not (eql *version* (tree-version alg))))
    (format t "Training tree...~%")
    (do-train-chord-tree alg)
    (setf (tree-version alg) *version*)))

(add-algorithm (make-instance 'tree
                              :name "ES-tree"
                              :description "A decision tree classifier."))