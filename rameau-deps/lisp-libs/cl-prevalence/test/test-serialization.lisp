;;;; -*- mode: Lisp -*-
;;;;
;;;; $Id: test-serialization.lisp,v 1.6 2007/03/16 15:37:18 scaekenberghe Exp $
;;;;
;;;; Testing XML and S-Expression based Serialization for Common Lisp and CLOS
;;;;
;;;; Copyright (C) 2003, 2004 Sven Van Caekenberghe, Beta Nine BVBA.
;;;;
;;;; You are granted the rights to distribute and use this software
;;;; as governed by the terms of the Lisp Lesser General Public License
;;;; (http://opensource.franz.com/preamble.html), also known as the LLGPL.

(in-package :s-serialization)

(defun serialize-and-deserialize-xml (object)
  (with-input-from-string
    (in (with-output-to-string (out)
	  (serialize-xml object out)))
    (deserialize-xml in)))

(defun serialize-and-deserialize-sexp (object)
  (with-input-from-string
    (in (with-output-to-string (out)
	  (serialize-sexp object out)))
    (deserialize-sexp in)))

;; primitives

(assert
 (null (serialize-and-deserialize-xml nil)))

(assert
 (null (serialize-and-deserialize-sexp nil)))

(assert
 (eq (serialize-and-deserialize-xml t)
     t))

(assert
 (eq (serialize-and-deserialize-sexp t)
     t))

(assert
 (= (serialize-and-deserialize-xml 100)
    100))

(assert
 (= (serialize-and-deserialize-sexp 100)
    100))

(assert
 (= (serialize-and-deserialize-xml (/ 3))
    (/ 3)))

(assert
 (= (serialize-and-deserialize-sexp (/ 3))
    (/ 3)))

(assert
 (= (serialize-and-deserialize-xml pi)
    pi))

(assert
 (= (serialize-and-deserialize-sexp pi)
    pi))

(assert
 (= (serialize-and-deserialize-xml (complex 1.5 2.5))
    (complex 1.5 2.5)))

(assert
 (= (serialize-and-deserialize-sexp (complex 1.5 2.5))
    (complex 1.5 2.5)))

(assert
 (eq (serialize-and-deserialize-xml 'foo)
     'foo))

(assert
 (eq (serialize-and-deserialize-sexp 'foo)
     'foo))

(assert
 (eq (serialize-and-deserialize-xml :foo)
     :foo))

(assert
 (eq (serialize-and-deserialize-sexp :foo)
     :foo))

(assert
 (eq (serialize-and-deserialize-xml 'room)
     'room))

(assert
 (eq (serialize-and-deserialize-sexp 'room)
     'room))

(assert
 (eq (serialize-and-deserialize-xml '|Unprintable|)
     '|Unprintable|))

(assert
 (eq (serialize-and-deserialize-sexp '|Unprintable|)
     '|Unprintable|))

(assert
 (equal (serialize-and-deserialize-xml "Hello")
	"Hello"))

(assert
 (equal (serialize-and-deserialize-sexp "Hello")
	"Hello"))

(assert 
 (equal (serialize-and-deserialize-xml "")
        ""))

(assert 
 (equal (serialize-and-deserialize-sexp "")
        ""))

(assert
 (equal (serialize-and-deserialize-xml #\A)
        #\A))

(assert
 (equal (serialize-and-deserialize-sexp #\A)
        #\A))

(assert
 (equal (serialize-and-deserialize-xml #\<)
        #\<))

(assert
 (equal (serialize-and-deserialize-sexp #\<)
        #\<))

(assert
 (equal (serialize-and-deserialize-xml "Hello <foo> & </bar>!")
	"Hello <foo> & </bar>!"))

(assert
 (equal (serialize-and-deserialize-sexp "Hello <foo> & </bar>!")
	"Hello <foo> & </bar>!"))

;; simple sequences

(assert
 (reduce #'(lambda (x &optional (y t)) (and x y))
	 (map 'list
	      #'eql
	      (serialize-and-deserialize-xml (list 1 2 3))
	      (list 1 2 3))))

(assert
 (reduce #'(lambda (x &optional (y t)) (and x y))
	 (map 'list
	      #'eql
	      (serialize-and-deserialize-sexp (list 1 2 3))
	      (list 1 2 3))))

(assert
 (equal (serialize-and-deserialize-xml (list 1 2 3))
	(list 1 2 3)))

(assert
 (equal (serialize-and-deserialize-sexp (list 1 2 3))
	(list 1 2 3)))

(assert
 (equal (serialize-and-deserialize-xml (cons 1 2))
        (cons 1 2)))

(assert
 (equal (serialize-and-deserialize-sexp (cons 1 2))
        (cons 1 2)))

(assert 
 (equal (serialize-and-deserialize-xml '(1 2 3 4 5 6 7 8 9 . 0))
        '(1 2 3 4 5 6 7 8 9 . 0)))

(assert 
 (equal (serialize-and-deserialize-sexp '(1 2 3 4 5 6 7 8 9 . 0))
        '(1 2 3 4 5 6 7 8 9 . 0)))

(assert
 (equal (serialize-and-deserialize-xml (cons 'hi 2))
	(cons 'hi 2)))

(assert
 (equal (serialize-and-deserialize-sexp (cons 'hi 2))
	(cons 'hi 2)))

(defun circular-list (&rest elements)
   (let ((cycle (copy-list elements))) 
     (nconc cycle cycle)))

(assert
 (equal (third (serialize-and-deserialize-sexp (circular-list 'a 'b)))
        'a))
(assert
 (equal (third (serialize-and-deserialize-xml (circular-list 'a 'b)))
        'a))

(assert
 (equal (serialize-and-deserialize-xml (cons 'hi 2))
	(cons 'hi 2)))

(assert
 (equal (serialize-and-deserialize-sexp (cons 'hi 2))
	(cons 'hi 2)))

(assert
 (equal (third (serialize-and-deserialize-sexp (circular-list 'a 'b)))
        'a))
(assert
 (equal (third (serialize-and-deserialize-xml (circular-list 'a 'b)))
        'a))

;; simple objects

(defclass foobar ()
  ((foo :accessor get-foo :initarg :foo)
   (bar :accessor get-bar :initarg :bar)))

(defparameter *foobar* (make-instance 'foobar :foo 100 :bar "Bar"))

(assert
 (let ((foobar (serialize-and-deserialize-xml *foobar*)))
   (and (equal (get-foo foobar) (get-foo *foobar*))
	(equal (get-bar foobar) (get-bar *foobar*))
	(eq (class-of foobar) (class-of *foobar*)))))

(assert
 (let ((foobar (serialize-and-deserialize-sexp *foobar*)))
   (and (equal (get-foo foobar) (get-foo *foobar*))
	(equal (get-bar foobar) (get-bar *foobar*))
	(eq (class-of foobar) (class-of *foobar*)))))

;; standard structs

(defstruct foobaz
  foo
  baz)

(defparameter *foobaz* (make-foobaz :foo 100 :baz "Baz"))

(assert
 (let ((foobaz (serialize-and-deserialize-xml *foobaz*)))
   (and (foobaz-p foobaz)
	(equal (foobaz-foo foobaz) (foobaz-foo *foobaz*))
	(equal (foobaz-baz foobaz) (foobaz-baz *foobaz*)))))

(assert
 (let ((foobaz (serialize-and-deserialize-sexp *foobaz*)))
   (and (foobaz-p foobaz)
	(equal (foobaz-foo foobaz) (foobaz-foo *foobaz*))
	(equal (foobaz-baz foobaz) (foobaz-baz *foobaz*)))))

;;; hash-tables

(defparameter *hashtable* 
  (let ((hashtable (make-hash-table :test 'equal)))
    (map nil
       #'(lambda (feature) (setf (gethash (symbol-name feature) hashtable) feature))
       *features*)
    hashtable))

(let (h2)
  (setf h2 (serialize-and-deserialize-xml *hashtable*))
  (maphash #'(lambda (k v) (assert (equal v (gethash k h2)))) *hashtable*) 
  (maphash #'(lambda (k v) (assert (equal v (gethash k *hashtable*)))) h2))

(let (h2)
  (setf h2 (serialize-and-deserialize-sexp *hashtable*))
  (maphash #'(lambda (k v) (assert (equal v (gethash k h2)))) *hashtable*) 
  (maphash #'(lambda (k v) (assert (equal v (gethash k *hashtable*)))) h2))

(defparameter *empty-hashtable* (make-hash-table))

(let (h2)
  (setf h2 (serialize-and-deserialize-xml *empty-hashtable*))
  (maphash #'(lambda (k v) (assert (equal v (gethash k h2)))) *empty-hashtable*) 
  (maphash #'(lambda (k v) (assert (equal v (gethash k *hashtable*)))) h2))

(let (h2)
  (setf h2 (serialize-and-deserialize-sexp *empty-hashtable*))
  (maphash #'(lambda (k v) (assert (equal v (gethash k h2)))) *empty-hashtable*) 
  (maphash #'(lambda (k v) (assert (equal v (gethash k *hashtable*)))) h2))

;;; eof
