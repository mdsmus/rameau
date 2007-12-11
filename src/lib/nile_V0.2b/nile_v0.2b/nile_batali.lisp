
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

;;;; $Id: nile_batali.lisp,v 1.60 1999/09/28 11:08:43 slink Exp $

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
				"nile_c2ompile-net-lib"
				"nile_compile-tools"
				"nile_compile-batali-lib"))

(eval-when (:compile-toplevel :load-toplevel :execute)
(defpackage nile_batali
  (:use common-lisp
	nile_compile-tools
	nile_compile-net-lib
	nile_c2ompile-net-lib
	nile_run-net-lib
	nile_compile-batali-lib)
  (:export run-simulation
	   communication-episode
	   get-words
	   show-words	   
	   startup
	   ))

)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (in-package nile_batali))
(defconstant *RCS-ID* "$Id: nile_batali.lisp,v 1.60 1999/09/28 11:08:43 slink Exp $")
(defparameter *package-load-date* 0)

(eval-when (:compile-toplevel :load-toplevel :execute)
  
  ;; size of the alphabet to be used between agents
(defparameter *numchars* 4)
(declaim (type (integer 1 4000) *numchars*))

(defconstant *popsize* 30)
;;(defconstant *popsize* 2)
;;(defparameter *hidden-size* 10)
;;(defparameter *hidden-size* 20)
(defparameter *hidden-size* 30)
(declaim (type (integer 1 4000) *hidden-size*))

(defconstant *max-word-length* 20)

(defparameter *netspec-batali*
    (make-batali-netspec *hidden-size* *numchars*))

)


(defmacro hear-one-char (netspec-form net char
			 &key (copy-recurrent nil)
			      (optimize t))
  (let* ((netspec (eval netspec-form))
	 (act-input (gensym "act-input-")))
    `(let ((,act-input (layer-act-vec (svref ,net 0))))
       (declare (type (simple-array type-act
				    (,(layer-spec-size 
				       (svref
					(net-spec-layer-specs netspec)
					0))))
		      ,act-input))
       (flet ((loc-activate ()
		(declare 
;;		 (:explain :variables :calls :types :boxing)
		 ,@(if optimize
		       '((optimize (speed 3) (space 0) (safety 0) (debug 0)
				   (compilation-speed 0)))))
		(activation-fn ,netspec-form ,net 
			       :copy-recurrent ,copy-recurrent)))
	 (declare (ftype (function () nil) 
			 loc-activate))
	 (inject-character ,act-input ,char *numchars*)
	 (loc-activate)))))

(eval-when (:compile-toplevel)
  (nile_compile-tools:my-tenure))

;;;; netspec: a compile-time net specification
;;;;
;;;; net:     a net
;;;; dest:    the meaning vector (output to be uttered)

(defmacro speak-one-char (netspec-form net dest
			  &key (optimize t))
  (let* ((netspec (eval netspec-form))
	 (layer-specs (net-spec-layer-specs netspec))
	 (numlayers (array-dimension layer-specs 0))

	 (best (gensym "best-"))		; the best char yet
	 (best-correct (gensym "best-correct-"))	; the correct-value of it
	 (best-error (gensym "best-error-"))	; the error of of it

	 (act-input (gensym "act-input-"))
	 (act-output (gensym "act-output-"))

	 (char (gensym "char-"))		; the char being testet
	 (correct (gensym "correct-"))
	 (error (gensym "error-"))
	 )
    `(the fixnum
       (let ((,best -1)			; the best char yet
	     (,best-correct -1)		; the correct-value of it
	     (,best-error ,(coerce 99.9 'type-act)) ; the error of of it

	     (,correct 0)		; current correct value
	     (,error ,(coerce 0.0 'type-act)) ; current error

	     (,act-input (layer-act-vec (svref ,net 0)))
	     (,act-output (layer-act-vec (svref ,net ,(1- numlayers)))))
	 (declare (fixnum ,best ,best-correct ,correct)
		  (type type-act ,best-error ,error)
		  (type (simple-array type-act
				      (,(layer-spec-size
					 (svref layer-specs 0))))
			,act-input)
		  (type (simple-array type-act
				      (,(layer-spec-size
					 (svref layer-specs (1- numlayers)))))
			,act-output))
	 (flet ((loc-hear-one-char (net char)
		  (declare (type (simple-array t (*)) net)
			   (fixnum char)
;;;			   (:explain :variables :calls :types :boxing)
			   ,@(if optimize
				 '((optimize (speed 3) (space 0) (safety 0) (debug 0)
					     (compilation-speed 0)))))
		  (hear-one-char ,netspec-form net char
				 :copy-recurrent t
				 :optimize ,optimize))
		(loc-activate ()
		  (declare 
;;;		   (:explain :variables :calls :types :boxing)
		   ,@(if optimize
			 '((optimize (speed 3) (space 0) (safety 0) (debug 0)
				     (compilation-speed 0)))))
		  (activation-fn ,netspec-form ,net)))
	   (declare (ftype (function ((simple-array t (*)) fixnum) nil)
			   loc-hear-one-char)
		    (ftype (function () nil)
			   loc-activate))
	   ;; go through chars,
	   ;; activate
	   ;; get correct value,
	   ;; if lower than best, get error
	   (dotimes (,char *numchars*)
	     (inject-character ,act-input ,char *numchars*)
	     (loc-activate)
	     (setq ,correct (correct ,act-output ,dest
				     ,(layer-spec-size
				       (svref layer-specs (1- numlayers)))))
	     (if (> ,correct ,best-correct)
		 (setq ,best ,char
		       ,best-correct ,correct
		       ,best-error (sum-squares-error
				    ,act-output ,dest
				    ,(layer-spec-size
				      (svref layer-specs (1- numlayers)))))
	       ;; else -> ,correct <= ,best-correct
	       (if (= ,correct ,best-correct)
		   ;; check error
		   (progn
		     (setq ,error (sum-squares-error
				   ,act-output ,dest
				   ,(layer-spec-size
				     (svref layer-specs (1- numlayers)))))
		     (if (< ,error ,best-error)
			 (setq ,best ,char
			       ,best-correct ,correct
			       ,best-error ,error))))))
	   ;; after best char has been determined, it has to be
	   ;; activated
	   (loc-hear-one-char ,net ,best)
	   
	   ;; and then return best
	   ,best)))))

