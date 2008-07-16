(defpackage :rameau-knn
  (:import-from #:arnesi "AIF" "IT" "LAST1" "ENABLE-SHARP-L-SYNTAX" "AWHEN")
  (:shadowing-import-from #:rameau-base #:defun #:defmacro #:defparameter #:defvar #:defstruct)
  (:use #:cl #:rameau #:genoslib #:rameau-options)
  (:documentation "K-Nearest-Neighbor classification for chord labeling."))

(in-package :rameau-knn)

(enable-sharp-l-syntax)

;; src/algoritmos/knn.lisp
;; A k-nearest-neighbor chord finder, for use in Rameau.

;; The training examples as stored in an alist, keyed by their
;; pitches. In the e-knn version, only one sonority is stored at a
;; time, while in the ec-knn a few surrouding sonorities are also
;; stored.

;; The values in the alist are also alists. These lists are keyed by
;; the classes for that example (there can be more than one) and the
;; values are the counts for how many times each class appears.

(defparameter *examples* (make-alist))

(defun process-chord (acorde diff)
  (cond ((chord-p acorde)
         (list 'chord
               (- (parse-note (chord-root acorde)) diff)
               (chord-mode acorde)
               (chord-7th acorde)))
        ((melodic-note-p acorde)
         (list '-))
        (t
         (list (augmented-sixth-type acorde)))))

(defun extract-chord (lista diff)
  (cond ((eq (first lista) '-)
         (make-melodic-note))
        ((eq (first lista) 'chord)
         (make-chord :root (print-note (code->notename (+ (second lista) diff)))
                     :mode (third lista)
                     :7th (fourth lista)))
        (t (make-augmented-sixth :type (first lista)))))

(defun hash-default (key table default)
  (aif (gethash key table nil)
       it
       (setf (gethash key table) default)))

(defun insert-count (chave acorde diff hash n)
  (let ((acorde (process-chord acorde diff)))
    (if (aget acorde *examples*)
        (apush (cons chave n) (aget acorde *examples*))
        (aset acorde *examples* (list (cons chave n))))
    (aincf acorde (aget chave hash (make-alist)))))

(defun train-1nn (alg coral answer n)
  (let ((nn (knn-nn alg)))
    (loop for segmento in coral
       for acorde in answer
       for diff = (extract-diff segmento)
       for pitches = (extract-feature-list segmento diff)
       do (if (listp acorde)
              (mapcar (lambda (x) (insert-count pitches x diff nn n)) acorde)
              (insert-count pitches acorde diff nn n)))))

(defun train-k1 (alg exemplos)
  (loop for exemplo in exemplos
       for n from 0
       for coral = (first exemplo)
       for answer = (second exemplo)
       do (train-1nn alg coral answer n)))

(defun get-class (diff maxkey maxv)
  (declare (ignore maxkey))
  (let ((resultado (make-hash-table :test #'equal)))
    (loop for hash in maxv do
         (loop for (k v) in hash
            do (incf (gethash k resultado 0) (or v 0))))
    (loop for k being the hash-keys in resultado
       with maxk = 0
       with maxv = 0
       when (> (gethash k resultado) maxv) do (setf maxk k
                                                    maxv (gethash k resultado))
       finally (return (extract-chord maxk diff)))))

(defun classify-k1 (segmento options alg)
  (declare (ignore options))
  (let* ((diff (extract-diff segmento))
         (pitches (extract-feature-list segmento diff))
         (k (knn-k alg))
         (nn (knn-nn alg)))
    (loop for (key value) in nn
       with knn = nil
       do 
         (let ((d (distance pitches key)))
           (setf knn (clip k (insert (list d key value) knn :key #'car))))
       finally (return (get-class diff (mapcar #'second knn) (mapcar #'third knn))))))

(defun prepare-answers-k1 (coral options alg)
  (add-inversions coral (mapcar #L(classify-k1 !1 options alg) coral)))

(defclass knn (rameau-algorithm)
  ((k :accessor knn-k :initarg :k :initform 1)
   (nn :accessor knn-nn :initform (make-alist))))

(defmethod perform-analysis (segments options (alg knn))
  (prepare-answers-k1 segments options alg))

(defmethod do-options ((alg knn) options)
  (awhen (aget :k (arg :options options))
    (setf (knn-k alg) it))
  (when (aget :train (arg :options options))
    (train-k1 alg *training-data*)))

(add-algorithm
 (make-instance 'knn :name "ES-Knn"
                :description "A k-nearest-neighbors classifier that classifies each sonority by itself."))

(defun show-examples ()
  "Mostra em que corais estão que tipos de acorde."
  (loop for h being the hash-keys in *examples*
     do (format t " ~a => ~a~%" h (remove-duplicates (gethash h *examples*)))))

;; Algoritmo context-knn. 
(defun context-extract-diff (alg segmentos)
  (extract-diff (nth (cknn-before-context alg) segmentos)))

(defun context-extract-features (alg segmentos diff)
  (let ((before-context (cknn-before-context alg))
        (variance (cknn-variance alg)))
    (loop for seg in segmentos
       for peso from (-  before-context)
       nconc (loop for x in (extract-feature-list seg diff)
                collect (/ x (+ 1 (* (abs peso) variance)))))))

(defun train-context-nn (alg coral answer n)
  (let ((nn (cknn-nn alg)))
    (loop for segmento in coral
       for acorde in answer
       for diff = (context-extract-diff alg segmento)
       for pitches = (context-extract-features alg segmento diff)
       do (if (listp acorde)
              (mapcar (lambda (x) (insert-count pitches x diff nn n)) acorde)
              (insert-count pitches acorde diff nn n)))))

(defun train-context (alg exemplos)
  (let ((before-context (cknn-before-context alg))
        (after-context (cknn-after-context alg)))
  (loop for exemplo in exemplos
     for coral = (first exemplo)
     for n from 0
     for answer = (second exemplo)
     do (train-context-nn alg (butlast (contextualize coral before-context after-context) before-context) answer n))))

(defun classify-context (alg segmento options)
  (declare (ignore options))
  (let* ((diff (context-extract-diff alg segmento))
         (pitches (context-extract-features alg segmento diff))
         (k (cknn-k alg))
         (nn (cknn-nn alg)))
    (loop for (key value) in nn 
       with knn = nil
       do 
         (let ((d (distance pitches key)))
           (setf knn (clip k (insert (list d key value) knn :key #'car))))
       finally (return (get-class diff (mapcar #'second knn) (mapcar #'third knn))))))

(defun prepare-answers-context (coral options alg)
  (let* ((before-context (cknn-before-context alg))
         (after-context (cknn-after-context alg))
         (c (contextualize coral before-context after-context)))
    (add-inversions coral (mapcar #L(classify-context alg !1 options) (butlast c before-context)))))

(defclass context-knn (rameau-algorithm)
  ((ck :accessor cknn-k :initarg :ck :initform 1)
   (nn :accessor cknn-nn :initform (make-alist))
   (before-context :accessor cknn-before-context :initarg :before-context :initform 1)
   (after-context :accessor cknn-after-context :initarg :after-context :initform 0)
   (variance :accessor cknn-variance :initarg :variance :initform 3/2)))

(defmethod perform-analysis (segments options (alg context-knn))
  (prepare-answers-context segments options alg))

(defmethod do-options ((alg context-knn) options)
  (awhen (aget :ck (arg :options options))
    (setf (cknn-k alg) it))
  (awhen (aget :before-context (arg :options options))
    (setf (cknn-before-context alg) it))
  (awhen (aget :after-context (arg :options options))
    (setf (cknn-after-context alg) it))
  (awhen (aget :variance (arg :options options))
    (setf (cknn-variance alg) it))
  (when (aget :train (arg :options options))
    (train-context alg *training-data*)))

(add-algorithm (make-instance
                'context-knn
                :name "EC-Knn"
                :description "A k-nearest-neighbor classifier that considers a bit of contextual information."))
