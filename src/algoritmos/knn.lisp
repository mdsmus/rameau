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
  (loop for i in a
     for j in b
     sum (square (- i j))))

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

(defun insere-contagem (chave acorde diff hash)
  (let ((acorde (processa-acorde acorde diff)))
    (incf (gethash acorde
                   (hash-default chave hash (make-hash-table :test #'equal))
                   0))))

(defun treina-1nn (coral gabarito)
  (loop for segmento in coral
     for acorde in gabarito
     for diff = (extrai-diff segmento)
     for pitches = (extrai-feature-list segmento diff)
     do (if (listp acorde)
            (mapcar (lambda (x) (insere-contagem pitches x diff *1-neighbours*)) acorde)
            (insere-contagem pitches acorde diff *1-neighbours*))))

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
;; Algoritmo context-knn. 

(defun agrupa (lista n)
  "Agrupa os elementos da lista em grupos de n em n, repetindo"
  (when lista
    (cons (safe-retorna-n-elementos lista n) (agrupa (rest lista) n))))

(defun coloca-n-contexto (segmentos antes depois)
  (butlast (agrupa (nconc (repeat-list antes nil) segmentos) (+ 1 antes depois)) (1- depois)))


(defparameter *contexto-antes* 2)
(defparameter *contexto-depois* 1)

(defparameter *variance* 1/2)

(defparameter *context-neighbors* (make-hash-table :test #'equal))
(defparameter *k-neighbors* 1)

(defun context-extrai-diff (segmentos)
  (extrai-diff (nth *contexto-antes* segmentos)))

(defun context-extrai-features (segmentos diff)
  (loop for seg in segmentos
     for peso from (-  *contexto-antes*)
     nconc (loop for x in (extrai-feature-list seg diff)
              collect (* x (if (= peso 0) 1 (/ *variance* (- (abs peso))))))))

(defun treina-context-nn (coral gabarito )
  (loop for segmento in coral
     for acorde in gabarito
     for diff = (context-extrai-diff segmento)
     for pitches = (context-extrai-features segmento diff)
     do (if (listp acorde)
            (mapcar (lambda (x) (insere-contagem pitches x diff *context-neighbors*)) acorde)
            (insere-contagem pitches acorde diff *context-neighbors*))))

(defun treina-context (exemplos)
  (loop for exemplo in exemplos
     for coral = (first exemplo)
     for gabarito = (second exemplo)
     do (treina-context-nn (coloca-n-contexto coral *contexto-antes* *contexto-depois*) gabarito)))

(treina-context *exemplos-de-treinamento*)

(defun classifica-context (segmento)
  (let* ((diff (context-extrai-diff segmento))
         (pitches (context-extrai-features segmento diff)))
    (loop for key being the hash-keys in *context-neighbors* 
       with mind = most-positive-fixnum
       with nn = nil
       do 
         (let ((d (distance pitches key)))
           (setf nn (clip *k-neighbors* (insere (list d key (gethash key *context-neighbors*)) nn))))
       finally (return (retorna-classificacao diff (mapcar #'second nn) (mapcar #'third nn))))))

(defun gera-gabarito-context (coral)
  (let ((c (coloca-n-contexto coral *contexto-antes* *contexto-depois*)))
    (mapcar #'classifica-context (butlast c 2))))

(register-algorithm "Knn-contexto" #'gera-gabarito-context #'compara-gabarito-modo-setima)
