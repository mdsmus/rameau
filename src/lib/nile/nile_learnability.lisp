
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

;;;; $Id: nile_learnability.lisp,v 1.38 1999/09/28 11:08:44 slink Exp $

;;;; nile_learnability
;;;; 
;;;; Code for learnability experiments
;;;; 
;;;; Most of it is just copied from nile_batali, but as certain
;;;; compile-time parameters (such as hidden layer size) are set
;;;; herein, the necessary code is duplicated here
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
  (nile_loader:load-and-compile	"nile_batali"
				"nile_run-net-lib"
				"nile_compile-net-lib"
				"nile_c2ompile-net-lib"
				"nile_compile-tools"
				"nile_compile-batali-lib"
				"nile_stats"))

(eval-when (:compile-toplevel :load-toplevel :execute)
(defpackage nile_learnability
  (:use common-lisp
	nile_compile-tools
	nile_compile-net-lib
	nile_c2ompile-net-lib
	nile_run-net-lib
	nile_compile-batali-lib
	nile_stats)
  (:export train-lang
	   runit
	   regular-words-fun
	   ideo-words-fun
	   show-words
	   get-words
	   word-generator
	   ))

)
(eval-when (:compile-toplevel :load-toplevel :execute)
(in-package nile_learnability))
(defconstant *RCS-ID* "$Id: nile_learnability.lisp,v 1.38 1999/09/28 11:08:44 slink Exp $")
(defparameter *package-load-date* 0)


(eval-when (:compile-toplevel :load-toplevel :execute)
  
(defparameter *numchars* 4)
(defparameter *max-word-length* 8)
;; WHAT TO COMPILE HERE
(defparameter *numhidden* 30)
(defparameter *netspec* (make-batali-netspec *numhidden* *numchars*))
(defparameter *numweights* (num-weights (net-spec-layer-specs *netspec*)))

(defparameter *null-activation* 0.0d0)
)

