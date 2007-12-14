
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

;;;; $Id: nile_c2ompile-net-lib.lisp,v 1.15 1999/09/28 11:02:42 slink Exp $

;;;; These are the innermost definitions which are
;;;; even needed at compile-time of nile_compile-net-lib.lisp

(defpackage nile_c2ompile-net-lib
  (:use common-lisp)
  (:export type-act
	   type-weight
	   type-delta
	   type-de-by-dw
	   type-sum
	   ;;
	   list-of-n
	   random-weight
	   kick-weights
	   kick-net
	   ;; net-spec
	   net-spec
	   net-spec-layer-specs
	   net-spec-recurrent
	   make-net-spec
	   net-spec-p
	   copy-net-spec
	   ;; layer-spec
	   layer-spec
	   layer-spec-size
	   layer-spec-act-fn
	   layer-spec-act-fn-dash
	   layer-spec-act-fn-dash-uses-sum
	   make-layer-spec
	   copy-layer-spec
	   layer-spec-p
	   ;;
	   num-weights
	   ;; protected-eq-subst
	   simple-dotimes-unroll
	   fromto
	   geom-series
	   possibly-do-flet
	   possibly-do-let
	   vector-of-n))
		   

(in-package :nile_c2ompile-net-lib)


(deftype type-act () 'double-float)
(defparameter type-act-epsilon double-float-epsilon)
;; weights
(deftype type-weight () 'double-float)
(defparameter most-positive-type-weight most-positive-double-float)
;; delta-values (dE/dS)
(deftype type-delta () 'double-float)
;; errors per weight
(deftype type-de-by-dw () 'double-float)
;; sums
(deftype type-sum () 'double-float)

(defmacro list-of-n (i-n what)
  (declare (optimize (speed 1) (space 1) (safety 1) (debug 0)
		     (compilation-speed 0)))
  (let ((lon (gensym))
	(n (gensym))
	(acc (gensym)))
    `(labels ((,lon (,n ,acc)
		(if (> ,n 0)
		    (,lon (1- ,n)
			  (cons ,what
				,acc))
		  ,acc)))
       (,lon ,i-n nil))))

;;;
;;; Allegros random number generator is best when used
;;; with argument 1.0f0 (see .../doc/cl/implementation.htm#5.4 cl:random)
(defmacro random-weight (&optional (dev 2.0))
  (declare (optimize (speed 1) (space 1) (safety 1) (debug 0)
		     (compilation-speed 0)))
  `(-
    (* 2.0 (the type-weight (coerce ,dev 'type-weight))
       (random 1.0f0))
    ,dev))

(defmacro kick-weights (array
			&key (dev 2.0d0)
			     fresh
			     size)
  (declare (optimize (speed 1) (space 1) (safety 1) (debug 0)
		     (compilation-speed 0)))
  (let ((asize (gensym))
	(x (gensym)))
    `(let ((,asize ,(if size
			size
		      `(array-total-size ,array))))
       (declare (fixnum ,asize))
       (dotimes (,x ,asize)
	 ,(if fresh
	      `(setf (row-major-aref ,array ,x)
		 (random-weight ,dev))
	    `(setf (row-major-aref ,array ,x)
	       (+ (/ (row-major-aref ,array ,x)
		     2)
		  (random-weight ,dev))))))))

(defmacro kick-net (netspec-form net
		    &key (dev 2.0d0)
			 fresh)
  (let* ((netspec (eval netspec-form))
	 (layer-specs (net-spec-layer-specs netspec))
	 (num-layers (array-dimension layer-specs 0)))
    `(progn
       ,@(mapcar #'(lambda (layer)
		     `(kick-weights (nile_run-net-lib:layer-weight-vec (svref ,net ,layer))
				    :dev ,dev
				    :fresh ,fresh
				    :size (* ,(layer-spec-size 
					       (svref layer-specs layer))
					     ,(1+ (layer-spec-size 
						   (svref layer-specs (1- layer)))))))
		 (fromto 1 (1- num-layers))))))
					

		    

(defstruct net-spec
  layer-specs				; vector of layer-specs
  ;; list of pairs of pairs what to copy where
  ;; e.g.:
  ;;
  ;; (((1 . 1) . (0 . 1)) ((1 . 2) . (0 . 6)))
  ;; copy node 1 of layer 1 to node 1 layer 0
  ;; node 2 of layer 1 to node 6 of layer 0
  recurrent)

(defstruct layer-spec
  ;; number of nodes in that layer
  size					; integer
  ;; the activation function to use
  act-fn				; name of macro
  ;; the derivative of the activation function to use
  act-fn-dash				; name of macro
  ;; whether act-fn-dash uses s_m (sum of node)
  act-fn-dash-uses-sum
  )

(defun num-weights (layer-specs)
  (declare (optimize (speed 1) (space 1) (safety 1) (debug 0)
		     (compilation-speed 0)))
  (let ((numweights 0))
    (dotimes (layer (1- (car (array-dimensions layer-specs)))) ; 0..dim-2
      (incf numweights
	    (*
	     (1+ (layer-spec-size (svref layer-specs layer)))
	     (layer-spec-size (svref layer-specs (1+ layer))))))
    numweights))

(defun fromto (from to)
  (declare (fixnum from to)
	   (optimize (speed 3) (space 0) (safety 0) (debug 0)
		     (compilation-speed 0))
	   ;;	   (:explain :calls :types :boxing)
	   )
  (do ((count (1- to) (1- count))
       (res (cons to nil) (cons count res)))
      ((< count from) res)
    (declare (fixnum count))))

;;; #|

;;;; Idea to make really fast:
;;;; Analyse tree
;;;; For subtrees which do not contain a symbol to be replaced,
;;;; put in reference to original structure

;;; 1st return-val: List of trees which can be taken literally
;;; 2nd return-val: If tree can be taken literally as a whole

(declaim (ftype (function (atom t) (values t boolean))
		analyse))

(defun analyse (tobereplaced tree)
  (declare (optimize (speed 3) (space 0) (safety 0) (debug 0)
		     (compilation-speed 0))
	   ;;	   (:explain :calls :types :boxing)
	   (atom tobereplaced))
  ;; if all subtrees can be taken literally, then this one as
  ;; well. Otherwise return list of those subtrees which can.
  (if (consp tree)
      ;; is consp
      (if (eq (car tree) 'quote)
	  ;; can be taken literally, but do not record in
	  ;; resultlist, because it's gonna be checked by
	  ;; protected-eq-subst without lookup in the
	  ;; literals-list
	  (values nil t)
	;; consp and not quoted
	(let ((alltrue t)
	      (resultlist nil))
	  (declare (type boolean alltrue))
	  ;; if all subtrees return true, return true
	  ;; for this one and just return tree for literal
	  (setq resultlist 
	    (mapcan #'(lambda (subtree)
			(multiple-value-bind (litlist literal)
			    (analyse tobereplaced subtree)
			  (declare (type boolean literal))
			  (setq alltrue (and alltrue literal))
			  litlist))
		    tree))
	  (if alltrue
	      (values (list tree) t)
	    ;; otherwise return list of all which can be
	    ;; taken literally
	    (values resultlist nil))))
    ;; is atom
    (if (eq tree tobereplaced)
	(values nil nil)
      ;; don't include atoms in literalslist- return nil as 2nd
      (values nil t))))

(declaim (ftype (function (atom atom t t t t) t)
		protected-eq-subst-acc))
(defun protected-eq-subst-acc (new old tree literals acc lastelem)
  (declare (optimize (speed 3) (space 0) (safety 0) (debug 0)
		     (compilation-speed 0))
	   ;;	   (:explain :calls :types :boxing)
	   (atom new old))	   
  ;; acc is the first cons cell of the resulting list
  ;; lastelem is the last cons cell
  (if (null tree)
      ;; end of list
      acc
    ;; "mapcan" over elements
    (if (consp tree)
	;; is consp
	(if (eq (car tree) 'quote)
	    tree
	  ;; consp and not quoted - can we take it literally ?
	  (if (member tree literals :test #'eq)
	      tree
	    ;; unfortunately we really have to build 
	    ;; a new tree
	    (if lastelem
		;; not first pos of the list
		(protected-eq-subst-acc 
		 new old (cdr tree) literals
		 acc
		 (setf (cdr lastelem)
		   (cons
		    (protected-eq-subst-acc new old (car tree) literals
					    nil nil)
		    nil)))
	      ;; first pos of the list
	      (let ((firstcons
		     (cons
		      (protected-eq-subst-acc new old (car tree) literals
					      nil nil)
		      nil)))
		(protected-eq-subst-acc 
		 new old (cdr tree) literals
		 firstcons firstcons)))))
      ;; is atom
      (if (eq tree old)
	  new
	tree))))

(defun protected-eq-subst (new old tree literals)
  (protected-eq-subst-acc new old tree literals nil nil))

(defmacro simple-dotimes-unroll (varval &body body)
  (declare (optimize (speed 1) (space 1) (safety 1) (debug 0)
		     (compilation-speed 0)))
  (let ((var (car varval))
	(max (cadr varval)))
    (if (numberp max)
	(multiple-value-bind (literals justliteral)
	    (analyse var body)
	  (if justliteral
	      (progn
		;;		(format t "** nothing to subst - ~a times ~a~%" max body)
		`(progn ,@(do ((val (1- max) (1- val))
			       (result nil))
			      ((< val 0) result)
			    (setq result
			      (append body result)))
			nil))
	    (progn
	      ;;	      (format t "** doing subst with ~a times ~a~%" max body)
	      `(progn ,@(do ((val (1- max) (1- val))
			     (result nil))
			    ((< val 0) result)
			  (setq result
			    (nconc 
			     (protected-eq-subst-acc val var body literals 
						     nil nil)
			     result)))
		      nil))))
      (progn
	(warn
	 (format nil "Can't unroll: ~a is not a number at compile-time:~%         ~a~%"
		 max body))
	`(dotimes (,var ,max) ,@body)))))

(defmacro geom-series (c s &optional fromzero)
  "The geometric series of c until step s"
  (warn "geom-series: Declarations still have to be done")
  (let ((cl (gensym "cl-"))
	(ic (gensym "ic-"))
	(i (gensym "i-"))
	(sum (gensym "sum-")))
    `(let ((,cl ,c))
       (do ((,ic ,cl (* ,ic ,cl))
	    (,i 1 (1+ ,i))
	    (,sum ,(if fromzero 
		       `(coerce 1.0d0 (type-of ,c))
		     `(coerce 0.0d0 (type-of ,c)))
		  (+ ,sum ,ic)))
	   ((> ,i ,s) ,sum)
	 (declare (fixnum ,i))))))

(defun possibly-do-flet (flets decls &rest body)
  (if (and flets (>= (length flets) 1))
      `(flet ,flets
	 ,decls
	 ,@body)
    (if (= (length body) 1)
	(car body)
      `(progn
	 ,@body))))

(defun possibly-do-let (lets decls &rest body)
  (if (and lets (>= (length lets) 1))
      `(let ,lets
	 ,decls
	 ,@body)
    (if (= (length body) 1)
	(car body)
      `(progn
	 ,@body))))

(defmacro vector-of-n (n what &key (type t))
  "Macro to create at runtime a vector of n entries of what"
  (let ((vec (gensym))
	(x (gensym))
	(en (eval n)))
    `(let* ((,vec (make-array ,(if (numberp en)
				   `'(,en)
				 `(list ,en))
			      :element-type ,type)))
       (dotimes (,x ,en)
	 ,(if (eq type t)
	      `(setf (svref ,vec ,x) ,what)
	    `(setf (aref ,vec ,x) ,what)))
       ,vec)))

