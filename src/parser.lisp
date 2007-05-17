(require 'yacc)
(require 'lexer)
(load "formato.lisp")

(defpackage #:parser
  (:export parse-string parse-file)
  (:use #:cl #:yacc #:lexer #:formato))

(in-package #:parser)

;;;; Funções auxiliares para o parser

;; (ignore-first a b) => b
;; Ignora o primeiro argumento
(defun ignore-first (a b)
  (declare (ignore a))
  b)

;; (expmerge exp1 exp2) => expressãoanova
;; Junta as duas expressões, executando simultaneamente
(defun expmerge (exp1 exp2)
  (merge 'list exp1 exp2
         (lambda (x y)
           (< (inicio x) (inicio y)))))

(deflexer string-lexer
  ("(c|d|e|f|g|a|b)(is|es|isis|eses)?" (return (values 'NOTE %0)))
  ("(128|16|32|64|1|2|4|8)" (return (values 'DUR %0)))
  ("(\-|\a|\\^)." (return (values 'ARTICULATION %0)))
  ("[:space:]+" ); (return (values 'WHITESPACE %0)))
  ("-+\n")
  ("new Staff" (return (values 'NEW-STAFF %0)))
  ("<<" (return (values '|<<| '|<<|)))
  (">>" (return (values '|>>| '|>>|)))
  ("\\{" (return (values '|{| '|{|)))
  ("\\}" (return (values '|}| '|}|)))
  )

;;;; Funções para fazer o parsing

;; (parse-standalone-music-expression expr)
; trata uma music expression como se ela estivesse fora de <<>>
(defun parse-standalone-music-expression (expr)
  (if (cdr expr)
      (reduce #'formato::concatena-sequencias expr :initial-value nil)
      expr))

;; (parse-simultaneous-music-expression a exprs b)
; Ignora a e b e processa uma music expression como dentro de <<>>
(defun parse-simultaneous-music-expression (a exprs b)
  (declare (ignore a b))
  ;exprs)
  (reduce #'expmerge (cdr exprs) :initial-value (car exprs)))


;; (parse-simultaneous-staff-block a b c)
; Ignora a e c e trata um staff block como dentro de <<>>
(defun parse-simultaneous-staff-block (a b c)
  (declare (ignore a c))
  b)

;; (merge-exprs expr1 expr2)
; Trata expr1 e expr2 como music expressions que precisam começar
; do 0 e as junta
(defun merge-exprs (expr1 expr2)
  (expmerge (car (parse-standalone-music-expression expr1))
            (car (parse-standalone-music-expression expr2))))


;; (parse-staff-block1 ign expr1 expr2
; Contrói um staff block a partir de expr1 e expr2.
; FIXME: tem como dois staff blocks em sequência não soarem simultaneamente?
(defun parse-staff-block1 (ign expr1 expr2)
  (declare (ignore ign))
  (merge-exprs expr1 expr2))

;; (parse-staff-block2 ign staff)
; retorna staff
(defun parse-staff-block2 (ign staff)
  (ignore-first ign staff))

;; (parse-notes-expression a notes b expr)
; processa uma music expression que é uma sequência de notas e
; outra music expression ignorando delimitadores
(defun parse-notes-expression(a notes b expr)
  (declare (ignore a b))
  (append (list (emite-sequencia notes))
          expr))

;; (parse-notes a notes b)
; processa uma music expression que é uma sequência de notas
(defun parse-notes (a notes b)
  (declare (ignore a b))
  (list (emite-sequencia notes)))

;; (parse-note-sequence note note-expr)
; processa uma sequência de notas
(defun parse-note-sequence (note note-expr)
  (append note (list note-expr)))

(define-parser *expression-parser*
  (:start-symbol music-block)
  (:terminals (WHITESPACE NEW-STAFF DUR NOTE ARTICULATION |{| |}| |<<| |>>| ))

  (music-block
   staff-block
   (music-expression #'parse-standalone-music-expression)
   (|<<| music-expression |>>| #'parse-simultaneous-music-expression)
   (|<<| staff-block |>>| #'parse-simultaneous-staff-block)
   )

  (staff-block
   (NEW-STAFF music-expression staff-block #'parse-staff-block1)
   (NEW-STAFF music-expression #'parse-staff-block2))
  
  (music-expression
   (|{| notes |}| music-expression #'parse-notes-expression)
   (|{| notes |}| #'parse-notes))

  (notes
   (note-expr #'list)
   (notes note-expr #'parse-note-sequence))
  
  (note-expr
   (NOTE #'cria-nota)
   (NOTE DUR #'cria-nota)
   (NOTE DUR articulation-expr #'cria-nota)
   (NOTE articulation-expr #'cria-nota-artic))

  (articulation-expr
   ARTICULATION
   (articulation-expr ARTICULATION))
  )

(defun parse-string (str)
  (parse-with-lexer (string-lexer str) *expression-parser*))

(defun read-entire-file (f &optional (acumulated nil))
  (multiple-value-bind (l end) (read-line f)
    (if end
        (let ((seq (nreverse (cons l acumulated))))
          (reduce (lambda (x y)
                    (concatenate 'string x "
" ;; FIXME
                                 y))
                  (cdr seq)
                  :initial-value (car seq)))
        (read-entire-file f (cons l acumulated)))))
                

(defun parse-file (filename)
  (with-open-file (f filename)
    (parse-string (read-entire-file f))))


(parse-string "{c d e f}")

(parse-string "<< { c d e f } >>")

(parse-string "<<
{ c d e f }
{ c d e f }
>>")

(parse-string "<<
{ c d e f }
{ c d e f }
{ c d e f }
>>")

(parse-string "<<
new Staff { c d e f }
new Staff { c d e f }
>>")

(parse-string "new Staff { c d e f }")

