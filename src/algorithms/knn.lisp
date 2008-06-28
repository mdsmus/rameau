(defpackage :rameau-knn
  (:import-from #:arnesi "AIF" "IT" "LAST1" "ENABLE-SHARP-L-SYNTAX")
  (:shadowing-import-from #:rameau-base #:defun #:defmacro #:defparameter #:defvar #:defstruct)
  (:use #:cl #:rameau #:genoslib #:rameau-options))

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
(defparameter *1-neighbours* (make-alist))

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
;(trace extract-chord get-class)
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

(defun train-1nn (coral answer n)
  (loop for segmento in coral
     for acorde in answer
     for diff = (extract-diff segmento)
     for pitches = (extract-feature-list segmento diff)
     do (if (listp acorde)
            (mapcar (lambda (x) (insert-count pitches x diff *1-neighbours* n)) acorde)
            (insert-count pitches acorde diff *1-neighbours* n))))

(defun train-k1 (exemplos)
  (loop for exemplo in exemplos
       for n from 0
       for coral = (first exemplo)
       for answer = (second exemplo)
       do (train-1nn coral answer n)))

(train-k1 *training-data*)

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

(defun classify-k1 (segmento options priv)
  (let* ((diff (extract-diff segmento))
         (pitches (extract-feature-list segmento diff))
         (k (or (aget :k (arg :options options))
                (aget :k priv))))
    (loop for (key value) in *1-neighbours* 
       with nn = nil
       do 
         (let ((d (distance pitches key)))
           (setf nn (clip k (insert (list d key value) nn :key #'car))))
       finally (return (get-class diff (mapcar #'second nn) (mapcar #'third nn))))))

(defun prepare-answers-k1 (coral options alg)
  (add-inversions coral (mapcar #L(classify-k1 !1 options (algorithm-private-data alg)) coral)))

(register-algorithm "ES-Knn" #'prepare-answers-k1
                    :description "A k-nearest-neighbors classifier that classifies each sonority by itself."
                    :private-data '((:k 1))
                    :do-options #'standard-do-options)

(defun show-examples ()
  "Mostra em que corais estão que tipos de acorde."
  (loop for h being the hash-keys in *examples*
     do (format t " ~a => ~a~%" h (remove-duplicates (gethash h *examples*)))))

;; Algoritmo context-knn. 



(defparameter *before-context* 2)
(defparameter *after-context* 0)

(defparameter *variance* 1/2)

(defparameter *context-neighbors* (make-alist))

(defun context-extract-diff (segmentos)
  (extract-diff (nth *before-context* segmentos)))

(defun context-extract-features (segmentos diff)
  (loop for seg in segmentos
     for peso from (-  *before-context*)
     nconc (loop for x in (extract-feature-list seg diff)
              collect (/ x (+ 1 (* (abs peso) *variance*))))))

(defun train-context-nn (coral answer n)
  (loop for segmento in coral
     for acorde in answer
     for diff = (context-extract-diff segmento)
     for pitches = (context-extract-features segmento diff)
     do (if (listp acorde)
            (mapcar (lambda (x) (insert-count pitches x diff *context-neighbors* n)) acorde)
            (insert-count pitches acorde diff *context-neighbors* n))))

(defun train-context (exemplos)
  (loop for exemplo in exemplos
     for coral = (first exemplo)
     for n from 0
     for answer = (second exemplo)
     do (train-context-nn (contextualize coral *before-context* *after-context*) answer n)))

(train-context *training-data*)

(defun classify-context (segmento options priv)
  (let* ((diff (context-extract-diff segmento))
         (pitches (context-extract-features segmento diff))
         (k (or (aget :ck (arg :options options))
                (aget :ck priv))))
    (loop for (key value) in *context-neighbors* 
       with nn = nil
       do 
         (let ((d (distance pitches key)))
           (setf nn (clip k (insert (list d key value) nn :key #'car))))
       finally (return (get-class diff (mapcar #'second nn) (mapcar #'third nn))))))

(defun prepare-answers-context (coral options alg)
  (let ((c (contextualize coral *before-context* *after-context*)))
    (add-inversions coral (mapcar #L(classify-context !1 options (algorithm-private-data alg)) (butlast c *before-context*)))))

(register-algorithm "EC-Knn" #'prepare-answers-context
                    :description "A k-nearest-neighbor classifier that considers a bit of contextual information."
                    :private-data '((:ck 3))
                    :do-options #'standard-do-options)
