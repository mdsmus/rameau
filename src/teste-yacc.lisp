(require 'yacc)
(require 'lexer)
(load "formato.lisp")
(defpackage #:teste-yacc
  (:export teste)
  (:use #:cl #:yacc #:lexer #:formato))

(in-package #:teste-yacc)


(deflexer string-lexer
  ("(c|d|e|f|g|a|b)(is|es|isis|eses)?" (return (values 'NOTE %0)))
  ("(128|16|32|64|1|2|4|8)" (return (values 'DUR %0)))
  ("(\-|\_|\\^)." (return (values 'ARTICULATION %0)))
  ("[:space:]+" ); (return (values 'WHITESPACE %0)))
  ("-+\n")
  ("new Staff" (return (values 'NEW-STAFF %0)))
  ("<<" (return (values '|<<| '|<<|)))
  (">>" (return (values '|>>| '|>>|)))
  ("\\{" (return (values '|{| '|{|)))
  ("\\}" (return (values '|}| '|}|)))
  )

(defun parse-notes (_ notes __)
  (declare (ignore _ __))
  (print "parse-notes")
  (emite-sequencia notes))

(defun parse-expression(_ notes __ expr)
  (declare (ignore _ __))
  (print "parse-expression")
  (append (list (emite-sequencia notes))
          expr))

(defun parse-note (note note-expr)
  (print "pn")
  (print note)
  (print note-expr)
  (print "np")
  (append note (list note-expr)))

(defun ignore-first (a b)
  (declare (ignore a))
  b)


(defun merge-exprs (ign expr1 expr2)
  (declare (ignore ign))
  (merge 'list expr1 expr2
         (lambda (x y)
           (< (inicio x) (inicio y)))))

(define-parser *expression-parser*
  (:start-symbol music-block)
  (:terminals (WHITESPACE NEW-STAFF DUR NOTE ARTICULATION |{| |}| |<<| |>>| ))

  (music-block
   staff-block
   music-expression
   (|<<| music-expression |>>|)
   (|<<| staff-block |>>|)
   )

  (staff-block
   (NEW-STAFF music-expression staff-block #'merge-exprs)
   (NEW-STAFF music-expression #'ignore-first))
  
  (music-expression
   (|{| notes |}| music-expression #'parse-expression)
   (|{| notes |}| #'parse-notes))

  (notes
   (note-expr #'list)
   (notes note-expr #'parse-note))
  
  (note-expr
   (NOTE #'cria-nota)
   (NOTE DUR #'cria-nota)
   (NOTE DUR articulation-expr #'cria-nota)
   (NOTE articulation-expr #'cria-nota-artic))

  (articulation-expr
   ARTICULATION
   (articulation-expr ARTICULATION #'flatten))
  )

(parse-with-lexer (string-lexer "{c d e f}") *expression-parser*)
(parse-with-lexer (string-lexer "<< { c d e f } >>") *expression-parser*)

(parse-with-lexer (string-lexer "<<
{ c d e f }
{ c d e f }
>>") *expression-parser*)

(parse-with-lexer (string-lexer "<<
new Staff { c d e f }
new Staff { c d e f }
>>") *expression-parser*)

(print (parse-with-lexer (string-lexer "new Staff { c d e f }") *expression-parser*))
