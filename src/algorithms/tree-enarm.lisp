(eval-when (:compile-toplevel :load-toplevel)
  (asdf:oos 'asdf:load-op :machine-learning))

(defpackage :rameau-tree-enarm
  (:import-from #:arnesi "AIF" "IT" "LAST1")
  (:shadowing-import-from #:rameau-base #:defun #:defmacro #:defparameter #:defvar #:defstruct)
  (:use #:cl #:rameau #:machine-learning #:genoslib))

(in-package :rameau-tree-enarm)



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


(defparameter *chord-tree* nil)

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

(defun train-chord-tree (corais gabaritos)
  (setf *chord-tree* (id3 (prepare-training-song corais gabaritos)
                          *attributes*
                          *chord-classes*)))

(defun chord-tree-classify (segmento)
  (let ((res (classify (make-example :values (prepare-sonority segmento)) *chord-tree*)))
    (aif (parse-chord res)
         it
         (make-melodic-note))))

(defun show-chord-tree (&rest args)
  (declare (ignore args))
  (print-tree *chord-tree*))

(defun do-classification (coral &rest ignore)
  (declare (ignore ignore))
  (dbg 'rameau::mostra-arvore "Arvore: ~/rameau-tree-enarm::show-chord-tree/ ~%" *chord-tree*)
  (add-inversions coral (mapcar #'chord-tree-classify coral)))

(register-algorithm "ES-tree" #'do-classification)

(defun do-train-chord-tree ()
  (multiple-value-bind (corais gabaritos)
      (unzip *training-data*)
    (train-chord-tree corais gabaritos)))

(do-train-chord-tree)

