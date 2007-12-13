
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

;;;; $Id: nile_demos.lisp,v 1.22 1999/09/28 11:08:43 slink Exp $

;;;; Some demos to show the basic capabilities of the package
;;;; 
;;;; Everything but demo-par5 has not yet been changed to use
;;;; the versatile trainer macro
;;;; 


(defpackage nile_demos
  (:use common-lisp
	nile_compile-net-lib
	nile_c2ompile-net-lib
	nile_run-net-lib)
  (:export demo-xor
	   demo-par5
	   demo-sine
	   demo-sine5
	   cg
	   sd))


(in-package :nile_demos)



(defparameter *zero-act* 0.001d0)

(defun tr-sd-5-5-1-sigm (net
			 train-input train-output
			 error-lim
			 eta
			 &key (max-cycles 0)
			      (momentum (coerce 0.0d0 'type-weight))
			      (write-error-every 1)
			      (write-net-every 0)
			      write-final)
  (declare
   (type type-weight momentum eta)
   (type type-act error-lim)
   (fixnum max-cycles write-error-every write-net-every)
   (optimize (speed 3) (space 2) (safety 0) (debug 0)
  	     (compilation-speed 0))
   )
  (trainer (netspec 5 5 1) net
	   train-input 
	   train-output
	   :batch t
	   
	   :method :sd
	   :sd-opts (:eta eta
		     :momentum momentum)

	   :max-cycles max-cycles
	   :error-lim error-lim

	   :cycle-opts
	   (:write-error-every write-error-every
            :write-net-every write-net-every)
	   :write-final write-final))


(defun tr-cg-5-5-1-sigm (net
			 train-input train-output
			 error-lim
			 &key (max-cycles 0)
			      (interval-location-eta (coerce 0.075d0 'type-weight))
			      (gss-tol (coerce 0.0001d0 'type-act))
			      (write-error-every 1)
			      (write-net-every 0)
			      write-final
			      ext-detect-locmin-kick
			      ext-detect-locmin)
  (declare
   (type type-weight interval-location-eta gss-tol)
   (type type-act error-lim)
   (fixnum max-cycles write-error-every write-net-every)
   (optimize (speed 3) (space 2) (safety 0) (debug 0)
   	     (compilation-speed 0)))

  (trainer (netspec 5 5 1) net
	   train-input train-output
	   :error-lim error-lim
	   :method :cg
	   :cg-opts (:save-weights-method :set
		     :interval-location-eta interval-location-eta
		     :gss-tol gss-tol)    
	   :max-cycles max-cycles
	   :cycle-opts
	   (:write-error-every write-error-every
	    :write-net-every write-net-every)
	   :write-final write-final
	   ))


(defun demo-par5 (&key (method :sd)
		       (eta 0.1d0)
		       (alpha 0.9d0)
		       random-state
		       (max-cycles 100)
		       (error-lim 0.01d0)
		       (write-error-every 1)
		       (write-net-every 0)
		       (write-final t)
		       (iloc-eta 0.15d0)
		       output-to-file
		       (ext-detect-locmin 0.005d0)
		       (ext-detect-locmin-kick 4.0)
		       (weight-deviation 2.0)
		       calc-test-error)
  "Demonstrate the package by training of a 5-5-1 net to learn a
5-bit parity problem.

Arguments are:

method                 :sd or :cg
eta                    the learning rate
alpha                  momentum
random-state           a random-state to use to unitialise the net
max-cycles             maximum number of cycles
error-lim              error limit after which to stop training
write-error-every      ... soandsomany cycles
write-net-every        ... soandsomany cycles
write-final            wheather to write the final net
iloc-eta               eta value for interval location of :CG
output-to-file         write testset result to 'output.dat'
ext-detect-locmin      Proprietrary local minima detection
                       difference factor
ext-detect-locmin-kick and the deviation of the random distibution
                       from which to draw values to kick the weights
weight-deviation       the deviation (mean zero) from which to draw
                       values for the initial weights
calc-test-error        wheather to calculate the test error"
  (declare
   (single-float weight-deviation)
   (type type-act error-lim)
   )
  (let* ((net
          (mk-net (netspec 5 5 1)
                  :weight-deviation weight-deviation
                  :runtime-weights t
                  :runtime-weights-state random-state))
         (train-input 
          (patterns 5
                    (0.0 0.0 0.0 0.0 0.0)
                    (0.0 0.0 0.0 0.0 1.0)
                    (0.0 0.0 0.0 1.0 0.0)
                    (0.0 0.0 0.0 1.0 1.0)
                    (0.0 0.0 1.0 0.0 0.0)
                    (0.0 0.0 1.0 0.0 1.0)
                    (0.0 0.0 1.0 1.0 0.0)
                    (0.0 0.0 1.0 1.0 1.0)
                    (0.0 1.0 0.0 0.0 0.0)
                    (0.0 1.0 0.0 0.0 1.0)
                    (0.0 1.0 0.0 1.0 0.0)
                    (0.0 1.0 0.0 1.0 1.0)
                    (0.0 1.0 1.0 0.0 0.0)
                    (0.0 1.0 1.0 0.0 1.0)
                    (0.0 1.0 1.0 1.0 0.0)
                    (0.0 1.0 1.0 1.0 1.0)
                    (1.0 0.0 0.0 0.0 0.0)
                    (1.0 0.0 0.0 0.0 1.0)
                    (1.0 0.0 0.0 1.0 0.0)
                    (1.0 0.0 0.0 1.0 1.0)
                    (1.0 0.0 1.0 0.0 0.0)
                    (1.0 0.0 1.0 0.0 1.0)
                    (1.0 0.0 1.0 1.0 0.0)
                    (1.0 0.0 1.0 1.0 1.0)
                    (1.0 1.0 0.0 0.0 0.0)
                    (1.0 1.0 0.0 0.0 1.0)
                    (1.0 1.0 0.0 1.0 0.0)
                    (1.0 1.0 0.0 1.0 1.0)
                    (1.0 1.0 1.0 0.0 0.0)
                    (1.0 1.0 1.0 0.0 1.0)
                    (1.0 1.0 1.0 1.0 0.0)
                    (1.0 1.0 1.0 1.0 1.0)))
         (train-output
          (patterns 1 
                    (0.0)
                    (1.0)
                    (1.0)
                    (0.0)
                    (1.0)
                    (0.0)
                    (0.0)
                    (1.0)
                    (1.0)
                    (0.0)
                    (0.0)
                    (1.0)
                    (0.0)
                    (1.0)
                    (1.0)
                    (0.0)
                    (1.0)
                    (0.0)
                    (0.0)
                    (1.0)
                    (0.0)
                    (1.0)
                    (1.0)
                    (0.0)
                    (0.0)
                    (1.0)
                    (1.0)
                    (0.0)
                    (1.0)
                    (0.0)
                    (0.0)
                    (1.0)))
         (test-input train-input)
         (test-output train-output)
         (test-error (coerce 0.0d0 'type-act)))
    (declare (type type-act test-error))

	
    (ecase method
      (:sd
       (tr-sd-5-5-1-sigm net
			 train-input train-output
			 (coerce error-lim 'type-act)
			 (coerce eta 'type-weight)
			 :max-cycles max-cycles
			 :momentum (coerce alpha 'type-weight)
			 :write-error-every write-error-every
			 :write-net-every write-net-every
			 :write-final write-final))
      (:cg
       (tr-cg-5-5-1-sigm net
			 train-input train-output
			 (coerce error-lim 'type-act)
			 :max-cycles max-cycles
			 :interval-location-eta (coerce iloc-eta 'type-weight)
			 :gss-tol 0.000001d0
			 :write-error-every write-error-every
			 :write-net-every write-net-every
			 :write-final write-final
			 :ext-detect-locmin-kick (coerce ext-detect-locmin-kick 'single-float)
			 :ext-detect-locmin (coerce ext-detect-locmin 'type-act)
			 )))
    ;; now get test error
    (if calc-test-error
	(let ((output-layer-act (layer-act-vec (svref net 2)))
	      (filehandle (if output-to-file
			      (open "output.dat"
				    :direction :output
				    :if-exists :supersede
				    :if-does-not-exist :create)
			    t)))
	  (setq test-error
	    (all-pattern-error (netspec 5 5 1) net
			       test-input test-output
			       (array-dimension test-input 0)
			       :write-output-to
			       filehandle))
	  
	  (format t "~%Test-error: ~a~%" test-error)
	  (if (and filehandle
		   (not (eq filehandle 't)))
	      (close filehandle))
	  test-error))))
