(in-package #:cl-user)

(defpackage #:rameau
  (:export
   #:*algoritmos*
   #:algoritmo-compara
   #:algoritmo-nome
   #:algoritmo-processa
   #:calcula-duracoes
   #:chord-fundamental
   #:chord-mode
   #:chord-7th
   #:chordp
   #:compara-gabarito-fundamental
   #:compara-notas
   #:filtra-algoritmos
   #:lista-notas
   #:make-chord
   #:make-melodic-note
   #:parse-file
   #:parse-chord
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
   #:transpose-segmentos
   #:transpose-chords
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

