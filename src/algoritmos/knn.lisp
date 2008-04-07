(defpackage :rameau-knn
  (:use :arnesi :cl :rameau))

(in-package :rameau-knn)


(defun make-alist () (list nil))

(defun apush (obj place)
  (let ((ap (car place))
        (dp (cdr place)))
    (setf (car place) obj
          (cdr place) (cons ap dp))))

(defun aget (key list &optional default)
  (aif (assoc key list :test #'equal)
       (second it)
       (progn
         (when (and default (not (eq default 'erro)))
           (apush (list key default) list))
         default)))

(defmacro aset (key list value)
  `(if (eq 'erro (aget ,key ,list 'erro))
       (apush (list ,key ,value) ,list)
       (setf (second (assoc ,key ,list :test #'equal)) ,value)))

(defmacro aincf (key list &optional (amount 1))
  `(if (eq 'erro (aget ,key ,list 'erro))
       (aset ,key ,list ,amount)
       (incf (car (cdr (assoc ,key ,list :test #'equal))) ,amount)))

(defmacro square (x)
  (let ((n (gensym)))
    `(let ((,n ,x))
       (* ,n ,n))))

(defun distance (a b)
  (if (and a b)
      (loop for i in a
         for j in b
         sum (square (- i j)))
      most-positive-fixnum))

;; src/algoritmos/knn.lisp
;; A k-nearest-neighbor chord finder, for use in Rameau.

;; The training examples as stored in a hash table, keyed by their
;; pitches. In the e-knn version, only one sonority is stored at a time, while
;; in the ec-knn a few surrouding sonorities are also stored.

;; The values in the hash table are also hash tables. These tables
;; are keyed by the classes for that example (there can be more than one)
;; and the values are the counts for how many times each class appears.

(defparameter *exemplos* (make-alist))
(defparameter *1-neighbours* (make-alist))
(defparameter *k* 1)

(defun processa-acorde (acorde diff)
  (cond ((chordp acorde)
         (list 'chord
               (- (parse-note (chord-fundamental acorde)) diff)
               (chord-mode acorde)
               (chord-7th acorde)))
        ((melodic-note-p acorde)
         (list '-))
        (t
         (list (augmented-sixth-type acorde)))))

(defun extrai-acorde (lista diff)
  (cond ((eq (first lista) '-)
         (make-melodic-note))
        ((eq (first lista) 'chord)
         (make-chord :fundamental (print-note (code->notename (+ (second lista) diff)))
                     :mode (third lista)
                     :7th (fourth lista)))
        (t (make-augmented-sixth :type (first lista)))))

(defun hash-default (key table default)
  (aif (gethash key table nil)
       it
       (setf (gethash key table) default)))

(defun insere-contagem (chave acorde diff hash n)
  (let ((acorde (processa-acorde acorde diff)))
    (if (aget acorde *exemplos*)
        (apush (cons chave n) (aget acorde *exemplos*))
        (aset acorde *exemplos* (list (cons chave n))))
    (aincf acorde (aget chave hash (make-alist)))))

(defun treina-1nn (coral gabarito n)
  (loop for segmento in coral
     for acorde in gabarito
     for diff = (extract-diff segmento)
     for pitches = (extract-feature-list segmento diff)
     do (if (listp acorde)
            (mapcar (lambda (x) (insere-contagem pitches x diff *1-neighbours* n)) acorde)
            (insere-contagem pitches acorde diff *1-neighbours* n))))

(defun treina-k1 (exemplos)
  (loop for exemplo in exemplos
       for n from 0
       for coral = (first exemplo)
       for gabarito = (second exemplo)
       do (treina-1nn coral gabarito n)))

(treina-k1 *training-data*)

(defun retorna-classificacao (diff maxkey maxv)
  (declare (ignore maxkey))
  (let ((resultado (make-hash-table :test #'equal)))
    (loop for hash in maxv do
         (loop for (k v) in hash
            do (incf (gethash k resultado 0) (or v 0))))
    (loop for k being the hash-keys in resultado
       with maxk = 0
       with maxv = 0
       when (> (gethash k resultado) maxv) do (setf maxk k maxv (gethash k resultado))
       finally (return (extrai-acorde maxk diff)))))

(defun classifica-k1 (segmento)
  (let* ((diff (extract-diff segmento))
         (pitches (extract-feature-list segmento diff)))
    (loop for (key value) in *1-neighbours* 
       with nn = nil
       do 
         (let ((d (distance pitches key)))
           (setf nn (clip *k* (insert (list d key value) nn :key #'car))))
       finally (return (retorna-classificacao diff (mapcar #'second nn) (mapcar #'third nn))))))

(defun gera-gabarito-k1 (coral)
  (coloca-inversoes coral (mapcar #'classifica-k1 coral)))

(register-algorithm "ES-Knn" #'gera-gabarito-k1 #'compara-gabarito-tonal)

(defun mostra-exemplos ()
  "Mostra em que corais estão que tipos de acorde."
  (loop for h being the hash-keys in *exemplos*
     do (format t " ~a => ~a~%" h (remove-duplicates (gethash h *exemplos*)))))

;; Algoritmo context-knn. 



(defparameter *contexto-antes* 2)
(defparameter *contexto-depois* 0)

(defparameter *variance* 1/2)

(defparameter *context-neighbors* (make-alist))
(defparameter *k-neighbors* 1)

(defun context-extrai-diff (segmentos)
  (extract-diff (nth *contexto-antes* segmentos)))

(defun context-extrai-features (segmentos diff)
  (loop for seg in segmentos
     for peso from (-  *contexto-antes*)
     nconc (loop for x in (extract-feature-list seg diff)
              collect (/ x (+ 1 (* (abs peso) *variance*))))))

(defun treina-context-nn (coral gabarito n)
  (loop for segmento in coral
     for acorde in gabarito
     for diff = (context-extrai-diff segmento)
     for pitches = (context-extrai-features segmento diff)
     do (if (listp acorde)
            (mapcar (lambda (x) (insere-contagem pitches x diff *context-neighbors* n)) acorde)
            (insere-contagem pitches acorde diff *context-neighbors* n))))

(defun treina-context (exemplos)
  (loop for exemplo in exemplos
     for coral = (first exemplo)
     for n from 0
     for gabarito = (second exemplo)
     do (treina-context-nn (contextualize coral *contexto-antes* *contexto-depois*) gabarito n)))

(treina-context *training-data*)

(defun classifica-context (segmento)
  (let* ((diff (context-extrai-diff segmento))
         (pitches (context-extrai-features segmento diff)))
    (loop for (key value) in *context-neighbors* 
       with nn = nil
       do 
         (let ((d (distance pitches key)))
           (setf nn (clip *k-neighbors* (insert (list d key value) nn :key #'car))))
       finally (return (retorna-classificacao diff (mapcar #'second nn) (mapcar #'third nn))))))

(defun gera-gabarito-context (coral)
  (let ((c (contextualize coral *contexto-antes* *contexto-depois*)))
    (coloca-inversoes coral (mapcar #'classifica-context (butlast c *contexto-antes*)))))

(register-algorithm "EC-Knn" #'gera-gabarito-context #'compara-gabarito-tonal)
