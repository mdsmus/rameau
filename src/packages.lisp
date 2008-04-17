(in-package #:cl-user)

(defpackage #:rameau
  (:export
   #:i
   #:f
   #:d
   #:p
   #:v
   #:m
   #:al
   #:fr
   #:it
   #:al+6
   #:fr+6
   #:it+6
   #:*algorithms*
   #:*training-data*
   #:*lily-dir-list*
   #:*gabarito-dir-list*
   #:*do-not-test*
   #:algorithm-tempered?
   #:algorithm-compare
   #:algorithm-name
   #:algorithm-classify
   #:augmented-sixth-type
   #:augmented-sixth-template
   #:calcula-duracoes
   #:chord-root
   #:chord-mode
   #:chord-7th
   #:chord-p
   #:add-inversions
   #:compare-answer-sheet
   #:compara-notas
   #:do-not-test
   #:extract-diff
   #:extract-feature-list
   #:filter-algorithms
   #:first-string
   #:get-comandos
   #:lista-notas
   #:make-chord
   #:make-melodic-note
   #:make-augmented-sixth
   #:melodic-note-p
   #:parse-file
   #:parse-file-list
   #:parse-answer-sheet
   #:parse-chord
   #:pitches
   #:rameau-args
   #:*rameau-path*
   #:rameau-profile
   #:rameau-report
   #:rameau-quit
   #:remove-comma-if-needed
   #:read-user-config
   #:sonorities
   #:set-lang
   #:event-pitch
   #:event-dur
   #:event-octave
   #:event-start
   #:event-time-sig
   #:event-key
   #:make-event
   #:fim-event
   #:processa-cifras
   #:register-algorithm
   #:read-chords
   #:temperado
   #:teste
   #:transpose-segmentos
   #:transpose-chords
   )
  (:use #:rameau-base #:genoslib  #:cl #:it.bese.arnesi #:lisp-unit))

(in-package :rameau)
(export-rameau-symbols)


(defstruct algorithm
  name
  classify
  tempered?)


(defparameter *algorithms* nil)

(defun register-algorithm (nome processa &optional tempered?)
  (push (make-algorithm :name nome :classify processa :tempered? tempered?)
        *algorithms*))

(defun filter-algorithms (algoritmos)
  (if algoritmos
      (remove-duplicates
       (loop for alg in algoritmos
          append (loop for i in *algorithms*
                    when (> (count-subseq alg (string-downcase (algorithm-name i))) 0)
                    collect i)))
    *algorithms*))

(do-not-test register-algorithm filtra-algoritmos)