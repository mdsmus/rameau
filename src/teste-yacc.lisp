(require 'yacc)

(defpackage #:teste-yacc
  (:export teste)
  (:use #:cl #:yacc))

(in-package #:teste-yacc)

(defun list-lexer (list)
  #'(lambda ()
      (let ((value (pop list)))
        (if (null value)
            (values nil nil)
            (let ((terminal
                   (cond ((member value '(+ - * / |(| |)|)) value)
                         ((integerp value) 'int)
                         ((symbolp value) 'id)
                         (t (error "Unexpected value ~S" value)))))
              (values terminal value))))))

(defun string-lexer (foo)
  (let ((c (read-char foo nil nil)))
    (values c c)))

(defun k-2-3 (a b c)
  (declare (ignore a c))
  b)

(defun calcula (a b c)
  (funcall b a c))

(defun print-string (a b c)
  (print a))

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
   (- term)
   (|(| expression |)| #'k-2-3)))

(define-parser *expression-parser2*
    (:start-symbol expression)
  (:terminals (int + |(| |)|))

  (expression
   (expression + expression #'print-string)
   term)
     
  (term
   int
   (|(| expression |)| #'k-2-3)))

(parse-with-lexer (list-lexer '(3 * 2 + 3 * 4)) *expression-parser*)

(parse-with-lexer (string-lexer '"2+2") *expression-parser2*)
