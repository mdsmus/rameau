
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
	nile_compile-tools
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


(eval-when (:compile-toplevel)
  (gc-pre-compile))

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

(eval-when (:compile-toplevel)
  (format t "End of tr-sd-5-5-1-sigm~%")
  (my-tenure))

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

(eval-when (:compile-toplevel)
  (format t "End of tr-cg-5-5-1-sigm...~%")
  (my-tenure))

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
	  (my-tenuring (mk-net (netspec 5 5 1)
				  :weight-deviation weight-deviation
				  :runtime-weights t
				  :runtime-weights-state random-state)))
	 (train-input (my-tenuring
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
				 (1.0 1.0 1.0 1.0 1.0))))
	 (train-output (my-tenuring
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
				  (1.0))))
	 (test-input train-input)
	 (test-output train-output)
	 (test-error (coerce 0.0d0 'type-act)))
    (declare (type type-act test-error))

    (nile_loader:gnunotice)
	
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

(eval-when (:compile-toplevel)
  (format t "End of test-par5~%")
  (my-tenure))

#|

(defun tr-sd-2-2-1-sigm (net
			 train-input train-output
			 error-lim
			 eta
			 &key max-cycles
			      momentum
			      write-error-every
			      write-net-every
			      write-final)
  (declare
   ;;   (:explain :calls :types :boxing)
   (type type-weight momentum eta)
   (type type-act error-lim)
   (fixnum max-cycles write-error-every write-net-every)
   (optimize (speed 3) (space 2) (safety 0) (debug 0)
  	     (compilation-speed 0))
   )
  (train-sd (netspec 2 2 1) net
	    train-input train-output
	    error-lim
	    eta
	    :max-cycles max-cycles
	    :momentum momentum
	    :write-error-every write-error-every
	    :write-net-every write-net-every
	    :write-final write-final))

(eval-when (:compile-toplevel)
  (format t "End of tr-sd-2-2-1-sigm~%")
  (my-tenure))

(defun tr-cg-2-2-1-sigm (net
			 train-input train-output
			 error-lim
			 &key max-cycles
			      interval-location-eta
			      gss-tol
			      write-error-every
			      write-net-every
			      write-final
			      ext-detect-locmin-kick
			      ext-detect-locmin)
  (declare
   (type type-weight interval-location-eta gss-tol)
   (type type-act error-lim)
   (fixnum max-cycles write-error-every write-net-every)
   (optimize (speed 3) (space 2) (safety 0) (debug 0)
   	     (compilation-speed 0))
   )

  (train-cg (netspec 2 2 1) net
		 train-input train-output
		 error-lim
		 :max-cycles max-cycles
		 :save-weights-method set ;; compile-time
		 :interval-location-eta interval-location-eta
		 :gss-tol gss-tol
		 :write-error-every write-error-every
		 :write-net-every write-net-every
		 :write-final write-final
		 :ext-detect-locmin-kick ext-detect-locmin-kick
		 :ext-detect-locmin ext-detect-locmin))

(eval-when (:compile-toplevel)
  (format t "End of tr-cg-2-2-1-sigm...~%")
  (my-tenure))

(defun demo-xor (&key (method 'sd)
		      (eta 0.1d0)
		      (alpha 0.9d0)
		      random-state
		      (max-cycles 100)
		      (error-lim 0.01d0)
		      (write-error-every 1)
		      (write-net-every nil)
		      (write-final t)
		      (iloc-eta 0.075d0)
		      output-to-file
		      (ext-detect-locmin 0.005d0)
		      (ext-detect-locmin-kick 4.0)
		      (weight-deviation 2.0))
  (declare
;;   (type type-weight alpha eta iloc-eta)
   (single-float weight-deviation)
   (type type-act error-lim)
;;   (optimize (speed 3) (space 2) (safety 0) (debug 0)
;;	     (compilation-speed 0))
   )
  (let* ((net
	  (my-tenuring (mk-net (netspec 2 2 1)
				  :weight-deviation weight-deviation
				  :runtime-weights t
				  :runtime-weights-state random-state)))
	 (train-input (my-tenuring
		       (patterns 2 (0.0 0.0) (0.0 1.0) (1.0 0.0) (1.0 1.0))))
	 (train-output (my-tenuring
			(patterns 1 (0.0) (1.0) (1.0) (0.0))))
	 (test-input train-input)
	 (test-output train-output)
	 (train-error 0.0)
	 (test-error 0.0))
    (declare (type type-act train-error test-error))
    
    (setq train-error
      (ecase method
	(sd
	 (tr-sd-2-2-1-sigm net
			   train-input train-output
			   (coerce error-lim 'type-act)
			   (coerce eta 'type-weight)
			   :max-cycles max-cycles
			   :momentum (coerce alpha 'type-weight)
			   :write-error-every write-error-every
			   :write-net-every write-net-every
			   :write-final write-final))
	(cg
	 (tr-cg-2-2-1-sigm net
			   train-input train-output
			   (coerce error-lim 'type-act)
			   :max-cycles max-cycles
			   :interval-location-eta (coerce iloc-eta 'type-weight)
			   :gss-tol 0.0001d0
			   :write-error-every write-error-every
			   :write-net-every write-net-every
			   :write-final write-final
			   :ext-detect-locmin-kick (coerce ext-detect-locmin-kick 'single-float)
			   :ext-detect-locmin (coerce ext-detect-locmin 'type-act)))))
    ;; now get test error
    (let ((output-layer-act (layer-act-vec (svref net 2)))
	  (filehandle (if output-to-file
			  (open "output.dat"
				:direction :output
				:if-exists :supersede
				:if-does-not-exist :create)
			t)))
      (setq test-error
	(all-pattern-error (netspec 2 2 1) net
			   test-input test-output
			   (array-dimension test-input 0)
			   :write-output-to
			   filehandle))

      (format t "~%Test-error: ~a~%" test-error)
      (if (and filehandle
	       (not (eq filehandle 't)))
	  (close filehandle))
      (values train-error test-error))))

(eval-when (:compile-toplevel)
  (format t "End of test-xor~%")
  (my-tenure))

|#

;; data was made using:
#|
(let ((ipats nil)
      (opats nil))
  (dotimes (x 20)			; for test: (x 101)
    (let* ((i (random 1.0d0))		; for test (i (/ x 100.0))
	   (n (- (random 0.1) 0.05))
	   (o (/ (+ 1 n (sin (* 2 pi i)))
		 2)))
      (format t "~a ~a~%" i o)
      (push (list i) ipats)
      (push (list o) opats)))
  (write ipats)(terpri)
  (write opats)(terpri))
|#

;;; #|

#|

(defun sine-train20-in ()
  (patterns 1
	    (0.8674384307443042d0) (0.1491778574153706d0) (0.9537849936049874d0)
	    (0.3045172061185646d0) (0.5391662204563126d0) (0.09297721023952832d0)
	    (0.39447027554485103d0) (0.3291905269514679d0) (0.12400941096382567d0)
	    (0.05029480011049614d0) (0.06131893666696797d0) (0.8804722425379374d0)
	    (0.6291395806229083d0) (0.3210149431904803d0) (0.3032211861926193d0)
	    (0.7523815440546038d0) (0.07643689010149401d0) (0.7883638857032658d0)
	    (0.943003198791704d0) (0.758605877679404d0)))

(eval-when (:compile-toplevel)
  (my-tenure))

(defun sine-train20-out ()
  (patterns 1
	    (0.13295597570671358d0) (0.8941540484409647d0) (0.34494024432427994d0)
	    (0.9597808051915018d0) (0.3599701805796525d0) (0.7708439847490176d0)
	    (0.8291132953659979d0) (0.9503942191694235d0) (0.8478901438285936d0)
	    (0.6582276564831211d0) (0.6701647616844122d0) (0.15834965519468885d0)
	    (0.1247553259946344d0) (0.9597542461577215d0) (0.9820402339039298d0)
	    (0.002094098128277544d0) (0.7176038968385049d0) (0.01689937579465467d0)
	    (0.31437304017571327d0) (0.0032819739859302755d0)))

(eval-when (:compile-toplevel)
  (my-tenure))

(defun sine-train-in ()
  (patterns 1
	(0.73960525) (0.5727094) (0.49873155) (0.099443555) (0.8288612) (0.39776146)
	(0.09032446) (0.40874135) (0.8874287) (0.9167387)))

(eval-when (:compile-toplevel)
  (my-tenure))

(defun sine-train-out ()
  (patterns 1
	    (-2.3639202e-4) (0.27862668) (0.510725) (0.7990142) (0.04106164) (0.80814505)
	    (0.7462534) (0.77519983) (0.16202581) (0.27401155)))

(eval-when (:compile-toplevel)
  (my-tenure))

(defun sine-test-in ()
  (patterns 1
	    (1.0d0) (0.99d0) (0.98d0) (0.97d0) (0.96d0) (0.95d0) (0.94d0) (0.93d0)
	    (0.92d0) (0.91d0) (0.9d0) (0.89d0) (0.88d0) (0.87d0) (0.86d0) (0.85d0)
	    (0.84d0) (0.83d0) (0.82d0) (0.81d0) (0.8d0) (0.79d0) (0.78d0) (0.77d0)
	    (0.76d0) (0.75d0) (0.74d0) (0.73d0) (0.72d0) (0.71d0) (0.7d0) (0.69d0)
	    (0.68d0) (0.67d0) (0.66d0) (0.65d0) (0.64d0) (0.63d0) (0.62d0) (0.61d0)
	    (0.6d0) (0.59d0) (0.58d0) (0.57d0) (0.56d0) (0.55d0) (0.54d0) (0.53d0)
	    (0.52d0) (0.51d0) (0.5d0) (0.49d0) (0.48d0) (0.47d0) (0.46d0) (0.45d0)
	    (0.44d0) (0.43d0) (0.42d0) (0.41d0) (0.4d0) (0.39d0) (0.38d0) (0.37d0)
	    (0.36d0) (0.35d0) (0.34d0) (0.33d0) (0.32d0) (0.31d0) (0.3d0) (0.29d0)
	    (0.28d0) (0.27d0) (0.26d0) (0.25d0) (0.24d0) (0.23d0) (0.22d0) (0.21d0)
	    (0.2d0) (0.19d0) (0.18d0) (0.17d0) (0.16d0) (0.15d0) (0.14d0) (0.13d0)
	    (0.12d0) (0.11d0) (0.1d0) (0.09d0) (0.08d0) (0.07d0) (0.06d0) (0.05d0)
	    (0.04d0) (0.03d0) (0.02d0) (0.01d0) (0.0d0)))

(eval-when (:compile-toplevel)
  (my-tenure))

(defun sine-test-out ()
  (patterns 1
	    (0.4761123955249785d0) (0.4801163640947489d0) (0.4149685284052256d0)
	    (0.4211800459275051d0) (0.35413891214190707d0) (0.3630601506740069d0)
	    (0.3383481760235359d0) (0.2936262743796648d0) (0.25911323877578724d0)
	    (0.2477768695965309d0) (0.18677159728630421d0) (0.20175808788551236d0)
	    (0.1646096510189624d0) (0.14626174809120462d0) (0.10087021872669871d0)
	    (0.0831285458117938d0) (0.10045152959289483d0) (0.07811235030475877d0)
	    (0.031482103411383966d0) (0.020849796072598015d0) (0.040728074249884116d0)
	    (0.01215675746745326d0) (0.0022191590213367918d0) (0.028361301400408767d0)
	    (-0.016832470792962684d0) (-0.009621798992156982d0) (-0.005096077818109168d0)
	    (0.027365963437304575d0) (0.013852435960728882d0) (0.025733980291549996d0)
	    (0.028979700741430803d0) (0.03662648989355144d0) (0.054658088032431995d0)
	    (0.05562393506351743d0) (0.07892739829482975d0) (0.08160385899843942d0)
	    (0.13135727927357382d0) (0.13133206607483205d0) (0.17415509646116223d0)
	    (0.19899511457694913d0) (0.22513860048874274d0) (0.23328251010327522d0)
	    (0.2648953363538361d0) (0.30644627979653494d0) (0.31702610447125945d0)
	    (0.35308221392931693d0) (0.39210385221301314d0) (0.3995527985939784d0)
	    (0.43168384636977963d0) (0.4848577943773416d0) (0.5115941762924195d0)
	    (0.5423153075246665d0) (0.5532900312986012d0) (0.6072481509795385d0)
	    (0.6006624386900782d0) (0.6532231826275372d0) (0.681136582353539d0)
	    (0.7286228282128038d0) (0.7428999975084689d0) (0.7799397074565395d0)
	    (0.8165534180201686d0) (0.8048311459897624d0) (0.8330069082480815d0)
	    (0.8771414792380494d0) (0.8664878340038614d0) (0.8923284072369122d0)
	    (0.9230962986045841d0) (0.9335207180183764d0) (0.9440351099331898d0)
	    (0.9692945759137912d0) (0.9657215655473266d0) (0.9675181480711057d0)
	    (1.0144886785602978d0) (1.020894069693341d0) (0.9828020333234803d0)
	    (1.0123698115348816d0) (0.9897495209161774d0) (0.9977848124721194d0)
	    (1.0055215769863537d0) (0.9779973598783567d0) (0.9675266326097045d0)
	    (0.953161833747272d0) (0.9555141598542256d0) (0.9517515436809895d0)
	    (0.9386172288948064d0) (0.9049291271656537d0) (0.9052368731769876d0)
	    (0.876757088883893d0) (0.8302478390437511d0) (0.7960685479520426d0)
	    (0.8139958423175012d0) (0.773455198942135d0) (0.74118004587883d0)
	    (0.70608458348853d0) (0.6998938660411305d0) (0.6478769440144085d0)
	    (0.6208555088633417d0) (0.5958329674353794d0) (0.5568896750058765d0)
	    (0.5132997962503287d0) (0.5067220330238342d0)))

(eval-when (:compile-toplevel)
  (my-tenure))

(defun tr-sd-1-2-1 (net
		    train-input train-output
		    error-lim
		    eta
		    &key max-cycles
			 momentum
			 write-error-every
			 write-net-every
			 write-final)
  (declare
   (type type-weight momentum eta)
   (type type-act error-lim)
   (fixnum max-cycles write-error-every write-net-every)
   (optimize (speed 3) (space 2) (safety 0) (debug 0)
	     (compilation-speed 0))
   ;;   (:explain :calls :types :boxing)
   )
  (train-sd (netspec-linout 1 2 1) net
	    train-input train-output
	    error-lim
	    eta
	    :max-cycles max-cycles
	    :momentum momentum
	    :write-error-every write-error-every
	    :write-net-every write-net-every
	    :write-final write-final))

(eval-when (:compile-toplevel)
  (format t "End of sd-1-2-1...~%")
  (my-tenure))

(defun tr-cg-1-2-1 (net
		    train-input train-output
		    error-lim
		    &key max-cycles
			 interval-location-eta
			 gss-tol
			 write-error-every
			 write-net-every
			 write-final)
  (declare
   (type type-weight interval-location-eta gss-tol)
   (type type-act error-lim)
   (fixnum max-cycles write-error-every write-net-every)
   (optimize (speed 3) (space 2) (safety 0) (debug 0)
   	     (compilation-speed 0))
   ;;   (:explain :calls :types :boxing)
   )

  (train-cg (netspec-linout 1 2 1) net
		 train-input train-output
		 error-lim
		 :max-cycles max-cycles
		 :save-weights-method set ;; compile-time
		 :interval-location-eta interval-location-eta
		 :gss-tol gss-tol
		 :write-error-every write-error-every
		 :write-net-every write-net-every
		 :write-final write-final))

(eval-when (:compile-toplevel)
  (format t "End of cg-1-2-1...~%")
  (my-tenure))

(defun demo-sine (&key (method 'sd)
		      (eta 0.03d0)
		      (alpha 0.5d0)
		      random-state
		      (max-cycles 100)
		      (error-lim 0.01d0)
		      (write-error-every 1)
		      (write-net-every nil)
		      (write-final t)
		      (iloc-eta 0.075d0)
		      output-to-file
		      (ext-detect-locmin 0.005d0)
		      (ext-detect-locmin-kick 4.0)
		      (weight-deviation 2.0))
  (declare
;;   (type type-weight alpha eta iloc-eta)
   (single-float weight-deviation)
   (type type-act error-lim)
;;   (optimize (speed 3) (space 2) (safety 0) (debug 0)
;;	     (compilation-speed 0))
   )
  (let ((net
	 (my-tenuring (mk-net (netspec-linout 1 2 1)
			 :weight-deviation weight-deviation
			 :runtime-weights t
			 :runtime-weights-state random-state)))
	(train-input (my-tenuring (sine-train20-in)))
	(train-output (my-tenuring (sine-train20-out)))
	(test-input (my-tenuring (sine-test-in)))
	(test-output (my-tenuring (sine-test-out)))
	(train-error 0.0)
	(test-error 0.0))
    (declare (type type-act train-error test-error))
	
    (setq train-error
      (ecase method
	(sd
	 (tr-sd-1-2-1 net
		      train-input train-output
		      (coerce error-lim 'type-act)
		      (coerce eta 'type-weight)
		      :max-cycles max-cycles
		      :momentum (coerce alpha 'type-weight)
		      :write-error-every write-error-every
		      :write-net-every write-net-every
		      :write-final write-final))
	(cg
	 (tr-cg-1-2-1 net
		      train-input train-output
		      (coerce error-lim 'type-act)
		      :max-cycles max-cycles
		      :interval-location-eta (coerce iloc-eta 'type-weight)
		      :gss-tol 0.0001d0
		      :write-error-every write-error-every
		      :write-net-every write-net-every
		      :write-final write-final))))

    ;; now get test error
    (let ((output-layer-act (layer-act-vec (svref net 2)))
	  (filehandle (if output-to-file
			  (open "output.dat"
				:direction :output
				:if-exists :supersede
				:if-does-not-exist :create)
			t)))
      (setq test-error (all-pattern-error (netspec-linout 1 2 1) net
					  test-input test-output
					  (array-dimension test-input 0)
					  :write-output-to
					  filehandle))

      (format t "~%Test-error: ~a~%" test-error)
      (if (and filehandle
	       (not (eq filehandle 't)))
	  (close filehandle))
      (values train-error test-error))))

(eval-when (:compile-toplevel)
  (format t "End of test-sine...~%")
  (my-tenure))

(defun tr-sd-1-5-1 (net
		    train-input train-output
		    error-lim
		    eta
		    &key max-cycles
			 momentum
		      write-error-every
			 write-net-every
			 write-final)
  (declare
   (type type-weight momentum eta)
   (type type-act error-lim)
   (fixnum max-cycles write-error-every write-net-every)
   (optimize (speed 3) (space 2) (safety 0) (debug 0)
  	     (compilation-speed 0))
   )
  (train-sd (netspec-linout 1 5 1) net
	    train-input train-output
	    error-lim
	    eta
	    :max-cycles max-cycles
	    :momentum momentum
	    :write-error-every write-error-every
	    :write-net-every write-net-every
	    :write-final write-final))

(eval-when (:compile-toplevel)
  (format t "End of sd-1-5-1...~%")
  (my-tenure))

(defun tr-cg-1-5-1 (net
		    train-input train-output
		    error-lim
		    &key max-cycles
			 interval-location-eta
			 gss-tol
			 write-error-every
			 write-net-every
			 write-final)
  (declare
   (type type-weight interval-location-eta gss-tol)
   (type type-act error-lim)
   (fixnum max-cycles write-error-every write-net-every)
;;   (optimize (speed 3) (space 2) (safety 0) (debug 0)
;;   	     (compilation-speed 0))
   )
  (train-cg (netspec-linout 1 5 1) net
	    train-input train-output
	    error-lim
	    :max-cycles max-cycles
	    :save-weights-method set ;; compile-time
	    :interval-location-eta interval-location-eta
	    :gss-tol gss-tol
	    :write-error-every write-error-every
	    :write-net-every write-net-every
	    :write-final write-final))

(eval-when (:compile-toplevel)
  (format t "End of cg-1-5-1...~%")
  (my-tenure))

(defun demo-sine5 (&key (method 'sd)
		      (eta 0.03d0)
		      (alpha 0.5d0)
		      random-state
		      (max-cycles 100)
		      (error-lim 0.01d0)
		      (write-error-every 1)
		      (write-net-every nil)
		      (write-final t)
		      (iloc-eta 0.075d0)
		      output-to-file
		      (ext-detect-locmin 0.005d0)
		      (ext-detect-locmin-kick 4.0)
		      (weight-deviation 2.0))
  (declare
;;;   (type type-weight alpha eta iloc-eta)
   (single-float weight-deviation)
   (type type-act error-lim)
;;   (optimize (speed 3) (space 2) (safety 0) (debug 0)
;;	     (compilation-speed 0))
   )
  (let ((net
	 (my-tenuring (mk-net (netspec-linout 1 5 1)
			 :weight-deviation weight-deviation
			 :runtime-weights t
			 :runtime-weights-state random-state)))
	(train-input (my-tenuring (sine-train20-in)))
	(train-output (my-tenuring (sine-train20-out)))
	(test-input (my-tenuring (sine-test-in)))
	(test-output (my-tenuring (sine-test-out)))
	(train-error 0.0)
	(test-error 0.0))
    (declare (type type-act train-error test-error))
    
    (setq train-error
      (ecase method
	(sd
	 (tr-sd-1-5-1 net
		      train-input train-output
		      (coerce error-lim 'type-act)
		      (coerce eta 'type-weight)
		      :max-cycles max-cycles
		      :momentum (coerce alpha 'type-weight)
		      :write-error-every write-error-every
		      :write-net-every write-net-every
		      :write-final write-final))
	(cg
	 (tr-cg-1-5-1 net
		      train-input train-output
		      (coerce error-lim 'type-act)
		      :max-cycles max-cycles
		      :interval-location-eta (coerce iloc-eta 'type-weight)
		      :gss-tol 0.0001d0
		      :write-error-every write-error-every
		      :write-net-every write-net-every
		      :write-final write-final))))

    ;; now get test error
    (let ((output-layer-act (layer-act-vec (svref net 2)))
	  (filehandle (if output-to-file
			  (open "output.dat"
				:direction :output
				:if-exists :supersede
				:if-does-not-exist :create)
			t)))
      (setq test-error (all-pattern-error (netspec-linout 1 5 1) net
					  test-input test-output
					  (array-dimension test-input 0)
					  :write-output-to
					  filehandle))
      
      (format t "~%Test-error: ~a~%" test-error)
      
      (if (and filehandle
	       (not (eq filehandle 't)))
	  (close filehandle))
      (values train-error test-error))))
|#

(eval-when (:compile-toplevel)
  (gc-post-compile))
