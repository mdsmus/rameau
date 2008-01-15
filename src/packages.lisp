(in-package #:cl-user)

(defpackage #:rameau
  (:export
   #:i
   #:f
   #:d
   #:p
   #:v
   #:m
   #:*algoritmos*
   #:*exemplos-de-treinamento*
   #:*lily-dir-list*
   #:*gabarito-dir-list*
   #:algoritmo-compara
   #:algoritmo-nome
   #:algoritmo-processa
   #:calcula-duracoes
   #:chord-fundamental
   #:chord-mode
   #:chord-7th
   #:chordp
   #:compara-gabarito-fundamental
   #:compara-gabarito-modo-setima
   #:compara-notas
   #:filtra-algoritmos
   #:first-string
   #:get-comandos
   #:lista-notas
   #:make-chord
   #:make-melodic-note
   #:parse-file
   #:processa-files
   #:processa-gabarito
   #:parse-chord
   #:pitches
   #:rameau-path
   #:rameau-args
   #:rameau-profile
   #:rameau-report
   #:rameau-quit
   #:read-user-config
   #:segmentos-minimos
   #:set-lang
   #:evento-pitch
   #:evento-dur
   #:evento-octave
   #:evento-inicio
   #:make-evento
   #:fim-evento
   #:processa-cifras
   #:registra-algoritmo
   #:read-chords
   #:teste
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
      (exclude-repetition
       (loop for alg in algoritmos
          append (loop for i in *algoritmos*
                    when (> (count-subseq alg (string-downcase (algoritmo-nome i))) 0)
                    collect i)))
    *algoritmos*))

