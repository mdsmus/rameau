;;; load fann
(eval-when (:compile-toplevel :load-toplevel)
  (asdf:oos 'asdf:load-op :fann))

;;; define package
(defpackage :rameau-neural
  (:import-from #:arnesi "AIF" "AWHEN" "IT" "LAST1" "ENABLE-SHARP-L-SYNTAX")
  (:import-from #:alexandria "SWITCH")
  (:shadowing-import-from #:rameau-base #:defun #:defmacro #:defparameter #:defvar #:defstruct)
  (:use #:cl #:fann #:rameau #:iterate #:genoslib :cl-lily)
  (:documentation "Neural networks for chord labeling"))

(in-package :rameau-neural)

;;; general parameters
(enable-sharp-l-syntax)

(defparameter *root-increment* 4)
(defparameter *mode-length* 5)
(defparameter *7th-length* 4)
(defparameter *value* 96)
(defparameter *neural-version* "-007-")
(defparameter *neural-path* (concat *rameau-path* "algorithms/master-" *neural-version* "-"))

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
  (let ((size (length data))
        (training-data (concat *neural-path* training-data)))
    (format t "* writing training data ~a~%" training-data)
    (with-open-file (f training-data :direction :output :if-exists :supersede)
      (iter (initially (format f "~a ~a ~a~%" size value 109))
            (for d in data)
            (format f (remove-comma-if-needed (format nil "~{~a ~}~%" (first d))))
            (format f "~{~a ~}~%" (second d))))))

(defun train-net (net training-data value net-file hidden-units)
  (setf (symbol-value net) (make-net value hidden-units 109))
  (format t "* training the network~%")
  (train-on-file (symbol-value net) (concat *neural-path* training-data) 1500 100 0.1)
  (format t "* saving ~a~%" (concat *neural-path* net-file))
  (save-to-file (symbol-value net) (concat *neural-path* net-file)))

;;; e-chord
(defun e-chord-training-data ()
  (loop for (a b) in *training-data* nconc (prepare-training-data-net a b)))

(defun e-chord-data-set (alg)
  (write-data-set (e-chord-training-data) (e-chord-data alg) *value*))

(defun train-e-chord-net (alg)
  (let (net)
    (declare (special net))
    (unless (cl-fad:file-exists-p (concat *neural-path* (e-chord-data alg)))
      (e-chord-data-set alg))
    (unless (cl-fad:file-exists-p (concat *neural-path* (e-chord-fann alg)))
      (train-net 'net 
                 (e-chord-data alg)
                 *value*
                 (e-chord-fann alg)
                 (chord-hidden-units alg)))))

(defun apply-e-chord-net (inputs options alg)
  (let ((fann-file (concat *neural-path* (e-chord-fann alg)))
        net)
    (if (cl-fad:file-exists-p fann-file)
        (progn
          (setf net (load-from-file fann-file))
          (add-inversions inputs (mapcar #L(run-my-net !1 net #'extract-diff #'make-sonority-pattern)
                                         inputs)))
        (progn
          (train-e-chord-net alg)
          (apply-e-chord-net inputs options alg)))))

(defclass chord-net (rameau-algorithm)
  ((chord-data :accessor e-chord-data :initarg :data :initform "chord-data.fann")
   (chord-fann :accessor e-chord-fann :initarg :fann :initform "chord.fann")
   (hidden-units :accessor chord-hidden-units :initarg :units :initform 30)
   (version)))

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
                              :description "A neural network classifier that looks only at each sonority."))
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
  (write-data-set (context-training-data alg) (context-data alg) (* (+ 1 (net-context-after alg) (net-context-before alg)) *value*)))

(defun train-context-net (alg)
  (let ((fann-file (context-fann alg))
        (data-file (context-data alg))
        net)
    (declare (special net))
    (unless (cl-fad:file-exists-p (concat *neural-path* data-file))
      (context-data-set alg))
    (unless (cl-fad:file-exists-p (concat *neural-path* fann-file))
      (train-net 'net
                 data-file
                 (* (+ 1 (net-context-after alg) (net-context-before alg)) *value*)
                 fann-file
                 (context-hidden-units alg)))))

(defun apply-context-net (inputs options alg)
  (let* ((fann-file (concat *neural-path* (context-fann alg)))
         (context-before (net-context-before alg))
         (context-after (net-context-after alg))
         (context (butlast (contextualize inputs context-before context-after)
                           context-before))
         net)
    (labels ((context-extract-diff (segmentos)
               (extract-diff (nth context-before segmentos)))
             (context-extract-features (segmento &optional diff)
               (let ((diff (or diff (context-extract-diff segmento))))
                 (loop for s in segmento nconc (make-sonority-pattern s diff)))))
      (if (cl-fad:file-exists-p fann-file)
          (progn
            (setf net (load-from-file fann-file))
            (add-inversions inputs (mapcar #L(run-my-net !1 net #'context-extract-diff #'context-extract-features)
                                           context)))
          (progn
            (train-context-net alg)
            (apply-context-net inputs options alg))))))

(defclass context-net (rameau-algorithm)
  ((context-data :accessor context-data :initarg :data :initform "context-train.data" )
   (context-fann :accessor context-fann :initarg :fann :initform "context.fann" )
   (context-before :accessor net-context-before :initarg :context-before :initform 1)
   (context-after :accessor net-context-after :initarg :context-after :initform 0)
   (hidden-units :accessor context-hidden-units :initarg :units :initform 22)
   (version)))

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
                              :description "A neural network classifier that considers surrounding sonorities as well."))