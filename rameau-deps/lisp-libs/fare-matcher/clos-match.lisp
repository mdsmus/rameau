;;; -*- Mode: Lisp ; Base: 10 ; Syntax: ANSI-Common-Lisp -*-
;;;;; Fare's stuff for CLOS and its MOP

; This file contains enough to generate matchers of instances of classes
; known at macro-expansion-time.

(in-package :fare-clos-match)

;(eval-now
(defgeneric class-initarg-to-slot (class))
(defmethod class-initarg-to-slot ((class standard-class))
  (loop
      with hash = (make-hash-table)
      with slots = (compute-slots class)
      for slot in slots
      do (loop for initarg in (slot-definition-initargs slot)
               do (setf (gethash initarg hash) slot))
      finally (return #'(lambda (x) (gethash x hash)))))
;)

(defun simple-load-form (&rest rest)
  (mvbind (vars lforms iforms)
	  (values (mapcar #'(lambda (x) (declare (ignore x)) (gensym)) rest)
		  (mapcar2 #'make-load-form rest))
     `(let ,(mapcar #'list vars lforms)
	,@iforms
	(values ,@vars))))

#-gcl
(define-macro-matcher instance
  #'(lambda (class &rest arglist)
      (let ((initarg-to-slot (class-initarg-to-slot (find-class class)))
	    (*form (gensym))
	    (matchers '())
	    (var-lists '()))
	(mapc #'(lambda (x)
		  (let* ((initarg (car x))
			 (pat (cdr x))
			 (slot (funcall initarg-to-slot initarg))
			 (slotname (slot-definition-name slot)))
		    (mvbind (matcher vars) (pattern-matcher pat)
		      (push `(funcall ,matcher
				      (slot-value ,*form ',slotname))
                            ;; I don't dare use slot-value-using-class,
			    ;; because the matched object's class
			    ;; may be a subclass of class
			    matchers)
		      (push vars var-lists))))
	      (plist->alist arglist))
	(values
	 `#'(lambda (,*form)
	      `(m%and (typep ,',*form ',',class)
		      ,,@(nreverse matchers)))
	 (merge-matcher-variables var-lists)))))

#|
(load "fare")
(load "matcher")
(load "fare-clos")
(in-package :fare-clos)

(defclass foo ()
  ((x :initarg :x :accessor foo-x)
   (y :initarg :y :accessor foo-y)))
(defclass bar (foo)
  ((z :initarg :z :accessor bar-z)))
(setf (symbol-function 'baz) (class-initarg-to-slot (find-class 'bar)))

(TTEST*
 ((ifmatch (instance foo :x x :y y) (make-instance 'foo :x 1 :y 2) (list x y))
  :result '(1 2))
 ((ifmatch (instance foo :x x :y y) (make-instance 'bar :x 1 :y 2 :z 3) 
	   (list x y))
  :result '(1 2))
 ((ifmatch (slot* (x a) (z b)) (make-instance 'bar :x 1 :y 2 :z 3) 
	   (list a b))
  :result '(1 3))
 ((ifmatch (accessor* (foo-x a) (bar-z b)) (make-instance 'bar :x 1 :y 2 :z 3) 
	   (list a b))
  :result '(1 3)))


|#
