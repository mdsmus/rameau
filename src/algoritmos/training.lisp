
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

(defun load-net (net net-file training-function)
  (if (cl-fad:file-exists-p net-file)
      (setf (symbol-value net) (load-from-file net-file))
      (funcall training-function)))

(defun run-my-net (x net fn)
  (let ((d (extract-diff x)))
    (get-class-chord-net d (run-net net (funcall fn x d)))))

(defun write-training-file-net (data training-data value)
  (with-open-file (f training-data :direction :output)
    (iter (for size = (length data))
          (initially (format f "~a ~a ~a~%" size value 109))
          (for d in data)
          (format f (remove-comma-if-needed (format nil "~{~a ~}~%" (first d))))
          (format f "~{~a ~}~%" (second d)))))

(defun train-net (net training-data value net-file write-training-fn)
  (if (cl-fad:file-exists-p training-data)
      (progn
        (setf (symbol-value net) (make-net value *hidden-units* 109))
        (train-on-file net training-data 1500 100 0.1)
        (save-to-file net net-file))
      (progn
        (funcall write-training-fn)
        (train-net training-data value net net-file write-training-fn))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defparameter *version* "-0005-")
(defparameter *hidden-units* 22)

(defparameter *neural-path* (concat *rameau-path* "neural-nets/" "master" *version*))

(defvar *e-chord-net* nil)
(defparameter *e-chord-net-file* (concat *neural-path* "e-chord-net.fann"))
(defparameter *e-chord-net-train-data* (concat *neural-path* "e-chord-net-train.data"))

(defun apply-e-chord-net (inputs)
  (load-net '*e-chord-net* *e-chord-net-file* #'train-e-chord-net)
  (add-inversions inputs (mapcar #L(run-my-net !1 *e-chord-net* #'make-sonority-pattern) inputs)))


(unless (cl-fad:file-exists-p *e-chord-net-train-data*)
  (let ((training-data (loop for i in *training-data*
                          nconc (prepare-training-data-net (first i) (second i)))))
    (write-training-file-net training-data
                           *e-chord-net-train-data*
                           96)))

(unless (cl-fad:file-exists-p *e-chord-net-file*)
  (train-net '*e-chord-net*
             *e-chord-net-train-data*
             96
             *e-chord-net-file*
             #'write-training-file-e-chord-net))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar *context-net* nil)
(defparameter *context-net-file* (concat *neural-path* "context-net.fann"))
(defparameter *context-net-train-data* (concat *neural-path* "context-net-train.data"))

(defun apply-context-net (inputs)
  (load-net '*context-net* *context-net-file* #'train-context-net)
  (let ((context (butlast (contextualize inputs *context-before* *context-after*)
                          *context-before*)))
    (add-inversions inputs (mapcar #L(run-my-net !1 *context-net* #'context-extrai-features)
                                   context))))
                                 
(unless (cl-fad:file-exists-p *context-net-train-data*)
  (let ((training-data (loop for i in *training-data* nconc
                            (prepare-training-data-net (contextualize (first i)
                                                                      *context-before*
                                                                      *context-after*)
                                                       (second i)
                                                       #'context-extract-diffs
                                                       #'context-extrai-features))))
    (write-training-file-net training-data
                             *context-net-train-data*
                             (* (+ 1 *context-after* *context-before*) 96))))

(unless (cl-fad:file-exists-p *context-net-file*)
  (train-net '*context-net*
             *context-net-train-data*
             (* (+ 1 *context-after* *context-before*) 96)
             *context-net-file*
             #'write-training-file-context-net))
