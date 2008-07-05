(eval-when (:compile-toplevel :load-toplevel)
  (asdf:oos 'asdf:load-op :machine-learning))

(defpackage :rameau-tree-enarm
  (:import-from #:arnesi "AIF" "IT" "LAST1" "ENABLE-SHARP-L-SYNTAX")
  (:shadowing-import-from #:rameau-base #:defun #:defmacro #:defparameter #:defvar #:defstruct)
  (:use #:cl #:rameau #:machine-learning #:genoslib #:rameau-options))

(in-package :rameau-tree-enarm)

(enable-sharp-l-syntax)

(defparameter *attributes* (list
                           (cons 'pitch1 (loop for i from 0 to 95 collect i))
                           (cons 'pitch2 (loop for i from 0 to 95 collect i))
                           (cons 'pitch3 (loop for i from 0 to 95 collect i))
                           (cons 'pitch4 (loop for i from 0 to 95 collect i))
                            ))

(defparameter *names* '(pitch1 pitch2 pitch3 pitch4))

(defparameter *chords*
  (loop for modo in '("" "m" "+" "°" "ø" "!")
     append
       (loop for setima in '("" "7" "7-" "7+")
          append
            (loop for root from 0 to 95 collect
                 (make-chord :root (print-note (code->notename root))
                             :mode modo
                             :7th setima)))))

(defparameter *chord-classes* (mapcar #'string->symbol (mapcar #'stringify (append (list '— 'al+6 'fr+6 'it+6)
                                                                                   *chords*))))

(defun prepare-sonority (segmento)
  (loop for nota in segmento
     for n in *names* collect (cons n (event-pitch nota))))

(defun extract-class (acorde)
  (if (and (chord-p acorde)
           (member (chord-mode acorde) (list "" "m" "°" "!" "+" "ø") :test #'equal))
      (string->symbol
       (stringify
        (make-chord :root (chord-root acorde)
                    :7th (chord-7th acorde)
                    :mode (chord-mode acorde))))
      (if (melodic-note-p acorde)
          (string->symbol "—")
          (string->symbol (stringify acorde)))))


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

(defun do-train-chord-tree (alg)
  (multiple-value-bind (corais gabaritos)
      (unzip *training-data*)
    (train-chord-tree alg corais gabaritos)))

(defclass tree (rameau-algorithm)
  ((tree :accessor tree-tree :initform nil)))

(defmethod perform-analysis (segments options (alg tree))
  (do-classification segments options alg))

(defmethod do-options ((alg tree) options)
  (when (aget :train (arg :options options))
    (do-train-chord-tree alg)))

(add-algorithm (make-instance 'tree
                              :name "ES-tree"
                              :description "A decision tree classifier."))