(eval-when (:compile-toplevel)
  (nile_compile-tools:my-tenure))

;;;; STATISTICS USED
;;;; 
;;;; speaker-error		: average sum-squares error between speaker
;;;; 			          and meaning (gives idea of error of the
;;;; 			          whole population)
;;;; hearer-error		: average sum-squares-error between hearer
;;;; 			          and meaning (after training)
;;;; speaker-hearer-error       : average ssq error between the hearers and the
;;;; 			          speakers meaning
;;;; 
;;;; speaker-correct            : fraction of episodes with speaker-correct
;;;; hearer-correct             : fraction of episodes with hearer-correct
;;;; length                     : average length of words


(defmacro communication-episode (netspec-form speaker hearer meaning
				 &key training
				      collect-stats
				      st-speaker-error-in
				      st-hearer-error-in
				      st-speaker-hearer-error-in
				      st-speaker-correct-in
				      st-hearer-correct-in
				      st-length-in
				      print-speaker
				      print-hearer
				      print-meaning
				      verbose
				      (eta 0.01)
				      (optimize t)
				      record-chars-in
				      (max-word-length *max-word-length*))
  (let* ((netspec (eval netspec-form))
	 (layer-specs (net-spec-layer-specs netspec))
	 (numlayers (array-dimension layer-specs 0))

	 (speaker-correct (gensym "speaker-correct-"))
	 (speaker-act-output (gensym "speaker-act-output-"))

	 (hearer-act-output (gensym "hearer-act-output-"))
	 
	 (char-spoken (gensym "char-spoken-"))
	 (char-count (gensym "char-count-"))
	 
	 (st-val (gensym "st-val-"))

	 (cg-beta (gensym "cg-beta-"))
	 (cg-interval-left (gensym "cg-interval-left-"))
	 (cg-interval-right (gensym "cg-interval-right-"))
	 (cg-interval-left-err (gensym "cg-interval-left-err-"))
	 (cg-interval-right-err (gensym "cg-interval-right-err-"))
	 
	 (cg-linesearch-fn 
	  (if (eq training :cg)
	      `(linesearch-eval-net-one-pattern 
		,netspec
		,hearer
		;; use saved weights
		t
		;; output-layer act
		,hearer-act-output
		;; dest
		,meaning
		(loc-activate)
		:eta)))
	 
	 )
    ;; 1. set all netwoprk-inputs to zero
    ;; while not (or speaker_correct reached_max_word_length)
    ;;       speak char by speaker -> hear char by hearer
    ;;       determine speaker-correct-value
    `(flet (
	    ,@(ecase training
		(:sd
		 `(
		   (loc-adjust-weights-and-clear-de-by-dws ()
		     (declare 
;;;		      (:explain :variables :calls :types :boxing)
		      (optimize (speed 3) (space 0) (safety 0) (debug 0)
				(compilation-speed 0)))
		     (adjust-weights ,netspec-form ,hearer
				     :eta ,eta
				     :clear-de-by-dws t))
		    (loc-backprop ()
		     (declare 
		      ;;		 (:explain :variables :calls :types :boxing)
		      (optimize (speed 3) (space 0) (safety 0) (debug 0)
				(compilation-speed 0)))
		     (backprop-fn ,netspec-form ,hearer ,meaning))
		    (loc-copy-recurrent ()
		     (declare 
		      ;;		 (:explain :variables :calls :types :boxing)
		      (optimize (speed 3) (space 0) (safety 0) (debug 0)
				(compilation-speed 0)))
		     (activation-fn ,netspec-form ,hearer 
				    :copy-recurrent t
				    :activate nil))))
		(:cg
		 `(
		   (loc-zero-beta ()
		       (declare
;;;		 (:explain :variables :calls :types :boxing)
			 (optimize (speed 3) (space 0) (safety 0) (debug 0)
				   (compilation-speed 0)))
			(beta ,layer-specs ,hearer
			      :zero-beta-save-derivs t))

		   (loc-beta ()
			(declare
;;;		 (:explain :variables :calls :types :boxing)
			 (optimize (speed 3) (space 0) (safety 0) (debug 0)
				   (compilation-speed 0)))
			(beta ,layer-specs ,hearer))

		      (loc-make-cg-updates-with-beta (beta)
			(declare
			 (type type-de-by-dw beta)
;;;		 (:explain :variables :calls :types :boxing)
			 (optimize (speed 3) (space 0) (safety 0) (debug 0)
				   (compilation-speed 0)))
			(adjust-weights ',netspec ,hearer
					:save-weights :set
					:make-cg-updates-with-beta beta))

		      (loc-final-adjust-weights (eta)
		        (declare
			 (type type-weight eta)
;;;		 (:explain :variables :calls :types :boxing)
			 (optimize (speed 3) (space 0) (safety 0) (debug 0)
				   (compilation-speed 0)))
			
			(adjust-weights ',netspec ,hearer
					:eta eta
					:use-saved-weights t
					:save-update t
					:cg-update t
					:clear-de-by-dws t))

		      (loc-activate ()
			(declare
;;;		 (:explain :variables :calls :types :boxing)
			 (optimize (speed 3) (space 0) (safety 0) (debug 0)
				   (compilation-speed 0)))
			(activation-fn ',netspec ,hearer))
		      
		      (loc-backprop ()
		        (declare
;;;		 (:explain :variables :calls :types :boxing)
			 (optimize (speed 3) (space 0) (safety 0) (debug 0)
				   (compilation-speed 0)))
			(backprop-fn ',netspec ,hearer ,meaning))))
	      
		(:sd-act-again
		 `(
		   (loc-adjust-weights-and-clear-de-by-dws ()
		     (declare 
		      ;;	       (:explain :variables :calls :types :boxing)
		      (optimize (speed 3) (space 0) (safety 0) (debug 0)
				(compilation-speed 0)))
		     (adjust-weights ,netspec-form ,hearer
				     :eta ,eta
				     :clear-de-by-dws t))
		    (loc-backprop ()
		     (declare 
		      ;;		 (:explain :variables :calls :types :boxing)
		      (optimize (speed 3) (space 0) (safety 0) (debug 0)
				(compilation-speed 0)))
		     (backprop-fn ,netspec-form ,hearer ,meaning))))
		(:no nil)))
       (declare 
	,@(ecase training
	    (:sd
	     '((ftype (function () nil) 
		      loc-adjust-weights-and-clear-de-by-dws
		      loc-backprop
		      loc-copy-recurrent)))
	    (:sd-act-again
	     '((ftype (function () nil) 
		      loc-adjust-weights-and-clear-de-by-dws
		      loc-backprop)))
	    (:cg
	     `((ftype (function () nil)
		      loc-backprop
		      loc-activate)
	       (ftype (function (type-de-by-dw) nil)
		      loc-make-cg-updates-with-beta)
	       (ftype (function () type-de-by-dw)
		      loc-zero-beta
		      loc-beta)
	       (ftype (function (type-weight) nil)
		      loc-final-adjust-weights)))
;;;	       (ftype (function ((simple-array type-act
;;;						     (,(layer-spec-size
;;;							(svref layer-specs
;;;							       (1- numlayers))))))
;;;				nil)
;;;		      loc-backprop)))
	    (:no nil)))
       
       ,@(if hearer
	     `((zero-input-layer ,netspec-form ,hearer)))
       (zero-input-layer ,netspec-form ,speaker)
	
       ,@(if (and verbose print-speaker print-hearer print-meaning)
	     `((format t "Hearer ~a Speaker ~a Meaning ~a:~%"
		       ,print-hearer ,print-speaker ,print-meaning)))
	
       (do ((,char-count 0 (1+ ,char-count))
	    (,speaker-correct 0)
	    (,speaker-act-output (layer-act-vec 
				  (svref ,speaker
					 ,(1- numlayers))))
	    ,@(if hearer
		  `((,hearer-act-output (layer-act-vec 
					 (svref ,hearer
						,(1- numlayers))))))
	    ,@(if (eq training :cg)
		  `((,cg-beta ,(coerce 0.0d0 'type-de-by-dw))
		    (,cg-interval-left 
		     ,(the type-weight (coerce 0.0d0 'type-weight)))
		    (,cg-interval-right 
		     ,(the type-weight (coerce 0.0d0 'type-weight)))
		    (,cg-interval-left-err 
		     ,(the type-weight (coerce 0.0d0 'type-act)))
		    (,cg-interval-right-err 
		     ,(the type-weight (coerce 0.0d0 'type-act))))))
	   
	   ((or (= ,speaker-correct
		   ,(layer-spec-size
		     (svref layer-specs (1- numlayers))))
		(>= ,char-count ,max-word-length))
	    ;; return value
	    ,@(if verbose
		  `((terpri)))
	    ;; speaker-error
	    ,@(if (and collect-stats st-speaker-error-in)
		  `((let ((,st-val 
			   (sum-squares-error ,speaker-act-output
					      ,meaning
					      ,(layer-spec-size
						(svref layer-specs 
						       (1- numlayers))))))
		      (incf ,st-speaker-error-in ,st-val)
		      ,@(if verbose
			    `((format t "  Speaker-error : ~a~%" ,st-val))))))
	    ;; hearer-error
	    ,@(if (and collect-stats st-hearer-error-in)
		  `((let ((,st-val 
			   (sum-squares-error ,hearer-act-output
					      ,meaning
					      ,(layer-spec-size
						(svref layer-specs 
						       (1- numlayers))))))
		      (incf ,st-hearer-error-in ,st-val)
		      ,@(if verbose
			    `((format t "  Hearer-error : ~a~%" ,st-val))))))
	    ;; speaker-hearer-error
	    ,@(if (and collect-stats st-speaker-hearer-error-in)
		  `((let ((,st-val 
			   (sum-squares-error ,speaker-act-output
					      ,hearer-act-output
					      ,(layer-spec-size
						(svref layer-specs 
						       (1- numlayers))))))
		      (incf ,st-speaker-hearer-error-in ,st-val)
		      ,@(if verbose
			    `((format t "  Speaker-Hearer-error : ~a~%" ,st-val))))))
	    ;; speaker correct
	    ,@(if (and collect-stats st-speaker-correct-in)
		  `((if (= ,speaker-correct
			   ,(layer-spec-size
			     (svref layer-specs (1- numlayers))))
			(incf ,st-speaker-correct-in))))
	    ;; hearer correct
	    ,@(if (and collect-stats st-hearer-correct-in)
		  `((if (= (correct ,hearer-act-output
				    ,meaning
				    ,(layer-spec-size
				      (svref layer-specs (1- numlayers))))
			   ,(layer-spec-size
			     (svref layer-specs (1- numlayers))))
			(incf ,st-hearer-correct-in))))
	    ;; length
	    ,@(if (and collect-stats st-length-in)
		  `((incf ,st-length-in ,char-count)))
	    ,@(if verbose
		  '((terpri)))
	    nil)
	 (declare (fixnum ,char-count ,speaker-correct)
		  (type type-de-by-dw ,cg-beta)
		  ,@(if (eq training :cg)
			`((type type-weight
				,cg-interval-left
				,cg-interval-right)
			  (type type-act
				,cg-interval-left-err
				,cg-interval-right-err)))
		  
		  (type (simple-array type-act
				      (,(layer-spec-size
					 (svref layer-specs (1- numlayers)))))
			,speaker-act-output)
		  (type (simple-array type-act
				      (,(layer-spec-size
					 (svref layer-specs (1- numlayers)))))
			,hearer-act-output))
	 ,(ecase training
	    (:sd
	     `(let ((,char-spoken (speak-one-char ,netspec-form
						  ,speaker
						  ,meaning
						  :optimize ,optimize)))
		(declare (fixnum ,char-spoken))
		
		,@(if verbose
		      `((format t "~%       ~a " (code-char (+ ,(char-code #\A) ,char-spoken)))))
		
		(hear-one-char ,netspec-form
			       ,hearer
			       ,char-spoken
			       :copy-recurrent nil)
		
		(loc-backprop)
		;; Big question here:
		;;
		;;    should we adjust weights first, activate again and then
		;;    copy recurrent connecttions
		;;OR
		;;    copy activation with old weights and the adjust them ?
		;;
		;; BATALI IMPLEMENTATION:
		;; USE ACTIVATION FROM OLD WEIGHTS !!! (personal communication)
		
		(loc-adjust-weights-and-clear-de-by-dws)
		
		(loc-copy-recurrent)))
	    
	    (:sd-act-again
	     `(let ((,char-spoken (speak-one-char ,netspec-form
						  ,speaker
						  ,meaning
						  :optimize ,optimize)))
		(declare (fixnum ,char-spoken))
		
		,@(if verbose
		      `((format t "~%       ~a " (code-char (+ ,(char-code #\A) ,char-spoken)))))
		
		(hear-one-char ,netspec-form
			       ,hearer
			       ,char-spoken
			       :copy-recurrent nil)
		,@(if verbose
		      `((format t "(err ~a) " (sum-squares-error ,hearer-act-output
								 ,meaning
								 ,(layer-spec-size
								   (svref 
								    layer-specs 
								    (1- numlayers)))))))
		(loc-backprop)
		;; Big question here:
		;;
		;;    should we adjust weights first, activate again and then
		;;    copy recurrent connecttions
		;;OR
		;;    copy activation with old weights and the adjust them ?
		;;
		;; DECISION HERE: Activate again after training
		(loc-adjust-weights-and-clear-de-by-dws)
		
		(hear-one-char ,netspec-form
			       ,hearer
			       ,char-spoken
			       :copy-recurrent t)
		,@(if verbose
		      `((format t "(after-train-err ~a)" (sum-squares-error ,hearer-act-output
									    ,meaning
									    ,(layer-spec-size
									      (svref 
									       layer-specs 
									       (1- numlayers)))))))))
	    (:cg
	     `(let ((,char-spoken (speak-one-char ,netspec-form
						  ,speaker
						  ,meaning
						  :optimize ,optimize)))
		(declare (fixnum ,char-spoken))
	       
		,@(if verbose
		      `((format t "~%       ~a " (code-char (+ ,(char-code #\A) ,char-spoken)))))
		
		;; - hear char
		;; - if ,char-count = 0 -> beta 0
		;; - assuming num_weights > *max-word-length* -> DON'T CHECK
		;; 
;;		(terpri)
;;		(write ,hearer)
;;		(terpri)

		(hear-one-char ,netspec-form
			       ,hearer
			       ,char-spoken
			       :copy-recurrent nil)
		,@(if verbose
		      `((format t "(err ~a) " (sum-squares-error ,hearer-act-output
								 ,meaning
								 ,(layer-spec-size
								   (svref 
								    layer-specs 
								    (1- numlayers)))))))
		;;* (backprop-fn ,netspec-form ,hearer ,meaning)
		(loc-backprop)
		
		(if (= ,char-count 0)
		    ;;* (setq ,cg-beta (beta ,layer-specs ,hearer
		    ;;*			     :zero-beta-save-derivs t))
		    (setq ,cg-beta (loc-zero-beta))
		  ;;* (setq ,cg-beta (beta ,layer-specs ,hearer))
		  (setq ,cg-beta (loc-beta)))
		
		;;* (adjust-weights ',netspec ,hearer
		;;*  		    :save-weights set
		;;*		    :make-cg-updates-with-beta ,cg-beta)
		(loc-make-cg-updates-with-beta ,cg-beta)
		
		#|
		(format t "~%input: ~a~%"
			(layer-act-vec (svref ,hearer 0)))
		(format t "~%derivs layer 1: ~a~%"
			(layer-de-by-dw-vec (svref ,hearer 1)))
		(format t "~%derivs layer 2: ~a~%"
			(layer-de-by-dw-vec (svref ,hearer 2)))
			|#

		#|
		(terpri)
		(write ,hearer)
		(terpri)
			|#

		;; do linesearch
		(interval-location ;; error
		 (sum-squares-error ,hearer-act-output
				    ,meaning
				    ,(layer-spec-size
				      (svref 
				       layer-specs 
				       (1- numlayers))))
		 ;; eval-fn for rest
		 ,cg-linesearch-fn
		 ;; eta for interval-location
		 ,(coerce 0.3d0 'type-weight)
		 :maximum 1.0d0
		 :values-in (,cg-interval-left 
			     ,cg-interval-left-err 
			     ,cg-interval-right
			     ,cg-interval-right-err))

		(golden-section-search ,cg-interval-left 
				       ,cg-interval-left-err
				       ,cg-interval-right
				       ,cg-interval-right-err
				       ;; eval-fn
				       ,cg-linesearch-fn
				       ;; tolerance
				       ,(coerce 0.001d0 'type-weight))

		;; take final update to be middle of left and right
		;; save the update and clear de-by-dws
		
		;;   (adjust-weights ',netspec ,net
		;;		   :eta (+ ,cg-interval-left
		;;			   (/ (- ,cg-interval-right
		;;				 ,cg-interval-left)
		;;			      2))
		;;		   :use-saved-weights t
		;;		   :save-update t
		;;		   :cg-update t
		;;		   :clear-de-by-dws t)
		(loc-final-adjust-weights (+ ,cg-interval-left
					     (/ (- ,cg-interval-right
						   ,cg-interval-left)
						2)))

		(hear-one-char ,netspec-form
			       ,hearer
			       ,char-spoken
			       :copy-recurrent t)

		,@(if verbose
		      `((format t "(after-train-err ~a)" (sum-squares-error ,hearer-act-output
									    ,meaning
									    ,(layer-spec-size
									      (svref 
									       layer-specs 
									       (1- numlayers)))))))))
	    (:no
	     ;; not training
	     `(let ((,char-spoken (speak-one-char ,netspec-form
						  ,speaker
						  ,meaning
						  :optimize nil)))
		(declare (fixnum ,char-spoken))
		
		,@(if record-chars-in
		      `((push
			 (code-char (+ ,(char-code #\A) ,char-spoken))
			 ,record-chars-in)))
		
		,@(if verbose
		      `((format t "~a" (code-char (+ ,(char-code #\A) ,char-spoken))))))))
		
	    ;; determine correct value
	 
	    (setq ,speaker-correct (correct ,speaker-act-output ,meaning
					    ,(layer-spec-size
					      (svref layer-specs (1- numlayers)))))
	 
	    ,@(if verbose
		  `((format t "(~a) " ,speaker-correct))))
	    
       ;; episode over
       nil)))

(eval-when (:compile-toplevel)
  (nile_compile-tools:my-tenure))


(defun batali-round-sd (population population-size
			meanings meaning-size
			round
			num-teachers num-meanings
			eta)
  (declare (type (integer 2 400000) population-size) 
	   (type (integer 1 400000) meaning-size)
	   (fixnum round)
	   (type (integer 1 400000) num-teachers)
	   (type (integer 1 400000) num-meanings)
	   (type type-weight eta)
	   
	   (optimize (speed 3) (space 2) (safety 0) (debug 0)
		     (compilation-speed 0))
;;;	   (:explain :calls :types :boxing)
	   )
  (let* ((student-num (the fixnum (random population-size)))
	 (student (svref population student-num))
	 ;; stats
	 (st-speaker-error (coerce 0.0d0 'type-act)) ; type-act
	 (st-hearer-error (coerce 0.0d0 'type-act)) ; type-act
	 (st-speaker-hearer-error (coerce 0.0d0 'type-act)) ; type-act
	 (st-speaker-correct 0)		; fixnum
	 (st-hearer-correct 0)		; fixnum
	 (st-length 0)			; fixnum
	 (num-episodes (* num-teachers num-meanings))
	 ;; inner loops
	 (teacher-num 0)
	 (teacher nil)
	 (meaning-num 0)
	 (meaning (svref meanings 9))
	 )
    (declare (fixnum student-num teacher-num meaning-num)
	     (type type-act st-speaker-error st-hearer-error st-speaker-hearer-error)
	     (fixnum st-speaker-correct st-hearer-correct st-length num-episodes)
	     (type (simple-array type-act (*)) meaning))
    (dotimes (x num-teachers)
      (setq teacher-num (from-m-but-n population-size student-num)
	    teacher (svref population teacher-num))
      ;; batali sais: Choose meaning independed of other meanings every time -
      ;; I think this is not really correct (Used n-random-integers to choose
      ;; num-meanings DISTINCT meanings every round)
      ;;
      ;; Anyway - I do it here as he did it
      (dotimes (y num-meanings)
	(setq meaning-num (the fixnum (random meaning-size))
	      meaning (svref meanings meaning-num))
	(communication-episode *netspec-batali*
			       teacher
			       student
			       meaning
			       ;;
;;;			       :verbose t
			       ;;
			       :training :sd
			       :eta eta
			       ;; stats
			       :collect-stats t
			       :st-speaker-error-in st-speaker-error
;;; hearer error is useless with
;;; original batali experiment
;;;			       :st-hearer-error-in st-hearer-error
			       :st-speaker-hearer-error-in st-speaker-hearer-error
			       :st-speaker-correct-in st-speaker-correct
;;; dito
;;;			       :st-hearer-correct-in st-hearer-correct
			       :st-length-in st-length
			       :print-speaker teacher-num
			       :print-hearer student-num
			       :print-meaning meaning-num)))
    (format t "Stats: Round ~a Sp-Err ~a He-Err ~a Sp-He-Err ~a Sp-Co ~a He-Co ~a Len ~a~%"
	    round 
	    (/ st-speaker-error num-episodes 5)
	    (/ st-hearer-error num-episodes 5)
	    (/ st-speaker-hearer-error num-episodes 5)
	    (/ st-speaker-correct num-episodes 1.0)
	    (/ st-hearer-correct num-episodes 1.0)
	    (/ st-length num-episodes *max-word-length*))))

(eval-when (:compile-toplevel)
  (nile_compile-tools:gc-post-compile)
  (my-tenure))

#|
(defun batali-round-cg (population population-size
			meanings meaning-size
			round
			num-teachers num-meanings)
  (declare (fixnum meaning-size round)
	   (type (integer 1 100000) population-size num-teachers num-meanings)
	   (optimize (speed 3) (space 2) (safety 0) (debug 0)
		     (compilation-speed 0))
;;;	   (:explain :calls :types :boxing)
	   )
  (let* ((student-num (the fixnum (random population-size)))
	 (student (svref population student-num))
	 ;; stats
	 (st-speaker-error (coerce 0.0d0 'type-act)) ; type-act
	 (st-hearer-error (coerce 0.0d0 'type-act)) ; type-act
	 (st-speaker-hearer-error (coerce 0.0d0 'type-act)) ; type-act
	 (st-speaker-correct 0)		; fixnum
	 (st-hearer-correct 0)		; fixnum
	 (st-length 0)			; fixnum
	 (num-episodes (* num-teachers num-meanings))
	 ;; inner loops
	 (teacher-num 0)
	 (teacher nil)
	 (meaning-num 0)
	 (meaning (svref meanings 0))
	 )
    (declare (fixnum student-num teacher-num meaning-num)
	     (type type-act st-speaker-error st-hearer-error st-speaker-hearer-error)
	     (fixnum st-speaker-correct st-hearer-correct st-length num-episodes)
	     (type (simple-array type-act (*)) meaning))
    (dotimes (x num-teachers)
      (setq teacher-num (from-m-but-n population-size student-num)
	    teacher (svref population teacher-num))
      ;; batali sais: Choose meaning independed of other meanings every time -
      ;; I think this is not really correct (Used n-random-integers to choose
      ;; num-meanings DISTINCT meanings every round)
      ;;
      ;; Anyway - I do it here as he did it
      (dotimes (y num-meanings)
	(setq meaning-num (the fixnum (random meaning-size))
	      meaning (svref meanings meaning-num))
	(communication-episode *netspec-batali*
			       teacher
			       student
			       meaning
			       ;;
;;;			       :verbose t
			       ;;
			       :training :cg
			       :max-word-length 8
			       ;; stats
			       :collect-stats t
			       :st-speaker-error-in st-speaker-error
;;; hearer error is useless with
;;; original batali experiment
;;;			       :st-hearer-error-in st-hearer-error
			       :st-speaker-hearer-error-in st-speaker-hearer-error
			       :st-speaker-correct-in st-speaker-correct
;;; dito
;;;			       :st-hearer-correct-in st-hearer-correct
			       :st-length-in st-length
			       :print-speaker teacher-num
			       :print-hearer student-num
			       :print-meaning meaning-num)))
    (format t "Stats: Round ~a Sp-Err ~a He-Err ~a Sp-He-Err ~a Sp-Co ~a He-Co ~a Len ~a~%"
	    round 
	    (/ st-speaker-error num-episodes 5)
	    (/ st-hearer-error num-episodes 5)
	    (/ st-speaker-hearer-error num-episodes 5)
	    (/ st-speaker-correct num-episodes 1.0)
	    (/ st-hearer-correct num-episodes 1.0)
	    (/ st-length num-episodes 8.0))))
|#

(defun get-words (pop &optional (popsize *popsize*))
  (let ((pred-names (make-array 10 :initial-contents
				(list :happy
				      :sad
				      :angry
				      :tired
				      :excited
				      :sick
				      :hungry
				      :thirsty
				      :silly
				      :scared)))
	(ref-names (make-array 10 :initial-contents
			       (list :me
				     :we
				     :mip
				     :you
				     :yall
				     :yup
				     :yumi
				     :one
				     :they
				     :all)))
	(meanings (batali-meanings))
	(stat-hash (make-hash-table :test #'equal
				    :size popsize
				    :rehash-size popsize))
	(outlist nil))

    (dotimes (refs 10)
      (let ((referent (svref ref-names refs)))
	(dotimes (preds 10)
	  (let* ((predicate (svref pred-names preds))
		 (meaning-num (+ (* refs 10) preds))
		 (meaning (svref meanings meaning-num)))
	    (clrhash stat-hash)
	    (dotimes (agent-num popsize)
	      (let ((agent (svref pop agent-num))
		    (word nil))
		(communication-episode *netspec-batali*
				       agent
				       nil ; no student
				       meaning
				       :verbose nil
				       :record-chars-in word
				       :training :no)
		(incf (gethash word stat-hash 0))))
	    
	    (let ((list nil))
	      (maphash #'(lambda (word num)
			   (push (cons (reverse word) (/ num popsize 1.0)) list))
		       stat-hash)
	      (push (cons (cons referent predicate) 
			  (sort list #'>= :key #'cdr))
		    outlist))))))
    (nreverse outlist)))

(defun show-words (pop &optional (popsize *popsize*))
  (mapc #'(lambda (word)
	    (format t "~a~%" word))
	(get-words pop popsize))
  nil)

(eval-when (:compile-toplevel)
  (nile_compile-tools:my-tenure))

(defun run-simulation (&key (max-cycles 10000)
			    (write-pop-every 2000)
			    (num-teachers 10)
			    (num-meanings 5)
			    (method 'sd)
			    (eta 0.01d0)
			    post-round-func
			    random-state)
  (declare (fixnum max-cycles num-teachers num-meanings write-pop-every))
  (let ((inteta (coerce eta 'type-weight)))
    (declare (type type-weight inteta))

    (nile_loader:gnunotice)
    (format t "Compile-time parameters:~%")
    (format t "nile_batali *RCS-ID*: ~a~%" *RCS-ID*)
    (format t "nile_run-net-lib *RCS-ID*: ~a~%" nile_run-net-lib::*RCS-ID*)
    (format t "*NUMCHARS*        : ~a~%" *numchars*)
    (format t "*POPSIZE*         : ~a~%" *popsize*)
    (format t "*HIDDEN-SIZE*     : ~a~%" *hidden-size*)
    (format t "*MAX-WORD-LENGTH* : ~a~%~%" *max-word-length*)
    (format t "Random-state: ~a~%"
	    (setf *random-state* (or random-state
				     (make-random-state t))))
    (format t "Maximum number of cycles: ~a~%" max-cycles)  
    (format t "Writing population every ~a cycles~%" write-pop-every) 
    (format t "Population size ~a~%" *popsize*)
    (format t "Choosing ~a meanings from ~a to communicate from ~a teachers~%" num-meanings 100 num-teachers)
    (format t "Method ~a~%" method)
    (if (eq method 'sd)
	(format t "Learning rate ~a~%~%" inteta))
    (let ((population (nile_compile-tools:my-tenuring (vector-of-n *popsize* (mk-net *netspec-batali*
								     :runtime-weights t
								     :weight-deviation 0.5))))
	  (meanings (batali-meanings))
	  (write-pop-next (if (/= write-pop-every 0)
			      write-pop-every
			    -1)))
      (declare (fixnum write-pop-next))
      (ecase method
	(sd
	 (dotimes (cycle max-cycles)
	   (batali-round-sd population *popsize* meanings 100 cycle num-teachers num-meanings inteta)
	   (if post-round-func
	       (funcall post-round-func population cycle))
	   (if (= cycle write-pop-next)
	       (progn
		 (setq write-pop-next (+ cycle write-pop-every))
		 (write population
			:right-margin 80
			:level 99
			:length 10000)))))
	(cg
	 (dotimes (cycle max-cycles)
	   (batali-round-cg population *popsize* meanings 100 cycle num-teachers num-meanings)
	   (if (= cycle write-pop-next)
	       (progn
		 (setq write-pop-next (+ cycle write-pop-every))
		 (format t "~a~%" population
			 :right-margin 80
			 :level 99
			 :length 10000))))))
      
      (format t "~a~%" population
	      :right-margin 80
	      :level 99
	      :length 10000)
      nil)))

(eval-when (:compile-toplevel)
  (nile_compile-tools:my-tenure))

(defun startup ()
  (let ((max-cycles 25000)
	(write-pop-every 4000)
	(num-teachers 10)
	(num-meanings 100)
	(method 'sd)
	(eta 0.01d0))
    (macrolet ((usage ()
		 '(progn
		   (nile_loader:gnunotice t)
		   (format t "Usage: ~a [lisp-options] -- [nile_batali options]~%~%"
		    (my-command-line-argument 0))
		   (format t "nile_batali options are:~%")
		   (format t "   -max-cycles <n>     : Set n to be the maximum number of \"rounds\"~%")
		   (format t "                         of the simulation. [~a]~%" max-cycles)
		   (format t "   -write-pop-every <n>: Write whole population every n rounds [~a]~%" write-pop-every)
		   (format t "   -num-teachers <n>   : Number of teachers in each round [~a]~%" num-teachers)
		   (format t "   -num-meanings <n>   : Number of meanings to be communicated by~%")
		   (format t "                         each teacher in each round [~a]~%" num-meanings)
		   (format t "   -method sd | cg     : Learning method [~a]~%" method)
		   (format t "   -eta <n>            : Learning rate [~a] (only -method SD)~%" eta)
		   (format t "   -h                  : Print this message~%~%"))))

      (do ((argnum 1))
	  ((>= argnum (my-command-line-argument-count)))
	(let ((currentarg (my-command-line-argument argnum)))
	  (cond
	   ((string= currentarg "-max-cycles")
	    (setq max-cycles (coerce 
			      (read-from-string 
			       (my-command-line-argument (1+ argnum))) 
			      'fixnum))
	    (incf argnum 2))
	   ((string= currentarg "-write-pop-every")
	    (setq write-pop-every (coerce 
				   (read-from-string 
				    (my-command-line-argument (1+ argnum))) 
				   'fixnum))
	    (incf argnum 2))
	   ((string= currentarg "-num-teachers")
	    (setq num-teachers (coerce 
				(read-from-string 
				 (my-command-line-argument (1+ argnum))) 
				'fixnum))
	    (incf argnum 2))
	   ((string= currentarg "-num-meanings")
	    (setq num-meanings (coerce 
				(read-from-string 
				 (my-command-line-argument (1+ argnum))) 
				'fixnum))
	    (incf argnum 2))
	   ((string= currentarg "-eta")
	    (setq eta (coerce 
		       (read-from-string 
			(my-command-line-argument (1+ argnum))) 
		       'type-weight))
	    (incf argnum 2))
	   ((string= currentarg "-method")
	    (let ((nextarg (my-command-line-argument (1+ argnum))))
	      (cond
	       ((string-equal nextarg "sd") (setq method 'sd))
	       ((string-equal nextarg "cg") (setq method 'cg))
	       (t
		(error "Method must either be SG og CG")))
	      (incf argnum 2)))
	   ((string= currentarg "-h")
	    (usage)
	    (incf argnum 1)
	    (error "Help given"))
	   (t
	    (usage)
	    (incf argnum 1)
	    (error "Unknown argument")))))
	    
      (run-simulation :max-cycles max-cycles
		      :write-pop-every write-pop-every
		      :num-teachers num-teachers
		      :num-meanings num-meanings
		      :method method
		      :eta eta))))

