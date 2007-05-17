(in-package :cl-user)

(defpackage #:formato
  (:export 
   #:emite-evento
   #:move-evento-no-tempo
   #:movimenta-sequencia
   #:emite-sequencia
   #:emite-acorde
   #:cria-nota
   #:cria-nota-artic
   #:inicio
   #:concatena-sequencias)
  (:use #:cl))

(defpackage #:segment
  (:use #:cl))

(defpackage #:parser
  (:use #:cl #:yacc #:lexer #:formato)
  (:export #:parse-string #:parse-file))
