(defpackage :rameau-knn
  (:use :arnesi :cl :rameau))

(in-package :rameau-knn)

(defparameter *1-neighbours* (make-hash-table :test #'equal))
(defparameter *k* 1)

;; Os vizinhos são guardados, a principio, em uma hash table
;; a chave é o vetor de notas, o valor é uma estrutura com contagens
;; de classes.

;; A estrutura com contagens de classes é uma hash table equal.
;; A chave é uma lista com pitch, modo e setima do acorde, o
;; conteudo é a contagem daquele acorde naquele vizinho, a principio.

;; Isso é necessário por knn usar um voto majoritário dos vizinhos mais
;; próximos, e, como o rameau é noisy, pode ser necessário

;; As notas são guardadas em um vetor transposto, já que analise harmônica é
;; invariante em relação a transposição.

(defmacro square (x)
  (let ((n (gensym)))
    `(let ((,n ,x))
       (* ,n ,n))))

(defun distance (a b)
  ;; A é o vetor, b é o candidato a neighbor
  (let ((diff (- (first a) (first b))))
    (loop for i in a
       for j in b
       sum (square (- i (+ j diff))))))

(defun processa-acorde (acorde diff)
  (if (chordp acorde)
      (list (- (note->code (chord-fundamental acorde)) diff)
            (chord-mode acorde)
            (chord-7th acorde))
      (list '-)))

(defun extrai-feature-list (segmento diff)
  (let ((segmento (mapcar2 (lambda (x) (module (- x diff))) #'evento-pitch segmento))
        (n (length segmento))
        (feature-list (repeat-list 96 0)))
    (loop for nota in segmento
       do (incf (nth nota feature-list) (/ 1 3)))
    feature-list))

(defun extrai-diff (segmento)
  (let ((segmento (sorted segmento #'compara-notas)))
    (evento-pitch (first segmento))))

(defun extrai-acorde (lista diff)
  (if (eq (first lista) '-)
      (make-melodic-note)
      (make-chord :fundamental (print-note (code->note (+ (first lista) diff)))
                  :mode (second lista)
                  :7th (third lista))))

(defun hash-default (key table default)
  (aif (gethash key table nil)
       it
       (setf (gethash key table) default)))

(defun insere-contagem-k1 (chave acorde diff)
  (let ((acorde (processa-acorde acorde diff)))
    (incf (gethash acorde
                   (hash-default chave *1-neighbours* (make-hash-table :test #'equal))
                   0))))

(defun treina-1nn (coral gabarito)
  (loop for segmento in coral
     for acorde in gabarito
     for diff = (extrai-diff segmento)
     for pitches = (extrai-feature-list segmento diff)
     for chave = (mapcar (lambda (x) (- x diff)) pitches)
     do (if (listp acorde)
            (mapcar (lambda (x) (insere-contagem-k1 chave x diff)) acorde)
            (insere-contagem-k1 chave acorde diff))))

(defun treina-k1 (exemplos)
  (loop for exemplo in exemplos
       for coral = (first exemplo)
       for gabarito = (second exemplo)
       do (treina-1nn coral gabarito)))

(treina-k1 *exemplos-de-treinamento*)

(defun retorna-classificacao (diff maxkey maxv)
  (let ((resultado (make-hash-table :test #'equal)))
    (loop for hash in maxv do
         (loop for k being the hash-keys in hash
            do (incf (gethash k resultado 0) (gethash k hash))))
    (loop for k being the hash-keys in resultado
       with maxk = 0
       with maxv = 0
       when (> (gethash k resultado) maxv) do (setf maxk k maxv (gethash k resultado))
       finally (return (extrai-acorde maxk diff)))))

(defun insere (elemento lista)
  "Insere elemento em lista, na posição correta. O primeiro elemento de elemento, assim
como do resto da lista, é a posição, quanto menor, mais na frente"
  (if lista
      (let ((fe (first elemento))
            (fl (first (first lista))))
        (if (< fe fl)
            (cons elemento lista)
            (cons (first lista) (insere elemento (rest lista)))))
      (list elemento)))

(defun clip (tamanho lista)
  "Corta lista para ter um tamanho maximo tamanho"
  (remove-if #'null (safe-retorna-n-elementos lista tamanho)))

(defun classifica-k1 (segmento)
  (let* ((diff (extrai-diff segmento))
         (pitches (extrai-feature-list segmento diff)))
    (loop for key being the hash-keys in *1-neighbours* 
       with mind = most-positive-fixnum
       with nn = nil
       do 
         (let ((d (distance pitches key)))
           (setf nn (clip *k* (insere (list d key (gethash key *1-neighbours*)) nn))))
       finally (return (retorna-classificacao diff (mapcar #'second nn) (mapcar #'third nn))))))

(defun gera-gabarito-k1 (coral)
  (mapcar #'classifica-k1 coral))

(register-algorithm "Knn" #'gera-gabarito-k1 #'compara-gabarito-modo-setima)