(in-package #:cl-user)

(defpackage #:rameau
  (:export
   #:acorde->cifra
   #:*algoritmos*
   #:algoritmo-compara
   #:algoritmo-nome
   #:algoritmo-processa
   #:calcula-duracoes
   #:compara-notas
   #:filtra-algoritmos
   #:lista-notas
   #:parse-file
   #:pitches
   #:segmentos-minimos
   #:evento-pitch
   #:evento-dur
   #:evento-octave
   #:evento-inicio
   #:make-evento
   #:fim-evento
   #:processa-cifras
   #:registra-algoritmo
   #:read-chords
   )
  (:use #:rameau-base #:genoslib  #:cl #:it.bese.arnesi #:lisp-unit))

(in-package :rameau)
(export-rameau-symbols)


(defstruct algoritmo
  (nome)
  (processa)
  (compara))

(defparameter *algoritmos* nil)

(defun registra-algoritmo (nome processa compara)
  (push (make-algoritmo :nome nome :processa processa :compara compara)
        *algoritmos*))

(defun filtra-algoritmos (algoritmos)
  (if algoritmos
    (loop for alg in algoritmos
         append (loop for i in *algoritmos*
                   when (> (count-subseq alg (string-downcase (algoritmo-nome i))) 0)
                   collect i))
    *algoritmos*))

