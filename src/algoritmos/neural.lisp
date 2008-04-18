(eval-when (:compile-toplevel :load-toplevel)
  (asdf:oos 'asdf:load-op :fann))

(defpackage :rameau-neural
  (:use #:cl #:fann #:arnesi #:rameau #:string-case))

(in-package :rameau-neural)

(defparameter *version* "-0003-")

(defparameter *neural-path* (concat *rameau-path* "neural-nets/" "master" *version*))

(defparameter *hidden-units* 22)

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

(defun load-chord-net ()
  (if (cl-fad:file-exists-p *chord-net-file*)
      (setf *chord-net* (load-from-file *chord-net-file*))
      (treina-chord-net)))

(defun save-chord-net ()
  (save-to-file *chord-net* *chord-net-file*))

(defun make-empty-pattern ()
  (repeat-list (+ *mode-length* *7th-length*) 0))

(defun make-pattern-7th (7th)
  (let ((pattern (repeat-list *7th-length* 0))
        (*package* (find-package :rameau)))
    (incf (nth (string-case (7th)
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
    (incf (nth (string-case (modo)
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


(defvar *e-chord-net* nil)

(defparameter *e-chord-net-file* (concat *neural-path* "e-chord-net.fann"))
(defparameter *e-chord-net-train-data* (concat *neural-path* "e-chord-net-train.data"))

(defun load-e-chord-net ()
  (if (cl-fad:file-exists-p *e-chord-net-file*)
      (setf *e-chord-net* (load-from-file *e-chord-net-file*))
      (train-e-chord-net)))

(defun save-e-chord-net ()
  (save-to-file *e-chord-net* *e-chord-net-file*))

(defun run-e-chord-net (x)
  (let ((d (extract-diff x)))
    (get-class-chord-net
     d
     (run-net *e-chord-net*
              (make-sonority-pattern x d)))))

(defun apply-e-chord-net (inputs)
  (load-e-chord-net)
  (add-inversions inputs (mapcar #'run-e-chord-net inputs)))

(defun prepare-training-data-chord-net (coral gabarito &optional
                                        (diff-func #'extrai-diffs)
                                        (feature #'cria-pattern-segmento))
  (loop for c in coral
     for gab in gabarito
     for ds = (funcall diff-func c)
     if (listp gab)
       nconc (prepare-training-data-chord-net (repeat-list (length gab) c)
                                              gab diff-func feature)
     else
       nconc (loop for d in ds
                nconc (list (list (funcall feature c d)
                                  (cria-pattern-saida-acorde gab d))))))




(defun make-training-data-e-chord-net ()
  (loop for i in *training-data*
     nconc (prepare-training-data-chord-net (first i) (second i))))

(defun write-training-file-e-chord-net ()
  (let* ((dados (make-training-data-e-chord-net))
         (tamanho (length dados)))
    (with-open-file (f *e-chord-net-train-data* :direction :output)
      (format f "~a ~a ~a~%" tamanho 96 109)
      (loop for d in dados
         do
           (format f (remove-comma-if-needed (format nil "~{~a ~}~%" (first d))))
           (format f "~{~a ~}~%" (second d))))))

(unless (cl-fad:file-exists-p *e-chord-net-train-data*)
  (write-training-file-e-chord-net))

(defun train-e-chord-net ()
  (if (cl-fad:file-exists-p *e-chord-net-train-data*)
      (progn
        (setf *e-chord-net* (make-net 96 *hidden-units* 109))
        (train-on-file *e-chord-net*
                       *e-chord-net-train-data*
                       1500
                       100
                       0.1)
        (save-e-chord-net))
      (progn
        (write-training-file-e-chord-net)
        (train-e-chord-net))))

(unless (cl-fad:file-exists-p *e-chord-net-file*)
  (train-e-chord-net))

(register-algorithm "ES-net" #'apply-e-chord-net)

(defparameter *context-net* nil)

(defparameter *context-net-file* (concat *neural-path* "context-net.fann"))
(defparameter *context-net-train-data* (concat *neural-path* "context-net-train.data"))

(defparameter *context-before* 1)
(defparameter *context-after* 1)

(defun context-extract-diffs (segmento)
  (extract-diffs (nth *context-before* segmento)))

(defun context-extract-diff (segmentos)
  (extract-diff (nth *context-before* segmentos)))

(defun context-extrai-features (segmento &optional diff)
  (let ((diff (or diff (context-extract-diff segmento))))
    (loop for s in segmento nconc (make-sonority-pattern s diff))))

(defun load-context-net ()
  (if (cl-fad:file-exists-p *context-net-file*)
      (setf *context-net* (load-from-file *context-net-file*))
      (train-context-net)))

(defun save-context-net ()
  (save-to-file *context-net* *context-net-file*))

(defun run-context-net (x)
  (let ((d (context-extract-diff x)))
    (get-class-chord-net
     d
     (run-net *context-net*
              (context-extrai-features x d)))))

(defun apply-context-net (inputs)
  (load-context-net)
  (let ((contexto (butlast (contextualize inputs *context-before* *context-after*)
                           *context-before*)))
    (add-inversions inputs (mapcar #'run-context-net contexto))))

(defun make-training-data-context-net ()
  (loop for i in *training-data*
     nconc (prepare-training-data-chord-net (contextualize (first i)
                                                                  *context-before*
                                                                  *context-after*)
                                                   (second i)
                                                   #'context-extract-diffs
                                                   #'context-extrai-features)))

(defun write-training-file-context-net ()
  (let* ((dados (make-training-data-context-net))
         (tamanho (length dados)))
    (with-open-file (f *context-net-train-data* :direction :output)
      (format f "~a ~a ~a~%" tamanho (* (+ 1 *context-after* *context-before*) 96) 109)
      (loop for d in dados
         do
           (format f (remove-comma-if-needed (format nil "~{~a ~}~%" (first d))))
           (format f "~{~a ~}~%" (second d))))))

(unless (cl-fad:file-exists-p *context-net-train-data*)
  (write-training-file-context-net))

(defun train-context-net ()
  (if (cl-fad:file-exists-p *context-net-train-data*)
      (progn
        (setf *context-net* (make-net (* (+ 1 *context-after* *context-before*) 96)
                                      *hidden-units*
                                      109))
        (train-on-file *context-net*
                       *context-net-train-data*
                       1500
                       100
                       0.1)
        (save-context-net))
      (progn
        (write-training-file-context-net)
        (train-context-net))))

(unless (cl-fad:file-exists-p *context-net-file*)
  (train-context-net))

(register-algorithm "EC-net" #'apply-context-net)
