;;; load fann
(eval-when (:compile-toplevel :load-toplevel)
  (asdf:oos 'asdf:load-op :fann))

;;; define package
(defpackage :rameau-neural
  (:import-from #:arnesi "AIF" "AWHEN" "IT" "LAST1" "ENABLE-SHARP-L-SYNTAX")
  (:import-from #:alexandria "SWITCH")
  (:shadowing-import-from #:rameau-base #:defun #:defmacro #:defparameter #:defvar #:defstruct)
  (:use #:cl #:fann #:rameau #:iterate #:rameau-options #:genoslib))

(in-package :rameau-neural)

;;; general parameters
(enable-sharp-l-syntax)

(defparameter *root-increment* 4)
(defparameter *mode-length* 5)
(defparameter *7th-length* 4)
(defparameter *context-before* 1)
(defparameter *context-after* 1)
(defvar *e-chord-net* nil)
(defvar *context-net* nil)

;;; general functions
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

(defun prepare-training-data-net (coral gabarito &optional
                                        (diff-func #'extract-diffs)
                                        (feature #'make-sonority-pattern))
  (loop for c in coral
     for gab in gabarito
     for ds = (funcall diff-func c)
     if (listp gab)
       nconc (prepare-training-data-net (repeat-list (length gab) c)
                                              gab diff-func feature)
     else
       nconc (loop for d in ds
                nconc (list (list (funcall feature c d)
                                  (make-chord-answer-pattern gab d))))))

(defun run-my-net (x net extract-diff-fn fn)
  (let ((d (funcall extract-diff-fn x)))
    (get-class-chord-net d (run-net net (funcall fn x d)))))

(defun write-data-set (data training-data value)
  (let ((size (length data)))
    (format t "* writing training data ~a~%" training-data)
    (with-open-file (f training-data :direction :output :if-exists :supersede)
      (iter (initially (format f "~a ~a ~a~%" size value 109))
            (for d in data)
            (format f (remove-comma-if-needed (format nil "~{~a ~}~%" (first d))))
            (format f "~{~a ~}~%" (second d))))))

(defun train-net (net training-data value net-file hidden-units)
  (setf (symbol-value net) (make-net value hidden-units 109))
  (format t "* training the network~%")
  (train-on-file (symbol-value net) training-data 1500 100 0.1)
  (format t "* saving ~a~%" net-file)
  (save-to-file (symbol-value net) net-file))

;;; e-chord
(defun train-e-chord-net (options)
  (train-net '*e-chord-net* 
             (get-e-chord-data options)
             96
             (get-e-chord-fann options)
             (get-hidden-units options)))

(defun apply-e-chord-net (inputs options)
  (format t "opcoes: ~s~%" options)
  (let ((fann-file (get-e-chord-fann options)))
    (if (cl-fad:file-exists-p fann-file)
        (progn
          (setf *e-chord-net* (load-from-file (get-e-chord-fann options)))
          (add-inversions inputs (mapcar #L(run-my-net !1 *e-chord-net* #'extract-diff #'make-sonority-pattern)
                                         inputs)))
        (progn
          (format t "I could not find ~a, please train the net.~%" fann-file)
          (rameau-quit)))))

(defun e-chord-training-data ()
  (loop for (a b) in *training-data* nconc (prepare-training-data-net a b)))

(defun e-chord-data-set (options)
  (write-data-set (e-chord-training-data) (get-e-chord-data options) (get-e-chord-value options)))

(register-algorithm "ES-net" #'apply-e-chord-net)

;;; context
(defun context-extract-diffs (segmento)
  (extract-diffs (nth *context-before* segmento)))

(defun context-extract-diff (segmentos)
  (extract-diff (nth *context-before* segmentos)))

(defun context-extract-features (segmento &optional diff)
  (let ((diff (or diff (context-extract-diff segmento))))
    (loop for s in segmento nconc (make-sonority-pattern s diff))))

(defun train-context-net (options)
  (let ((fann-file (get-context-fann options))
        (data-file (get-context-data options)))
    (train-net '*context-net*
               data-file
               (* (+ 1 *context-after* *context-before*) 96)
               fann-file
               (get-hidden-units options))))

(defun context-training-data ()
  (loop for (a b) in *training-data* nconc
       (prepare-training-data-net (contextualize a *context-before* *context-after*)
                                  b
                                  #'context-extract-diffs
                                  #'context-extract-features)))

(defun apply-context-net (inputs options)
  (let ((fann-file (get-context-fann options))
        (context (butlast (contextualize inputs *context-before* *context-after*)
                          *context-before*)))
    (if (cl-fad:file-exists-p fann-file)
        (progn
          (setf *context-net* (load-from-file fann-file))
          (add-inversions inputs (mapcar #L(run-my-net !1 *context-net* #'context-extract-diff #'context-extract-features)
                                         context)))
        (progn
          (format t "I could not find ~a, please train the net.~%" fann-file)
          (rameau-quit)))))

(register-algorithm "EC-net" #'apply-context-net)

(defun context-data-set (options)
  (write-data-set (context-training-data) (get-context-data options) (get-context-value options)))