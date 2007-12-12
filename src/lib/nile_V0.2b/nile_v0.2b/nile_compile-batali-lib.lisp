
;;;; The NILE Package - Neural Network Simulations in LISP and
;;;;                    simulations of language evolution
;;;; 
;;;; Copyright (C) 1999 Nils Goroll <slink@schokola.de>
;;;; 
;;;; This program is free software; you can redistribute it and/or
;;;; modify it under the terms of the GNU General Public License
;;;; as published by the Free Software Foundation; either version 2
;;;; of the License, or (at your option) any later version.
;;;; 
;;;; This program is distributed in the hope that it will be useful,
;;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;;; GNU General Public License for more details.
;;;; 
;;;; You should have received a copy of the GNU General Public License
;;;; along with this program; if not, write to the Free Software
;;;; Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
;;;; 
;;;; Contact: slink@schokola.de
;;;; Snailmail address should be available via
;;;; http://www.cityline.net/~slink/

;;;; $Id: nile_compile-batali-lib.lisp,v 1.9 1999/09/28 11:02:42 slink Exp $

;;;; nile_compile-batali-lib
;;;; 
;;;; Some tools to compile batalis simulation (nile_batali)
;;;; 
;;;; 
;;;; 
;;;; 

(eval-when (:compile-toplevel :load-toplevel :execute)
  (let ((checker (and (find-package 'nile_loader)
		      (find-symbol (symbol-name 'check-if-modified)
				   (find-package 'nile_loader)))))
    (or (and checker
	     (fboundp checker)
	     (funcall (symbol-function checker)))
	(load "nile_loader"))))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (nile_loader:load-and-compile "nile_run-net-lib"
				"nile_compile-net-lib"
				"nile_c2ompile-net-lib"))

;;(eval-when (:load-toplevel :execute)
;;  (if (not (find-package 'nile_compile-batali-lib))
;;      (make-package 'nile_compile-batali-lib)))

(eval-when (:compile-toplevel :load-toplevel :execute)
(defpackage nile_compile-batali-lib
  (:use common-lisp
	nile_run-net-lib
	nile_compile-net-lib
	nile_c2ompile-net-lib)
  (:export make-batali-netspec
	   zero-input-layer
	   inject-character
	   correct
	   batali-meanings
	   )))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (in-package nile_compile-batali-lib))
(defconstant *RCS-ID* "$Id: nile_compile-batali-lib.lisp,v 1.9 1999/09/28 11:02:42 slink Exp $")
(defparameter *package-load-date* 0)

(defun make-batali-netspec (hidden-size numchars)
  "Generate a network specification for a batali-style net"
  (let ((netspec (netspec (+ hidden-size numchars) hidden-size 10)))
    (setf (net-spec-recurrent netspec)
      (let ((li nil))
	(dotimes (x hidden-size)
	  (push (cons
		 (cons 1 x)
		 (cons 0 (+ x numchars))) 
		li))
	li))
    netspec))

(defmacro zero-input-layer (netspec-form net
			    &key (method 'set))
  "Clear input-layer"
  (declare (optimize (speed 2) (space 1) (safety 1) (debug 0)
		     (compilation-speed 0)))
  (let* ((netspec (eval netspec-form))
	 (size (layer-spec-size
		(svref (net-spec-layer-specs netspec)
		       0))))
    (ecase method
      (set
       `(setf (layer-act-vec (svref ,net 0))
	  (make-array ',size
		      :element-type 'type-act
		      :initial-element ,(coerce 0.0 'type-act))))
      (copy
       (let ((act (gensym))
	     (x (gensym)))
	 `(let ((,act (layer-act-vec ,net)))
	    (declare (type (simple-array type-act
					 (,size))
			   ,act))
	    (dotimes (,x ,size)
	      (setf (aref ,act ,x) ,(coerce 0.0 'type-act)))))))))

;; characters "communicated" between the nets are just a
;; number - 0..3 for the original batali implementation
(defmacro inject-character (input-layer-act inum inumchars)
  "Inject a character"
  (let ((x (gensym))
	(num inum)
	(numchars (eval inumchars)))
    (if (not (numberp numchars))
	(error "inumchars argument of inject-character has to evaluate to a fixnum"))
    ;; if num is given at compile-time, make tailored function
    (if (and (numberp num) (>= num 0) (<= num (1- numchars)))
	`(progn
	   ,@(mapcar #'(lambda (x)
			 (if (= x num)
			     `(setf (aref ,input-layer-act ,x)
				,(coerce 1.0d0 'type-act))
			   `(setf (aref ,input-layer-act ,x)
			      ,(coerce 0.1d0 'type-act))))
		     (fromto 0 (1- numchars))))
      `(progn
	 (simple-dotimes-unroll 
	  (,x ,numchars)
	  (setf (aref ,input-layer-act ,x) ,(coerce 0.1d0 'type-act)))
	 (setf (aref ,input-layer-act ,num) ,(coerce 1.0d0 'type-act))))))

;;
;; determine batalis correct-mesure: how many of the values in
;; act and dest differ not more than 0.5
(defmacro correct (act dest size)
  "Calculate correct-value"
  (let ((no (gensym))
	(x (gensym)))
    `(the fixnum
       (let ((,no 0))
	 (declare (fixnum ,no))
	 (simple-dotimes-unroll 
	  (,x ,size)
	  (if (<= (the type-act (abs (the type-act (- (aref ,act ,x) (aref ,dest ,x)))))
		  ,(coerce 0.5 'type-act))
	      (incf ,no)))
	 ,no))))

(defun batali-meanings ()
  "Batalis meaning vectors"
  (let ((predicates (patterns 6
			      (0.0 1.0 1.0 0.0 0.0 1.0)	; happy
			      (0.0 1.0 1.0 1.0 0.0 0.0)	; sad 
			      (1.0 0.0 1.0 0.0 0.0 1.0)	; angry
			      (1.0 0.0 0.0 0.0 1.0 1.0)	; tired
			      (1.0 1.0 0.0 0.0 0.0 1.0)	; excited
			      (1.0 0.0 0.0 1.0 0.0 1.0)	; sick
			      (1.0 0.0 0.0 1.0 1.0 0.0)	; hungry
			      (0.0 0.0 0.0 1.0 1.0 1.0)	; thristy
			      (0.0 1.0 0.0 1.0 0.0 1.0)	; silly
			      (0.0 1.0 0.0 0.0 1.0 1.0)	; scared
			      ))
	(referents (patterns 4
			     (1.0 0.0 0.0 0.0) ; me
			     (1.0 0.0 0.0 1.0) ; we
			     (1.0 0.0 1.0 1.0) ; mip
			     (0.0 1.0 0.0 0.0) ; you
			     (0.0 1.0 0.0 1.0) ; yall
			     (0.0 1.0 1.0 1.0) ; yup
			     (1.0 1.0 0.0 1.0) ; yumi
			     (0.0 0.0 1.0 0.0) ; one
			     (0.0 0.0 1.0 1.0) ; they
			     (1.0 1.0 1.0 1.0) ; all
			     ))
	(all-meanings (nile_compile-tools:my-tenuring
		       (vector-of-n 100 
				    (make-array '(10)
						:element-type 'type-act)))))
    (declare (optimize speed))
    (dotimes (refs 10)
      (let ((referent (svref referents refs)))
	(declare (type (simple-array type-act (4))
		       referent))
	(dotimes (preds 10)
	  (let ((predicate (svref predicates preds))
		(meaning (svref all-meanings (+ (the fixnum (* refs 10)) preds))))
	    (declare (type (simple-array type-act (6))
			   predicate)
		     (type (simple-array type-act (10))
			   meaning))
	    (simple-dotimes-unroll 
	     (in-ref 4)
	     (setf (aref meaning in-ref) (aref referent in-ref)))
	    (simple-dotimes-unroll 
	     (in-pred 6)
	     (setf (aref meaning (+ in-pred 4)) (aref predicate in-pred)))))))
    all-meanings))

