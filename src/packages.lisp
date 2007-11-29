(in-package #:cl-user)

(defpackage #:rameau
  (:export #:acorde->cifra #:calcula-duracoes #:cifra->acorde
  #:compara-notas #:lista-notas #:parse-file
  #:pitches #:pop->gab #:read-pop-file #:segmentos-minimos
  #:evento-pitch #:evento-dur #:evento-octave #:evento-inicio
  #:make-evento #:fim-evento #:pops->gabs)
  (:use #:rameau-base #:genoslib  #:cl #:it.bese.arnesi #:lisp-unit))

(in-package :rameau)
(export-rameau-symbols)
