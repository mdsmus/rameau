(require 'yacc)
(require 'lexer)
(defpackage #:teste-yacc
  (:export teste)
  (:use #:cl #:yacc #:lexer))

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

(defun flatten-list (l)
  (when l
    (if (atom l)
        l
        (if (atom (car l))
            (cons (car l) (flatten-list (cdr l)))
            (nconc (flatten-list (car l)) (flatten-list (cdr l)))))))



(defun flatten (&rest lists)
  (princ "saida: ")
  (print lists)
  ;(reduce #'nconc (mapcar #'flatten-list lists)))
  (flatten-list lists))


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
   (NEW-STAFF music-expression staff-block)
   (NEW-STAFF music-expression))
  
  (music-expression
   (|{| notes |}| music-expression)
   (|{| notes |}|))

  (notes
   note-expr
   (notes note-expr #'flatten))
  
  (note-expr
   NOTE
   (NOTE DUR)
   (NOTE DUR articulation-expr)
   (NOTE articulation-expr))

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

(parse-with-lexer (string-lexer "new Staff { c d e f }") *expression-parser*)