(defun num2char-f (tree)
  "Subsitues in a tree 0 by \#A, 1 by \#B, 2 by \#C and 3 by \#D"
  (sublis '((0 . #\A)(1 . #\B)(2 . #\C)(3 . #\D)) tree))

(eval-when (:compile-toplevel :load-toplevel :execute)
(defmacro char2num (&rest lists)
  "Builds from its arguments a vector, the elements of each argument list
beging subsituted as #\A to 0, #\B to 1, #\C to 2 and #\D to 3"
  `(vector ,@(mapcar #'(lambda (x) (list 'quote x))
		     (sublis '((#\A . 0)
			       (#\B . 1)
			       (#\C . 2)
			       (#\D . 3)) lists))))
)

(defmacro hear-one-char (netspec-form net char
			 &key (copy-recurrent nil)
			      (optimize t))
  "From nile_batali. Documented there"
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
  "From nile_batali. Documented there"
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
  "From nile_batali. Documented there"
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

;;;; Our own show-words (copied from nile_batali), because net-size
;;;; may be different here

(defun get-words (pop &optional (popsize 1))
  "Extract words of pop (of size popsize). From nile_batali, documented there"
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
		(communication-episode *netspec*
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

(defun show-words (pop &optional (popsize 1))
  "Prints to *standard-output* the result of get-words"
  (mapc #'(lambda (word)
	    (format t "~a~%" word))
	(get-words pop popsize))
  nil)

;;;; A quite short, very regular grammar for the meanings: Assign
;;;; the first two characters to the predicate, the last two
;;;; to the referent

(defmacro regular-words (netspec-form)
"A quite short, very regular grammar for the meanings: Assign
the first two characters to the predicate, the last two
to the referent

Generates a training set as taken by nile_compile-net-lib:trainer"
  (let* ((netspec (eval netspec-form))
	(layer-specs (net-spec-layer-specs netspec))
	(input-layer-size (layer-spec-size (svref layer-specs 0)))

	(predicates
	 (char2num
	  (#\B #\A)				; happy
	  (#\B #\D)				; sad
	  (#\C #\A)				; angry
	  (#\C #\B)				; tired
	  (#\D #\B)				; excited
	  (#\C #\D)				; sick
	  (#\C #\C)				; hungry
	  (#\A #\C)				; thristy
	  (#\B #\B)				; silly
	  (#\B #\C)				; scared
	  ))
	(referents
	 (char2num
	  (#\C #\A)				; me
	  (#\C #\B)				; we
	  (#\C #\C)				; mip
	  (#\B #\A)				; you
	  (#\B #\B)				; yall
	  (#\B #\C)				; yup
	  (#\D #\B)				; yumi
	  (#\A #\C)				; one
	  (#\A #\D)				; they
	  (#\D #\D)				; all
	  ))
	(words (make-array '(100))))
    (declare (optimize speed))
    (dotimes (refs 10)
      (declare (fixnum refs))
      (let ((referent (svref referents refs)))
	(dotimes (preds 10)
	  (declare (fixnum preds))
	  (let ((predicate (svref predicates preds))
		(wordsnum (+ (* refs 10) preds)))
	    (setf (svref words wordsnum)
	      (append predicate referent))))))
    ;; words is now an array with the "words" in form of
    ;; lists of fixnums

    ;; build the list of input-layers for the first
    ;; character, then for the second, etc

    `(flet ((array-maker (char)
	      (declare
	       (optimize (speed 3) (space 2) (safety 0) (debug 0))
	       (fixnum char))
	      (let ((arr (make-array ,input-layer-size
				     :element-type 'type-act
				     :initial-element
				     ,(coerce *null-activation* 'type-act))))
		(declare (type (simple-array type-act (,input-layer-size))
			       arr))
		(setf (aref arr char) ,(coerce 1.0d0 'type-act))
		arr)))
       (vector
	,@(mapcar #'(lambda (x)
		      (declare (ignore x))
		      `(vector
			,@(do* ((index 0 (1+ index))
				(result (cons nil nil))
				(current result)
				(adim (array-dimension words 0)))
			      ((>= index adim) (cdr result))
			    (if (null (svref words index))
				(setf current (setf (cdr current)
						(cons nil nil)))
			      (setf current (setf (cdr current)
					      (cons `(array-maker
						      ,(pop (svref words index)))
						    nil)))))))
		  '(1 2 3 4))))))

(defun regular-words-fun ()
  (regular-words *netspec*))

(defmacro clear-act-layer (netspec-form net)
  "Clear the input-layer of net (which conplies with netspec-form)
(name of macro misleading :-( )"
  (let* ((netspec (eval netspec-form))
	 (layer-specs (net-spec-layer-specs netspec))
	 (input-layer-size (layer-spec-size (svref layer-specs 0))))
    `(flet ((clear-act-vec (net)
	      (declare
	       (optimize (speed 3) (space 2) (safety 0) (debug 0)))
	      (let ((arr (make-array ,input-layer-size
				     :element-type 'type-act
				     :initial-element
				     ,(coerce *null-activation* 'type-act))))
		(declare (type (simple-array type-act (,input-layer-size))
			       arr))
		(setf (layer-act-vec (svref net 0)) arr))))
       (clear-act-vec ,net))))

(defun num2base4list (num)
  "Converts an integer into a list of integers, representing the
same number in base 4 notation"
  (let ((list nil))
    (do ((count 0 (1+ count))
	 (num num)
	 (remainder 0))
	((>= count 4) list)
      (multiple-value-setq (num remainder) (floor num 4))
      (push remainder list))))

(defun word-generator (howmany outof &key (random-dist t)
					  (prob-from 0)
					  (prob-to 1))
  "generate howmany words out of outof possible such that a 
uniform stistribution of nile_stats:regularity will be achieved:
choose randomly how many of the beginnings and endings
will be equal.

random-dist specifies if regularity values are to be chosen randomly
or in equally distant steps. Prob-from is the lowest regularity, prob-to
the highest.

Returns list of lists of numbers as used by ideo-words"
  (let* (;; number of endings/beginning is root of howmany
	 (sqrthowmany (floor (sqrt howmany)))
	 ;; now choose how many of them will be beginnings
	 ;; and endings
	 (numequals 
	  (round (* sqrthowmany
		    (+ prob-from 
		       (if random-dist
			   (random (coerce (abs (- prob-to prob-from)) 'single-float))
			 0)))))
	 (equal-beginnings numequals)
	 (equal-endings equal-beginnings)
	 ;; number of possible ends/begs is root of outof
	 (sqrtoutof (floor (sqrt outof)))
	 ;; regulars to choose from
	 (regular-beginnings (n-random-integers sqrthowmany sqrtoutof))
	 (regular-endings (n-random-integers sqrthowmany sqrtoutof))
	 (list nil))
    (dotimes (refnum sqrthowmany)
      (dotimes (prednum sqrthowmany)
	(let ((pred (if (< (random sqrthowmany) equal-beginnings)
			(nth prednum regular-beginnings)
		      (random sqrtoutof)))
	      (ref (if (< (random sqrthowmany) equal-endings)
		       (nth refnum regular-endings)
		     (random sqrtoutof))))
	  (push
	   (+ (* sqrtoutof
		 pred)
	      ref)
	   list))))
    list))

(defmacro ideo-words (netspec-form word-gen-opts)
  "Generates training set for nile_batali:trainer
with words for batalis meanings generated by word-generator
using word-gen-opts"
  (let* ((netspec (eval netspec-form))
	 (layer-specs (net-spec-layer-specs netspec))
	 (input-layer-size (layer-spec-size (svref layer-specs 0)))
	 (words (gensym "words-"))
	 (index (gensym "index-"))
	 (charcount (gensym "charcount-"))
	 (training-positions (gensym "training-positions"))
	 (training-patterns (gensym "training-patterns"))
	 (adim (gensym "adim-"))
	 (word-ids (gensym "word-ids-"))
	 )
    ;; Do everything at runtime because of 'random
    `(let ((,words (make-array '(100)))
	   (,word-ids (apply #'word-generator 100 (* 4 4 4 4) ,word-gen-opts))
	   (,training-positions (make-array '(4)))
	   (pred-names (make-array 10 :initial-contents
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
	   (lang nil))

       (dotimes (,index 100)
	 (setf (svref ,words ,index)
	   (num2base4list (pop ,word-ids))))
       (flet ((array-maker (char)
		(declare
		 (optimize (speed 3) (space 2) (safety 0) (debug 0))
		 (fixnum char))
		(let ((arr (make-array ,input-layer-size
				       :element-type 'type-act
				       :initial-element
				       ,(coerce *null-activation* 'type-act))))
		  (declare (type (simple-array type-act (,input-layer-size))
				 arr))
		  (setf (aref arr char) ,(coerce 1.0d0 'type-act))
		  arr)))

	 (dotimes (refs 10)
	   (let ((referent (svref ref-names refs)))
	     (dotimes (preds 10)
	       (let* ((predicate (svref pred-names preds))
		      (meaning-num (+ (* refs 10) preds)))
		 (push (list (cons referent predicate)
			     (cons (num2char-f (svref ,words meaning-num))
				   1))
		       lang)))))

	 (dotimes (,charcount 4)
	   (do* ((,index 0 (1+ ,index))
		 (,training-patterns (make-array '(100)))
		 (,adim (array-dimension ,words 0)))
	       ((>= ,index ,adim) (setf (svref ,training-positions ,charcount)
				    ,training-patterns))
	     (setf (svref ,training-patterns ,index)
	       (array-maker (pop (svref ,words ,index))))))
	 (values ,training-positions lang)))))

(defun ideo-words-fun (&rest word-gen-opts)
  (ideo-words *netspec* word-gen-opts))


#|
(defun glob-func-clear-de-by-dws ()
  (declare
   ;; (:explain :variables :calls :types :boxing)
   (optimize (speed 3) (space 0) (safety 0) (debug 0)
	     (compilation-speed 0)))
  (adjust-weights ',netspec ,net
		  :clear-de-by-dws t))))

(defun glob-func-std-activate ()
  (declare
   ;; (:explain :variables :calls :types :boxing)
   (optimize (speed 3) (space 0) (safety 0) (debug 0)
	     (compilation-speed 0)))
  (activation-fn ',netspec ,net))))

(defun glob-func-copy-recurrent ()
  (declare
   ;; (:explain :variables :calls :types :boxing)
   (optimize (speed 3) (space 0) (safety 0) (debug 0)
	     (compilation-speed 0)))
  (activation-fn ',netspec ,net
		 :activate nil
		 :copy-recurrent t))))

(defun glob-func-cg-zero-beta ()
  (declare
   ;; (:explain :variables :calls :types :boxing)
   (optimize (speed 3) (space 0) (safety 0) (debug 0)
	     (compilation-speed 0)))
  (beta ,layer-specs ,net
	:zero-beta-save-derivs t))))

(defun glob-func-cg-beta ()
  (declare
   ;; (:explain :variables :calls :types :boxing)
   (optimize (speed 3) (space 0) (safety 0) (debug 0)
	     (compilation-speed 0)))
  (beta ,layer-specs ,net))))

(defun glob-func-cg-make-cg-updates-with-beta (beta)
  (declare
   (type type-de-by-dw beta)
   ;; (:explain :variables :calls :types :boxing)
   (optimize (speed 3) (space 0) (safety 0) (debug 0)
	     (compilation-speed 0)))
  (adjust-weights ',netspec ,net
		  :save-weights ,cg-opt-save-weights-method
		  :make-cg-updates-with-beta beta))))

(defun glob-func-cg-final-adjust-weights (eta)
  (declare
   (type type-weight eta)
   ;; (:explain :variables :calls :types :boxing)
   (optimize (speed 3) (space 0) (safety 0) (debug 0)
	     (compilation-speed 0)))
  (adjust-weights ',netspec ,net
		  :eta eta
		  :use-saved-weights t
		  :save-update t
		  :cg-update t
		  :clear-de-by-dws t))))

(defun glob-func-cg-adjust-weights (eta)
  (declare
   (type type-weight eta)
   ;; (:explain :variables :calls :types :boxing)
   (optimize (speed 3) (space 0) (safety 0) (debug 0)
	     (compilation-speed 0)))
  (adjust-weights ',netspec ,net
		  :eta eta
		  :use-saved-weights t))))

(defun glob-func-sd-adjust-weights-and-clear-de-by-dws ()
  (declare
   ;; (:explain :variables :calls :types :boxing)
   (optimize (speed 3) (space 0) (safety 0) (debug 0)
	     (compilation-speed 0)))
  (adjust-weights ,netspec-form ,net
		  :eta ,sd-opt-eta
		  :momentum ,sd-opt-momentum
		  :clear-de-by-dws t))))

(defun glob-func-improved-elman-activate  ()
			  (declare
			   ;; (:explain :variables :calls :types :boxing)
			   (optimize (speed 3) (space 0) (safety 0) (debug 0)
				     (compilation-speed 0)))
			  (the type-act
			    (activation-fn ',netspec ,net
					   :activate t
					   :return-context-unit-stats t)))))

(defun glob-func-get-weight-mean  ()
			  (declare
			   ;; (:explain :variables :calls :types :boxing)
			   (optimize (speed 3) (space 0) (safety 0) (debug 0)
				     (compilation-speed 0)))
			  (the type-weight
			    (get-weight-mean ,netspec-form ,net))))))



(declaim (ftype (function () nil)
		glob-func-clear-de-by-dws)
	 (ftype (function () nil)
		glob-func-std-activate)
	 (ftype (function () nil)
		glob-func-copy-recurrent)
	 (ftype (function () type-de-by-dw)
		glob-func-cg-zero-beta)
	 (ftype (function () type-de-by-dw)
		glob-func-cg-beta)
	 (ftype (function (type-de-by-dw) nil)
		glob-func-cg-make-cg-updates-with-beta)
	 (ftype (function (type-weight) nil)
		glob-func-cg-final-adjust-weights)
	 (ftype (function (type-weight) nil)
		glob-func-cg-adjust-weights)
	 (ftype (function () nil)
		glob-func-sd-adjust-weights-and-clear-de-by-dws)
	 (ftype (function () type-act)
		glob-func-improved-elman-activate)
	 (ftype (function () type-weight)
		glob-func-get-weight-mean))

(
:clear-de-by-dws glob-func-clear-de-by-dws
:std-activate glob-func-std-activate
:copy-recurrent glob-func-copy-recurrent
:cg-zero-beta glob-func-cg-zero-beta
:cg-beta glob-func-cg-beta
:cg-make-cg-updates-with-beta glob-func-cg-make-cg-updates-with-beta
:cg-final-adjust-weights glob-func-cg-final-adjust-weights
:cg-adjust-weights glob-func-cg-adjust-weights
:sd-adjust-weights-and-clear-de-by-dws glob-func-sd-adjust-weights-and-clear-de-by-dws
:improved-elman-activate glob-func-improved-elman-activate
:get-weight-mean glob-func-get-weight-mean)

|#

(defun useless ()
  nil)

;; for learnability stuff - this is like batali generational

(defun tr-batali (net
		  train-inputs
		  train-output
		  error-lim
		  eta
		  trainto
		  &key (max-cycles 1)
		       (write-final t))
  (declare (type type-act error-lim)
	   (type type-weight eta)
	   (fixnum trainto max-cycles)
	   (optimize (speed 3) (space 2) (safety 0) (debug 0)
		     (compilation-speed 0)))
  (trainer *netspec* net
	   train-inputs
	   train-output
	   :elman-net t
	   :batch nil
	   :num-steps trainto
	   :method :sd
;;;	   :error-lim error-lim
	   :sd-opts
	   (:eta eta)
	   :max-cycles max-cycles
;;	   :cycle-opts
;;	   (:write-error-every write-error-every
;;	    :write-net-every write-net-every)
;;	   :step-opts
;;	   (:write-notice-every 1)
	   :write-final-error write-final))

(defun tr-batali-batch (net
			train-inputs
			train-output
			error-lim
			eta
			trainto
			&key (max-cycles 1)
			     (write-final t))
  (declare (type type-act error-lim)
	   (type type-weight eta)
	   (fixnum trainto max-cycles)
	   (optimize (speed 3) (space 2) (safety 0) (debug 0)
		     (compilation-speed 0)))
  (trainer *netspec* net
	   train-inputs
	   train-output
	   :elman-net t
	   :batch t
	   :num-steps trainto
	   :method :sd
;;;	   :error-lim error-lim
	   :sd-opts
	   (:eta eta)
	   :max-cycles max-cycles
;;	   :cycle-opts
;;	   (:write-error-every write-error-every
;;	    :write-net-every write-net-every)
;;	   :step-opts
;;	   (:write-notice-every 1)
	   :write-final-error write-final))

#|
(defun tr-batali-patternbatch (net
			       train-inputs
			       train-output
			       error-lim
			       eta
			       trainto
			       &key (max-cycles 1)
				    (write-final t))
  (declare (type type-act error-lim)
	   (type type-weight eta)
	   (fixnum trainto max-cycles write-error-every write-net-every)
	   (optimize (speed 3) (space 2) (safety 0) (debug 0)
		     (compilation-speed 0)))
  (trainer *netspec* net
	   train-inputs
	   train-output
	   :elman-net t
	   :num-steps trainto
	   :method :sd
;;;	   :error-lim error-lim
	   :sd-opts
	   (:eta eta)
	   :max-cycles max-cycles
	   ;;	   :cycle-opts
;;	   (:write-error-every write-error-every
;;	    :write-net-every write-net-every)
;;	   :step-opts
;;	   (:write-notice-every 1)
	   :write-final-error write-final))

(defun tr-sd-batali-elman (net
			   train-inputs
			   train-output
			   error-lim
			   eta
			   trainto
			   &key (max-cycles 0)
				(write-error-every 1)
				(write-net-every 0)
				write-final)
  (declare (type type-act error-lim)
	   (type type-weight eta)
	   (fixnum trainto max-cycles write-error-every write-net-every)
	   (optimize (speed 3) (space 2) (safety 0) (debug 0)
		     (compilation-speed 0)))
  (trainer *netspec* net
	   train-inputs
	   train-output
	   :elman-net t
	   :num-steps trainto
	   :method :sd
;;;	   :error-lim error-lim
	   :sd-opts
	   (:eta eta)
	   :max-cycles max-cycles
	   :cycle-opts
	   (:write-error-every write-error-every
	    :write-net-every write-net-every)
	   :step-opts
	   (:write-notice-every 1)
	   :write-final write-final))

(defun tr-sd-batali-elman-improved (net
				    train-inputs
				    train-output
				    error-lim
				    eta
				    trainto
				    &key (max-cycles 0)
					 (write-error-every 1)
					 (write-net-every 0)
					 write-final)
  (declare (type type-act error-lim)
	   (type type-weight eta)
	   (fixnum trainto max-cycles write-error-every write-net-every)
	   (optimize (speed 3) (space 2) (safety 0) (debug 0)
		     (compilation-speed 0)))
  (trainer *netspec* net
	   train-inputs
	   train-output
	   :elman-net t
	   :improved-elman t
	   :num-steps trainto
	   :method :sd
;;;	   :error-lim error-lim
	   :sd-opts
	   (:eta eta)
	   :max-cycles max-cycles
	   :cycle-opts
	   (:write-error-every write-error-every
	    :write-net-every write-net-every)
	   :step-opts
	   (:write-notice-every 1)
	   :write-final write-final))


(defun tr-sd-batali-timebatch (net
			   train-inputs
			   train-output
			   error-lim
			   eta
			   trainto
			   &key (max-cycles 0)
				(write-error-every 1)
				(write-net-every 0)
				write-final)
  (declare (type type-act error-lim)
	   (type type-weight eta)
	   (fixnum trainto max-cycles write-error-every write-net-every)
	   (optimize (speed 3) (space 2) (safety 0) (debug 0)
		     (compilation-speed 0))
	   (ignore trainto))
  (trainer *netspec* net
	   train-inputs
	   train-output
	   :elman-net t
	   :timebatch t
	   :method :sd
;;;	   :error-lim error-lim
	   :sd-opts
	   (:eta eta)
	   :max-cycles max-cycles
	   :cycle-opts
	   (:write-error-every write-error-every
	    :write-net-every write-net-every)
	   :step-opts
	   (:write-notice-every 1)
	   :write-final write-final))

(defun tr-sd-batali-timebatch-improved (net
				    train-inputs
				    train-output
				    error-lim
				    eta
				    trainto
				    &key (max-cycles 0)
					 (write-error-every 1)
					 (write-net-every 0)
					 write-final)
  (declare (type type-act error-lim)
	   (type type-weight eta)
	   (fixnum trainto max-cycles write-error-every write-net-every)
	   (optimize (speed 3) (space 2) (safety 0) (debug 0)
		     (compilation-speed 0))
	   (ignore trainto))
  (trainer *netspec* net
	   train-inputs
	   train-output
	   :elman-net t
	   :improved-elman t
	   :timebatch t
	   :method :sd
;;;	   :error-lim error-lim
	   :sd-opts
	   (:eta eta)
	   :max-cycles max-cycles
	   :cycle-opts
	   (:write-error-every write-error-every
	    :write-net-every write-net-every)
	   :step-opts
	   (:write-notice-every 1)
	   :write-final write-final))


(defun tr-cg-batali-elman-improved (net
				    train-inputs
				    train-output
				    error-lim
				    cg-update-counter
				    trainto
				    &key (max-cg-updates 0)
					 (max-cycles 0)
					 (write-error-every 1)
					 (write-net-every 0)
					 write-final)
  (declare (type type-act error-lim)
	   (fixnum trainto max-cycles write-error-every write-net-every cg-update-counter)
	   (fixnum max-cg-updates)
	   (optimize (speed 3) (space 2) (safety 0) (debug 0)
		     (compilation-speed 0)))
  (trainer *netspec* net
	   train-inputs
	   train-output
	   :elman-net t
	   :num-steps trainto
	   :method :cg
	   :improved-elman t
	   :cg-opts
	   (:max-cg-updates max-cg-updates)
	   :max-cycles max-cycles
	   :cycle-opts
	   (:write-error-every write-error-every
	    :write-net-every write-net-every)
	   :step-opts
	   (:write-notice-every 1)
	   :write-final write-final))


(defun tr-cg-batali-timebatch (net
			       train-inputs
			       train-output
			       error-lim
			       cg-update-counter
			       trainto
			       &key (max-cg-updates 0)
				    (max-cycles 0)
				    (write-error-every 1)
				    (write-net-every 0)
				    write-final)
  (declare (type type-act error-lim)
	   (fixnum trainto max-cycles write-error-every write-net-every cg-update-counter)
	   (fixnum max-cg-updates)
	   (optimize (speed 3) (space 2) (safety 0) (debug 0)
		     (compilation-speed 0)))
  (trainer *netspec* net
	   train-inputs
	   train-output
	   :elman-net t
	   :timebatch t
	   :num-steps trainto
	   :method :cg
	   :cg-opts
	   (:max-cg-updates max-cg-updates)
	   :max-cycles max-cycles
	   :cycle-opts
	   (:write-error-every write-error-every
	    :write-net-every write-net-every)
	   :step-opts
	   (:write-notice-every 1)
	   :write-final write-final))



(defun tr-cg-batali-timebatch-improved (net
					train-inputs
					train-output
					error-lim
					cg-update-counter
					trainto
					&key (max-cg-updates 0)
					     (max-cycles 0)
					     (write-error-every 1)
					     (write-net-every 0)
					     write-final)
  (declare (type type-act error-lim)
	   (fixnum trainto max-cycles write-error-every write-net-every cg-update-counter)
	   (fixnum max-cg-updates)
	   (optimize (speed 3) (space 2) (safety 0) (debug 0)
		     (compilation-speed 0)))
  (trainer *netspec* net
	   train-inputs
	   train-output
	   :elman-net t
	   :timebatch t
	   :num-steps trainto
	   :improved-elman t
	   :method :cg
	   :cg-opts
	   (:max-cg-updates max-cg-updates)
	   :max-cycles max-cycles
	   :cycle-opts
	   (:write-error-every write-error-every
	    :write-net-every write-net-every)
	   :step-opts
	   (:write-notice-every 1)
	   :write-final write-final))

(defun tr-cg-batali-elman (net
			   train-inputs
			   train-output
			   error-lim
			   cg-update-counter
			   trainto
			   &key (max-cg-updates 0)
				(max-cycles 0)
				(write-error-every 1)
				(write-net-every 0)
				write-final)
  (declare (type type-act error-lim)
	   (fixnum trainto max-cycles write-error-every write-net-every cg-update-counter)
	   (fixnum max-cg-updates)
	   (optimize (speed 3) (space 2) (safety 0) (debug 0)
		     (compilation-speed 0)))
  (trainer *netspec* net
	   train-inputs
	   train-output
	   :elman-net t
	   :num-steps trainto
	   :method :cg
	   :cg-opts
	   (:max-cg-updates max-cg-updates)
	   :max-cycles max-cycles
	   :cycle-opts
	   (:write-error-every write-error-every
	    :write-net-every write-net-every)
	   :step-opts
	   (:write-notice-every 1)
	   :write-final write-final))

(defun tr-cg-batali-elman-improved (net
				    train-inputs
				    train-output
				    error-lim
				    cg-update-counter
				    trainto
				    &key (max-cg-updates 0)
					 (max-cycles 0)
					 (write-error-every 1)
					 (write-net-every 0)
					 write-final)
  (declare (type type-act error-lim)
	   (fixnum trainto max-cycles write-error-every write-net-every cg-update-counter)
	   (fixnum max-cg-updates)
	   (optimize (speed 3) (space 2) (safety 0) (debug 0)
		     (compilation-speed 0)))
  (trainer *netspec* net
	   train-inputs
	   train-output
	   :elman-net t
	   :num-steps trainto
	   :method :cg
	   :improved-elman t
	   :cg-opts
	   (:max-cg-updates max-cg-updates)
	   :max-cycles max-cycles
	   :cycle-opts
	   (:write-error-every write-error-every
	    :write-net-every write-net-every)
	   :step-opts
	   (:write-notice-every 1)
	   :write-final write-final))

(defun tr-cg-batali-timebatch (net
			       train-inputs
			       train-output
			       error-lim
			       cg-update-counter
			       trainto
			       &key (max-cg-updates 0)
				    (max-cycles 0)
				    (write-error-every 1)
				    (write-net-every 0)
				    write-final)
  (declare (type type-act error-lim)
	   (fixnum trainto max-cycles write-error-every write-net-every cg-update-counter)
	   (fixnum max-cg-updates)
	   (optimize (speed 3) (space 2) (safety 0) (debug 0)
		     (compilation-speed 0)))
  (trainer *netspec* net
	   train-inputs
	   train-output
	   :elman-net t
	   :timebatch t
	   :num-steps trainto
	   :method :cg
	   :cg-opts
	   (:max-cg-updates max-cg-updates)
	   :max-cycles max-cycles
	   :cycle-opts
	   (:write-error-every write-error-every
	    :write-net-every write-net-every)
	   :step-opts
	   (:write-notice-every 1)
	   :write-final write-final))

(defun tr-cg-batali-timebatch-improved (net
					train-inputs
					train-output
					error-lim
					cg-update-counter
					trainto
					&key (max-cg-updates 0)
					     (max-cycles 0)
					     (write-error-every 1)
					     (write-net-every 0)
					     write-final)
  (declare (type type-act error-lim)
	   (fixnum trainto max-cycles write-error-every write-net-every cg-update-counter)
	   (fixnum max-cg-updates)
	   (optimize (speed 3) (space 2) (safety 0) (debug 0)
		     (compilation-speed 0)))
  (trainer *netspec* net
	   train-inputs
	   train-output
	   :elman-net t
	   :timebatch t
	   :num-steps trainto
	   :improved-elman t
	   :method :cg
	   :cg-opts
	   (:max-cg-updates max-cg-updates)
	   :max-cycles max-cycles
	   :cycle-opts
	   (:write-error-every write-error-every
	    :write-net-every write-net-every)
	   :step-opts
	   (:write-notice-every 1)
	   :write-final write-final))

|#

(defun train-lang (lang
		   &key (method :cg-timebatch)
			(eta 0.001d0)
			(alpha 0.9d0)
			random-state
			(passes 50)
			(max-cycles 50)
			(error-lim 0.01d0)
			(write-error-every 10)
			(write-net-every 0)
			(write-final nil)
			(iloc-eta 0.15d0)
			(max-cg-updates 0)
			output-to-file
			(ext-detect-locmin 0.005d0)
			(ext-detect-locmin-kick 4.0)
			(weight-deviation 2.0)
			(write-pass-every 1))
  "Do learnability experiment using the helper functions
defined above."
  (declare
;;;   (type type-weight alpha eta iloc-eta)
   (single-float weight-deviation)
   (type type-act error-lim)
   (fixnum max-cg-updates write-pass-every)
   ;;   (optimize (speed 3) (space 2) (safety 0) (debug 0)
   ;;	     (compilation-speed 0))
   )
  (let* ((net (my-tenuring (mk-net *netspec*
				   :weight-deviation weight-deviation
				   :runtime-weights t
				   :runtime-weights-state random-state)))
	 ;; training inputs are a vector of actual training
	 ;; inputs here - for each char
	 (train-inputs lang)
	 (word-length-train-inputs (array-dimension train-inputs 0))
	 (current-train-input nil)
	 (next-train-input nil)
	 (cg-update-counter 0)
	 (train-output (my-tenuring (batali-meanings)))
	 (train-error (coerce 0.0d0 'type-act))
	 (test-error (coerce 0.0d0 'type-act))
	 (write-pass-every-next
	  (if (= 0 write-pass-every)
	      -1
	    0))
	 (write-pass-this-time nil))
	  
    (declare (type type-act train-error test-error)
	     (fixnum cg-update-counter
		     write-pass-every-next)
	     (type boolean write-pass-this-time))
	     

    ;; Go through train-inputs and train on every set of patterns
    ;; write into next set of patterns

    (format t "HIDDEN UNITS: ~a~%" *numhidden*)
    (dotimes (pass passes)
      (if (eq pass write-pass-every-next)
	  (progn
	    (setq write-pass-this-time t
		  write-pass-every-next 
		  (+ pass write-pass-every))
	    (format t "PASS ~a...~%" pass))	    
	(setq write-pass-this-time nil))
      
      (ecase method
	(:batali
	 (tr-batali net train-inputs train-output
		    (coerce error-lim 'type-act)
		    (coerce eta 'type-weight)
		    word-length-train-inputs
		    :write-final write-pass-this-time))
	(:batali-batch
	 (tr-batali-batch net train-inputs train-output
			  (coerce error-lim 'type-act)
			  (coerce eta 'type-weight)
			  word-length-train-inputs
			  :write-final write-pass-this-time))
      	(:sd-elman
	 (tr-sd-batali-elman net train-inputs train-output
			     (coerce error-lim 'type-act)
			     (coerce eta 'type-weight)
			     pass
			     :max-cycles max-cycles
			     :write-error-every write-error-every
			     :write-net-every write-net-every
			     :write-final write-final))
	(:sd-elman-improved
	 (tr-sd-batali-elman-improved net train-inputs train-output
				      (coerce error-lim 'type-act)
				      (coerce eta 'type-weight)
				      pass
				      :max-cycles max-cycles
				      :write-error-every write-error-every
				      :write-net-every write-net-every
				      :write-final write-final))
	(:sd-timebatch
	 (tr-sd-batali-timebatch net train-inputs train-output
			     (coerce error-lim 'type-act)
			     (coerce eta 'type-weight)
			     pass
			     :max-cycles max-cycles
			     :write-error-every write-error-every
			     :write-net-every write-net-every
			     :write-final write-final))
	(:sd-timebatch-improved
	 (tr-sd-batali-timebatch-improved net train-inputs train-output
				      (coerce error-lim 'type-act)
				      (coerce eta 'type-weight)
				      pass
				      :max-cycles max-cycles
				      :write-error-every write-error-every
				      :write-net-every write-net-every
				      :write-final write-final))


	(:cg-timebatch-improved
	 (tr-cg-batali-timebatch-improved net train-inputs train-output
					  error-lim
					  cg-update-counter
					  pass
					  :max-cg-updates max-cg-updates
					  :max-cycles max-cycles
					  :write-error-every write-error-every
					  :write-net-every write-net-every
					  :write-final write-final))
	(:cg-timebatch
	 (tr-cg-batali-timebatch net train-inputs train-output
				 error-lim
				 cg-update-counter
				 pass
				 :max-cg-updates max-cg-updates
				 :max-cycles max-cycles
				 :write-error-every write-error-every
				 :write-net-every write-net-every
				 :write-final write-final))

	(:cg-elman
	 (tr-cg-batali-elman net train-inputs train-output
			     error-lim
			     cg-update-counter
			     pass
			     :max-cg-updates max-cg-updates
			     :max-cycles max-cycles
			     :write-error-every write-error-every
			     :write-net-every write-net-every
			     :write-final write-final))

	(:cg-elman-improved
	 (tr-cg-batali-elman-improved net train-inputs train-output
				      error-lim
				      cg-update-counter
				      pass
				      :max-cg-updates max-cg-updates
				      :max-cycles max-cycles
				      :write-error-every write-error-every
				      :write-net-every write-net-every
				      :write-final write-final))
	))

    (clear-act-layer *netspec* net)
    net))

(defun runit (&key (stream t))
  (nile_loader:gnunotice :stream stream)
  (format stream "nile_learnability: ~a~%" nile_learnability::*RCS-ID*)
  (format stream "nile_compile-net-lib: ~a~%" nile_compile-net-lib::*RCS-ID*)
  (format stream "nile_stats: ~a~%" nile_stats::*RCS-ID*)
  (dotimes (run 50)
    (format stream "~%~%~%RUN ~A~%~%" run)
    (multiple-value-bind (tr lang) 
	(ideo-words-fun :random-dist t
			:prob-from 0.2
			:prob-to 1.0)
      ;; 
      ;; :prob-from (+ 0.8 (/ run 150)))
      (let ((in-regu (regularity (analyse (beginningstats lang))
				 (analyse (endingstats lang)))))
	(dotimes (x 2)
	  (format stream "REPETITION ~A~%" x)
	  (let* ((randstate (make-random-state t))
		 (out-net (train-lang tr
				      :method :batali
				      :passes 8001
				      :write-pass-every 1000
				      :random-state randstate))
		 (out-lang (get-words (vector out-net) 1))
		 (out-regu (regularity (analyse (beginningstats out-lang))
				       (analyse (endingstats out-lang)))))
	    (multiple-value-bind (frac-equal frac-simil)
		(lang-similarity lang out-lang)
	      (format stream "IN-lang: ~a~%" lang)
	      (format stream "OUT-lang: ~a~%" out-lang)
	      (format stream "Regularity IN: ~a -> OUT: ~a~%"
		      in-regu out-regu)
	      (format stream "Similarities equal ~a similar ~a~%"
		      (coerce frac-equal 'single-float)
		      (coerce frac-simil 'single-float)))))))))
