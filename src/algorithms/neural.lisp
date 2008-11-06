;;; define package
(defpackage :rameau-neural
  (:import-from #:arnesi "AIF" "AWHEN" "IT" "LAST1" "ENABLE-SHARP-L-SYNTAX")
  (:import-from #:alexandria "SWITCH")
  (:use #:cl #:fann #:rameau #:iterate #:cl-utils #:cl-music :cl-lily)
  (:documentation "Neural networks for chord labeling

Since we use multilayer perceptrons as our neural networks, training
and running them is rather simple, provided one finds a representation
of the inputs and the outputs in an amenable form. Here, this is
considered an N-of-M codification, but some sources diverge.

Our inputs are, for each sonority, the frequencies of the pitches in
it, in relation to its bass. For more than one sonority (in contextual
networks), all the pitches are in relation to the central sonority's
bass.

The output, for the chord labeling networks, is something like:

@mono{(get-module)} pitches

some modes

some sevenths

some extra for marking non-chord-tones and augmented sixths


For the functional neural network, the output is an M-of-N
codification of our augmented-sixth format which is, I hope,
simpler. The functions @function{rameau-neural}{get-function-net} and
@function{rameau-neural}{function-net-result} should be
self-explanatory, and they do this coding/decoding."))

(in-package :rameau-neural)

;;; general parameters
(enable-sharp-l-syntax)

(defparameter *root-increment* 4)
(defparameter *mode-length* 5)
(defparameter *7th-length* 4)
(defparameter *value* 96)
(defparameter *neural-version* "009")
(defparameter *neural-prefix* "master")

(defun make-pathname-neural (filename type)
  (make-pathname :directory (logical-pathname-directory "rameau:algorithms;")
                 :name (format nil
                               "~@{~a~^-~}"
                               *neural-prefix*
                               *neural-version*
                               filename)
                 :type type))

;;; general functions
(defun extract-diffs (segmento)
  (mapcar #'event-pitch segmento))

(defun make-sonority-pattern (seg &optional diff)
  (let ((diff (or diff (extract-diff seg))))
    (mapcar (lambda (x) (coerce x 'float)) (extract-feature-list seg diff))))

(defun make-answer-pattern (gabarito diff)
  (let ((atual (make-list (+ *root-increment* (get-module)) :initial-element 0)))
    (cond ((chord-p gabarito)
           (incf (nth (module (- (parse-note (stringify (chord-root gabarito)))
                                 diff))
                      atual)))
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
  (flet ((%make-root (a b)
           (print-note (code->notename (module (+ a b))) :latin)))
    (loop for i from 0
          for r in output
          with maxi = 0
          with maxr = 0
          when (< maxr r) do (setf maxi i maxr r)
          finally (return
                    (cond ((= (get-module) maxi)
                           (make-melodic-note))
                          ((> (get-module) maxi)
                           (make-chord :root (%make-root diff maxi)))
                          ((= (+ 1 (get-module)) maxi)
                           (make-augmented-sixth :type "IT"))
                          ((= (+ 2 (get-module)) maxi)
                           (make-augmented-sixth :type "AL"))
                          ((= (+ 3 (get-module)) maxi)
                           (make-augmented-sixth :type "FR"))
                          (t (format t "module: ~a, maxi: ~a, output: ~a" (get-module) maxi output)
                             (error "erro")))))))

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
                                  (feature #'make-sonority-pattern)
                                  (chord #'make-chord-answer-pattern))
  (loop for c in coral
        for gab in gabarito
        for ds = (funcall diff-func c)
        if (listp gab)
        nconc (prepare-training-data-net (repeat-list (length gab) c)
                                         gab diff-func feature)
        else
        nconc (loop for d in ds
                    nconc (list (list (funcall feature c d)
                                      (funcall chord gab d))))))

(defun run-my-net (x net extract-diff-fn fn)
  (let ((d (funcall extract-diff-fn x)))
    (get-class-chord-net d (run-net net (funcall fn x d)))))

(defun write-data-set (data filename-data value &optional (chord-size 109))
  (format t "* writing training data ~a~%" filename-data)
  (with-output-file (f filename-data)
    (iter (initially (format f "~a ~a ~a~%" (length data) value chord-size))
          (for d in data)
          (format f (remove-comma-if-needed (format nil "~{~a ~}~%" (first d))))
          (format f "~{~a ~}~%" (second d)))))

(defun train-net (net training-data value net-file hidden-units
                  &optional (out-size 109))
  (setf (symbol-value net) (make-net value hidden-units out-size))
  (format t "* training the network~%")
  (train-on-file (symbol-value net) training-data 1500 100 0.1)
  (format t "* saving ~a~%" net-file)
  (save-to-file (symbol-value net) net-file))

;;; e-chord
(defun e-chord-training-data ()
  (loop for (a b) in *training-data* nconc (prepare-training-data-net a b)))

(defun e-chord-data-set (alg)
  (write-data-set (e-chord-training-data) (e-chord-data alg) *value*))

(defun train-e-chord-net (alg)
  (let (net)
    (declare (special net))
    (unless (cl-fad:file-exists-p (e-chord-data alg))
      (e-chord-data-set alg))
    (unless (cl-fad:file-exists-p (e-chord-fann alg))
      (train-net 'net 
                 (e-chord-data alg)
                 *value*
                 (e-chord-fann alg)
                 (chord-hidden-units alg)))))

(defun apply-e-chord-net (inputs options alg)
  (let ((fann-file (e-chord-fann alg))
        net)
    (if (cl-fad:file-exists-p fann-file)
        (progn
          (setf net (load-from-file fann-file))
          (add-inversions inputs
                          (mapcar #L(run-my-net !1
                                                net
                                                #'extract-diff
                                                #'make-sonority-pattern)
                                  inputs)))
        (progn
          (train-e-chord-net alg)
          (apply-e-chord-net inputs options alg)))))

(defclass chord-net (rameau-algorithm)
  ((chord-data :accessor e-chord-data :initform nil)
   (chord-fann :accessor e-chord-fann :initform nil)
   (hidden-units :accessor chord-hidden-units :initarg :units :initform 30)
   (version)))

(defmethod e-chord-data ((obj chord-net))
  (aif (slot-value obj 'chord-data)
       it
       (make-pathname-neural "chord-data" "fann")))

(defmethod e-chord-fann ((obj chord-net))
  (aif (slot-value obj 'chord-fann)
       it
       (make-pathname-neural "data" "fann")))

(defmethod you-ok-p ((algorithm chord-net))
  (handler-case (progn (load-from-file (e-chord-fann algorithm)) t)
    (error (c)   (format t "Error: ~a~%" c)  nil)))

(defmethod perform-analysis (segments options (alg chord-net))
  (dbg :neural "Starting neural net...~%")
  (let ((result (apply-e-chord-net segments options alg)))
    (dbg :neural "LEaving neural net...~%")
    result))

(defmethod do-options ((alg chord-net) options)
  (awhen (aget :e-chord-data (arg :options options))
    (setf (e-chord-data alg) it))
  (awhen (aget :e-chord-fann (arg :options options))
    (setf (e-chord-fann alg) it))
  (awhen (aget :hidden-units (arg :options options))
    (setf (chord-hidden-units alg) it))
  (when (aget :train (arg :options options))
    (train-e-chord-net alg)))

(add-algorithm (make-instance 'chord-net
                              :name "ES-Net"
                              :description "A neural network
                              classifier that looks only at each
                              sonority."))
;;; context

(defun context-training-data (alg)
  (let* ((context-before (net-context-before alg))
         (context-after (net-context-after alg)))
    (labels ((context-extract-diffs (segmentos)
               (extract-diffs (nth context-before segmentos)))
             (context-extract-diff (segmento)
               (extract-diff (nth context-before segmento)))
             (context-extract-features (segmento &optional diff)
               (let ((diff (or diff (context-extract-diff segmento))))
                 (loop for s in segmento nconc (make-sonority-pattern s diff)))))
      (loop for (a b) in *training-data* nconc
            (prepare-training-data-net (contextualize a context-before context-after)
                                       b
                                       #'context-extract-diffs
                                       #'context-extract-features)))))

(defun context-data-set (alg)
  (write-data-set (context-training-data alg)
                  (context-data alg)
                  (* (+ 1 (net-context-after alg) (net-context-before alg))
                     *value*)))

(defun train-context-net (alg)
  (let ((fann-file (context-fann alg))
        (data-file (context-data alg))
        net)
    (declare (special net))
    (unless (cl-fad:file-exists-p data-file)
      (context-data-set alg))
    (unless (cl-fad:file-exists-p fann-file)
      (train-net 'net
                 data-file
                 (* (+ 1 (net-context-after alg) (net-context-before alg))
                    *value*)
                 fann-file
                 (context-hidden-units alg)))))

(defun apply-context-net (inputs options alg)
  (let* ((fann-file (context-fann alg))
         (context-before (net-context-before alg))
         (context-after (net-context-after alg))
         (context (contextualize inputs context-before context-after))
         net)
    (labels ((context-extract-diff (segmentos)
               (extract-diff (nth context-before segmentos)))
             (context-extract-features (segmento &optional diff)
               (let ((diff (or diff (context-extract-diff segmento))))
                 (loop for s in segmento nconc (make-sonority-pattern s diff)))))
      (if (cl-fad:file-exists-p fann-file)
          (progn
            (setf net (load-from-file fann-file))
            (add-inversions inputs
                            (mapcar #L(run-my-net !1
                                                  net
                                                  #'context-extract-diff
                                                  #'context-extract-features)
                                    context)))
          (progn
            (train-context-net alg)
            (apply-context-net inputs options alg))))))

(defclass context-net (rameau-algorithm)
  ((context-data :accessor context-data :initarg :data :initform nil)
   (context-fann :accessor context-fann :initarg :fann :initform nil)
   (context-before :accessor net-context-before :initarg :context-before :initform 1)
   (context-after :accessor net-context-after :initarg :context-after :initform 0)
   (hidden-units :accessor context-hidden-units :initarg :units :initform 22)
   (version)))

(defmethod context-data ((obj context-net))
  (aif (slot-value obj 'context-data)
       it
       (make-pathname-neural "context-train" "data")))

(defmethod context-fann ((obj context-net))
  (aif (slot-value obj 'context-fann)
       it
       (make-pathname-neural "context" "fann")))

(defmethod you-ok-p ((algorithm context-net))
  (handler-case (progn (load-from-file (context-fann algorithm)) t)
    (error (c) (format t "Error: ~a~%" c) nil)))

(defmethod perform-analysis (segments options (alg context-net))
  (apply-context-net segments options alg))

(defmethod do-options ((alg context-net) options)
  (awhen (aget :context-data (arg :options options))
    (setf (context-data alg) it))
  (awhen (aget :context-fann (arg :options options))
    (setf (context-fann alg) it))
  (awhen (aget :hidden-units (arg :options options))
    (setf (context-hidden-units alg) it))
  (awhen (aget :context-before (arg :options options))
    (setf (net-context-before alg) it))
  (awhen (aget :context-after (arg :options options))
    (setf (net-context-after alg) it))
  (when (aget :train (arg :options options))
    (train-context-net alg)))

(add-algorithm (make-instance 'context-net
                              :name "EC-Net"
                              :description "A neural network
                              classifier that considers surrounding
                              sonorities as well."))

;; The functional analysis contextual network

(defparameter *tonal-key-size* (+ (get-module) 2))

(defun extract-key-result (diff res)
  (let ((pitch (iter (for i from 0 below (get-module))
                     (for el in res)
                     (finding i maximizing el)))
        (mode (if (apply #'> (last res 2)) :major :minor)))
    (make-tonal-key :center-pitch (module (+ diff pitch)) :mode mode)))

(defun make-key-result (diff key)
  (let ((result (repeat-list *tonal-key-size* 0)))
    (incf (nth (module (- (tonal-key-center-pitch key) diff)) result))
    (if (eq (tonal-key-mode key) :major)
        (incf (nth (get-module) result))
        (incf (nth (1+ (get-module)) result)))
    result))

;; (extract-key-result 10 (make-key-result 10 (make-tonal-key :center-pitch 55 :mode :major)))

(defparameter *function-number-size* 7)
(defparameter *function-accident-size* 3)
(defparameter *function-modes* '(:major :minor :augmented :diminished
                                 :half-diminished :german-sixth :italian-sixth
                                 :french-sixth))
(defparameter *function-mode-size* (1+ (length *function-modes*)))
(defparameter *total-function-size* (+ *function-number-size*
                                       *function-accident-size*
                                       *function-mode-size*))

(defun maxi (list)
  (iter (for el in list)
        (for i from 0)
        (finding i maximizing el)))

(defun extract-function-result (res)
  (let ((number (subseq res 0 *function-number-size*))
        (accidentals (subseq res
                             *function-number-size*
                             (+ *function-number-size* *function-accident-size*)))
        (mode (subseq res (+ *function-number-size* *function-accident-size*))))
    (make-roman-function :degree-number (1+ (maxi number))
                         :degree-accidentals (1- (maxi accidentals))
                         :mode (nth (maxi mode) *function-modes*))))

(defun make-function-result (function)
  (let ((number (repeat-list *function-number-size* 0))
        (accidentals (repeat-list *function-accident-size* 0))
        (mode (repeat-list *function-mode-size* 0))
        (rm (roman-function-degree-number function))
        (ac (roman-function-degree-accidentals function))
        (md (roman-function-mode function)))
    (incf (nth (1- rm) number))
    (incf (nth (min 1 (1+ (max -1 ac))) accidentals))
    (incf (nth (or (position md *function-modes*) 0) mode))
    (append number accidentals mode)))

(defun get-function-net (diff res)
  (let ((key (extract-key-result diff (firstn res *tonal-key-size*)))
        (function (extract-function-result (nthcdr *tonal-key-size* res))))
    (make-fchord :key key :roman-function function)))

(defun function-net-result (fchord diff)
  (append (make-key-result diff (fchord-key fchord))
          (make-function-result (fchord-roman-function fchord))))

(defun functional-training-data (alg)
  (let* ((context-before (net-context-before alg))
         (context-after (net-context-after alg)))
    (labels ((context-extract-diffs (segmentos)
               (extract-diffs (nth context-before segmentos)))
             (context-extract-diff (segmento)
               (extract-diff (nth context-before segmento)))
             (context-extract-features (segmento &optional diff)
               (let ((diff (or diff (context-extract-diff segmento))))
                 (loop for s in segmento nconc (make-sonority-pattern s diff)))))
      (loop for (a b) in *training-data* nconc
            (prepare-training-data-net (contextualize a context-before context-after)
                                       b
                                       #'context-extract-diffs
                                       #'context-extract-features
                                       #'function-net-result)))))

(defun functional-data-set (alg)
  (write-data-set (functional-training-data alg)
                  (context-data alg)
                  (* (+ 1 (net-context-after alg) (net-context-before alg)) *value*)
                  (+ *tonal-key-size* *total-function-size*)))

(defun train-functional-net (alg)
  (let ((fann-file (context-fann alg))
        (data-file (context-data alg))
        net)
    (declare (special net))
    (unless (cl-fad:file-exists-p data-file)
      (functional-data-set alg))
    (unless (cl-fad:file-exists-p fann-file)
      (train-net 'net
                 data-file
                 (* (+ 1 (net-context-after alg) (net-context-before alg)) *value*)
                 fann-file
                 (context-hidden-units alg)
                 (+ *tonal-key-size* *total-function-size*)))))

(defun run-fun-net (x net extract-diff-fn fn)
  (let ((d (funcall extract-diff-fn x)))
    (get-function-net d (run-net net (funcall fn x d)))))

(defun apply-functional-net (inputs options alg)
  (let* ((fann-file (context-fann alg))
         (context-before (net-context-before alg))
         (context-after (net-context-after alg))
         (context (contextualize inputs context-before context-after))
         net)
    (labels ((context-extract-diff (segmentos)
               (extract-diff (nth context-before segmentos)))
             (context-extract-features (segmento &optional diff)
               (let ((diff (or diff (context-extract-diff segmento))))
                 (loop for s in segmento nconc (make-sonority-pattern s diff)))))
      (if (cl-fad:file-exists-p fann-file)
          (progn
            (setf net (load-from-file fann-file))
            (mapcar #L(run-fun-net !1 net #'context-extract-diff #'context-extract-features)
                    context))
          (progn
            (train-functional-net alg)
            (apply-functional-net inputs options alg))))))

(defclass functional-net (rameau-algorithm)
  ((context-data :accessor context-data :initarg :data :initform nil)
   (context-fann :accessor context-fann :initarg :fann :initform nil)
   (context-before :accessor net-context-before :initarg :context-before :initform 4)
   (context-after :accessor net-context-after :initarg :context-after :initform 4)
   (hidden-units :accessor context-hidden-units :initarg :units :initform 22)
   (version)))

(defmethod context-data ((obj functional-net))
  (aif (slot-value obj 'context-data)
       it
       (make-pathname-neural "functional-train" "data")))

(defmethod context-fann ((obj functional-net))
  (aif (slot-value obj 'context-fann)
       it
       (make-pathname-neural "functional" "fann")))

(defmethod you-ok-p ((algorithm functional-net))
  (handler-case (progn (load-from-file (context-fann algorithm)) t)
    (error (c) (format t "Error: ~a~%" c) nil)))

(defmethod functional-analysis (segments options (alg functional-net))
    (apply-functional-net segments options alg))

(defmethod do-options ((alg functional-net) options)
  (awhen (aget :context-data (arg :options options))
    (setf (context-data alg) it))
  (awhen (aget :context-fann (arg :options options))
    (setf (context-fann alg) it))
  (awhen (aget :hidden-units (arg :options options))
    (setf (context-hidden-units alg) it))
  (awhen (aget :context-before (arg :options options))
    (setf (net-context-before alg) it))
  (awhen (aget :context-after (arg :options options))
    (setf (net-context-after alg) it))
  (when (aget :train (arg :options options))
    (format t "Training functional net...~%")
    (train-functional-net alg)))


(add-falgorithm (make-instance 'functional-net
                               :name "Tsui"
                               :context-before 4
                               :context-after 4
                               :description "A neural network
                              classifier for roman numeral functional
                              analysis."))

