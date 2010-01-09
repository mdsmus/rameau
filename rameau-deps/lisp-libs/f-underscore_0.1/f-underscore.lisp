; `F-UNDERSCORE' is a tiny library of functional programming utilities placed into the
; public domain
;
; the idea is to make functional programs shorter and easier to read without resorting
; to syntax [like arc's square bracket unary function syntax]
;
;   (f (x) ..) -> (lambda (x) ..)
;
;   (f0 ..)    -> (lambda () ..)
;
;   (f_ ..)    -> (lambda (_) ..)
;
;   (f_n ..)   -> (lambda (&rest _) ..)
;
;   (f_% ..)   ~= (lambda (&rest #:%) (declare (ignore #:%)) ..)
;
;   (setf (macro-function 'foo) (m args ..)) ~= (defmacro foo args ..)
;

(defpackage :f-underscore
  (:use :cl)
  (:export ; functional programming utils
           :f
           :f0
	   :f_
	   :f_n
	   :_
	   :f_%
	   :m))

(in-package :f-underscore)

; functional programming utils

(defmacro f (args &body body)
  "a synonym for LAMBDA"
  `(lambda ,args ,@body))

(defmacro f0 (&body body)
  "a LAMBDA that takes 0 arguments (aka a 'thunk')"
  `(lambda () ,@body))

(defmacro f_ (&body body)
  "a LAMBDA that takes 1 argument: `_'"
  `(lambda (_) ,@body))

(defmacro f_n (&body body)
  "a LAMBDA that takes 1 &REST argument: `_'"
  `(lambda (&rest _) ,@body))

(defmacro f_% (&body body)
  "a LAMBDA that takes 1 &REST that it ignores"
  (let ((% (gensym "ignore")))
    `(lambda (&rest ,%)
       (declare (ignore ,%))
       ,@body)))

(defmacro m (macro-lambda-list &body body)
  "a LAMBDA that has a macro-lambda-list instead of an ordinary lambda-list"
  (let ((% (gensym "macro-lambda-list")))
    (if (and (stringp (first body))
	     (rest body))

	;; there is a doc string
	`(lambda (&rest ,%)
	   ,(first body)
	   (destructuring-bind ,macro-lambda-list ,%
	     ,@(rest body)))

	;; there is no doc string
	`(lambda (&rest ,%)
	   (destructuring-bind ,macro-lambda-list ,%
	     ,@body)))))