(defpackage #:teste-yacc
  (:export teste)
  (:use #:cl #:yacc #:lexer))

(in-package #:teste-yacc)

(deflexer string-lexer
  ("[0-9]+" (return (values 'int  (num %0))))
  ("\\+" (return (values '+ '+)))
  ("\\*" (return (values '* '*)))
  ("\\/" (return (values '/ '/)))
  ("\\-" (return (values '- '-)))
  )

(defun calcula (a b c)
  (funcall b a c))

(define-parser *expression-parser*
  (:start-symbol expression)
  (:terminals (int id + - * / |(| |)|))
  (:precedence ((:left * /) (:left + -)))
     
  (expression
   (expression + expression #'calcula)
   (expression - expression #'calcula)
   (expression * expression #'calcula)
   (expression / expression #'calcula)
   term)
     
  (term
   id
   int
   (- term)))

(parse-with-lexer (string-lexer '"2+2*2") *expression-parser*)
