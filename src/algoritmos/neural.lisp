(eval-when (:compile-toplevel :load-toplevel)
  (asdf:oos 'asdf:load-op :fann))

(defpackage :rameau-neural
  (:import-from #:arnesi "AIF" "AWHEN" "IT" "LAST1" "ENABLE-SHARP-L-SYNTAX")
  (:import-from #:alexandria "SWITCH")
  (:use #:cl #:fann #:rameau #:iterate))

(in-package :rameau-neural)

(load "training")

(defparameter *root-increment* 4)

(defun extract-diffs (segmento)
  (mapcar #'event-pitch segmento))

(defun make-sonority-pattern (seg &optional diff)
  (let ((diff (or diff (extract-diff seg))))
    (mapcar (lambda (x) (coerce x 'float)) (extract-feature-list seg diff))))

(defun make-answer-pattern (gabarito diff)
  (let ((atual (make-list (+ *root-increment* (get-module)) :initial-element 0)))
    (cond ((chord-p gabarito)
           (incf (nth (module (- (parse-note (stringify (chord-root gabarito))) diff)) atual)))
          ((melodic-note-p gabarito)
           (incf (nth (get-module) atual)))
          ((equal 'it (augmented-sixth-type gabarito))
           (incf (nth (1+ (get-module)) atual)))
          ((equal 'al (augmented-sixth-type gabarito))
           (incf (nth (+ 2 (get-module)) atual)))
          ((equal 'fr (augmented-sixth-type gabarito))
           (incf (nth (+ 3 (get-module)) atual)))
          (t (format t "gabarito: ~s ~s~%" 'al (augmented-sixth-type gabarito))))
           
    atual))

(defun extract-root-result (diff output)
  (loop for i from 0
     for r in output
     with maxi = 0
     with maxr = 0
     when (< maxr r) do (setf maxi i maxr r)
     finally (return (cond ((= (get-module) maxi)
                            (make-melodic-note))
                           ((> (get-module) maxi)
                            (make-chord :root (print-note (code->notename (module (+ diff maxi)))
                                                              'latin)))
                           ((= (+ 1 (get-module)) maxi)
                            (make-augmented-sixth :type "IT"))
                           ((= (+ 2 (get-module)) maxi)
                            (make-augmented-sixth :type "AL"))
                           ((= (+ 3 (get-module)) maxi)
                            (make-augmented-sixth :type "FR"))
                           (t (format t "module: ~a, maxi: ~a, output: ~a" (get-module) maxi output)
                              (error "erro"))))))


(defparameter *mode-length* 5)
(defparameter *7th-length* 4)

(defun make-empty-pattern ()
  (repeat-list (+ *mode-length* *7th-length*) 0))

(defun make-pattern-7th (7th)
  (let ((pattern (repeat-list *7th-length* 0))
        (*package* (find-package :rameau)))
    (incf (nth (switch (7th :test 'equal)
                 ("" 0)
                 ("7" 1)
                 ("7-" 2)
                 ("7+" 3))
               pattern))
    pattern))

(defun extract-7th (lista)
  (loop for i from 0
     for l in lista
     with maxi = 0
     with maxl = (first lista)
     when (< maxl l) do (setf maxi i maxl l)
     finally (return
               (case maxi
                 (0 "")
                 (1 "7")
                 (2 "7-")
                 (3 "7+")
                 (t (error "Sétima não encontrada"))))))

(defun make-mode-pattern (modo)
  (let ((pattern (repeat-list *mode-length* 0)))
    (incf (nth (switch (modo :test 'equal)
                 ("" 0)
                 ("m" 1)
                 ("+" 2)
                 ("°" 3)
                 ("ø" 3)
                 ("!" 4))
               pattern))
    pattern))

(defun extract-mode (modo 7th)
  (loop for i from 0
     for m in modo
     with maxi = 0
     with maxm = (first modo)
     when (< maxm m) do (setf maxm m maxi i)
     finally (return
               (case maxi
                 (0 "")
                 (1 "m")
                 (2 "+")
                 (3 (if (equal "7" 7th) "ø" "°"))
                 (4 "!")))))

(defun make-mode-answer-pattern (gabarito)
  (if (chord-p gabarito)
      (append (make-mode-pattern (chord-mode gabarito))
              (make-pattern-7th (chord-7th gabarito)))
      (make-empty-pattern)))

(defun make-chord-answer-pattern (gabarito diff)
  (append (make-answer-pattern gabarito diff)
          (make-mode-answer-pattern gabarito)))

(defun get-class-chord-net (diff res)
  (let ((root (extract-root-result
                      diff
                      (firstn res (+ *root-increment* (get-module)))))
        (resto (nthcdr (+ *root-increment* (get-module)) res)))
    (if (chord-p root)
        (let* ((7th (extract-7th (nthcdr *mode-length* resto)))
               (mode (extract-mode (firstn resto *mode-length*) 7th)))
          
          (make-chord :root (chord-root root)
                      :mode mode
                      :7th 7th))
        root)))


(register-algorithm "ES-net" #'apply-e-chord-net)

(defparameter *context-before* 1)
(defparameter *context-after* 1)

(defun context-extract-diffs (segmento)
  (extract-diffs (nth *context-before* segmento)))

(defun context-extract-diff (segmentos)
  (extract-diff (nth *context-before* segmentos)))

(defun context-extrai-features (segmento &optional diff)
  (let ((diff (or diff (context-extract-diff segmento))))
    (loop for s in segmento nconc (make-sonority-pattern s diff))))

(register-algorithm "EC-net" #'apply-context-net)
