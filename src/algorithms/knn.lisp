(defpackage :rameau-knn
  (:import-from #:arnesi "AIF" "IT" "LAST1" "ENABLE-SHARP-L-SYNTAX" "AWHEN")
  (:shadowing-import-from #:rameau-base #:defun #:defmacro #:defparameter #:defvar #:defstruct)
  (:use #:cl #:rameau #:genoslib #:iterate :cl-lily)
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
(defparameter *version* 1)

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

(defun insert-count (chave acorde diff hash n &optional (process #'process-chord))
  (let ((acorde (funcall process acorde diff)))
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

(defun get-class (diff maxkey maxv &optional (extract #'extract-chord))
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
          finally (return (funcall extract maxk diff)))))

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
   (nn :accessor knn-nn :initform (make-alist))
   (version :accessor knn-version :initform 0)))

(defmethod perform-analysis (segments options (alg knn))
  (prepare-answers-k1 segments options alg))

(defun prepare (hash)
  (sorted (iter (for (k v) in hash)
                (when (and k v)
                  (nconcing (iter (for (mode count) in v)
                                  (when (and mode count)
                                    (collect (list count (format nil "~a" (extract-chord mode 0)) k)))))))
          #'>
          :key #'first))

(defun visualize-knn-hash (alg)
  (cl-cairo2:with-png-file ((concat *rameau-path* "analysis/view-knn.png")
                            'cl-cairo2:format-argb32
                            2000
                            2000)
    (let ((nn (prepare (knn-nn alg)))
          (center (list 1000 1000)))
      (destructuring-bind (first-count first-chord first-vector) (first nn)
        (declare (ignore first-chord))
        (cl-cairo2:rectangle 0 0 2000 2000)
        (cl-cairo2:set-source-rgb 1 1 1)
        (cl-cairo2:fill-path)
        (cl-cairo2:select-font-face "Vera" 'cl-cairo2:font-slant-normal 'cl-cairo2:font-weight-normal)
        (iter (for (count chord vector) in  nn)
              (let* ((angle (random (* 2 pi)))
                     (distance (distance first-vector vector))
                     (xpos (+ (first center) (* 700 (/ 1 (1+ (log count))) (/ 1 (1+ distance)) (cos angle))))
                     (ypos (+ (second center) (* 700 (/ 1 (1+ (log count))) (/ 1 (1+ distance)) (sin angle)))))
                (cl-cairo2:set-font-size (normalize 1 55 0 (log first-count) (log count)))
                (cairo-random-stroke-fill-colors)
                (cl-cairo2:move-to xpos ypos)
                (cl-cairo2:show-text chord)))))))

(defmethod do-options ((alg knn) options)
  (awhen (aget :k (arg :options options))
    (setf (knn-k alg) it))
  (when (aget :visualize (arg :options options))
    (visualize-knn-hash alg))
  (when (and (aget :train (arg :options options))
             (not (eql *version* (knn-version alg))))
    (format t "Training knn...~%")
    (train-k1 alg *training-data*)
    (setf (knn-version alg) *version*)))

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

(defun train-context-nn (alg coral answer n &optional (process #'process-chord))
  (let ((nn (cknn-nn alg)))
    (loop for segmento in coral
          for acorde in answer
          for diff = (context-extract-diff alg segmento)
          for pitches = (context-extract-features alg segmento diff)
          do (if (listp acorde)
                 (mapcar (lambda (x) (insert-count pitches x diff nn n process)) acorde)
                 (insert-count pitches acorde diff nn n process)))))

(defun train-context (alg exemplos)
  (let ((before-context (cknn-before-context alg))
        (after-context (cknn-after-context alg)))
    (loop for exemplo in exemplos
          for coral = (first exemplo)
          for n from 0
          for answer = (second exemplo)
          do (train-context-nn alg (butlast (contextualize coral before-context after-context) before-context) answer n))))

(defun classify-context (alg segmento options &optional (extract #'extract-chord))
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
          finally (return (get-class diff (mapcar #'second knn) (mapcar #'third knn) extract)))))

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
   (variance :accessor cknn-variance :initarg :variance :initform 3/2)
   (version :accessor cknn-version :initform 0)))

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
  (when (and (aget :train (arg :options options))
             (not (eql *version* (cknn-version alg))))
    (format t "Training cknn...~%")
    (train-context alg *training-data*)
    (setf (cknn-version alg) *version*)))

(add-algorithm (make-instance
                'context-knn
                :name "EC-Knn"
                :description "A k-nearest-neighbor classifier that considers a bit of contextual information."))


;; Functional knn

(defun process-fchord (fchord diff)
  (let* ((fchord (transpose-fchord fchord (- diff)))
         (key (fchord-key fchord))
         (function (fchord-roman-function fchord)))
    (list (tonal-key-center-pitch key)
          (tonal-key-mode key)
          (roman-function-mode function)
          (roman-function-degree-number function)
          (roman-function-degree-accidentals function))))

(defun functional-extract-chord (list diff)
  (destructuring-bind (key-pitch key-mode f-mode f-number f-acc) list
    (let ((key (make-tonal-key :mode key-mode :center-pitch key-pitch))
          (function (make-roman-function :degree-number f-number
                                         :degree-accidentals f-acc
                                         :mode f-mode)))
      (transpose-fchord (make-fchord :key key :roman-function function) diff))))

(defun train-functional (alg exemplos)
  (let ((before-context (cknn-before-context alg))
        (after-context (cknn-after-context alg)))
    (loop for exemplo in exemplos
          for coral = (first exemplo)
          for n from 0
          for answer = (second exemplo)
          do (train-context-nn alg (butlast (contextualize coral before-context after-context) before-context)
                               answer
                               n
                               #'process-fchord))))

(defun prepare-answers-functional (coral options alg)
  (let* ((before-context (cknn-before-context alg))
         (after-context (cknn-after-context alg))
         (c (contextualize coral before-context after-context)))
    (mapcar #L(classify-context alg !1 options #'functional-extract-chord) (butlast c before-context))))

(defclass functional-knn (rameau-algorithm)
  ((ck :accessor cknn-k :initarg :ck :initform 1)
   (nn :accessor cknn-nn :initform (make-alist))
   (before-context :accessor cknn-before-context :initarg :before-context :initform 1)
   (after-context :accessor cknn-after-context :initarg :after-context :initform 0)
   (variance :accessor cknn-variance :initarg :variance :initform 3/2)
   (version :accessor cknn-version :initform 0)))

(defmethod functional-analysis (segments options (alg functional-knn))
  (prepare-answers-functional segments options alg))

(defmethod do-options ((alg functional-knn) options)
  (awhen (aget :ck (arg :options options))
    (setf (cknn-k alg) it))
  (awhen (aget :before-context (arg :options options))
    (setf (cknn-before-context alg) it))
  (awhen (aget :after-context (arg :options options))
    (setf (cknn-after-context alg) it))
  (awhen (aget :variance (arg :options options))
    (setf (cknn-variance alg) it))
  (when (and (aget :train (arg :options options))
             (not (eql *version* (cknn-version alg))))
    (format t "Training fknn...~%")
    (train-functional alg *training-data*)
    (setf (cknn-version alg) *version*)))


(add-falgorithm (make-instance
                'functional-knn
                :name "F-Knn"
                :description "A k-nearest-neighbor classifier that considers a bit of contextual information and does functional harmonic analysis."))
