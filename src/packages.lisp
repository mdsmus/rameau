(in-package #:cl-user)


(defpackage #:rameau
  (:export
   #:cifra->acorde
   #:acorde->cifra
   #:read-pop-file
   #:7+
   #:extract-cifra
   #:expande-cifra-setima
   #:expand-mel
   #:gera-gabarito-file
   #:parse-file
   #:compara-notas
   #:lista-notas
   #:segmentos-minimos
   #:calcula-duracoes
   #:pop2cifra
   #:pitches
   )
  (:use #:rameau-base #:genoslib  #:cl #:it.bese.arnesi #:lisp-unit))

(in-package :rameau)
(export-rameau-symbols)
