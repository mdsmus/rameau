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
   #:algorithm-tempered?
   #:algorithm-compare
   #:algorithm-name
   #:algorithm-classify
   #:augmented-sixth-type
   #:augmented-sixth-template
   #:durations
   #:chord-root
   #:chord-mode
   #:chord-7th
   #:chord-p
   #:add-inversions
   #:compare-answer-sheet
   #:event-end
   #:extract-diff
   #:extract-feature-list
   #:event-<
   #:filter-algorithms
   #:file-ast
   #:first-string
   #:get-comandos
   #:get-parsed-notes
   #:get-ast-string
   #:getenv
   #:list-events
   #:make-chord
   #:make-melodic-note
   #:make-augmented-sixth
   #:melodic-note-p
   #:node-text
   #:parse-file
   #:parse-file-list
   #:parse-answer-sheet
   #:parse-chord
   #:pitches
   #:print-ast
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
   #:processa-cifras
   #:register-algorithm
   #:read-chords
   #:temperado
   #:teste
   #:transpose-segmentos
   #:transpose-chords
   )
  (:import-from #:arnesi "AIF" "IT" "LAST1")
  (:import-from #:alexandria "SWITCH" "FLATTEN")
  (:use #:rameau-base #:genoslib  #:cl #:lisp-unit))

(in-package :rameau)
(export-rameau-symbols)


(defstruct algorithm
  name
  classify
  tempered?)


(defparameter *algorithms* nil)

(defun register-algorithm (nome processa &optional tempered?)
  "[DONTCHECK]"
  (push (make-algorithm :name nome :classify processa :tempered? tempered?)
        *algorithms*))

(defun filter-algorithms (algoritmos)
  "[DONTCHECK]"
  (if algoritmos
      (remove-duplicates
       (loop for alg in algoritmos
          append (loop for i in *algorithms*
                    when (> (count-subseq alg (string-downcase (algorithm-name i))) 0)
                    collect i)))
    *algorithms*))
