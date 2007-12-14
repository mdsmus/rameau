
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

;;;; $Id: nile_run-net-lib.lisp,v 1.10 1999/09/28 11:02:45 slink Exp $

;;;; nile_run-net-lib
;;;;
;;;; defines various functions needed at runtime of an ANN
;;;; simulation
;;;;


(defpackage nile_run-net-lib
  (:use common-lisp)
  (:export layer
	   layer-sum-vec
	   layer-act-vec
	   layer-weight-vec
	   layer-saved-weight-vec
	   layer-previous-update-vec
	   layer-de-by-dw-vec
	   layer-previous-de-by-dw-vec
	   layer-delta-vec
	   ;
	   layer-weight-mean
	   layer-act-mean
	   ;
	   make-layer
	   copy-layer
	   layer-p
	   ;;
	   write-io
	   write-net
	   ;;
	   from-m-but-n
	   n-random-integers))

(in-package :nile_run-net-lib)


(defstruct layer
  ;; sum-vector
  sum-vec
  ;; activation-vector
  act-vec
  ;; activation function vector
  ;;  act-fn-vec
  ;; activation function for whole vector
  ;;  act-fn
  ;; weight-array: to i'th neuron of current layer
  ;; from j'th neuron of previous layer
  weight-vec
  ;;
  ;; For line search, we need the original weight-vector
  saved-weight-vec
  ;;
  ;; Previous updates are needed for momentum and
  ;; conjugate gradients
  previous-update-vec
  ;; dE / dW : derivative of error by weight
  ;; weight update something like w -> w - eta * dE/dW
  de-by-dw-vec
  ;;
  ;; Previous de-by-dws are needed to calculate beta
  ;; values for conjugate gradients
  previous-de-by-dw-vec
  ;; delta: dE/dS
  delta-vec
  )

(defun write-io (net)
  "Writes to *standard-output* the input- and output-layer of net"
  (if net
      (format t "Input: ~A Output ~A~%"
	      (layer-act-vec (aref net 0))
	      (layer-act-vec (aref net (1- (car (array-dimensions net))))))))

(defun write-net (net)
  "Writes to *standard-output* the most important vectors of each layer of net"
  (if net
      (dotimes (layer (car (array-dimensions net)))
	(format t "Layer ~a~%" layer)
	(format t "Sums        -> ~a~%" (layer-sum-vec (aref net layer)))
	(format t "Activations -> ~a~%" (layer-act-vec (aref net layer)))
	(format t "Deltas      -> ~a~%" (layer-delta-vec (aref net layer)))
	(format t "Weights     -> ~a~%" (layer-weight-vec (aref net layer)))
	(format t "de/dw s     -> ~a~%~%" (layer-de-by-dw-vec (aref net layer)))
	)))

(defun floyds-n-rands (n m)
  "Floyds random number generator.
Generates a list of n random integers up to (not including) m

Does not work if n=m !"
  (let ((rands nil))
    (do* ((j (+ n (- m) 1) (1+ j))
	  (k (random j) (random j)))
	((> j n) rands)
      (declare (fixnum n m j))
      ;;      (format t "j ~a k ~a~%" j k)
      (if (member k rands)
	  (push (1- j) rands)
	(push k rands)))))

(defmacro removenth (ni list)
  "removes ni'th element from <list>
and returns modified <list>"
  (let ((n (gensym))
	(pos (gensym))
	(res (gensym)))
    `(let ((,n ,ni))
       (if (= ,n 0) 
	   (pop ,list)
	 (let* ((,pos (nthcdr (1- ,n) ,list))
		(,res (cadr ,pos)))
	   (setf (cdr ,pos) (cddr ,pos))
	   ,res)))))

(defmacro from-m-but-n (limit n)
  "Generates random number up to limit which is not n"
  (let ((choice (gensym)))
    `(the fixnum
       (let ((,choice (the fixnum (random (1- ,limit)))))
	 (declare (fixnum ,choice))
	 (if (>= ,choice ,n)
	     (1+ ,choice)
	   ,choice)))))

;;;
;;; duplicate from c2ompile-net-lib.lisp
(defun fromto (from to)
  "Generates a list counting from from to to"
  (declare (fixnum from to)
	   (optimize (speed 3) (space 0) (safety 0) (debug 0)
		     (compilation-speed 0))
	   ;;	   (:explain :calls :types :boxing)
	   )
  (do ((count (1- to) (1- count))
       (res (cons to nil) (cons count res)))
      ((< count from) res)
    (declare (fixnum count))))

;;
;; Idea: take list of integers
;; maintain length of list in l
;; remove elements from rand(l)th position
;; repeat

(defun n-random-integers (asmany smallerthan)
  "Generates a list of asmany random integers smaller than smallerthan
Unlike floyds generator also works for asmany=smallerthan"
  (declare (fixnum asmany smallerthan)
	   ;;  	   (:explain :calls :types :boxing)
	   (optimize (speed 3) (space 2) (safety 0) (debug 0)
		     (compilation-speed 0)))
  (let ((nums (fromto 0 (1- smallerthan)))
	(result nil)
	(finallength (- smallerthan asmany)))
    (declare (fixnum finallength))
    (do ((listlength smallerthan (1- listlength)))
	((= listlength finallength) result)
      (declare (fixnum listlength))
      (push (removenth (random listlength)
		       nums)
	    result))))
