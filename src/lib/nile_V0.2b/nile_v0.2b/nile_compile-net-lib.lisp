
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

;;;; $Id: nile_compile-net-lib.lisp,v 1.56 1999/09/28 11:02:43 slink Exp $

;;;; Functions and macros needed to compile ANN code
;;;; 
;;;; most important stuff is here
;;;; 

(defpackage nile_compile-net-lib
  (:use common-lisp
        nile_compile-tools
        nile_run-net-lib
        nile_c2ompile-net-lib)
  (:export sigmoid
           sigmoid-d1
           sigmoid-dash
           sigmoid-d1-dash
           linear
           linear-dash
           ;;
           mk-layer
           mk-net
           ;;
           netspec
           netspec-linout
           ;;
           sum-squares-error
           activation-fn
           get-weight-mean
           adjust-weights
           backprop-fn
           ;;
           beta
           interval-location
           golden-section-search
           all-pattern-error
           linesearch-eval-net
           linesearch-eval-net-one-pattern
           ;;
           patterns
           make-patterns
;;;
           act-mean
           act-mean-sum
           act-mean-count
           make-act-mean
           copy-act-mean
           act-mean-p
           ;;
           weight-mean
           weight-mean-sum
           weight-mean-count
           make-weight-mean
           copy-weight-mean
           weight-mean-p
           ;;
           trainer))

(in-package :nile_compile-net-lib)


(defparameter *nile-debug* nil)
;;(defparameter *nile-debug* t)

(defparameter *nile-debug-intloc* nil)
;;(defparameter *nile-debug-intloc* t)

(defparameter *debug-improved-elman* nil)

(defparameter *debug-iters* nil)

(defmacro sigmoid (d x)
  "The sigmoid function"
  `(/ 1
      (1+
       (exp
        (* -1 ,d ,x)))))



(defmacro sigmoid-d1 (x)
  "Possibly protected version of the sigmoid function with fixed gain d=1"
  (if *protect-act-fun*
      `(if (> ,x ,(coerce -35.0d0 'type-sum))
           (if (< ,x (coerce 35.0d0 'type-sum))
               (/ ,(the type-act (coerce 1.0 'type-act))
                  (+ ,(the type-act (coerce 1.0 'type-act))
                     (exp
                      (- ,x))))
               ,(coerce 1.0d0 'type-act))
           ,(coerce 0.0d0 'type-act))
      `(/ ,(the type-act (coerce 1.0 'type-act))
          (+ ,(the type-act (coerce 1.0 'type-act))
             (exp
              (- ,x))))))



(defmacro sigmoid-dash (d sum act)
  "The derivative of the sigmoid"
  (declare (ignore sum))
  `(* ,d
      ,act
      (- 1 ,act)))

(defmacro sigmoid-d1-dash (sum act)
  "The derivative of the sigmoid with fixed gain d=1"
  (declare (ignore sum))
  `(* ,act
      (- 1 ,act)))

(defmacro linear (x)
  "A linear unit ;-)"
  x)

(defmacro linear-dash (sum act)
  "And the derivative of a linear unit - 1.0 ;-)"
  (declare (ignore sum act))
  (the type-act (coerce 1.0d0 'type-act)))

(defmacro mk-layer (size prev-layer &optional
                    (weight-dev 2.0)
                    &key (runtime-weights t))
  "Make a layer of a net (initialise weights etc...)"
  (declare (optimize (speed 1) (space 1) (safety 1) (debug 0)
                     (compilation-speed 0)))
  `(make-layer
    :act-vec
    (make-array ',size
                :element-type 'type-act)
    ,@(if (>= prev-layer 1)
          `(:sum-vec
            (make-array ',size
                        :element-type 'type-sum)

            :weight-vec
            ,(if runtime-weights
                 (let ((array (gensym "array-")))
                   `(let ((,array
                           (make-array '(,size ,(1+ prev-layer))
                                       :element-type 'type-weight)))
                      (declare (type (simple-array type-weight
                                                   (,size ,(1+ prev-layer)))
                                     ,array))
                      (kick-weights ,array :dev ,weight-dev :fresh t
                                    :size ,(* size (1+ prev-layer)))
                      ,array))
                 `(make-array '(,size ,(1+ prev-layer))
                              :element-type 'type-weight
                              :initial-contents
                              ',(list-of-n
                                 size
                                 (list-of-n
                                  (1+ prev-layer)
                                  (random-weight
                                   weight-dev)))))

            :saved-weight-vec
            (make-array '(,size ,(1+ prev-layer))
                        :element-type 'type-weight)

            :de-by-dw-vec
            (make-array '(,size ,(1+ prev-layer))
                        :element-type 'type-de-by-dw
                        :initial-element ,(the type-de-by-dw (coerce 0.0 'type-de-by-dw)))

            :previous-de-by-dw-vec
            (make-array '(,size ,(1+ prev-layer))
                        :element-type 'type-de-by-dw
                        :initial-element ,(the type-de-by-dw (coerce 0.0 'type-de-by-dw)))

            :previous-update-vec
            (make-array '(,size ,(1+ prev-layer))
                        :element-type 'type-de-by-dw
                        :initial-element ,(the type-de-by-dw (coerce 0.0 'type-de-by-dw)))

            :delta-vec
            (make-array ,size
                        :element-type 'type-delta)))))

(defmacro mk-net (netspec-form &key (weight-deviation 2.0)
                  (runtime-weights t)
                  runtime-weights-state)
  "Make a network according to netspec-form, initialise with
weights from a uniform distribution with mean 0 and weight-deviation.
Calculate weights at runtime if runtime-weights, if so,
use runtime-weights-state random-state"
  (declare (optimize (speed 1) (space 1) (safety 1) (debug 0)
                     (compilation-speed 0)))
  (let* ((layer-specs (net-spec-layer-specs (eval netspec-form)))
         (layer-sizes
          (map 'list #'(lambda (x) (layer-spec-size x)) layer-specs)))
    `(progn
       ,@(if (and runtime-weights runtime-weights-state)
             (let ((sta (gensym "sta-")))
               `((let ((,sta ,runtime-weights-state))
                   (if (random-state-p ,sta)
                       (setf *random-state* (make-random-state ,sta))
                       (warn "mk-net: random-state supplied was no random-state"))))))
       (vector
        ,@(mapcar
           #'(lambda (layer-size previous-layer-size)
               `(mk-layer ,layer-size ,previous-layer-size ,weight-deviation
                          :runtime-weights ,runtime-weights))
           layer-sizes (cons 0 layer-sizes))))))

(defun netspec (&rest layers)
  "Generate a network specification with sigmoid units and
layers of sizes of the given arguments. Input layer first"
  (declare (optimize (speed 1) (space 1) (safety 1) (debug 0)
                     (compilation-speed 0)))
  (make-net-spec
   :layer-specs
   (apply #'vector
          (cons
           ;;input-layer
           (make-layer-spec
            :size (car layers))
           (mapcar
            #'(lambda (nodes)
                (make-layer-spec
                 :size nodes
                 :act-fn '(nile_compile-net-lib:sigmoid-d1)
                 :act-fn-dash '(nile_compile-net-lib:sigmoid-d1-dash)))
            (cdr layers))))))

(defun netspec-linout (&rest layers)
  "Generate a network specification with sigmoid units in all
layers except the output layer (which is made linear),
layers of sizes of the given arguments. Input layer first"
  (declare (optimize (speed 1) (space 1) (safety 1) (debug 0)
                     (compilation-speed 0)))
  (make-net-spec
   :layer-specs
   (apply #'vector
          (nconc
           ;;input-layer
           (list (make-layer-spec
                  :size (car layers)))
           (mapcar
            #'(lambda (nodes)
                (make-layer-spec
                 :size nodes
                 :act-fn '(nile_compile-net-lib:sigmoid-d1)
                 :act-fn-dash '(nile_compile-net-lib:sigmoid-d1-dash)))
            (reverse (cdr (reverse (cdr layers)))))
           (list
            (make-layer-spec
             :size (car (last layers))
             :act-fn '(nile_compile-net-lib:linear)
             :act-fn-dash '(nile_compile-net-lib:linear-dash)))))))

(defmacro sum-squares-error (iact idest size)
  "Calculate the sum of squares error between vectors of size size
of type-act icact and idest"
  (declare (optimize (speed 1) (space 1) (safety 1) (debug 0)
                     (compilation-speed 0)))
  (let ((error (gensym "error-"))
        (x (gensym "x-"))
        (act (gensym "act-"))
        (diff (gensym "diff-"))
        (dest (gensym "dest-")))
    `(the type-act
       (let ((,error ,(the type-act (coerce 0.0 'type-act)))
             (,diff ,(the type-act (coerce 0.0 'type-act)))
             (,act ,iact)
             (,dest ,idest))
         (declare (type type-act ,error ,diff)
                  (type (simple-array type-act
                                      (,size))
                        ,act)
                  (type (simple-array type-act
                                      (,size))
                        ,dest))
         (simple-dotimes-unroll
             (,x ,size)
           ;;(dotimes (,x ,size)
           (setq ,diff (- (aref ,dest ,x)
                          (aref ,act ,x))
                 ,error (+ ,error
                           (* ,diff ,diff))))
         (/ ,error ,(coerce 2.0d0 'type-act))))))

(defstruct act-mean
  (sum 0.0d0 :type type-act)
  (count 0 :type fixnum))

(defstruct weight-mean
  (sum 0.0d0 :type type-weight)
  (count 0 :type fixnum))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; WHY (* X X) IS TO BE PREFERRED OVER EXPT:
;;;; times does opencode in allego while expt does not, and it is
;;;; faster anyway:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;;; [1] USER(36): (defun timestimes (x)
;;;; 	    (declare (single-float x)
;;;; 		     (optimize speed)
;;;; 		     (:explain :calls :types :boxing))
;;;; 	    (format t "(* x x)~%")
;;;; 	    (time
;;;; 	     (dotimes (i 100000)
;;;; 	       (* x x)))
;;;; 	    (format t "~%(expt x 2)~%")
;;;; 	    (time
;;;; 	     (dotimes (i 100000)
;;;; 	       (expt x 2))))
;;;; TIMESTIMES
;;;; [1] USER(37): (compile 'timestimes)
;;;; ;Examining a call to FORMAT with arguments:
;;;; ;  constant T type SYMBOL
;;;; ;  constant #((* x x)~% 7 PPRINT-NEWLINE-UNCONDITIONAL) type (SIMPLE-ARRAY T (3))
;;;; ; which returns a value of type T
;;;; ;Generating a non-inline  call to FORMAT
;;;; ;Examining a call to TIME-A-FUNCALL with arguments:
;;;; ;  a COMPILER-LET type KNOWN-FUNCTION
;;;; ;  call to LL type KNOWN-FUNCTION
;;;; ; which returns a value of type T
;;;; ;Examining a call to .BUILD-NEW-CLOSED-OVER-FUNCTION with arguments:
;;;; ;  constant G2855 type SYMBOL
;;;; ;  constant  type SYMBOL
;;;; ; which returns a value of type LEXICALLY-VISIBLE-FUNCTION
;;;; ;Examining a call to LL with arguments:
;;;; ;  constant AREF-LONG type SYMBOL
;;;; ;  constant TIME-REPORT type SYMBOL
;;;; ;  call to LL type T
;;;; ; which returns a value of type KNOWN-FUNCTION
;;;; ;Examining a call to LL with arguments:
;;;; ;  constant FIXNUM-TO-MI type SYMBOL
;;;; ;  constant 21 type (INTEGER 21 21)
;;;; ; which returns a value of type T
;;;; ;Generating a non-inline  call to TIME-A-FUNCALL
;;;; ;Examining a call to FORMAT with arguments:
;;;; ;  constant T type SYMBOL
;;;; ;  constant #(~%(expt x 2)~% PPRINT-NEWLINE-UNCONDITIONAL 32780 ...) type (SIMPLE-ARRAY T (4))
;;;; ; which returns a value of type T
;;;; ;Generating a non-inline  call to FORMAT
;;;; ;Examining a call to TIME-A-FUNCALL with arguments:
;;;; ;  a COMPILER-LET type KNOWN-FUNCTION
;;;; ;  call to LL type KNOWN-FUNCTION
;;;; ; which returns a value of type T
;;;; ;Examining a call to .BUILD-NEW-CLOSED-OVER-FUNCTION with arguments:
;;;; ;  constant G2856 type SYMBOL
;;;; ;  constant  type SYMBOL
;;;; ; which returns a value of type LEXICALLY-VISIBLE-FUNCTION
;;;; ;Examining a call to LL with arguments:
;;;; ;  constant AREF-LONG type SYMBOL
;;;; ;  constant TIME-REPORT type SYMBOL
;;;; ;  call to LL type T
;;;; ; which returns a value of type KNOWN-FUNCTION
;;;; ;Examining a call to LL with arguments:
;;;; ;  constant FIXNUM-TO-MI type SYMBOL
;;;; ;  constant 21 type (INTEGER 21 21)
;;;; ; which returns a value of type T
;;;; ;Generating a non-inline  call to TIME-A-FUNCALL
;;;; ;Examining a call to >=_2OP with arguments:
;;;; ;  symeval I type (INTEGER 0 100000)
;;;; ;  constant 100000 type (INTEGER 100000 100000)
;;;; ; which returns a value of type T
;;;; ;Examining a call to EXPT with arguments:
;;;; ;  symeval X (closed over) type (SINGLE-FLOAT * *)
;;;; ;  constant 2 type (INTEGER 2 2)
;;;; ; which returns a value of type T
;;;; ;Generating a non-inline  call to EXPT
;;;; ;Examining a call to +_2OP with arguments:
;;;; ;  symeval I type (INTEGER 0 100000)
;;;; ;  constant 1 type (INTEGER 1 1)
;;;; ; which returns a value of type (INTEGER 0 100000)
;;;; ;Examining a call to >=_2OP with arguments:
;;;; ;  symeval I type (INTEGER 0 100000)
;;;; ;  constant 100000 type (INTEGER 100000 100000)
;;;; ; which returns a value of type T
;;;; ;Examining a (possibly unboxed) call to *_2OP with arguments:
;;;; ;  symeval X (closed over) type (SINGLE-FLOAT * *)
;;;; ;  symeval X (closed over) type (SINGLE-FLOAT * *)
;;;; ; which returns a value of type (SINGLE-FLOAT * *)
;;;; ;Examining a call to +_2OP with arguments:
;;;; ;  symeval I type (INTEGER 0 100000)
;;;; ;  constant 1 type (INTEGER 1 1)
;;;; ; which returns a value of type (INTEGER 0 100000)
;;;; TIMESTIMES
;;;; NIL
;;;; NIL
;;;; [1] USER(38): (timestimes 5.1234)
;;;; (* x x)
;;;; ; cpu time (non-gc) 30 msec user, 0 msec system
;;;; ; cpu time (gc)     0 msec user, 0 msec system
;;;; ; cpu time (total)  30 msec user, 0 msec system
;;;; ; real time  25 msec
;;;; ; space allocation:
;;;; ;  0 cons cells, 0 symbols, 0 other bytes, 0 static bytes
;;;; (expt x 2)
;;;; ; cpu time (non-gc) 3,730 msec user, 90 msec system
;;;; ; cpu time (gc)     540 msec user, 30 msec system
;;;; ; cpu time (total)  4,270 msec user, 120 msec system
;;;; ; real time  4,792 msec
;;;; ; space allocation:
;;;; ;  0 cons cells, 0 symbols, 3,200,000 other bytes, 0 static bytes
;;;; NIL
;;;; [1] USER(39):

(defmacro activation-fn (netspec-form net
                         &key (copy-recurrent nil)
                         (activate t)
                         ;; whether to return statistics
                         ;; of context units
                         return-context-unit-stats)
  "Builds a function to activate net which complies with
netspec-form. If the argument activate is true, activation is
actually done. If copy-recurrent is true, recurrent connections
defined in netspec are copied. If return-context-uni-stats
is true, the activations of the last n input layer units
are averaged and returned, n being the number of hidden layer
units"
  (declare (optimize (speed 1) (space 1) (safety 1) (debug 0)
                     (compilation-speed 0)))
  (let* ((netspec (eval netspec-form))
         (layer-specs (net-spec-layer-specs netspec))
         (recurrent-specs (net-spec-recurrent netspec))
         (num-layers (car (array-dimensions layer-specs)))

         ;; we need sums and weights for layers 1..n
         (sums (make-array
                num-layers
                :initial-contents
                (cons nil
                      (list-of-n (1- num-layers)
                                 (gensym "sums-")))))
         (weights (make-array
                   num-layers
                   :initial-contents
                   (cons nil
                         (list-of-n (1- num-layers)
                                    (gensym "weights-")))))
         (layers (make-array
                  num-layers
                  :initial-contents
                  (cons nil
                        (list-of-n (1- num-layers)
                                   (gensym "layers-")))))
         ;; and acts for all layers
         (acts (make-array
                num-layers
                :initial-contents
                (list-of-n num-layers (gensym "acts-"))))

         (sum (gensym "thesum-"))

         (row-major-index (gensym "row-major-index-"))

         (current-layer-neuron-count (gensym "current-layer-count-"))
         (previous-layer-neuron-count (gensym "previous-layer-count-"))

         (theweight (gensym "theweight-"))
         (theact (gensym "theact-"))
         (theprod (gensym "theprod-"))

         (act-mean-sum (if return-context-unit-stats
                           (gensym "act-mean-sum-")))

         )

    ;; make let statement
    `(let* ((,theweight ,(coerce 0.0 'type-weight))
            (,theact ,(coerce 0.0 'type-act))
            (,theprod ,(coerce 0.0 'type-act))
            ,@(if (and activate *prefer-row-major-aref*)
                  `((,row-major-index 0)))

            ,@(if return-context-unit-stats
                  `((,act-mean-sum ,(coerce 0.0d0 'type-act))))

            (,sum ,(the type-sum (coerce 0.0 'type-sum)))
            ;; make assignments for let* - assign gensyms created above
            ;; the different arrays from layers from the real net
            ,@(mapcan
               #'(lambda (layer-num)
                   (if (= 0 layer-num)
                       ;; for 0th layer only activation
                       `((,(svref acts layer-num)
                           (layer-act-vec (svref ,net ,layer-num))))
                       (if activate
                           `(
                             (,(svref layers layer-num) (svref ,net ,layer-num))
                             (,(svref acts layer-num) (layer-act-vec ,(svref layers layer-num)))
                             (,(svref sums layer-num) (layer-sum-vec ,(svref layers layer-num)))
                             (,(svref weights layer-num) (layer-weight-vec ,(svref layers layer-num)))
                             )
                           ;; else if activate
                           (if copy-recurrent
                               `((,(svref acts layer-num)
                                   (layer-act-vec (svref ,net ,layer-num))))))))
               (fromto 0 (1- num-layers))))
;;; part after let-statement: declarations
       (declare (ignorable ,theweight ,theact ,theprod ,sum)
                (type type-weight ,theweight)
                (type type-act ,theact)
                (type type-act ,theprod)
                (type type-sum ,sum)

                ,@(if return-context-unit-stats
                      `((type type-act ,act-mean-sum)))
                ,@(if (and activate *prefer-row-major-aref*)
                      `((type fixnum ,row-major-index)))
                ;;		    (:explain :variables :calls :types :boxing)
                ,@(mapcan
                   #'(lambda (layer-num)
                       (let ((spec-current-layer-size
                              (layer-spec-size (svref layer-specs layer-num))))
                         (if (= 0 layer-num)
                             ;; for 0th layer only activation
                             `(
                               (type
                                (simple-array type-act
                                              (,spec-current-layer-size))
                                ,(svref acts layer-num)))
                             (if activate
                                 `(
                                   (type
                                    (simple-array type-act
                                                  (,spec-current-layer-size))
                                    ,(svref acts layer-num))
                                   (type
                                    (simple-array type-sum
                                                  (,spec-current-layer-size))
                                    ,(svref sums layer-num))
                                   (ignorable ,(svref sums layer-num))
                                   (type
                                    (simple-array type-weight
                                                  (,spec-current-layer-size
                                                   ,(1+ (layer-spec-size
                                                         (svref layer-specs (1- layer-num))))))
                                    ,(svref weights layer-num))
                                   (ignorable ,(svref weights layer-num)))
                                 (if copy-recurrent
                                     `(
                                       (ignorable ,(svref acts layer-num))
                                       (type
                                        (simple-array type-act
                                                      (,spec-current-layer-size))
                                        ,(svref acts layer-num))))))))
                   (fromto 0 (1- num-layers))))
;;; after declarations: the program
       ,@(if activate
             (mapcan
              #'(lambda (layer) ;; starting with layer=1
                  (let ((spec-current-layer-size
                         (layer-spec-size (svref layer-specs layer)))
                        (spec-previous-layer-size
                         (layer-spec-size (svref layer-specs (1- layer))))
                        (spec-current-layer-act-fn
                         (layer-spec-act-fn (svref layer-specs layer))))

                    ;; now do the loop for this layer
                    `(
                      ,@(if *prefer-row-major-aref*
                            `((setq ,row-major-index 0)))

                      (dotimes (,current-layer-neuron-count
                                 ,spec-current-layer-size)
                        (setq ,sum ,(coerce 0.0d0 'type-sum))
                        ;; and add up all weight*act
                        ;; (dotimes (,previous-layer-neuron-count
                        ;;	  ,spec-previous-layer-size)
                        (simple-dotimes-unroll
                            (,previous-layer-neuron-count
                             ,spec-previous-layer-size)
                          (setq ,theact (aref ,(aref acts (1- layer))
                                              ,previous-layer-neuron-count)
                                ,theweight ,(if *prefer-row-major-aref*
                                                ;; prefer row-major-aref
                                                `(row-major-aref ,(svref weights layer)
                                                                 ,row-major-index)
                                                ;; prefer normal aref
                                                `(aref ,(aref weights layer)
                                                       ,current-layer-neuron-count
                                                       ,previous-layer-neuron-count))
                                ,theprod (* ,theact ,theweight)
                                ,sum (+ ,sum ,theprod))
                          ,@(if *prefer-row-major-aref*
                                `((incf ,row-major-index))))

                        ;; decease by bias-weight
                        (setq ,sum (- ,sum
                                      ,(if *prefer-row-major-aref*
                                           ;; prefer row-major-aref
                                           `(row-major-aref ,(svref weights layer)
                                                            ,row-major-index)
                                           ;; prefer normal aref
                                           `(aref ,(aref weights layer)
                                                  ,current-layer-neuron-count
                                                  ,spec-previous-layer-size))))
                        ,@(if *prefer-row-major-aref*
                              `((incf ,row-major-index)))

                        (setf (aref ,(svref sums layer)
                                    ,current-layer-neuron-count)
                              ,sum
                              ;; and pass through activation function
                              (aref ,(svref acts layer)
                                    ,current-layer-neuron-count)
                              (,@spec-current-layer-act-fn (the type-sum ,sum)))))))

              ;; end lambda of mapcar
              (fromto 1 (1- num-layers))))


       ;; sum up activations of context units
       ,@(if return-context-unit-stats
             (do ((code nil)
                  (count (- (layer-spec-size (svref layer-specs 0))
                            (layer-spec-size (svref layer-specs 1)))
                         (1+ count)))
                 ((>= count (layer-spec-size (svref layer-specs 0)))
                  code)
               (push `(incf ,act-mean-sum (aref ,(svref acts 0)
                                                ,count))
                     code)))

       ;; do recurrent connections
       ,@(if copy-recurrent
             (mapcar
              #'(lambda (copy-exp)
                  (let* ((from (car copy-exp))
                         (to (cdr copy-exp))
                         (from-layer (car from))
                         (from-node (cdr from))
                         (to-layer (car to))
                         (to-node (cdr to)))
                    `(setf (aref ,(svref acts to-layer) ,to-node)
                           (aref ,(svref acts from-layer) ,from-node))))
              recurrent-specs))
       ;; return stats in return-context-unit-stats,
       ;; else nil
       ,(if return-context-unit-stats
            `(the type-act (/ ,act-mean-sum
                              ,(layer-spec-size
                                (svref layer-specs 1))))))))

(defmacro get-weight-mean (netspec-form net)
  "Calculates the mean of all weights of net complying with netspec-form
between all hidden layer units and the last n input layer units, n
being the number of hidden layer units"
  (declare (optimize (speed 1) (space 1) (safety 1) (debug 0)
                     (compilation-speed 0)))
  (let* ((netspec (eval netspec-form))
         (layer-specs (net-spec-layer-specs netspec))
         (num-layers (car (array-dimensions layer-specs)))

         ;; we need weights - possibly for all layers
         (weights (make-array
                   num-layers
                   :initial-contents
                   (cons nil
                         (list-of-n (1- num-layers)
                                    (gensym "weights-")))))
         (row-major-index (gensym "row-major-index-"))

         (current-layer-neuron-count (gensym "current-layer-count-"))
         (previous-layer-neuron-count (gensym "previous-layer-count-"))

         (weight-mean-sum (gensym "weight-mean-sum-")))

    ;; make let statement
    `(let* (,@(if *prefer-row-major-aref*
                  `((,row-major-index 0)))

            (,weight-mean-sum ,(coerce 0.0d0 'type-weight))

              ,@(mapcan
                 #'(lambda (layer-num)
                     `((,(svref weights layer-num)
                         (layer-weight-vec (svref ,net ,layer-num)))))
                 '(1)))
;;; part after let-statement: declarations
       (declare (type type-weight ,weight-mean-sum)

                ,@(if *prefer-row-major-aref*
                      `((type fixnum ,row-major-index)))
                ,@(mapcan
                   #'(lambda (layer-num)
                       (let ((spec-current-layer-size
                              (layer-spec-size (svref layer-specs layer-num))))
                         `((type
                            (simple-array type-weight
                                          (,spec-current-layer-size
                                           ,(1+ (layer-spec-size
                                                 (svref layer-specs (1- layer-num))))))
                            ,(svref weights layer-num)))))
                   '(1)))
;;; after declarations: the program
       ,@(mapcan
          #'(lambda (layer) ;; starting with layer=1
              (let ((spec-current-layer-size
                     (layer-spec-size (svref layer-specs layer)))
                    (spec-previous-layer-size
                     (layer-spec-size (svref layer-specs (1- layer)))))

                ;; now do the loop for this layer
                `(
                  ,@(if *prefer-row-major-aref*
                        `((setq ,row-major-index 0)))

                  (dotimes (,current-layer-neuron-count
                             ,spec-current-layer-size)

                    (simple-dotimes-unroll
                        (,previous-layer-neuron-count
                         ,spec-previous-layer-size)

                      ;; get weight stats for all weights from hidden layer
                      ;; to context units. For context units assume them to be
                      ;; the last n of the imput layer, n being the number of
                      ;; units in the hidden layer
                      (if (>= ,previous-layer-neuron-count
                              ,(- spec-previous-layer-size
                                  spec-current-layer-size))
                          (incf ,weight-mean-sum
                                ,(if *prefer-row-major-aref*
                                     ;; prefer row-major-aref
                                     `(row-major-aref ,(svref weights layer)
                                                      ,row-major-index)
                                     ;; prefer normal aref
                                     `(aref ,(aref weights layer)
                                            ,current-layer-neuron-count
                                            ,previous-layer-neuron-count))))
                      ,@(if *prefer-row-major-aref*
                            `((incf ,row-major-index))))

                    ;; incf for bias-weight
                    ,@(if *prefer-row-major-aref*
                          `((incf ,row-major-index)))))))
          ;; just layer 1
          '(1))

;;; return mean weight
       (the type-weight (/ ,weight-mean-sum
                           ,(* (layer-spec-size (svref layer-specs 1))
                               (layer-spec-size (svref layer-specs 1))))))))

;;;;
;;;; For conjgate gradients we do updates as:
;;;;
;;;;    weights = weights + alpha * update
;;;;
;;;; where update is the "direction" of the search:
;;;;
;;;;    update = - de-by-dw + beta * previous-update
;;;;
;;;;
;;;;
;;;; As for CGs we determine the right alpha value by
;;;; doing a line-search, using the adjust-weights in the
;;;; usual way is expensive, as update had to be calculated
;;;; for every step of the line search.
;;;;
;;;; Thus we "misuse" adjust-weights by setting
;;;; de-by-dw of the net to -update such that the normal update
;;;;
;;;;    weights = weights - eta * de-by-dw
;;;;
;;;; then in fact calculates
;;;;
;;;;    weights = weights + "eta"=alpha * update
;;;;
;;;; The keyword-argument MAKE-CG-UPDATES-WITH-BETA sets de-by-dw to
;;;; - update

;; sets weights in
;;
;;
;;
(defmacro adjust-weights (netspec-form ; the compile-time net-specification
                          net      ; the net-array of layer-structures
                          &key eta ; learning rate for update w <- w - eta * de/dw
                          ;; momentum:
                          ;; update to w <- w - eta * de/dw + mom * prev_update
                          ;; Implies save-update
                          momentum
                          ;; save-weights:
                          ;; either 'copy -> copies to saved-weight-vec
                          ;; or     'set  -> sets saved-weight-vec to weight-vec and
                          ;;                 sets weight-vec to new array
                          save-weights
                          ;; use the saved weights t/nil
                          use-saved-weights
                          ;; clear de-by-dws t/nil
                          clear-de-by-dws
                          ;; save the update made into previous-update-vec
                          save-update
                          ;;
                          cg-update
                          ;; see above
                          make-cg-updates-with-beta
                          ;; kick-weights
                          kick-weights)
  "Builds a function to adjust weights. See source for more documentation"
  (declare (optimize (speed 1) (space 1) (safety 1) (debug 0)
                     (compilation-speed 0)))

  (if (and save-weights
           (not (or (eq save-weights :copy)
                    (eq save-weights :set))))
      (error
       (format nil "Macro adjust-weights: Wrong save-weights type ~A (must be :COPY or :SET)"
               save-weights)))


  ;; check arguments
  (if (and save-update
           (not eta))
      ;; update to save needs some update to be done
      (error "Macro adjust-weights: save-update specified but no eta-value"))
  (if momentum
      (if (not eta)
          (error "Macro adjust-weights: momentum specified but no eta-value")
          ;; momentum implies save-update
          (setf save-update t)))
  (if (eq save-weights :set)
      ;; save-weights 'set implies use-saved-weights
      (setf use-saved-weights t))

  (if (and momentum cg-update)
      (error "Macro adjust-weights: momentum and cg-update must not be both true"))

  (let* ((layer-specs (net-spec-layer-specs (eval netspec-form)))
         (num-layers (car (array-dimensions layer-specs)))

         (layers (make-array
                  num-layers
                  :initial-contents
                  (cons nil
                        (list-of-n (1- num-layers)
                                   (gensym "layers-")))))
         (weights (make-array
                   num-layers
                   :initial-contents
                   (cons nil
                         (list-of-n (1- num-layers)
                                    (gensym "weights-")))))

         (saved-weights (make-array
                         num-layers
                         :initial-contents
                         (cons nil
                               (list-of-n (1- num-layers)
                                          (gensym "saved-weights-")))))

         (de-by-dws (make-array
                     num-layers
                     :initial-contents
                     (cons nil
                           (list-of-n (1- num-layers)
                                      (gensym "de-by-dws-")))))

         (previous-updates (make-array
                            num-layers
                            :initial-contents
                            (cons nil
                                  (list-of-n (1- num-layers)
                                             (gensym "previous-updates-")))))

         (current-layer-neuron-count (gensym "current-layer-neuron-count"))
         (previous-layer-neuron-count (gensym "previous-layer-neuron-count"))

         (row-major-index (gensym "row-major-index-"))

         (update (gensym "update-")) ; to store weight update temporarily

         ;; What variables are needed ?
         (need-weights
          ;; need weights for adjusting them, kicking them or
          ;; copying them
          (or eta
              (eq save-weights :copy)
              kick-weights))

         (need-de-by-dws
          ;; need to make updates, clear them or make them be cg-updates
          (or eta
              clear-de-by-dws
              make-cg-updates-with-beta))
         (need-prev-update
          ;; needed if update is to be saved or to make cg-updates
          (or save-update
              make-cg-updates-with-beta))
         (need-saved-weights
          ;; either to save weights or to do update which uses them
          (or (eq save-weights :copy)
              (and eta
                   use-saved-weights)))
         (need-layers
          ;; layers are needed for any of the above or to do any kind
          ;; of weight-saving
          (or save-weights
              need-weights
              need-de-by-dws
              need-prev-update
              need-saved-weights))

         (need-second-loop
          ;; make-cg-updates got its own loop
          (or eta
              kick-weights
              (eq save-weights :copy)
              clear-de-by-dws))

         (need-loop
          ;; loop through weights etc is only needed for eta, save-weight-copy
          ;; clear-de-by-dws and make-cg-updates with-beta, IOW for everything
          ;; but save-weight-set
          (or need-second-loop
              make-cg-updates-with-beta))

         )

    (if (not need-loop)
        ;; just do save-weight-set
        `(progn
           ;;	   (format t "adjw: Saving weights - set~%")
           ,@(mapcar
              #'(lambda (layer-num)
                  `(let ((,(svref layers layer-num) (svref ,net ,layer-num)))
                     ;;		     (format t "adjw: Saving ~a~%" (layer-weight-vec
                     ;;						    ,(svref layers layer-num)))
                     (setf
                      (layer-saved-weight-vec ,(svref layers layer-num))
                      (layer-weight-vec ,(svref layers layer-num))
                      (layer-weight-vec ,(svref layers layer-num))
                      (make-array '(,(layer-spec-size
                                      (svref layer-specs layer-num))
                                    ,(1+ (layer-spec-size
                                          (svref layer-specs (1- layer-num)))))
                                  :element-type 'type-weight))))
              (fromto 1 (1- num-layers)))
           nil)
        ;; loop needed
        `(let* (
                ,@(if *prefer-row-major-aref*
                      `((,row-major-index 0)))

                ,@(if eta
                      `((,update ,(coerce 0.0 'type-de-by-dw))))
                  ;; make assignments for layers
                ,@(mapcan
                   #'(lambda (layer-num)
                       ;; counting 1..
                       `(
                         ,@(if need-layers
                               `((,(svref layers layer-num) (svref ,net ,layer-num))))

                           ;; SAVE-WEIGHTS CASE :SET
                           ;; If weights are to be saved by setf'ing the weight-vec,
                           ;; then do so *NOW*
                         ,@(if (and need-weights
                                    (eq save-weights :set))
                               `(
                                 ;;			     (format t "adjw: Saving weights need weights - set~%")
                                 ;;			     (format t "adjw: Saving ~A~%" (layer-weight-vec
                                 ;;							    ,(svref layers layer-num)))
                                 (,(svref saved-weights layer-num)
                                   (setf (layer-saved-weight-vec ,(svref layers layer-num))
                                         (layer-weight-vec ,(svref layers layer-num))))
                                 (,(svref weights layer-num)
                                   (setf (layer-weight-vec ,(svref layers layer-num))
                                         (make-array '(,(layer-spec-size
                                                         (svref layer-specs layer-num))
                                                       ,(1+ (layer-spec-size
                                                             (svref layer-specs (1- layer-num)))))
                                                     :element-type 'type-weight))))
                               ;; else (save-weights was not :set)
                               `(,@(if need-weights
                                       `((,(svref weights layer-num)
                                           (layer-weight-vec ,(svref layers layer-num)))))
                                   ,@(if need-saved-weights
                                         `((,(svref saved-weights layer-num)
                                             (layer-saved-weight-vec ,(svref layers layer-num)))))))
                           ;; FINISHED WITH (SAVED)WEIGHTS
                           ;; still to come: de-by-dw, prev-update

                         ,@(if need-de-by-dws
                               `((,(svref de-by-dws layer-num)
                                   (layer-de-by-dw-vec ,(svref layers layer-num)))))

                         ,@(if need-prev-update
                               `((,(svref previous-updates layer-num)
                                   (layer-previous-update-vec ,(svref layers layer-num)))))
                         ))
                   (fromto 1 (1- num-layers))))
           ;; DECLARATIONS
           (declare
            ,@(if *prefer-row-major-aref*
                  `((type fixnum ,row-major-index)))

            ,@(if eta
                  `((type type-de-by-dw ,update)))
            ;;	  (:explain :calls :types :boxing)
            ,@(mapcan
               #'(lambda (layer-num)
                   (let ((spec-current-layer-size
                          (layer-spec-size (svref layer-specs layer-num)))
                         (spec-previous-layer-size
                          (layer-spec-size (svref layer-specs (1- layer-num)))))
                     `(
                       ,@(if (and need-weights
                                  (eq save-weights :set))
                             `((type
                                (simple-array type-weight
                                              (,spec-current-layer-size
                                               ,(1+ spec-previous-layer-size)))
                                ,(svref weights layer-num))

                               (type
                                (simple-array type-weight
                                              (,spec-current-layer-size
                                               ,(1+ spec-previous-layer-size)))
                                ,(svref saved-weights layer-num)))
                             ;; else (save-weights was not :set)
                             `(,@(if need-weights
                                     `((type
                                        (simple-array type-weight
                                                      (,spec-current-layer-size
                                                       ,(1+ spec-previous-layer-size)))
                                        ,(svref weights layer-num))))
                                 ,@(if need-saved-weights
                                       `((type
                                          (simple-array type-weight
                                                        (,spec-current-layer-size
                                                         ,(1+ spec-previous-layer-size)))
                                          ,(svref saved-weights layer-num))))))
                         ;; FINISHED WITH (SAVED)WEIGHTS
                         ;; still to come: de-by-dw, prev-update
                       ,@(if need-de-by-dws
                             `((type
                                (simple-array type-de-by-dw
                                              (,spec-current-layer-size
                                               ,(1+ spec-previous-layer-size)))
                                ,(svref de-by-dws layer-num))))

                       ,@(if need-prev-update
                             `((type
                                (simple-array type-de-by-dw
                                              (,spec-current-layer-size
                                               ,(1+ spec-previous-layer-size)))
                                ,(svref previous-updates layer-num)))))))
               (fromto 1 (1- num-layers))))
           ,@(mapcan
              #'(lambda (layer) ;; 1..
                  (let ((spec-current-layer-size
                         (layer-spec-size (svref layer-specs layer)))
                        (spec-previous-layer-size
                         (layer-spec-size (svref layer-specs (1- layer)))))

                    `(
                      ,@(if (and (not need-weights)
                                 (eq save-weights :set))
                            `(
                              ;;			    (format t "adjw: Saving weights not need weights - set~%")
                              ;;			    (format t "adjw: Saving ~A~%" (layer-weight-vec
                              ;;							   ,(svref layers layer)))

                              (setf
                               (layer-saved-weight-vec ,(svref layers layer))
                               (layer-weight-vec ,(svref layers layer))
                               (layer-weight-vec ,(svref layers layer))
                               (make-array '(,(layer-spec-size
                                               (svref layer-specs layer))
                                             ,(1+ (layer-spec-size
                                                   (svref layer-specs (1- layer)))))
                                           :element-type 'type-weight))))

                      ,@(if kick-weights
                            `((kick-weights ,(svref weights layer)
                                            :dev ,kick-weights
                                            :size ,(* spec-current-layer-size
                                                      (1+ spec-previous-layer-size)))))

                        ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                        ;;
                        ;; make de-by-dw the cg-update
                      ,@(if make-cg-updates-with-beta
                            `(
                              (if (/= 0 ,make-cg-updates-with-beta)
                                  (progn
                                    ,@(if *prefer-row-major-aref*
                                          `((setq ,row-major-index 0)))

                                    (dotimes (,current-layer-neuron-count
                                               ,spec-current-layer-size)
                                      ;;don't forget the bias-weight - 1+ !
                                      ;; (dotimes (,previous-layer-neuron-count
                                      ;;	     ,(1+ spec-previous-layer-size))
                                      (simple-dotimes-unroll
                                          (,previous-layer-neuron-count
                                           ,(1+ spec-previous-layer-size))
                                        ,@(if *nile-debug*
                                              `(
                                                (format t "adjw: Making cg-update: layer ~a node ~a to ~a : ~a -> ~a (beta ~a)~%"
                                                        ,layer ,current-layer-neuron-count
                                                        ,previous-layer-neuron-count
                                                        (aref ,(svref de-by-dws layer)
                                                              ,current-layer-neuron-count
                                                              ,previous-layer-neuron-count)
                                                        (- (aref ,(svref de-by-dws layer)
                                                                 ,current-layer-neuron-count
                                                                 ,previous-layer-neuron-count)
                                                           (* ,make-cg-updates-with-beta
                                                              (aref ,(svref previous-updates layer)
                                                                    ,current-layer-neuron-count
                                                                    ,previous-layer-neuron-count)))
                                                        ,make-cg-updates-with-beta)))
                                        ;; -update =  de-by-dw - beta*previous-update
                                        (decf
                                         ,(if *prefer-row-major-aref*
                                              ;; prefer row major
                                              `(row-major-aref ,(svref de-by-dws layer)
                                                               ,row-major-index)
                                              ;; prefer aref
                                              `(aref ,(svref de-by-dws layer)
                                                     ,current-layer-neuron-count
                                                     ,previous-layer-neuron-count))
                                         ;; (* beta previous-update)
                                         (* ,make-cg-updates-with-beta
                                            ,(if *prefer-row-major-aref*
                                                 ;; prefer row major
                                                 `(row-major-aref ,(svref previous-updates layer)
                                                                  ,row-major-index)
                                                 ;; prefer aref
                                                 `(aref ,(svref previous-updates layer)
                                                        ,current-layer-neuron-count
                                                        ,previous-layer-neuron-count))))
                                        ,@(if *prefer-row-major-aref*
                                              `((incf ,row-major-index)))))))))

                      ,@(if (and need-second-loop
                                 *prefer-row-major-aref*)
                            `((setq ,row-major-index 0)))

                      ,@(if need-second-loop
                            `((dotimes (,current-layer-neuron-count
                                         ,spec-current-layer-size)
                                ;;don't forget the bias-weight - 1+ !
                                ;; (dotimes (,previous-layer-neuron-count
                                ;;	     ,(1+ spec-previous-layer-size))
                                (simple-dotimes-unroll
                                    (,previous-layer-neuron-count
                                     ,(1+ spec-previous-layer-size))
                                  ;; first: save-weights if to be copied
                                  ,@(if (eq save-weights :copy)
                                        `((setf
                                           ,(if *prefer-row-major-aref*
                                                ;; prefer row major
                                                `(row-major-aref ,(svref saved-weights layer)
                                                                 ,row-major-index)
                                                ;; prefer aref
                                                `(aref ,(svref saved-weights layer)
                                                       ,current-layer-neuron-count
                                                       ,previous-layer-neuron-count))
                                           ,(if *prefer-row-major-aref*
                                                ;; prefer row major
                                                `(row-major-aref ,(svref weights layer)
                                                                 ,row-major-index)
                                                ;; prefer aref
                                                `(aref ,(svref weights layer)
                                                       ,current-layer-neuron-count
                                                       ,previous-layer-neuron-count)))))

                                  ;; main-part : do update (if eta)
                                  ,@(if eta
                                        (let ((weights-from ;; from where to take weights
                                               (if use-saved-weights
                                                   ;; saved weights
                                                   (if *prefer-row-major-aref*
                                                       ;; prefer row major
                                                       `(row-major-aref ,(svref saved-weights layer)
                                                                        ,row-major-index)
                                                       ;; prefer aref
                                                       `(aref ,(svref saved-weights layer)
                                                              ,current-layer-neuron-count
                                                              ,previous-layer-neuron-count))
                                                   ;; else weights
                                                   (if *prefer-row-major-aref*
                                                       ;; prefer row major
                                                       `(row-major-aref ,(svref weights layer)
                                                                        ,row-major-index)
                                                       ;; prefer aref
                                                       `(aref ,(svref weights layer)
                                                              ,current-layer-neuron-count
                                                              ,previous-layer-neuron-count)))))
                                          ;;
                                          ;; Specified: ETA=T
                                          ;; Return   : list of commands
                                          (if momentum
                                              ;;
                                              ;; Specified: ETA=T MOMENTUM=T
                                              ;; Return   : list of commands
                                              `((setq ,update
                                                      (+
                                                       ;; - eta*dE/dw
                                                       (* (- ,eta)
                                                          ,(if *prefer-row-major-aref*
                                                               ;; prefer row major
                                                               `(row-major-aref ,(svref de-by-dws layer)
                                                                                ,row-major-index)
                                                               ;; prefer aref
                                                               `(aref ,(svref de-by-dws layer)
                                                                      ,current-layer-neuron-count
                                                                      ,previous-layer-neuron-count)))
                                                       ;; alpha * delta-w
                                                       (* ,momentum
                                                          ,(if *prefer-row-major-aref*
                                                               ;; prefer row major
                                                               `(row-major-aref ,(svref previous-updates layer)
                                                                                ,row-major-index)
                                                               ;; prefer aref
                                                               `(aref ,(svref previous-updates layer)
                                                                      ,current-layer-neuron-count
                                                                      ,previous-layer-neuron-count)))))
                                                ;; do update
                                                (setf
                                                 ,(if *prefer-row-major-aref*
                                                      ;; prefer row major
                                                      `(row-major-aref ,(svref weights layer)
                                                                       ,row-major-index)
                                                      ;; prefer aref
                                                      `(aref ,(svref weights layer)
                                                             ,current-layer-neuron-count
                                                             ,previous-layer-neuron-count))
                                                 (+ ,weights-from
                                                    ,update))
                                                ;; save update
                                                (setf
                                                 ,(if *prefer-row-major-aref*
                                                      ;; prefer row major
                                                      `(row-major-aref ,(svref previous-updates layer)
                                                                       ,row-major-index)
                                                      ;; prefer aref
                                                      `(aref ,(svref previous-updates layer)
                                                             ,current-layer-neuron-count
                                                             ,previous-layer-neuron-count))
                                                 ,update))
                                              ;; else if momentum
                                              ;;
                                              ;; Specified: ETA=T MOMENTUM=NIL
                                              ;; Return   : list of commands

                                              `((setq ,update ;; is only (- de-by-dws)
                                                      (-
                                                       ,(if *prefer-row-major-aref*
                                                            ;; prefer row major
                                                            `(row-major-aref ,(svref de-by-dws layer)
                                                                             ,row-major-index)
                                                            ;; prefer aref
                                                            `(aref ,(svref de-by-dws layer)
                                                                   ,current-layer-neuron-count
                                                                   ,previous-layer-neuron-count))))
                                                ;; update product with eta
                                                (setf
                                                 ,(if *prefer-row-major-aref*
                                                      ;; prefer row major
                                                      `(row-major-aref ,(svref weights layer)
                                                                       ,row-major-index)
                                                      ;; prefer aref
                                                      `(aref ,(svref weights layer)
                                                             ,current-layer-neuron-count
                                                             ,previous-layer-neuron-count))
                                                 (+ ,weights-from
                                                    (* ,eta
                                                       ,update)))
                                                ,@(if save-update
                                                      (if cg-update
                                                          ;; SAVE-UPDATE=T CG-UPDATE=T
                                                          `((setf
                                                             ,(if *prefer-row-major-aref*
                                                                  ;; prefer row major
                                                                  `(row-major-aref ,(svref previous-updates layer)
                                                                                   ,row-major-index)
                                                                  ;; prefer aref
                                                                  `(aref ,(svref previous-updates layer)
                                                                         ,current-layer-neuron-count
                                                                         ,previous-layer-neuron-count))
                                                             ,update))
                                                          ;; SAVE-UPDATE=T CG-UPDATE=NIL
                                                          `((setf
                                                             ,(if *prefer-row-major-aref*
                                                                  ;; prefer row major
                                                                  `(row-major-aref ,(svref previous-updates layer)
                                                                                   ,row-major-index)
                                                                  ;; prefer aref
                                                                  `(aref ,(svref previous-updates layer)
                                                                         ,current-layer-neuron-count
                                                                         ,previous-layer-neuron-count))
                                                             (* ,eta ,update)))))))))
                                  ,@(if clear-de-by-dws
                                        `((setf
                                           ,(if *prefer-row-major-aref*
                                                ;; prefer row major
                                                `(row-major-aref ,(svref de-by-dws layer)
                                                                 ,row-major-index)
                                                ;; prefer aref
                                                `(aref ,(svref de-by-dws layer)
                                                       ,current-layer-neuron-count
                                                       ,previous-layer-neuron-count))
                                           ,(coerce 0.0 'type-de-by-dw))))

                                  ,@(if *prefer-row-major-aref*
                                        `((incf ,row-major-index))))))))))
              (fromto 1 (1- num-layers)))
           nil))))


;; needed arrays:
;; input-layer: activation
;; output-layer: activation, delta, (sum), weights, de-by-dw
;; hidden layer(s): activation, (sum), delta, weights, de-by-dw
;;

;; ASSUMES : de-by-dw to be set to zero for iteration over first
;;           pattern !

(defmacro backprop-fn (netspec-form net dest
                       &key scale
                       scale-just-elman-recurrents
                       improved-elman
                       improved-elman-opts)
  "Builds a function to do back propagation on net (complying to netspec-form),
given pattern dest. Other options are experimental."
  (declare (optimize (speed 1) (space 1) (safety 1) (debug 0)
                     (compilation-speed 0)))
  (destructuring-bind (&key ((:this-pattern-cs ie-this-pattern-cs))
                            ((:all-patterns ie-all-patterns))
                            ((:step-num ie-step-num))
                            ((:pattern-num ie-pattern-num))
                            ((:gdash-sum-in ie-gdash-sum-in)))
      improved-elman-opts
    ;; INDENTATION WRONG BY PURPOSE
    ;;     )
    (if (and improved-elman
             (not (and ie-this-pattern-cs
                       ie-all-patterns
                       ie-step-num
                       ie-pattern-num)))
        (error "macro backprop-fn : Improved-elman needs all improved-elman-opts"))

    (let* ((layer-specs (net-spec-layer-specs (eval netspec-form)))
           (num-layers (car (array-dimensions layer-specs)))

           ;; for all layers but input
           (layers (make-array
                    num-layers
                    :initial-contents
                    (cons nil
                          (list-of-n (1- (if (=  0 num-layers) 1 num-layers))
                                     (gensym "layers-")))))
           (sums (make-array
                  num-layers
                  :initial-contents
                  (cons nil
                        (list-of-n (1-  (if (=  0 num-layers) 1 num-layers))
                                   (gensym "sums-")))))
           (deltas (make-array
                    num-layers
                    :initial-contents
                    (cons nil
                          (list-of-n (1-  (if (=  0 num-layers) 1 num-layers))
                                     (gensym "deltas-")))))
           (weights (make-array
                     num-layers
                     :initial-contents
                     (cons nil
                           (list-of-n (1-  (if (=  0 num-layers) 1 num-layers))
                                      (gensym "weights-")))))
           (de-by-dws (make-array
                       num-layers
                       :initial-contents
                       (cons nil
                             (list-of-n (1-  (if (=  0 num-layers) 1 num-layers))
                                        (gensym "de-by-dws")))))
           ;; and acts for all layers
           (acts (make-array
                  num-layers
                  :initial-contents
                  (list-of-n num-layers (gensym "acts-"))))

           (delta (gensym "delta-"))
           (delta-sum (gensym "delta-sum-"))

           (previous-layer-count (gensym "previous-layer-count-"))
           (current-layer-count (gensym "current-layer-count-"))
           (next-layer-count (gensym "next-layer-count-"))

           (row-major-index (gensym "row-major-index-"))

           (act (gensym "act-"))

           (iscale (gensym "scale-"))
           (scaled-delta (gensym "scaled-delta-"))

           (ie-corrected-input-layer-act (gensym "ie-corrected-input-layer-act-"))
           )
      ;; make let statement
      `(let* ((,delta (the type-delta ,(coerce 0.0 'type-delta)))
              (,delta-sum (the type-delta ,(coerce 0.0 'type-delta)))
              (,act ,(coerce 0.0 'type-act))

              ,@(if scale
                    `((,iscale (coerce ,scale 'type-delta))
                      (,scaled-delta ,(coerce 0.0d0 'type-delta))))

              ,@(if *prefer-row-major-aref*
                    `((,row-major-index 0)))

              ,@(if improved-elman
                    `((,ie-corrected-input-layer-act
                       (make-array '(,(1+ (layer-spec-size (svref layer-specs 0))))
                                   :element-type 'type-act))))

              ;; make assignments for let* - assign gensyms created above
              ;; the different arrays from layers from the real net
              ,@(mapcan
                 #'(lambda (layer-num)
                     (if (= 0 layer-num)
                         ;; for 0th layer only activation
                         `((,(svref acts layer-num)
                             (layer-act-vec (svref ,net ,layer-num))))
                         `(
                           (,(svref layers layer-num) (svref ,net ,layer-num))
                           (,(svref acts layer-num) (layer-act-vec ,(svref layers layer-num)))
                           ,@(if (layer-spec-act-fn-dash-uses-sum
                                  (svref layer-specs layer-num))
                                 `((,(svref sums layer-num)
                                     (layer-sum-vec ,(svref layers layer-num)))))
                           (,(svref deltas layer-num) (layer-delta-vec ,(svref layers layer-num)))
                           ;; weight not needed for layer 1 - gives warning
                           ,@(if (not (= layer-num 1))
                                 `((,(svref weights layer-num)
                                     (layer-weight-vec ,(svref layers layer-num)))))
                           (,(svref de-by-dws layer-num) (layer-de-by-dw-vec ,(svref layers layer-num)))
                           )))
                 (fromto 0 (1- num-layers))))
         ;; part after let-statement: declarations
         (declare
          ,@(if *prefer-row-major-aref*
                `((type fixnum ,row-major-index)))
          ,@(if scale
                `((type type-delta ,iscale ,scaled-delta)))
          (type type-delta ,delta ,delta-sum)
          (type type-act ,act)

          ;; make it one bigger than input layer for bias-weight-c !
          ,@(if improved-elman
                `((type (simple-array type-act (,(1+ (layer-spec-size
                                                      (svref layer-specs 0)))))
                        ,ie-corrected-input-layer-act)))
          ;;		  (:explain :calls :types :boxing)
          ,@(mapcan
             #'(lambda (layer-num)
                 (let ((spec-current-layer-size
                        (layer-spec-size (svref layer-specs layer-num))))
                   (if (= 0 layer-num)
                       ;; for 0th layer only activation
                       `(
                         (type
                          (simple-array type-act
                                        (,spec-current-layer-size))
                          ,(svref acts layer-num)))
                       (let ((spec-previous-layer-size
                              (layer-spec-size (svref layer-specs (1- layer-num)))))
                         `(
                           (type
                            (simple-array type-act
                                          (,spec-current-layer-size))
                            ,(svref acts layer-num))

                           ,@(if (layer-spec-act-fn-dash-uses-sum
                                  (svref layer-specs layer-num))
                                 `((type
                                    (simple-array type-sum
                                                  (,spec-current-layer-size))
                                    ,(svref sums layer-num))))

                           (type
                            (simple-array type-delta
                                          (,spec-current-layer-size))
                            ,(svref deltas layer-num))

                           ,@(if (not (= layer-num 1))
                                 `((type
                                    (simple-array type-weight
                                                  (,spec-current-layer-size
                                                   ,(1+ spec-previous-layer-size)))
                                    ,(svref weights layer-num))))

                           (type
                            (simple-array type-de-by-dw
                                          (,spec-current-layer-size
                                           ,(1+ spec-previous-layer-size)))
                            ,(svref de-by-dws layer-num)))))))
             (fromto 0 (1- num-layers))))

         ;; make the ie-corrected-input-layer-act
         ,@(if improved-elman
               (let ((idx (gensym "bp-idx-"))
                     (step (gensym "bp-step-"))
                     (c (gensym "bp-c-"))
                     (prev-act (gensym "bp-prev-act-")))
                 `( ;; copy all
                   (simple-dotimes-unroll
                       (,idx ,(layer-spec-size (svref layer-specs 0)))
                     (setf (aref ,ie-corrected-input-layer-act ,idx)
                           (aref ,(svref acts 0) ,idx)))
                   ;; bias act is one
                   ;; (actually, is -1, but backpropper sets de/dw
                   ;; to -1 * bias-act*delta
                   (setf (aref ,ie-corrected-input-layer-act
                               ,(layer-spec-size (svref layer-specs 0)))
                         ,(coerce 1.0d0 'type-act))
                   ;; now set rescaled acts
                   ;; act is \sum_{all-steps<current} a_step*c_step
                   ,@(if *debug-improved-elman*
                         `((format t "cs  : ")))

                   (dotimes (,step ,ie-step-num)
                     (declare (fixnum ,step))
                     (let ((,prev-act (svref (svref ,ie-all-patterns ,step)
                                             ,ie-pattern-num))
                           (,c (aref ,ie-this-pattern-cs ,step)))
                       (declare (type (simple-array type-act (,(layer-spec-size
                                                                (svref layer-specs 0))))
                                      ,prev-act)
                                (type type-act ,c))
                       ,@(if *debug-improved-elman*
                             `((format t "[step ~a c ~a] " ,step ,c)))
                       (do ((,idx ,(- (layer-spec-size (svref layer-specs 0))
                                      (layer-spec-size (svref layer-specs 1)))
                                  (1+ ,idx)))
                           ((>= ,idx ,(layer-spec-size (svref layer-specs 0))))
                         (declare (fixnum ,idx))
                                        ;, a := a+c(t)*a(t)
                         (incf (aref ,ie-corrected-input-layer-act ,idx)
                               (* ,c
                                  (aref ,prev-act ,idx)))
                         ,@(if *debug-improved-elman*
                               `((format t "~a " (* ,c
                                                    (aref ,prev-act ,idx)))))
                         )
                       (incf (aref ,ie-corrected-input-layer-act
                                   ,(layer-spec-size (svref layer-specs 0)))
                             ,c)))
                   ,@(if *debug-improved-elman*
                         (format t "~%")))))

         ;; after declarations: the program
         ;; OUTPUT LAYER
         ,@(let* ((layer (1- num-layers))
                  (spec-current-layer-size
                   (layer-spec-size (svref layer-specs layer)))
                  (spec-previous-layer-size
                   (layer-spec-size (svref layer-specs (1- layer))))
                  (spec-current-layer-gdash
                   (layer-spec-act-fn-dash (svref layer-specs layer))))
                 `(
                   ;;()
                   ,@(if *prefer-row-major-aref*
                         `((setq ,row-major-index 0)))

                   (dotimes (,current-layer-count ,spec-current-layer-size)
                     ;; act is activation of current neuron
                     (setq ,act (aref ,(svref acts layer)
                                      ,current-layer-count))
                     ;; dE/dw = -(d - a) *   g'(s)     * a_prev-layer
                     ;;       = -(d - a) * Da(1-a)     * a_prev-layer
                     ;; delta = -(d - a) *   g'(s)
                     (setq ,delta
                           (* (- (- (aref ,dest ,current-layer-count)
                                    ,act))
                              (,@spec-current-layer-gdash
                               ;; sum will hopefully be ignored by fn
                               ,(if (layer-spec-act-fn-dash-uses-sum
                                     (svref layer-specs layer))
                                    `(aref ,(svref sums layer) ,current-layer-count))
                               ,act)))
                     ;; save delta
                     (setf (aref ,(svref deltas layer) ,current-layer-count)
                           ,delta)

                     ,@(if (and scale (not scale-just-elman-recurrents))
                           `((setq ,scaled-delta (* ,iscale ,delta))))

                     ;; dE/dw_mi = delta_m * a_i
                     ;; (dotimes (,previous-layer-count ,spec-previous-layer-size)
                     (simple-dotimes-unroll
                         (,previous-layer-count ,spec-previous-layer-size)
                       (incf
                        ,(if *prefer-row-major-aref*
                             ;; prefer row major
                             `(row-major-aref ,(svref de-by-dws layer)
                                              ,row-major-index)
                             ;; prefer aref
                             `(aref ,(svref de-by-dws layer)
                                    ,current-layer-count
                                    ,previous-layer-count))
                        (* ,(if (and scale (not scale-just-elman-recurrents))
                                scaled-delta
                                delta)
                           (aref ,(svref acts (1- layer))
                                 ,previous-layer-count)))
                       ,@(if *prefer-row-major-aref*
                             `((incf ,row-major-index))))

                     ;; dE/dw_bias = delta * -1 (bias is alway -1)
                     (decf
                      ,(if *prefer-row-major-aref*
                           ;; prefer row major
                           `(row-major-aref ,(svref de-by-dws layer)
                                            ,row-major-index)
                           ;; prefer aref
                           `(aref ,(svref de-by-dws layer)
                                  ,current-layer-count
                                  ,spec-previous-layer-size))
                      ,(if (and scale (not scale-just-elman-recurrents))
                           scaled-delta
                           delta))

                     ,@(if *prefer-row-major-aref*
                           `((incf ,row-major-index))))))

         ;; ALL OTHER LAYERS - Backwards
         ,@(mapcan
            #'(lambda (layer) ;; LAST-1 downto 1
                (let* ((spec-current-layer-size
                        (layer-spec-size (svref layer-specs layer)))
                       (spec-previous-layer-size
                        (layer-spec-size (svref layer-specs (1- layer))))
                       (spec-next-layer-size
                        (layer-spec-size (svref layer-specs (1+ layer))))
                       (spec-current-layer-gdash
                        (layer-spec-act-fn-dash (svref layer-specs layer))))

                  `(
                    ,@(if *prefer-row-major-aref*
                          `((setq ,row-major-index 0)))

                    (dotimes (,current-layer-count ,spec-current-layer-size)
                      (setq ,act (aref ,(svref acts layer)
                                       ,current-layer-count))
                      (setq ,delta-sum ,(coerce 0.0 'type-delta))
                      ;; sum over deltas * weights from next layer
                      ;;(dotimes (,next-layer-count ,spec-next-layer-size)
                      (simple-dotimes-unroll
                          (,next-layer-count ,spec-next-layer-size)
                        (incf ,delta-sum
                              (* (aref ,(svref deltas (1+ layer)) ,next-layer-count)
                                 (aref ,(svref weights (1+ layer))
                                       ,next-layer-count
                                       ,current-layer-count))))
                      ,(if (and improved-elman ie-gdash-sum-in)
                           `(setq ,delta (,@spec-current-layer-gdash
                                          ;; sum will hopefully be ignored by fn
                                          ,(if (layer-spec-act-fn-dash-uses-sum
                                                (svref layer-specs layer))
                                               `(aref ,(svref sums layer) ,current-layer-count))
                                          ,act)
                                  ,ie-gdash-sum-in (+ ,ie-gdash-sum-in ,delta)
                                  ,delta (* ,delta ,delta-sum))
                           ;; delta is GDASH(AM,SM)*SUM(deltas-prev-layer)*WEIGHTS
                           `(setq ,delta
                                  (* (,@spec-current-layer-gdash
                                      ;; sum will hopefully be ignored by fn
                                      ,(if (layer-spec-act-fn-dash-uses-sum
                                            (svref layer-specs layer))
                                           `(aref ,(svref sums layer) ,current-layer-count))
                                      ,act)
                                     ,delta-sum)))
                      ;; save delta
                      (setf (aref ,(svref deltas layer) ,current-layer-count)
                            ,delta)

                      ,@(if scale
                            (if scale-just-elman-recurrents
                                (if (= layer 1)
                                    `((setq ,scaled-delta (* ,iscale ,delta))))
                                `((setq ,scaled-delta (* ,iscale ,delta)))))

                      ;; calculate de-by-dws
                      ;; (dotimes (,previous-layer-count ,spec-previous-layer-size)
                      (simple-dotimes-unroll
                          (,previous-layer-count ,spec-previous-layer-size)
                        ,@(if *nile-debug*
                              `((format t "Setting de-by-dw (~a ~a) : was ~a , adding (* ~a ~a)"
                                        ,current-layer-count ,previous-layer-count
                                        (aref ,(svref de-by-dws layer)
                                              ,current-layer-count
                                              ,previous-layer-count)
                                        ,delta
                                        (aref ,(svref acts (1- layer)) ,previous-layer-count))))
                        (incf
                         ,(if *prefer-row-major-aref*
                              ;; prefer row major
                              `(row-major-aref ,(svref de-by-dws layer)
                                               ,row-major-index)
                              ;; prefer aref
                              `(aref ,(svref de-by-dws layer)
                                     ,current-layer-count
                                     ,previous-layer-count))
                         (* ,(if scale
                                 (if scale-just-elman-recurrents
                                     (if (= layer 1)
                                         `(if (>= ,previous-layer-count
                                                  ,(- spec-previous-layer-size
                                                      spec-current-layer-size))
                                              ,scaled-delta
                                              ,delta)
                                         ;; layer not 1
                                         delta)
                                     ;; scale not just elmans
                                     scaled-delta)
                                 ;; don't scale
                                 delta)
                            ,(if (and improved-elman (= layer 1))
                                 `(aref ,ie-corrected-input-layer-act
                                        ,previous-layer-count)
                                 `(aref ,(svref acts (1- layer)) ,previous-layer-count))))

                        ,@(if *nile-debug*
                              `((format t " -> ~a~%" (aref ,(svref de-by-dws layer)
                                                           ,current-layer-count
                                                           ,previous-layer-count))))
                        ,@(if *prefer-row-major-aref*
                              `((incf ,row-major-index))))

                      ;;
                      ;; Terrible bug used to be here: Next decf was included in loop !!!
                      ;;
                      ;; bias weight
                      ,@(if *nile-debug*
                            `((format t "setting bias-weight (~a ~a) : (- ~a ~a)"
                                      ,current-layer-count
                                      ,spec-previous-layer-size
                                      (aref ,(svref de-by-dws layer)
                                            ,current-layer-count
                                            ,spec-previous-layer-size)
                                      ,delta)))
                      (decf
                       ,(if *prefer-row-major-aref*
                            ;; prefer row major
                            `(row-major-aref ,(svref de-by-dws layer)
                                             ,row-major-index)
                            ;; prefer aref
                            `(aref ,(svref de-by-dws layer)
                                   ,current-layer-count
                                   ,spec-previous-layer-size))
                       ,(if improved-elman
                            (if (and scale (not scale-just-elman-recurrents))
                                `(* ,scaled-delta
                                    (aref ,ie-corrected-input-layer-act
                                          ,(layer-spec-size (svref layer-specs 0))))
                                `(* ,delta
                                    (aref ,ie-corrected-input-layer-act
                                          ,(layer-spec-size (svref layer-specs 0)))))
                            (if (and scale (not scale-just-elman-recurrents))
                                scaled-delta
                                delta)))
                      ,@(if *prefer-row-major-aref*
                            `((incf ,row-major-index)))
                      ,@(if *nile-debug*
                            `((format t " -> ~a~%" (aref ,(svref de-by-dws layer)
                                                         ,current-layer-count
                                                         ,spec-previous-layer-size))))))))
            ;; end lambda
            (reverse (fromto 1 (- num-layers 2))))))))

#|
(defun test-activation-means (seed)
  (declare
   ;;   (optimize (speed 3) (space 0) (safety 0) (debug 0) ;
   ;;	     (compilation-speed 0))       ;
   )
  (let ((net
         (mk-net (netspec 3 2 2)
                 :runtime-weights t
                 :runtime-weights-state seed))
        (act-mean (make-act-mean :count 0
                                 :sum (coerce 0.0d0 'type-act)))
        (weight-mean (make-weight-mean :count 0
                                       :sum (coerce 0.0d0 'type-weight))))

    (setf (layer-act-vec (svref net 0))
          (make-array 3 :element-type 'type-act
                      :initial-contents (list (coerce 0.1 'type-act)
                                              (coerce 0.2 'type-act)
                                              (coerce 0.3 'type-act))))
    (format t "before activation~%")
    (write-net net)
    (activation-fn (netspec 3 2 2) net
                   :hidden-act-mean-in act-mean
                   :hidden-weight-mean-in weight-mean)

    (format t "after activation~%")
    (write-net net)
    (format t "weight mean ~a (~a), actt mean ~a (~a)~%"
            (/ (weight-mean-sum weight-mean) (weight-mean-count weight-mean))
            weight-mean
            (/ (act-mean-sum act-mean) (act-mean-count act-mean))
            act-mean)))

(defun test-activation (seed)
  (declare
   ;;   (optimize (speed 3) (space 0) (safety 0) (debug 0)
   ;;	     (compilation-speed 0))
   )
  (let ((net
         (mk-net (netspec 3 2 2)
                 :runtime-weights t
                 :runtime-weights-state seed)))
    (setf (layer-act-vec (svref net 0))
          (make-array 3 :element-type 'type-act
                      :initial-contents (list (coerce 0.1 'type-act)
                                              (coerce 0.2 'type-act)
                                              (coerce 0.3 'type-act))))
    (format t "before activation~%")
    (write-net net)
    (time
     (dotimes (la 10000)
       (activation-fn (netspec 3 2 2)
                      net))
     )
    (format t "after activation~%")
    (write-net net)
    ))


(defun test-activation-opt (seed)
  (declare
   (optimize (speed 3) (space 0) (safety 0) (debug 0)
             (compilation-speed 0))
   (:explain :calls :types :boxing)
   )
  (let ((net
         (mk-net (netspec 3 2 2)
                 :runtime-weights t
                 :runtime-weights-state seed)))
    (setf (layer-act-vec (svref net 0))
          (make-array 3 :element-type 'type-act
                      :initial-contents (list (coerce 0.1 'type-act)
                                              (coerce 0.2 'type-act)
                                              (coerce 0.3 'type-act))))
    (format t "before activation~%")
    (write-net net)
    (time
     (dotimes (la 10000)
       (activation-fn (netspec 3 2 2)
                      net))
     )
    (format t "after activation~%")
    (write-net net)
    ))

;;;;
;;;; Test how compiler optimises with own function for
;;;; activation-fn

(defun my-activate (net)
  (declare
   (:explain :variables :calls :types :boxing))
  (activation-fn (netspec 3 2 2)
                 net))

(defun test-activation-sep-fn (seed)
  (declare
   (optimize (speed 3) (space 0) (safety 0) (debug 0)
             (compilation-speed 0))
   (:explain :calls :types :boxing)
   )
  (let ((net
         (mk-net (netspec 3 2 2)
                 :runtime-weights t
                 :runtime-weights-state seed)))
    (setf (layer-act-vec (svref net 0))
          (make-array 3 :element-type 'type-act
                      :initial-contents (list (coerce 0.1 'type-act)
                                              (coerce 0.2 'type-act)
                                              (coerce 0.3 'type-act))))
    (format t "before activation~%")
    (write-net net)
    (dotimes (la 100000)
      (my-activate net))
    (format t "after activation~%")
    (write-net net)
    ))

(defun test-adjust-weights ()
  (declare
   (:explain :calls :types :boxing)
   (optimize (speed 3) (space 0) (safety 0) (debug 0)
             (compilation-speed 0)))

  (let ((net
         (mk-net (netspec 3 2 2)))
        (eta (the type-weight (coerce 0.1d0 'type-weight)))
        (momentum (the type-weight (coerce 0.9d0 'type-weight))))
    (declare (type type-weight eta momentum))
    (time
     (dotimes (la 10000)
       (adjust-weights (netspec 3 2 2) net
                       :eta eta
                       :momentum momentum
                       :save-weights :copy
                       :clear-de-by-dws t)

       (adjust-weights (netspec 3 2 2) net
                       :eta eta
                       :make-cg-updates-with-beta 6.6)

       (adjust-weights (netspec 3 2 2) net
                       :eta eta
                       :save-update t)


       (adjust-weights (netspec 3 2 2) net
                       :eta eta
                       :momentum momentum
                       :save-weights :copy
                       :use-saved-weights t
                       )))))

(defun test-adjust-weights-nopt (seed)
  (declare
   ;;(:explain :calls :types :boxing)
   ;;   (optimize (speed 3) (space 0) (safety 0) (debug 0)
   ;;	     (compilation-speed 0)))
   )
  (let ((net
         (mk-net (netspec 3 2 2)
                 :runtime-weights t
                 :runtime-weights-state seed))
        (eta (the type-weight (coerce 0.1d0 'type-weight)))
        (momentum (the type-weight (coerce 0.9d0 'type-weight))))
    (declare (type type-weight eta momentum))

    (setf (layer-act-vec (svref net 0))
          (make-array 3 :element-type 'type-act
                      :initial-contents (list (coerce 0.1 'type-act)
                                              (coerce 0.2 'type-act)
                                              (coerce 0.3 'type-act))))

    (activation-fn (netspec 3 2 2)
                   net)

    (backprop-fn (netspec 3 2 2)
                 net
                 (make-array 2
                             :element-type 'type-act
                             :initial-contents (list (coerce 1.0 'type-act)
                                                     (coerce 0.0 'type-act))))

    (format t "** Before eta+mom~%")
    (write-net net)
    (adjust-weights (netspec 3 2 2) net
                    :eta eta
                    :momentum momentum
                    :save-weights :copy)

    (format t "** After eta+mom~%")
    (write-net net)

    (adjust-weights (netspec 3 2 2) net
                    :make-cg-updates-with-beta 6.6)

    (format t "** After make-cg-updates~%")
    (write-net net)

    (adjust-weights (netspec 3 2 2) net
                    :eta eta
                    :use-saved-weights t
                    :save-update t)
    (format t "** After final upd~%")
    (write-net net)))

(defun test-adjust-weights-opt (seed)
  (declare
   (:explain :calls :types :boxing)
   (optimize (speed 3) (space 0) (safety 0) (debug 0)
             (compilation-speed 0))
   )
  (let ((net
         (mk-net (netspec 3 2 2)
                 :runtime-weights t
                 :runtime-weights-state seed))
        (bp-dest (make-array 2
                             :element-type 'type-act
                             :initial-contents (list (coerce 1.0 'type-act)
                                                     (coerce 0.0 'type-act))))
        (eta (the type-weight (coerce 0.1d0 'type-weight)))
        (momentum (the type-weight (coerce 0.9d0 'type-weight))))
    (declare (type type-weight eta momentum)
             (type (simple-array type-act (2)) bp-dest))

    (setf (layer-act-vec (svref net 0))
          (make-array 3 :element-type 'type-act
                      :initial-contents (list (coerce 0.1 'type-act)
                                              (coerce 0.2 'type-act)
                                              (coerce 0.3 'type-act))))

    (activation-fn (netspec 3 2 2)
                   net)

    (backprop-fn (netspec 3 2 2)
                 net bp-dest)


    (format t "** Before eta+mom~%")
    (write-net net)
    (adjust-weights (netspec 3 2 2) net
                    :eta eta
                    :momentum momentum
                    :save-weights :copy)

    (format t "** After eta+mom~%")
    (write-net net)

    (adjust-weights (netspec 3 2 2) net
                    :make-cg-updates-with-beta 6.6)

    (format t "** After make-cg-updates~%")
    (write-net net)

    (adjust-weights (netspec 3 2 2) net
                    :eta eta
                    :use-saved-weights t
                    :save-update t)
    (format t "** After final upd~%")
    (write-net net)))

(defun test-bprop (ieta seed)
  ;;  (declare
  ;;   (optimize (speed 3) (space 0) (safety 0) (debug 0)
  ;;  	     (compilation-speed 0)))

  (let ((net
         (mk-net (netspec 3 2 2)
                 :runtime-weights t
                 :runtime-weights-state seed))
        (eta (the type-weight (coerce ieta 'type-weight))))
    (declare (type type-weight eta))
    (setf (layer-act-vec (svref net 0))
          (make-array 3 :element-type 'type-act
                      :initial-contents
                      (list (coerce 1.0 'type-act)
                            (coerce 1.0 'type-act)
                            (coerce 0.6 'type-act))))

    (activation-fn (netspec 3 2 2)
                   net)
    (format t "After activation~%")
    (write-net net)
    (backprop-fn (netspec 3 2 2)
                 net
                 (make-array 2
                             :element-type 'type-act
                             :initial-contents (list (coerce 1.0 'type-act)
                                                     (coerce 0.0 'type-act))))
    (adjust-weights (netspec 3 2 2)
                    net :eta eta)
    (format t "After BPROP+ADJUST-WEIGHTS~%")
    (write-net net)
    (activation-fn (netspec 3 2 2)
                   net)
    (format t "After another activation~%")
    (write-net net)))

(defun test-bprop-opt (ieta seed)
  (declare
   (optimize (speed 3) (space 0) (safety 0) (debug 0)
             (compilation-speed 0)))

  (let ((net
         (mk-net (netspec 3 2 2)
                 :runtime-weights t
                 :runtime-weights-state seed))
        (eta (the type-weight (coerce ieta 'type-weight))))
    (declare (type type-weight eta))
    (setf (layer-act-vec (svref net 0))
          (make-array 3 :element-type 'type-act
                      :initial-contents
                      (list (coerce 1.0 'type-act)
                            (coerce 1.0 'type-act)
                            (coerce 0.6 'type-act))))

    (activation-fn (netspec 3 2 2)
                   net)
    (format t "After activation~%")
    (write-net net)
    (backprop-fn (netspec 3 2 2)
                 net
                 (make-array 2
                             :element-type 'type-act
                             :initial-contents (list (coerce 1.0 'type-act)
                                                     (coerce 0.0 'type-act))))
    (adjust-weights (netspec 3 2 2)
                    net :eta eta)
    (format t "After BPROP+ADJUST-WEIGHTS~%")
    (write-net net)
    (activation-fn (netspec 3 2 2)
                   net)
    (format t "After another activation~%")
    (write-net net)))

|#




(defmacro beta (layer-specs net &key (variant :polak-ribiere)
				     zero-beta-save-derivs)
  "Builds a function to calculate the beta value used for conjugate
gradient updates. The varient can be specified as :polak-ribiere,
:fletcher-reeves or :hestenes-steifel.

If zero-beta-save-derivs is true, a function is built which
returns zero, and saves the current de-by-dws to the
previous-de-by-dw vector"
  ;;; Formula:
  ;;;
  ;;; current . (current-prev) / (current . current)
  ;;;
  ;;; IDEA:
  ;;;
  ;;; Create sums for divident and divisor "in parallel", then divide
  ;;;
  ;;; assume arrays to be declared
  ;;;
  (declare (optimize (speed 1) (space 1) (safety 1) (debug 0)
		     (compilation-speed 0)))
  (let* ((num-layers (car (array-dimensions layer-specs)))

	 (layers (make-array
		  num-layers
		  :initial-contents
		  (cons nil
			(list-of-n (1- num-layers)
				   (gensym "layers-")))))

	 (de-by-dws (make-array
		     num-layers
		     :initial-contents
		     (cons nil
			   (list-of-n (1- num-layers)
				      (gensym "de-by-dws-")))))
	 (previous-de-by-dws (make-array
			      num-layers
			      :initial-contents
			      (cons nil
				    (list-of-n (1- num-layers)
					       (gensym "previous-de-by-dws")))))

	 (row-major-index (gensym "row-major-index-"))

	 (divident (gensym "divident-"))
	 (divisor (gensym "divisor-"))
	 (current (gensym "current-"))
	 (previous (gensym "previous-"))
	 (previous-layer-neuron-count (gensym "previous-layer-neuron-count-"))
	 (current-layer-neuron-count (gensym "current-layer-neuron-count-")))
    (if (not (or (eq variant :polak-ribiere)
		 (eq variant :fletcher-reeves)
 		 (eq variant :hestenes-steifel)))
	(error "macro beta: Unknown variant ~A !~%" variant))
    `(the type-de-by-dw
       (let* (,@(if (not zero-beta-save-derivs)
		    `((,divident (the type-de-by-dw ,(coerce 0.0 'type-de-by-dw)))
		      (,divisor (the type-de-by-dw ,(coerce 0.0 'type-de-by-dw)))
		      (,current (the type-de-by-dw ,(coerce 0.0 'type-de-by-dw)))
		      (,previous (the type-de-by-dw ,(coerce 0.0 'type-de-by-dw)))))

	      ,@(if *prefer-row-major-aref*
		    `((,row-major-index 0)))

	      ;; make assignments for layers
	      ,@(mapcan
	       #'(lambda (layer-num)
		   ;; counting 1.. - weights only in non-input-layers
		   `(
		     (,(svref layers layer-num) (svref ,net ,layer-num))
		     (,(svref de-by-dws layer-num) (layer-de-by-dw-vec ,(svref layers layer-num)))
		     (,(svref previous-de-by-dws layer-num)
		      (layer-previous-de-by-dw-vec ,(svref layers layer-num)))))
	       (fromto 1 (1- num-layers))))
	 ;; declarations
	 (declare
	  ,@(if *prefer-row-major-aref*
		`((type fixnum ,row-major-index)))

	  ,@(if (not zero-beta-save-derivs)
		`((type type-de-by-dw ,divident ,divisor ,current ,previous)))
	  ;;		(:explain :calls :types :boxing)
	  ,@(mapcan
	     #'(lambda (layer-num)
		 (let ((spec-current-layer-size
			(layer-spec-size (svref layer-specs layer-num)))
		       (spec-previous-layer-size
			(layer-spec-size (svref layer-specs (1- layer-num)))))
		   `(
		     (type
		      (simple-array type-de-by-dw
				    (,spec-current-layer-size
				     ,(1+ spec-previous-layer-size)))
		      ,(svref de-by-dws layer-num))
		     (type
		      (simple-array type-de-by-dw
				    (,spec-current-layer-size
				     ,(1+ spec-previous-layer-size)))
		      ,(svref previous-de-by-dws layer-num)))))
	     (fromto 1 (1- num-layers))))
	 ;; NOW THE PROGRAMME
	 ,@(mapcan
	    #'(lambda (layer) ;; 1..
		(let ((spec-current-layer-size
		       (layer-spec-size (svref layer-specs layer)))
		      (spec-previous-layer-size
		       (layer-spec-size (svref layer-specs (1- layer)))))
		  `(
		    ,@(if *prefer-row-major-aref*
			  `((setq ,row-major-index 0)))

		    (dotimes (,current-layer-neuron-count
				 ,spec-current-layer-size)
		      ;; don't forget the bias-weight - 1+ !
		      ;; (dotimes (,previous-layer-neuron-count
		      ;;		,(1+ spec-previous-layer-size))
		      (simple-dotimes-unroll
		       (,previous-layer-neuron-count
			,(1+ spec-previous-layer-size))
		       ,@(if (not zero-beta-save-derivs)
			     `((setq ,current ,(if *prefer-row-major-aref*
						   ;; prefer row major
						   `(row-major-aref ,(svref de-by-dws layer)
								    ,row-major-index)
						 ;; prefer aref
						 `(aref ,(svref de-by-dws layer)
							,current-layer-neuron-count
							,previous-layer-neuron-count))
				     ,previous ,(if *prefer-row-major-aref*
						    ;; prefer row major
						    `(row-major-aref ,(svref previous-de-by-dws layer)
								     ,row-major-index)
						  ;; prefer aref
						  `(aref ,(svref previous-de-by-dws layer)
							 ,current-layer-neuron-count
							 ,previous-layer-neuron-count))
				     ,divident (+ ,divident
						  ,(ecase variant
						     ;; hestenes and steifel
						     (:hestenes-steifel
						      `(* (- ,current ,previous)
							  ,current))
						     ;; fletcher and reeves
						     (:fletcher-reeves
						      `(* ,current ,current))
						     ;; polak and ribiere
						     (:polak-ribiere
						      `(* ,current
							  (- ,current ,previous)))))
				     ,divisor (+ ,divisor
						 ,(ecase variant
						    ;; hestenes and steifel
						    (:hestenes-steifel
						     `(* (- ,current ,previous)
							 (the type-de-by-dw
							   (aref
							    (layer-previous-update-vec
							     (svref ,net ,layer))
							    ,current-layer-neuron-count
							    ,previous-layer-neuron-count))))
						    ;; fletcher and reeves
						    (:fletcher-reeves
						     `(* ,previous ,previous))
						    ;; polak and ribiere
						    (:polak-ribiere
						     `(* ,previous ,previous)))))
			       ,@(if *nile-debug*
				     `((format t "beta: layer ~a cur ~a prev ~a -> curval ~a prevval ~a divident ~a divisor ~a~%"
					       ,layer ,current-layer-neuron-count
					       ,previous-layer-neuron-count
					       ,current
					       ,previous
					       ,divident
					       ,divisor)))
			       (setf
				   ,(if *prefer-row-major-aref*
					;; prefer row major
					`(row-major-aref ,(svref previous-de-by-dws layer)
							 ,row-major-index)
				      ;; prefer aref
				      `(aref ,(svref previous-de-by-dws layer)
					     ,current-layer-neuron-count
					     ,previous-layer-neuron-count))
				 ,current))
			   ;; ELSE (if (not zero-beta-save-derivs))
			   ;; now save into previous
			   `((setf
				 ,(if *prefer-row-major-aref*
				      ;; prefer row major
				      `(row-major-aref ,(svref previous-de-by-dws layer)
						       ,row-major-index)
				    ;; prefer aref
				    `(aref ,(svref previous-de-by-dws layer)
					   ,current-layer-neuron-count
					   ,previous-layer-neuron-count))
			       ,(if *prefer-row-major-aref*
				    ;; prefer row major
				    `(row-major-aref ,(svref de-by-dws layer)
						     ,row-major-index)
				  ;; prefer aref
				  `(aref ,(svref de-by-dws layer)
					 ,current-layer-neuron-count
					 ,previous-layer-neuron-count)))))
		       ,@(if *prefer-row-major-aref*
			     `((incf ,row-major-index))))))))
	    (fromto 1 (1- num-layers)))
	 ,(if (not zero-beta-save-derivs)
	      `(if (= ,(coerce 0.0d0 'type-de-by-dw) ,divisor)
		   ,(coerce 0.0d0 'type-de-by-dw)
		 (/ ,divident ,divisor))
	    (the type-de-by-dw (coerce 0.0 'type-de-by-dw)))))))

#|

(defun test-beta ()
  (declare
   ;;(:explain :calls :types :boxing)
   (optimize (speed 3) (space 0) (safety 0) (debug 0)
             (compilation-speed 0)))

  (let ((net
         (mk-net (netspec 3 2 2)))
        (bp-dest (make-array 2
                             :element-type 'type-act
                             :initial-contents (list (coerce 1.0 'type-act)
                                                     (coerce 0.0 'type-act)))))
    (declare (type (simple-array type-act (2)) bp-dest))

    (activation-fn (netspec 3 2 2) net)
    (backprop-fn (netspec 3 2 2) net
                 bp-dest)
    (beta #.(net-spec-layer-specs (netspec 3 2 2))
          net
          :zero-beta-save-derivs t)

    ;;    (time
    (dotimes (la 10000)
      (beta #.(net-spec-layer-specs (netspec 3 2 2))
            net)
      (beta #.(net-spec-layer-specs (netspec 3 2 2))
            net
            :zero-beta-save-derivs t)
      nil)))                            ;)

(defun test-beta-nopt (seed)
  (declare
   ;;(:explain :calls :types :boxing)
   ;;   (optimize (speed 3) (space 0) (safety 0) (debug 0)
   ;;	     (compilation-speed 0))
   )

  (let ((net
         (mk-net (netspec 3 2 2)
                 :runtime-weights t
                 :runtime-weights-state seed))
        (beta 0.0)
        (eta (the type-weight (coerce 1 'type-weight))))
    (declare (type type-weight eta))
    (setf (layer-act-vec (svref net 0))
          (make-array 3 :element-type 'type-act
                      :initial-contents
                      (list (coerce 1.0 'type-act)
                            (coerce 1.0 'type-act)
                            (coerce 0.6 'type-act))))

    (activation-fn (netspec 3 2 2) net)
    (backprop-fn (netspec 3 2 2) net
                 (vector 7.0 4.3))
    (setq beta (beta #.(net-spec-layer-specs (netspec 3 2 2))
                     net
                     :zero-beta-save-derivs t))
    (adjust-weights (netspec 3 2 2)
                    net :eta eta
                    :save-update t)
    (activation-fn (netspec 3 2 2) net)
    (backprop-fn (netspec 3 2 2) net
                 (vector 7.0 4.3))

    (format t "beta is ~a~%" beta)
    (write-net net)

    (setq beta (beta #.(net-spec-layer-specs (netspec 3 2 2))
                     net))

    (format t "beta is ~a~%" beta)
    (write-net net)))

(defun test-beta-opt (seed)
  (declare
   ;;(:explain :calls :types :boxing)
   (optimize (speed 3) (space 0) (safety 0) (debug 0)
             (compilation-speed 0))
   )

  (let ((net
         (mk-net (netspec 3 2 2)
                 :runtime-weights t
                 :runtime-weights-state seed))
        (beta 0.0)
        (eta (the type-weight (coerce 1 'type-weight))))
    (declare (type type-weight eta))
    (setf (layer-act-vec (svref net 0))
          (make-array 3 :element-type 'type-act
                      :initial-contents
                      (list (coerce 1.0 'type-act)
                            (coerce 1.0 'type-act)
                            (coerce 0.6 'type-act))))

    (activation-fn (netspec 3 2 2) net)
    (backprop-fn (netspec 3 2 2) net
                 (vector 7.0 4.3))
    (setq beta (beta #.(net-spec-layer-specs (netspec 3 2 2))
                     net
                     :zero-beta-save-derivs t))
    (adjust-weights (netspec 3 2 2)
                    net :eta eta
                    :save-update t)
    (activation-fn (netspec 3 2 2) net)
    (backprop-fn (netspec 3 2 2) net
                 (vector 7.0 4.3))

    (format t "beta is ~a~%" beta)
    (write-net net)

    (setq beta (beta #.(net-spec-layer-specs (netspec 3 2 2))
                     net))

    (format t "beta is ~a~%" beta)
    (write-net net)))


(let ((x 0.0))
  (defun delta-testerr (upd)
    (incf x upd)
    (* (+ x 3)
       (+ x 3)
       (- x 7)))
  (defun delta-reseterr ()
    (setf x 0.0)
    (* 9 (- 7))))


;;(defun abs-testerr (x)
;;  (declare (ftype (function (single-float) single-float) abs-testerr)
;;	   (single-float x)
;;	   (optimize speed)
;;	   (:explain :calls :types :boxing))
;; (* (+ x 3)
;;     (+ x 3)
;;     (- x 7)))

|#



;;
;; Eval-fn must take one (more) argument, a factor with that to
;; update the weights and must return an error measure
;;
;; Keyword-arg update: Either diff : Argument to eval-fn is
;;                                    differential OR
;;                            abs  : Is absolute from initial point
;;
;; First two updates are both eta
;;
;; AS IN: Hagan, Demuth, Beale "Neural Network Design"
;;        p12-16

(defmacro interval-location (initial-err eval-fn eta
			     &key (update 'diff)
				  (zero-error (* 100 single-float-epsilon))
				  (maximum (coerce 10.0d5 'type-weight))
				  ;; values-in is a list
				  ;; LEFT LEFT-ERR RIGHT RIGHT-ERR
				  values-in)
  "Interval location for CG-linesearches. See source for more documentation"
  (declare (optimize (speed 1) (space 1) (safety 1) (debug 0)
		     (compilation-speed 0)))
  (let ((prev-a (gensym "prev-a-"))
	(prev-a-err (gensym "prev-a-err-"))
	(a (gensym "a-"))
	(b (gensym "b-"))
	(diff (gensym "diff-"))
	(a-err (gensym "a-err-"))
	(b-err (gensym "b-err-")))
    (if (not (or (eq update 'diff)
		 (eq update 'abs)))
	(error (format nil "Macro interval-location: Wrong update-method ~A" update)))
    `(do* ((,prev-a ,(coerce 0.0 'type-weight) ,a)
	   (,prev-a-err ,initial-err ,a-err)
	   (,a ,(coerce 0.0 'type-weight) ,b)
	   (,b ,eta (+ ,b ,diff))
	   (,a-err ,initial-err ,b-err)
	   ,(if (eq update 'diff)
		`(,b-err (,@eval-fn ,eta) (,@eval-fn ,diff))
	      `(,b-err (,@eval-fn ,eta) (,@eval-fn ,b)))
	   (,diff ,eta (* ,(coerce 2 'type-weight) ,diff)))

	 ((or (> ,b-err ,a-err)		; either error increases
	      (< ,b-err ,zero-error )	; or zero error
	      (>= ,b ,(coerce maximum 'type-weight))) ; or reached max number
	  ,@(if values-in
		(list (cons 'setq
			    (mapcan #'(lambda (i v)
					(list i v))
				    values-in (list prev-a prev-a-err
						    b b-err)))
		      nil)
	      `((values ,prev-a ,prev-a-err ,b ,b-err))))
       (declare (type type-weight ,prev-a ,a ,b ,diff)
		(type type-act ,a-err ,b-err ,prev-a-err))
       ,@(if *nile-debug-intloc*
	     `((format t "a: ~A  b: ~A  a-err: ~A  b-err: ~A  diff: ~A~%"
		       ,a ,b ,a-err ,b-err ,diff)))
       )))

#|
(defmacro abs-testerr (x)
  `(* (+ ,x 3)
      (+ ,x 3)
      (- ,x 7)))

;;(defun test-intloc (eta)
;;  (interval-location (reseterr) (testerr) eta))

(defun test-intloc (ieta)
  (declare (optimize speed))
  (let ((left 0.0)
        (right 0.0)
        (eta (the type-weight (coerce ieta 'type-weight))))
    (declare (single-float left right)
             (:explain :calls :types :boxing)
             (type type-weight eta))
    (interval-location (abs-testerr 0.0) (abs-testerr) eta
                       :values-in (left right)
                       :update abs)
    (format t "~a ~a~%" left right)
    ))
|#
;; #|

;;;; THE PROBLEM WITH THIS GOLDEN SECTION SEARCH:
;;;;
;;;; If the minimum is in fact the starting point, IOW if every update in
;;;; the chosen direction would INCREASE the error, this funciton will
;;;; never find the true minimum

;;
;; Eval-fn as in interval-location
;;
;;
(defmacro golden-section-search (a-in a-err-in b-in b-err-in eval-fn itol)
  "Performs golden-section-search in an interval a-in b-in.
Used for CG-linesearches. See source for more documentation"
  (declare (optimize (speed 1) (space 1) (safety 1) (debug 0)
                     (compilation-speed 0)))
  ;; a and b are left and right limit of interval
  (let (
        ;;(tau 0.618)
        (omtau (coerce 0.382d0 'type-weight))
        (tiny (coerce 1.0d-10 'type-weight))
        (c (gensym "c-"))
        (d (gensym "d-"))
        (upd (gensym "upd-"))
        (c-err (gensym "c-err-"))
        (d-err (gensym "d-err-"))
        (a-err (gensym "a-err-"))
        (b-err (gensym "b-err-"))
        (tol (gensym "tol-"))
        (a (gensym "a-"))
        (b (gensym "b-")))
    ;;    (write
    `(do* (
           ;; make tolerance proportional to larger number of bracketing
           ;; and add a small amount to make it positive just in case
           ;; anything becomes zero
           (,a ,a-in)
           (,b ,b-in)
           (,tol (+ (* ,itol ,b) ,tiny))
           (,a-err ,a-err-in)
           (,b-err ,b-err-in)
           (,upd (* ,omtau
                    (- ,b ,a)))
           (,c (+ ,a ,upd))
           (,d (- ,b ,upd))
           (,c-err (,@eval-fn ,c))
           (,d-err (,@eval-fn ,d)))
          ((or (< (- ,b ,a) ,tol)
               (< (abs (- ,d-err ,c-err)) ,tiny))
           (prog2
               ;; now either a-err or b-err should be smaller
               ;; than a-err-in or b-err-in
               (if (< (min ,a-err ,b-err) (min ,a-err-in ,b-err-in))
                   ;; we acutually found a better bracketing
                   (setq ,a-in ,a
                         ,b-in ,b)
                   (if (< ,a-err-in ,b-err-in)
                       (setq ,b-in ,a-in)
                       (setq ,a-in ,b-in)))
               nil))
       (declare (type type-act ,a-err ,b-err ,c-err ,d-err)
                (type type-weight ,a ,b ,c ,d ,upd ,tol))
       ,@(if *nile-debug-intloc*
             `((format t "a: ~A  b: ~A  c: ~A  d: ~A c-err: ~A  d-err: ~A~%"
                       ,a ,b ,c ,d ,c-err ,d-err)))

       (if (< ,c-err ,d-err)
           (setq ,b ,d
                 ,b-err ,d-err
                 ,d ,c
                 ,c (+ ,a (* ,omtau (- ,b ,a)))
                 ,d-err ,c-err
                 ,c-err (,@eval-fn ,c))
           (setq ,a ,c
                 ,a-err ,c-err
                 ,c ,d
                 ,d (- ,b (* ,omtau (- ,b ,a)))
                 ,c-err ,d-err
                 ,d-err (,@eval-fn ,d))))
    ;;    )
    ))

#|

(defun test-gss (ieta itol)
  (declare (optimize speed))
  (let ((left (the type-weight (coerce 0.0d0 'type-weight)))
        (right (the type-weight (coerce 0.0d0 'type-weight)))
        (eta (the type-weight (coerce ieta 'type-weight)))
        (tol (the type-weight (coerce itol 'type-weight))))
    (declare (:explain :calls :types :boxing)
             (type-weight eta tol left right))
    (interval-location (abs-testerr 0.0) (abs-testerr) eta
                       :values-in (left right)
                       :update abs)
    (golden-section-search left right (abs-testerr) tol
                           :own-variables nil)
    (format t "~a ~a~%" left right)
    ))

|#

;;; #|

(defmacro timessign (signer number)
  "returns (* (signof signer) number)"
  `(if (< ,signer 0)
       (- ,number)
       ,number))



(defmacro pattern-iterator (netspec-form net
                            input-patterns
                            dest-patterns
                            numpatterns
                            &key (batch t)
                            ;; what standard operations to do
                            (do-activate t)
                            do-backprop
                            do-calc-error
                            ;; externally provided code
                            ext-code-inject
                            ext-code-activate
                            ext-code-backprop
                            ext-code-calc-error
                            ;; externally provided functions
                            ;; for standard operators
                            ext-func-activate
                            ext-func-backprop
                            ;; code to plug in
                            code-pre-inject
                            code-pre-activate
                            code-pre-backprop
                            code-pre-calc-error
                            code-post
                            code-non-batch
                            ;; how to call variables
                            var-name-pattern-num
                            var-name-current-input-pattern
                            var-name-current-dest-pattern
                            ;; externally defined variables
                            var-input-layer
                            var-output-layer-act
                            var-error)
  "Iterates though a set of input/output patterns,
activates, backprops, etc"
  (declare (optimize (speed 1) (space 1) (safety 1) (debug 0)
                     (compilation-speed 0)))
  ;; check arguments
  (if do-activate
      (if (and ext-code-activate ext-func-activate)
          (warn "pattern-iterator: both ext-code-activate and ext-func-activate given, latter ignored"))
      (cond
        (ext-code-activate
         (warn "pattern-iterator: (not do-activate) but ext-code-activate given"))
        (ext-func-activate
         (warn "pattern-iterator: (not do-activate) but ext-func-activate given"))))
  (if do-backprop
      (if (and ext-code-backprop ext-func-backprop)
          (warn "pattern-iterator: both ext-code-backprop and ext-func-backprop given, latter ignored"))
      (cond
        (ext-code-backprop
         (warn "pattern-iterator: (not do-backprop) but ext-code-backprop given"))
        (ext-func-backprop
         (warn "pattern-iterator: (not do-backprop) but ext-func-backprop given"))))
  (if (not do-calc-error)
      (cond
        (ext-code-calc-error
         (warn "pattern-iterator: (not do-calc-error) but ext-code-calc-error given"))))

  (let* ((netspec (eval netspec-form))
         (layer-specs (net-spec-layer-specs netspec))
         (num-layers (array-dimension layer-specs 0))

         ;; variables needed
         (input-layer (or var-input-layer
                          (gensym "pi-input-layer-")))
         (output-layer-act (or var-output-layer-act
                               (gensym "pi-output-layer-act-")))
         (error (or var-error
                    (gensym "pi-error-")))

         ;; local vars in inner loop
         (pattern-num (or var-name-pattern-num
                          (gensym "pi-pattern-num-")))
         (current-input-pattern (or var-name-current-input-pattern
                                    (gensym "pi-current-input-pattern-")))
         (current-dest-pattern (or var-name-current-dest-pattern
                                   (gensym "pi-current-dest-pattern-")))

         ;; what functions to define locally
         (need-loc-func-activate (and do-activate
                                      (not (or ext-code-activate
                                               ext-func-activate))))
         (loc-func-activate (if need-loc-func-activate
                                (gensym "pi-loc-func-activate-")))
         (need-loc-func-backprop (and do-backprop
                                      (not (or ext-code-backprop
                                               ext-func-backprop))))
         (loc-func-backprop (if need-loc-func-backprop
                                (gensym "pi-loc-func-backprop-")))

         ;; code segments
         (code-inject (or ext-code-inject
                          `((setf (layer-act-vec ,input-layer)
                                  ,current-input-pattern))))
         (code-activate (and do-activate
                             (or ext-code-activate
                                 (and ext-func-activate
                                      `((,ext-func-activate)))
                                 `((,loc-func-activate)))))
         (code-backprop (and do-backprop
                             (or ext-code-backprop
                                 (and ext-func-backprop
                                      `((,ext-func-backprop ,current-dest-pattern)))
                                 `((,loc-func-backprop ,current-dest-pattern)))))
         (code-calc-error (and do-calc-error
                               (or ext-code-calc-error
                                   (let ((this-pat-error (gensym "this-pat-error-")))
                                     `((let ((,this-pat-error (sum-squares-error
                                                               ,output-layer-act
                                                               ,current-dest-pattern
                                                               ,(layer-spec-size
                                                                 (svref layer-specs
                                                                        (1- num-layers))))))
                                         (declare (type type-act ,this-pat-error))
                                         ,(if batch
                                              `(setq ,error
                                                     (the type-act
                                                       (+ (the type-act ,error)
                                                          (the type-act ,this-pat-error))))
                                              `(setq ,error ,this-pat-error))
                                         nil)))))))
    (possibly-do-flet
     ;; flets go here
     `(
       ,@(if need-loc-func-activate
             `((,loc-func-activate
                ()
                (declare
                 (optimize (speed 3) (space 0) (safety 0) (debug 0)
                           (compilation-speed 0)))
                (activation-fn ',netspec ,net))))
       ,@(if need-loc-func-backprop
             `((,loc-func-backprop
                (dest)
                (declare
                 (optimize (speed 3) (space 0) (safety 0) (debug 0)
                           (compilation-speed 0))
                 (type (simple-array type-act
                                     (,(layer-spec-size
                                        (svref layer-specs (1- num-layers)))))
                       dest))
                (backprop-fn ',netspec ,net dest)))))
     ;; declarations go here
     `(declare
       ,@(if need-loc-func-activate
             `((ftype (function () nil)
                      ,loc-func-activate)))
       ,@(if need-loc-func-backprop
             `((ftype (function ((simple-array type-act
                                               (,(layer-spec-size
                                                  (svref layer-specs
                                                         (1- num-layers))))))
                                nil)
                      ,loc-func-backprop))))
     ;; body of flet
     (possibly-do-let
      `(,@(if (not var-input-layer)
              `((,input-layer (svref ,net 0))))
          ,@(if (and do-calc-error (not var-output-layer-act))
                `((,output-layer-act (layer-act-vec (svref ,net ,(1- num-layers))))))
          ,@(if (and do-calc-error (not var-error))
                `((,error ,(coerce 0.0d0 'type-act)))))
      `(declare ,@(if (not var-input-layer)
                      `((type layer ,input-layer)))
                ,@(if (and do-calc-error (not var-output-layer-act))
                      `((type (simple-array type-act
                                            (,(layer-spec-size
                                               (svref layer-specs (1- num-layers)))))
                              ,output-layer-act)))
                ,@(if (and do-calc-error (not var-error))
                      `((type type-act ,error))))
      ;; Using n-random-integers here is highly inefficient and
      ;; causes a lot consing... Online training is generally depreciated,
      ;; but this was the easiest way to do it.
      `(,@(if batch
              `(dotimes (,pattern-num ,numpatterns))
              `(dolist (,pattern-num (n-random-integers ,numpatterns ,numpatterns))))
          (declare (fixnum ,pattern-num))
          ,@(if *debug-iters*
                `((format t "PI pattern ~a~%" ,pattern-num)))
          (let ((,current-input-pattern
                 (svref ,input-patterns ,pattern-num))
                (,current-dest-pattern
                 (svref ,dest-patterns ,pattern-num)))
            (declare
             ;;	    (:explain :variables :calls :types :boxing)
             (type
              (simple-array type-act
                            (,(layer-spec-size
                               (svref layer-specs 0))))
              ,current-input-pattern)
             (type
              (simple-array type-act
                            (,(layer-spec-size
                               (svref layer-specs (1- num-layers)))))
              ,current-dest-pattern)
             (ignorable ,current-dest-pattern))

            ,@code-pre-inject
            ,@code-inject
            ,@code-pre-activate
            ,@code-activate
            ,@code-pre-backprop
            ,@code-backprop
            ,@code-pre-calc-error
            ,@code-calc-error
            ,@code-post
            ,@(if (not batch)
                  code-non-batch)))
      ;; return error
      (if (and (not var-error)
               do-calc-error)
          error)))))

(defmacro cycle-iterator (netspec-form net
                          &key (batch t)
                          ;; maximum amount of cycles
                          (max-cycles 100)
                          ;; error limit
                          (error-lim (coerce 0.01d0 'type-act))

                          ;; if to do proprietary local minimum detection
                          proprietary-detect-locmin
                          ;; amout that to kick when local minimum detected
                          (proprietary-detect-locmin-kick (coerce 2.0d0 'type-weight))
                          ;; factor to calculate locmin-measure
                          (proprietary-detect-locmin-x-error-factor (coerce 0.0001d0
                                                                            'type-act))
                          ;; code to plug in
                          ;; usually clear-de-by-dws and
                          ;; act-n-bprop
                          code-setup
                          ;; --- start loop
                          code-pre-batch
                          code-batch    ; usually update-function
                          code-post-batch
                          code-act-n-bprop ; pre-write-error usually act'n'backprop
                          ;; --- end loop
                          code-cleanup             ; after loop
                          ;; when just kicked, usually set a cg-counter-variable
                          code-just-kicked
                          ;; how to call variables
                          var-name-train-cycle-count
                          var-name-x-cycle-error
                          var-name-just-kicked
                          var-name-x-error-lim
                          var-name-x-diff
                          var-name-imax-cycles
                          var-name-ierror-lim
                          ;; externally defined variables
                          var-error

                          ;; standard writers
                          write-error-every
                          write-net-every)
  "Iterates through training-cycles"
  (declare (optimize (speed 1) (space 1) (safety 1) (debug 0)
                     (compilation-speed 0)))

  (let* ((netspec (eval netspec-form))
         ;;	 (layer-specs (net-spec-layer-specs netspec))
         ;;	 (num-layers (array-dimension layer-specs 0))

         ;; local variables needed
         ;; in do
         (train-cycle-count (or var-name-train-cycle-count
                                (gensym "ci-train-cycle-count-")))
         ;; only for licmin-detector
         (x-cycle-error (if proprietary-detect-locmin
                            (or var-name-x-cycle-error
                                (gensym "ci-x-cycle-error-"))))
         (just-kicked (if proprietary-detect-locmin
                          (or var-name-just-kicked
                              (gensym "ci-just-kicked-"))))
         (x-error-lim (if proprietary-detect-locmin
                          (or var-name-x-error-lim
                              (gensym "ci-x-error-lim-"))))
         (x-diff (if proprietary-detect-locmin
                     (or var-name-x-diff
                         (gensym "ci-x-diff-"))))
         ;; in outer let
         (imax-cycles (if max-cycles
                          (or var-name-imax-cycles
                              (gensym "ci-imax-cycles-"))))
         (ierror-lim (or var-name-ierror-lim
                         (gensym "ci-ierror-lim-")))

         ;; possibly externally defined variables
         (error (or var-error
                    (gensym "ci-error-")))

         ;; writers
         (write-error-every-next (if write-error-every
                                     (gensym "ci-write-error-every-next-")))
         (write-net-every-next (if write-net-every
                                   (gensym "ci-write-net-every-next-"))))

    `(let ((,ierror-lim ,error-lim)
           ,@(if max-cycles
                 `((,imax-cycles ,max-cycles)))
           ,@(if (not var-error)
                 `((,error ,(coerce 0.0d0 'type-act))))
           ,@(if write-error-every
                 `((,write-error-every-next
                    (if (= ,write-error-every 0)
                        -1
                        0))))
           ,@(if write-net-every
                 `((,write-net-every-next
                    (if (= ,write-net-every 0)
                        -1
                        0)))))
       (declare (type type-act ,ierror-lim)
                ,@(if max-cycles
                      `((fixnum ,imax-cycles)))
                ,@(if (not var-error)
                      `((type type-act ,error)))
                ,@(if write-error-every
                      `((fixnum ,write-error-every-next)))
                ,@(if write-net-every
                      `((fixnum ,write-net-every-next))))
       ,@(if var-error
             `((setq ,error ,(coerce 0.0d0 'type-act))))
       
       ,@code-setup
       
       (do ((,train-cycle-count 0 (+ ,train-cycle-count 1))
            ,@(if proprietary-detect-locmin
                  `((,x-cycle-error (* ,error ,(coerce 1.4d0 'type-act))
                                    (/ (+ ,x-cycle-error
                                          ,error)
                                       2))
                    (,just-kicked nil)
                    ;; the cross-cycle error lim factor
                    (,x-error-lim (* ,ierror-lim
                                     ,proprietary-detect-locmin-x-error-factor))
                    (,x-diff ,(coerce 0.0d0 'type-act)))))
           ,(if max-cycles
                `((>= ,train-cycle-count ,imax-cycles) ,(if (not var-error)
                                                            error))
                '(nil))
         ;; BODY OF DO-LOOP
         (declare (fixnum ,train-cycle-count)
                  ,@(if proprietary-detect-locmin
                        `((type type-act ,x-cycle-error ,x-diff ,x-error-lim)
                          (type boolean ,just-kicked))))
         ,@(if *debug-iters*
               `((format t "CI cycle ~a~%" ,train-cycle-count)))

         ;; DO: 
         ;;  set error 0.0
         ;;  act-n-bprop
         ;;  write
         ;;  check error
         ;;  pre-batch
         ;;  batch
         ;;  post-batch
         ;;  locmin
	 
         (setq ,error ,(coerce 0.0d0 'type-act))
         ,@code-act-n-bprop

         ;; if necessary write
         ,@(if write-error-every
               `((if (and ,write-error-every
                          (= ,train-cycle-count ,write-error-every-next))
                     (progn (format t "Error of cycle ~A : ~A~%"
                                    ,train-cycle-count ,error)
                            (setq ,write-error-every-next
                                  (+ ,train-cycle-count ,write-error-every))))))
         ,@(if write-net-every
               `((if (and ,write-net-every
                          (= ,train-cycle-count ,write-net-every-next))
                     (progn (format t "Net of cycle ~A~%" ,train-cycle-count)
                            (write-net ,net)
                            (setq ,write-net-every-next
                                  (+ ,train-cycle-count ,write-net-every))))))
	 
         (if (< ,error ,ierror-lim)
             ,(if (not var-error)
                  `(return ,error)
                  '(return)))

         ,@code-pre-batch
         ,@(if batch
               code-batch)
         ,@code-post-batch
         ,@(if proprietary-detect-locmin
               `( ;; x-diff is positive if error decreasing
                 (setq ,x-diff (- ,x-cycle-error ,error))
                 ;;		 (format t "~%error ~a x-cycle-error ~a  - diff ~a - measure ~a~%"
                 ;;			 ,error ,x-cycle-error ,x-diff
                 ;;			 (* ,x-error-lim ,error))
                 (if ,just-kicked
                     ;;		     (progn
                     ;;		       (format t "Just kicked - setting x-cycle-error to ~a~%"
                     ;;			       (* ,error 1.4))
                     (setq ,x-cycle-error (* ,error ,(coerce 1.4d0 'type-act))
                           ,just-kicked nil)
                     ;;)
                     (if (and (> ,x-diff 0)
                              (< ,x-diff ; positive if error decreasing
                                 (* ,x-error-lim ,error)))
                         (progn
                           ,@(if write-error-every
                                 `((format t "Locmin-detect: Kicking ~A !~%"
                                           ,proprietary-detect-locmin-kick)))
                           (setq ,just-kicked t)
                           ,@code-just-kicked
                           (adjust-weights ',netspec ,net
                                           :kick-weights ,proprietary-detect-locmin-kick)))))))
       ;; outside loop
       ,@code-cleanup
       ;; return error if not provided
       ,(if (not var-error)
            error))))

;;;; Works like this:
;;;;
;;;; - If (not elman-net), then do nothing (no patterns to iterate over),
;;;; except setting current-input-pattern and using the inner code
;;;;
;;;; - Otherwise, loop the inner code for all steps, binding current-input-pattern
;;;; and next-input-pattern (if appropriate)

;;;; About elman-timebatch, improved-elman-step 
;;;;
;;;; Batches: The training macro implements a couple of batch training
;;;; 	 methods:
;;;;
;;;; 	  - Normal batch training (parameter 'batch')
;;;;
;;;; 	    This can be t or nil. If t, then normal batch training is
;;;; 	    done, which means that:
;;;;
;;;; 	    * dE/dW are summed up over all patterns
;;;; 	    * error is summed up over all patterns
;;;;
;;;; 	  - Elman time batch training
;;;;
;;;; 	    For Elamn nets, the above may also be summed up
;;;; 	    over all timesteps. Then iinput-patterns is a
;;;; 	    vector of n timesteps of the input pattern for
;;;; 	    each timestep. The context part of the input layer
;;;; 	    is then set to the hidden layer of the previous
;;;; 	    timestep for each element if iinput-patterns for
;;;; 	    >= 1.
;;;;

(defmacro step-iterator (netspec-form net
                         ;; the input patterns:
                         ;; if (not elman-net)
                         ;;     vector of <numpatterns> input-layers
                         ;; else
                         ;;     vector of <num-steps>
                         ;;      vectors of <numpatterns> input-layers
                         input-patterns
                         ;; vector of <numpatterns> output-layers
                         dest-patterns
                         numpatterns
                         &key elman-net
                         num-steps
                         ;; whether or not to actually do the timesteps
                         do-steps
                         ;; code to plug in
                         code
                         code-recurrent ; only for loop
                         code-final
                         ;; how to call variables
                         var-name-step-count
                         var-name-current-input-patterns
                         var-name-next-input-patterns
                         var-inum-steps
                         ;; when to write
                         write-notice-every)
  "Iterates through timesteps for elman networks"
  (declare (optimize (speed 1) (space 1) (safety 1) (debug 0)
                     (compilation-speed 0))
           (ignorable net dest-patterns))

  (if (and elman-net (not num-steps))
      (error "Step-iterator: When elman-net, num-steps has to be given"))

  (let* (
         (netspec (eval netspec-form))
         (layer-specs (net-spec-layer-specs netspec))
         ;; (num-layers (array-dimension layer-specs 0))

         ;; local variables needed
         ;; in do
         (step-count (or var-name-step-count
                         (gensym "si-var-step-count-")))
         (current-input-patterns (or var-name-current-input-patterns
                                     (gensym "si-current-input-patterns-")))
         (next-input-patterns (or var-name-next-input-patterns
                                  (gensym "si-next-input-patterns-")))
         (inum-steps (or var-inum-steps
                         (gensym "si-var-inum-steps-")))
         ;; writers
         (write-notice-every-next (if write-notice-every
                                      (gensym "si-write-notice-every-next-")))
         (writer-code `(
                        ,@(if write-notice-every
                              `((if (and ,write-notice-every
                                         (= ,step-count ,write-notice-every-next))
                                    (progn (format t "Step ~A:~%" ,step-count)
                                           (setq ,write-notice-every-next
                                                 (+ ,step-count ,write-notice-every)))))))))
    (if elman-net
        ;; IS AN ELMAN NET
        (if do-steps
            ;; WE WANT TO ITERATE THE STEPS NOW
            `(let ((,inum-steps ,num-steps)
                   ,@(if write-notice-every
                         `((,write-notice-every-next
                            (if (= ,write-notice-every 0)
                                -1
                                0)))))
               (declare (fixnum ,inum-steps)
                        ,@(if write-notice-every
                              `((fixnum ,write-notice-every-next))))
               (dotimes (,step-count (the fixnum
                                       (- ,inum-steps
                                          (the fixnum ,(coerce 1 'fixnum)))))
                 (declare (type fixnum ,step-count))
                 ,@(if *debug-iters*
                       `((format t "SI step ~a~%" ,step-count)))
                 (let ((,current-input-patterns
                        (svref ,input-patterns ,step-count))
                       (,next-input-patterns
                        (svref ,input-patterns (1+ ,step-count))))
                   (declare (type (simple-array
                                   (simple-array type-act
                                                 (,(layer-spec-size
                                                    (svref layer-specs 0))))
                                   ;; only if numpatterns is a number
                                   ;; at compile time can we make a
                                   ;; precise declaration here
                                   ,(if (numberp numpatterns)
                                        `(,numpatterns)
                                        '(*)))
                                  ,current-input-patterns
                                  ,next-input-patterns)
                            (ignorable ,next-input-patterns))
                   ;; if necessary write
                   ,@writer-code
                   ;;
                   ,@code
                   ,@code-recurrent))
               (let* ((,step-count (the fixnum
                                     (- ,inum-steps
                                        (the fixnum
                                          ,(coerce 1 'fixnum)))))
                      (,current-input-patterns
                       (svref ,input-patterns ,step-count)))
                 (declare (fixnum ,step-count)
                          (type (simple-array
                                 (simple-array type-act
                                               (,(layer-spec-size
                                                  (svref layer-specs 0))))
                                 ;; only if numpatterns is a number
                                 ;; at compile time can we make a
                                 ;; precise declaration here
                                 ,(if (numberp numpatterns)
                                      `(,numpatterns)
                                      '(*)))
                                ,current-input-patterns))
                 ,@(if *debug-iters*
                       `((format t "SI step ~a~%" ,step-count)))
                 ;; if necessary write
                 ,@writer-code
                 ;;
                 ,@code
                 ,@code-final))
            ;; IS AN ELMAN NET BUT NO STEPS - JUST AFFECTS DECLARATION OF
            ;; current-input-patterns
            `(let ((,current-input-patterns ,input-patterns))
               (declare (type (simple-array
                               (simple-array
                                (simple-array type-act
                                              (,(layer-spec-size
                                                 (svref layer-specs 0))))
                                ,(if (numberp numpatterns)
                                     `(,numpatterns)
                                     '(*)))
                               ,(if (numberp num-steps)
                                    `(,num-steps)
                                    '(*)))
                              ,current-input-patterns))
               ,@code))
        ;; CASE FOR NON ELMAN NET - DO NOTHING SPECIAL
        `(let ((,current-input-patterns ,input-patterns))
           (declare (type (simple-array
                           (simple-array type-act
                                         (,(layer-spec-size
                                            (svref layer-specs 0))))
                           ,(if (numberp numpatterns)
                                `(,numpatterns)
                                '(*)))
                          ,current-input-patterns))
           ,@code))))

(defmacro trainer (netspec-form net
                   ;; the input patterns:
                   ;; if (not elman-net)
                   ;;     vector of <numpatterns> input-layers
                   ;; else
                   ;;     vector of <num-steps>
                   ;;      vectors of <numpatterns> input-layers
                   input-patterns
                   ;; vector of <numpatterns> output-layers
                   dest-patterns
                   &key numpatterns ; number of patterns (of each time step)
                   elman-net                          ; t if elman net
                   num-steps      ; number of time steps to be trained
                   improved-elman           ; EXPERIMENTAL
                   ;;
                   (batch t)            ; if to do batch over patterns
                   timebatch           ; if to do batch over timesteps
                   ;;
                   (method :sd)                     ; :sd or :cg
                   sd-opts             ; options to pass to SD trainer
                   cg-opts             ; options to pass to CG trainer
                   ;;
                   max-cycles               ; maximum number of cycles
                   ;; and an error limit at which to stop
                   (error-lim (coerce 0.01d0 'type-act)) 
                   ;;
                   ;; opts for cycles (writers)
                   cycle-opts
                   ;; opts for steps (writers)
                   step-opts
                   ;;
                   ;; whether to write both the final error and the final
                   ;; net to *standard-output* (compatibility arg)
                   write-final  
                   write-final-error ; whether to write the final error
                   write-final-net    ; whether to write the final net
                   return-final-error ; whether to return the final error
                   ;;
                   ;; Local minima detection is EXPERIMENTAL
                   ;; if to do proprietary local minimum detection
                   proprietary-detect-locmin
                   ;; amout that to kick when local minimum detected
                   (proprietary-detect-locmin-kick (coerce 2.0d0 'type-weight))
                   ;; factor to calculate locmin-measure
                   (proprietary-detect-locmin-x-error-factor (coerce 0.0001d0
                                                                     'type-act))
                   ;; external-functions
                   ext-funcs)
  "Versatile macro to build training functions. See source for more documentation."
  (if write-final
      (setq write-final-error write-final
            write-final-net write-final))

  ;; external functions
  (destructuring-bind
        (&key ((:clear-de-by-dws ext-func-clear-de-by-dws))
              ((:std-activate ext-func-std-activate))
              ((:std-backprop ext-func-std-backprop))
              ((:copy-recurrent ext-func-copy-recurrent))
              ((:cg-zero-beta ext-func-cg-zero-beta))
              ((:cg-beta ext-func-cg-beta))
              ((:cg-make-cg-updates-with-beta ext-func-cg-make-cg-updates-with-beta))
              ((:cg-adjust-weights ext-func-cg-adjust-weights))
              ((:cg-final-adjust-weights ext-func-cg-final-adjust-weights))
              ((:sd-adjust-weights-and-clear-de-by-dws ext-func-sd-adjust-weights-and-clear-de-by-dws))
              ((:improved-elman-activate  ext-func-improved-elman-activate ))
              ;; ((:improved-elman-backprop  ext-func-improved-elman-backprop ))
              ((:get-weight-mean ext-func-get-weight-mean)))
      ext-funcs
    ;; sd options
    (destructuring-bind (&key ((:eta sd-opt-eta) (coerce 0.01d0 'type-act))
                              ((:momentum sd-opt-momentum)))
        sd-opts
      ;; cg options
      (destructuring-bind (&key
                           ;; how to save weights - set or copy
                           ((:save-weights-method
                             cg-opt-save-weights-method) :set)
                           ((:interval-location-maximum
                             cg-opt-interval-location-maximum) (coerce 10.0d5
                             'type-weight))
                           ;; eta for interval-location - TYPE-WEIGHT
                           ((:interval-location-eta
                             cg-opt-interval-location-eta) (coerce 0.3d0 'type-weight))
                           ;; tolerance for golden section - TYPE-WEIGHT
                           ((:gss-tol
                             cg-opt-gss-tol) (coerce 0.00001d0 'type-weight))
                           ((:max-cg-updates
                             cg-opt-max-cg-updates)))
          cg-opts


        
        ;; make numpatterns and num-steps gensyms which will be set
        ;; in highest let, if they are not given as numbers at
        ;; compile-time
        (if (not (numberp numpatterns))
            (setq numpatterns (gensym "tr-inumpatterns-")))
        (if (not (numberp num-steps))
            (setq num-steps (gensym "tr-inum-steps-")))

        (let (                         ;; to be set in next let
              ;; funcs
              need-func-clear-de-by-dws
              need-func-std-activate
              need-func-std-backprop
              need-func-copy-recurrent
              need-func-cg-zero-beta
              need-func-cg-beta
              need-func-cg-make-cg-updates-with-beta
              need-func-cg-adjust-weights
              need-func-cg-final-adjust-weights
              need-func-sd-adjust-weights-and-clear-de-by-dws
              need-func-improved-elman-activate
              ;; need-func-improved-elman-backprop
              need-func-get-weight-mean
              ;; vars
              need-var-input-layer
              need-var-output-layer-act
              need-var-cg-update-counter
              need-var-cg-numweights)

          (let* ((netspec (eval netspec-form))
                 (layer-specs (net-spec-layer-specs netspec))
                 (num-layers (array-dimension layer-specs 0))

                 (current-input-patterns
                  (gensym "tr-current-input-patterns-"))
                 (next-input-patterns
                  (gensym "tr-next-input-patterns-"))
                 (pattern-num
                  (gensym "tr-pattern-num-"))

                 (error (gensym "tr-error-"))

                 (iinput-patterns (gensym "tr-input-patterns-"))
                 (idest-patterns (gensym "tr-dest-patterns-"))

                 ;;
                 (var-name-step-count (gensym "tr-si-step-count-"))

                 ;; VVV variables (dynamically configured)
                 (var-input-layer (gensym "tr-input-layer-"))
                 (var-output-layer-act (gensym "tr-output-layer-act-"))
                 (var-cg-update-counter (gensym "tr-cg-update-counter-"))
                 (var-cg-numweights (gensym "tr-cg-numweights-"))
                 ;; ^^^ variables (dynamically configured)

                 ;; VVV cg-variables
                 (cg-ls-error (gensym "tr-cg-linesearch-error-"))
                 ;; ^^^ cg-variables

                 ;; VVV SD-variables
                 ;; ^^^ SD-variables

                 ;; VVV improved elman variables
                 (var-improved-elman-c (if (and elman-net improved-elman)
                                           (gensym "tr-improved-elman-c-")))
                 ;; ^^^ improved elman variables

                 ;; VVV function names
                 (loc-func-clear-de-by-dws (gensym "tr-func-clear-de-by-dws-"))
                 (func-clear-de-by-dws (or ext-func-clear-de-by-dws
                                           loc-func-clear-de-by-dws))
                 need-loc-func-clear-de-by-dws

                 (loc-func-std-activate (gensym "tr-func-std-activate-"))
                 (func-std-activate (or ext-func-std-activate
                                        loc-func-std-activate))
                 need-loc-func-std-activate

                 (loc-func-std-backprop (gensym "tr-func-std-backprop-"))
                 (func-std-backprop (or ext-func-std-backprop
                                        loc-func-std-backprop))
                 need-loc-func-std-backprop


                 (loc-func-copy-recurrent (gensym "tr-func-copy-recurrent-"))
                 (func-copy-recurrent (or ext-func-copy-recurrent
                                          loc-func-copy-recurrent))
                 need-loc-func-copy-recurrent

                 (loc-func-cg-zero-beta (gensym "tr-func-cg-zero-beta-"))
                 (func-cg-zero-beta (or ext-func-cg-zero-beta
                                        loc-func-cg-zero-beta))
                 need-loc-func-cg-zero-beta

                 (loc-func-cg-beta (gensym "tr-func-cg-beta-"))
                 (func-cg-beta (or ext-func-cg-beta
                                   loc-func-cg-beta))
                 need-loc-func-cg-beta

                 (loc-func-cg-make-cg-updates-with-beta (gensym "tr-func-cg-make-cg-updates-with-beta-"))
                 (func-cg-make-cg-updates-with-beta (or ext-func-cg-make-cg-updates-with-beta
                                                        loc-func-cg-make-cg-updates-with-beta))
                 need-loc-func-cg-make-cg-updates-with-beta

                 (loc-func-cg-final-adjust-weights (gensym "tr-func-cg-final-adjust-weights-"))
                 (func-cg-final-adjust-weights (or ext-func-cg-final-adjust-weights
                                                   loc-func-cg-final-adjust-weights))
                 need-loc-func-cg-final-adjust-weights

                 (loc-func-sd-adjust-weights-and-clear-de-by-dws (gensym "tr-func-sd-adjust-weights-and-clear-de-by-dws-"))
                 (func-sd-adjust-weights-and-clear-de-by-dws (or ext-func-sd-adjust-weights-and-clear-de-by-dws
                                                                 loc-func-sd-adjust-weights-and-clear-de-by-dws))
                 need-loc-func-sd-adjust-weights-and-clear-de-by-dws

                 (loc-func-cg-adjust-weights (gensym "tr-func-cg-adjust-weights-"))
                 (func-cg-adjust-weights (or ext-func-cg-adjust-weights
                                             loc-func-cg-adjust-weights))
                 need-loc-func-cg-adjust-weights

                 (loc-func-improved-elman-activate (gensym "tr-func-improved-elman-activate-"))
                 (func-improved-elman-activate (or ext-func-improved-elman-activate
                                                   loc-func-improved-elman-activate))
                 need-loc-func-improved-elman-activate

                 ;; (loc-func-improved-elman-backprop (gensym "tr-func-improved-elman-backprop-"))
                 ;; (func-improved-elman-backprop (or ext-func-improved-elman-backprop
                 ;;				   loc-func-improved-elman-backprop))
                 ;; need-loc-func-improved-elman-backprop

                 (loc-func-get-weight-mean (gensym "tr-func-get-weight-mean-"))
                 (func-get-weight-mean (or ext-func-get-weight-mean
                                           loc-func-get-weight-mean))
                 need-loc-func-get-weight-mean
                 ;; ^^^ function names

                 ;; this code is to be executed within pattern iterator
                 ;; for each pattern
                 (copy-recurrent-within-pi
                  (if elman-net
                      ;; ELMAN-NET
                      (progn
                        (setq need-func-copy-recurrent t
                              need-var-input-layer 1)
                        `( ;; inject recurrent-next-input into net
                          (setf (layer-act-vec ,var-input-layer)
                                (the (simple-array type-act
                                                   (,(layer-spec-size
                                                      (svref layer-specs 0))))
                                  (svref ,next-input-patterns ,pattern-num)))
                          ;; copy context to that pattern
                          (,func-copy-recurrent)))))

                 ;; if we do time-batch, we can execute the above code
                 ;; within the inner pattern iterator code

                 ;; this code is to be executed within step-iterator
                 ;; at the end of each recurrent step
                 ;; we have to go through all patterns again now
                 (copy-recurrent-within-si
                  (if elman-net
                      (if timebatch
                          ;; ELMAN-NET TIMEBATCH
                          nil
                          ;; ELMAN-NET (NOT TIMEBATCH)
                          (progn
                            (setq need-func-std-activate t
                                  need-var-input-layer t)
                            `((pattern-iterator ',netspec ,net
                                                ,current-input-patterns
                                                ,dest-patterns
                                                ,numpatterns
                                                :do-activate t
                                                :ext-func-activate ,func-std-activate
                                                :code-post ,copy-recurrent-within-pi
                                                :var-name-pattern-num ,pattern-num
                                                :var-input-layer ,var-input-layer))))))

                 (all-pattern-error-code
                  (if (not batch)
                      `((setq ,error ,(coerce 0.0d0 'type-act))
                        (pattern-iterator ',netspec ,net
                                          ,current-input-patterns
                                          ,idest-patterns
                                          ,numpatterns
                                          :batch t
                                          :do-activate t
                                          :ext-func-activate ,func-std-activate
                                          :do-calc-error t
                                          :var-name-pattern-num ,pattern-num
                                          :var-input-layer ,var-input-layer
                                          :var-output-layer-act ,var-output-layer-act
                                          :var-error ,error))))


                 ;; VVV --- CG linesearch
                 (cg-linesearch-all-pattern-error-code-pi
                  (if (eq method :cg)
                      (progn
                        (setq need-func-std-activate t
                              need-var-input-layer t
                              need-var-output-layer-act t)
                        `((pattern-iterator ',netspec ,net
                                            ,current-input-patterns
                                            ,idest-patterns
                                            ,numpatterns
                                            :batch ,batch
                                            :do-activate t
                                            :ext-func-activate ,func-std-activate
                                            :do-calc-error t
                                            :var-name-pattern-num ,pattern-num
                                            :var-input-layer ,var-input-layer
                                            :var-output-layer-act ,var-output-layer-act
                                            :var-error ,cg-ls-error)))))

                 (cg-linesearch-all-pattern-error-code
                  (if (eq method :cg)
                      ;; for elman-net time-online we'll just look at
                      ;; the current input patterns
                      (let ((code
                             (if (not (and elman-net timebatch))
                                 cg-linesearch-all-pattern-error-code-pi))
                            (code-recurrent
                             ;; UUUAH ! This assumes that the cg-... variable
                             ;; just consists of one macro call
                             (if (and elman-net timebatch)
                                 `((,@(car cg-linesearch-all-pattern-error-code-pi)
                                      :code-post ,copy-recurrent-within-pi))))
                            (code-final
                             (if (and elman-net timebatch)
                                 cg-linesearch-all-pattern-error-code-pi)))
                        `((the type-act
                            (let ((,cg-ls-error ,(coerce 0.0d0 'type-act)))
                              (declare (type type-act ,cg-ls-error))
                              (step-iterator ',netspec ,net
                                             ,current-input-patterns
                                             ,idest-patterns
                                             ,numpatterns
                                             :elman-net ,(and elman-net
                                                              timebatch)
                                             :num-steps ,num-steps
                                             :do-steps ,timebatch
                                             ;; OK... We're configuring here what the pattern
                                             ;; iterator is supposed to do. When we do
                                             ;; timebatch, every pattern has to be copied,
                                             ;; but just when there is a next-timestep-pattern
                                             :code ,code
                                             :code-recurrent ,code-recurrent
                                             :code-final ,code-final
                                             :var-name-current-input-patterns
                                             ,current-input-patterns
                                             :var-name-next-input-patterns
                                             ,next-input-patterns)
                              ,cg-ls-error))))))

                 (cg-linesearch-code
                  (if (eq method :cg)
                      (progn
                        (setq need-func-cg-adjust-weights t)
                        `(linesearch-eval-net ',netspec ,net
                                              :ext-code-error-function ,cg-linesearch-all-pattern-error-code
                                              :ext-func-adjust-weights ,func-cg-adjust-weights
                                              :eta))))
                 ;; ^^^ --- CG linesearch


                 (update-code
                  (ecase method
                    (:cg
                     (setq need-func-std-activate t
                           need-func-cg-zero-beta t
                           need-func-cg-beta t
                           need-func-cg-make-cg-updates-with-beta t
                           need-func-cg-final-adjust-weights t
                           need-var-cg-update-counter t
                           need-var-cg-numweights t)

                     (let ((cg-beta (gensym "cg-beta-"))
                           (cg-interval-left (gensym "cg-interval-left-"))
                           (cg-interval-right (gensym "cg-interval-right-"))
                           (cg-interval-left-err (gensym "cg-interval-left-err-"))
                           (cg-interval-right-err (gensym "cg-interval-right-err-")))

                       `((let ((,cg-beta ,(the type-de-by-dw (coerce 0.0 'type-de-by-dw)))
                               (,cg-interval-left ,(the type-weight (coerce 0.0d0 'type-weight)))
                               (,cg-interval-right ,(the type-weight (coerce 0.0d0 'type-weight)))
                               (,cg-interval-left-err ,(the type-act (coerce 0.0d0 'type-act)))
                               (,cg-interval-right-err ,(the type-act (coerce 0.0d0 'type-act))))
                           (declare (type type-de-by-dw ,cg-beta)
                                    (type type-weight ,cg-interval-left ,cg-interval-right)
                                    (type type-act ,cg-interval-left-err ,cg-interval-right-err))

                           ,@(if *nile-debug*
                                 `((format t "do-cg-update: cg-update-counter: ~a,~%     (= ,cg-update-counter ,numweights) : ~a~%"
                                           ,var-cg-update-counter (= ,var-cg-update-counter ,var-cg-numweights))))
                           ;; get beta and save old de/dws
                           (if (= ,var-cg-update-counter ,var-cg-numweights)
                               (progn
                                 (setq ,cg-beta (,func-cg-zero-beta))
                                 (setq ,var-cg-update-counter 1))
                               (progn
                                 (setq ,cg-beta (,func-cg-beta))
                                 (incf ,var-cg-update-counter)))

                           ;; save weights and make cg-updates
                           ;; (adjust-weights ',netspec ,net
                           ;;		      :save-weights ,save-weights-method
                           ;;		      :make-cg-updates-with-beta ,beta)
                           (,func-cg-make-cg-updates-with-beta ,cg-beta)

                           ;; do linesearch
                           (interval-location ,error ; initial-error
                                              ;; eval-fn for rest
                                              ,cg-linesearch-code
                                              ;; eta for interval-location
                                              ,cg-opt-interval-location-eta
                                              :maximum ,cg-opt-interval-location-maximum
                                              :update abs
                                              :values-in (,cg-interval-left ,cg-interval-left-err ,cg-interval-right ,cg-interval-right-err))

                           (golden-section-search ,cg-interval-left
                                                  ,cg-interval-left-err
                                                  ,cg-interval-right
                                                  ,cg-interval-right-err
                                                  ;; eval-fn
                                                  ,cg-linesearch-code
                                                  ;; tolerance
                                                  ,cg-opt-gss-tol)

                           ;; take final update to be middle of left and right
                           ;; save the update and clear de-by-dws

                           ;;   (adjust-weights ',netspec ,net
                           ;;		   :eta (+ ,interval-left
                           ;;			   (/ (- ,interval-right
                           ;;				 ,interval-left)
                           ;;			      2))
                           ;;		   :use-saved-weights t
                           ;;		   :save-update t
                           ;;		   :cg-update t
                           ;;		   :clear-de-by-dws t)
                           (,func-cg-final-adjust-weights (+ ,cg-interval-left
                                                             (/ (- ,cg-interval-right
                                                                   ,cg-interval-left)
                                                                2)))))))
                    (:sd
                     (setq need-func-sd-adjust-weights-and-clear-de-by-dws t)
                     `((,func-sd-adjust-weights-and-clear-de-by-dws)))))

                 (act-and-bprop-code-pi
                  (let ((calc-error batch)
                        code-post)
                    (if (and elman-net improved-elman)
                        (let* ((current-dest-pattern (gensym "tr-loc-current-dest-pattern-"))
                               (nhid*wmean (gensym "tr-loc-actn-bprop-nhid*wmean-"))
                               (actmean (gensym "tr-loc-actn-bprop-actmean-"))
                               (this-pattern-cs (gensym "tr-loc-actn-bprop-these-cs-"))
                               (current-gdash-mean (gensym "tr-loc-act-actn-bprop-current-gdash-mean-"))
                               (code-act `((setq ,actmean
                                                 (,func-improved-elman-activate))))
                               (code-backprop
                                `((let ((,this-pattern-cs (svref ,var-improved-elman-c
                                                                 ,pattern-num))
                                        (,current-gdash-mean ,(coerce 0.0d0 'type-act)))
                                    (declare (type (simple-array type-act
                                                                 ,(if (numberp num-steps)
                                                                      `(,num-steps)
                                                                      '(*)))
                                                   ,this-pattern-cs)
                                             (type type-act ,current-gdash-mean))
                                    ;; now multiply all previous cs
                                    ;; NOT QUITE SURE WHAT IS CORRECT HERE
                                    ;; (dotimes (idx (1- ,var-name-step-count))
                                    (dotimes (idx ,var-name-step-count)
                                      (setf (aref ,this-pattern-cs idx)
                                            (* (aref ,this-pattern-cs idx)
                                               ,nhid*wmean)))
                                    ;; and finally really do backpropping
                                    (backprop-fn ,netspec-form ,net ,current-dest-pattern
                                                 :improved-elman t
                                                 :improved-elman-opts
                                                 (:this-pattern-cs ,this-pattern-cs
                                                                   :all-patterns ,iinput-patterns
                                                                   :step-num ,var-name-step-count
                                                                   :pattern-num ,pattern-num
                                                                   :gdash-sum-in ,current-gdash-mean))
                                    (setq ,current-gdash-mean (/ ,current-gdash-mean
                                                                 ,(coerce (layer-spec-size
                                                                           (svref layer-specs 1))
                                                                          'type-weight)))
                                    ;; set current c in cs
                                    (setf (aref ,this-pattern-cs ,var-name-step-count) ,current-gdash-mean)
                                    ;; (dotimes (idx (1- ,var-name-step-count))
                                    (dotimes (idx ,var-name-step-count)
                                      (setf (aref ,this-pattern-cs idx)
                                            (* (aref ,this-pattern-cs idx)
                                               ,current-gdash-mean)))))))
                          (setq need-func-improved-elman-activate t
                                need-func-get-weight-mean t
                                need-var-input-layer t
                                need-var-output-layer-act t)
                          `((let ((,actmean ,(coerce 0.0d0 'type-act))
                                  (,nhid*wmean (* ,(coerce (layer-spec-size
                                                            (svref layer-specs 1))
                                                           'type-weight)
                                                  (,func-get-weight-mean))))
                              (declare (type type-act ,actmean)
                                       (type type-weight ,nhid*wmean))
                              (pattern-iterator ',netspec ,net
                                                ,current-input-patterns
                                                ,idest-patterns
                                                ,numpatterns
                                                :batch ,batch
                                                :do-activate t
                                                :ext-code-activate ,code-act
                                                :do-backprop t
                                                :ext-code-backprop ,code-backprop
                                                :do-calc-error ,calc-error
                                                :code-non-batch ,update-code
                                                :code-post ,code-post
                                                :var-name-pattern-num ,pattern-num
                                                :var-name-current-dest-pattern ,current-dest-pattern
                                                :var-error ,error
                                                :var-input-layer ,var-input-layer
                                                :var-output-layer-act ,var-output-layer-act))))
                        ;; ELSE (NOT (AND ELMAN-NET IMPROVED-ELMAN))
                        ;; Note: may still be Elman-net "
                        (progn
                          (setq need-func-std-activate t
                                need-func-std-backprop t
                                need-var-input-layer t
                                need-var-output-layer-act t)
                          `((pattern-iterator ',netspec ,net
                                              ,current-input-patterns
                                              ,idest-patterns
                                              ,numpatterns
                                              :batch ,batch
                                              :do-activate t
                                              :ext-func-activate ,func-std-activate
                                              :do-backprop t
                                              :ext-func-backprop ,func-std-backprop
                                              :do-calc-error ,calc-error
                                              :code-non-batch ,update-code
                                              :code-post ,code-post
                                              :var-name-pattern-num ,pattern-num
                                              :var-error ,error
                                              :var-input-layer ,var-input-layer
                                              :var-output-layer-act ,var-output-layer-act)
                            ,@(if (and (not elman-net) (not batch))
                                  all-pattern-error-code))))))

                 (act-and-bprop-code-pi-recurrent
                  (let ((code-post (if (and elman-net timebatch)
                                       copy-recurrent-within-pi))
                        (calc-error nil))
                    (if (and elman-net improved-elman)
                        (let* ((current-dest-pattern (gensym "tr-loc-current-dest-pattern-"))
                               (nhid*wmean (gensym "tr-loc-actn-bprop-nhid*wmean-"))
                               (actmean (gensym "tr-loc-actn-bprop-actmean-"))
                               (this-pattern-cs (gensym "tr-loc-actn-bprop-these-cs-"))
                               (current-gdash-mean (gensym "tr-loc-act-actn-bprop-current-gdash-mean-"))
                               (code-act `((setq ,actmean
                                                 (,func-improved-elman-activate))))
                               (code-backprop
                                `((let ((,this-pattern-cs (svref ,var-improved-elman-c
                                                                 ,pattern-num))
                                        (,current-gdash-mean ,(coerce 0.0d0 'type-act)))
                                    (declare (type (simple-array type-act
                                                                 ,(if (numberp num-steps)
                                                                      `(,num-steps)
                                                                      '(*)))
                                                   ,this-pattern-cs)
                                             (type type-act ,current-gdash-mean))
                                    ;; now multiply all previous cs
                                    ;; NOT QUITE SURE WHAT IS CORRECT HERE
                                    ;; (dotimes (idx (1- ,var-name-step-count))
                                    (dotimes (idx ,var-name-step-count)
                                      (setf (aref ,this-pattern-cs idx)
                                            (* (aref ,this-pattern-cs idx)
                                               ,nhid*wmean)))
                                    ;; and finally really do backpropping
                                    (backprop-fn ,netspec-form ,net ,current-dest-pattern
                                                 :improved-elman t
                                                 :improved-elman-opts
                                                 (:this-pattern-cs ,this-pattern-cs
                                                                   :all-patterns ,iinput-patterns
                                                                   :step-num ,var-name-step-count
                                                                   :pattern-num ,pattern-num
                                                                   :gdash-sum-in ,current-gdash-mean))
                                    (setq ,current-gdash-mean (/ ,current-gdash-mean
                                                                 ,(coerce (layer-spec-size
                                                                           (svref layer-specs 1))
                                                                          'type-weight)))
                                    ;; set current c in cs
                                    (setf (aref ,this-pattern-cs ,var-name-step-count) ,current-gdash-mean)
                                    ;; (dotimes (idx (1- ,var-name-step-count))
                                    (dotimes (idx ,var-name-step-count)
                                      (setf (aref ,this-pattern-cs idx)
                                            (* (aref ,this-pattern-cs idx)
                                               ,current-gdash-mean)))))))
                          (setq need-func-improved-elman-activate t
                                need-func-get-weight-mean t
                                need-var-input-layer t
                                need-var-output-layer-act t)
                          `((let ((,actmean ,(coerce 0.0d0 'type-act))
                                  (,nhid*wmean (* ,(coerce (layer-spec-size
                                                            (svref layer-specs 1))
                                                           'type-weight)
                                                  (,func-get-weight-mean))))
                              (declare (type type-act ,actmean)
                                       (type type-weight ,nhid*wmean))
                              (pattern-iterator ',netspec ,net
                                                ,current-input-patterns
                                                ,idest-patterns
                                                ,numpatterns
                                                :batch ,batch
                                                :do-activate t
                                                :ext-code-activate ,code-act
                                                :do-backprop t
                                                :ext-code-backprop ,code-backprop
                                                :do-calc-error ,calc-error
                                                :code-non-batch ,update-code
                                                :code-post ,code-post
                                                :var-name-pattern-num ,pattern-num
                                                :var-name-current-dest-pattern ,current-dest-pattern
                                                :var-error ,error
                                                :var-input-layer ,var-input-layer
                                                :var-output-layer-act ,var-output-layer-act))))
                        ;; ELSE (NOT (AND ELMAN-NET IMPROVED-ELMAN))
                        ;; Note: may still be Elman-net "
                        (progn
                          (setq need-func-std-activate t
                                need-func-std-backprop t
                                need-var-input-layer t
                                need-var-output-layer-act t)
                          `((pattern-iterator ',netspec ,net
                                              ,current-input-patterns
                                              ,idest-patterns
                                              ,numpatterns
                                              :batch ,batch
                                              :do-activate t
                                              :ext-func-activate ,func-std-activate
                                              :do-backprop t
                                              :ext-func-backprop ,func-std-backprop
                                              :do-calc-error ,calc-error
                                              :code-non-batch ,update-code
                                              :code-post ,code-post
                                              :var-name-pattern-num ,pattern-num
                                              :var-error ,error
                                              :var-input-layer ,var-input-layer
                                              :var-output-layer-act ,var-output-layer-act))))))

                 (act-and-bprop-code
                  (let ((code
                         (if (not (and elman-net timebatch))
                             act-and-bprop-code-pi))
                        (code-recurrent
                         (if (and elman-net timebatch)
                             act-and-bprop-code-pi-recurrent))
                        (code-final
                         `(,@(if (and elman-net timebatch)
                                 act-and-bprop-code-pi))))
                    `((step-iterator ',netspec ,net
                                     ,current-input-patterns
                                     ,idest-patterns
                                     ,numpatterns
                                     :elman-net ,(and elman-net
                                                      timebatch)
                                     :num-steps ,num-steps
                                     :do-steps ,timebatch
                                     ;; OK... We're configuring here what the pattern
                                     ;; iterator is supposed to do. When we do
                                     ;; timebatch, every pattern has to be copied,
                                     ;; but just when there is a next-timestep-pattern
                                     :code ,code
                                     :code-recurrent ,code-recurrent
                                     :code-final ,code-final
                                     :var-name-step-count
                                     ,var-name-step-count
                                     :var-name-current-input-patterns
                                     ,current-input-patterns
                                     :var-name-next-input-patterns
                                     ,next-input-patterns))))

                 (cycle-code
                  (let ((setup-code `((,func-clear-de-by-dws))))
                    (setq need-func-clear-de-by-dws t)
                    `((cycle-iterator ',netspec ,net
                                      :batch ,batch
                                      :max-cycles ,max-cycles
                                      :error-lim ,error-lim
                                      ;;
                                      :proprietary-detect-locmin ,proprietary-detect-locmin
                                      :proprietary-detect-locmin-kick ,proprietary-detect-locmin-kick
                                      :proprietary-detect-locmin-x-error-factor ,proprietary-detect-locmin-x-error-factor
                                      ;;
                                      :code-setup ,setup-code
                                      :code-batch ,update-code
                                      :code-act-n-bprop ,act-and-bprop-code
                                      ;;
                                      :var-error ,error
                                      ;;
                                      ,@cycle-opts))))

                 (step-code
                  `((step-iterator ',netspec ,net
                                   ,input-patterns
                                   ,dest-patterns
                                   ,numpatterns
                                   :elman-net ,elman-net
                                   :num-steps ,num-steps
                                   ;; Do steps here only if not timebatch
                                   :do-steps ,(not timebatch)
                                   :code ,cycle-code
                                   :code-recurrent ,copy-recurrent-within-si
                                   :code-final ,all-pattern-error-code
                                   :var-name-step-count
                                   ,var-name-step-count
                                   :var-name-current-input-patterns
                                   ,current-input-patterns
                                   :var-name-next-input-patterns
                                   ,next-input-patterns
                                   ,@step-opts))))
            ;; decide on which functions are needed
            (setq need-loc-func-clear-de-by-dws (and need-func-clear-de-by-dws
                                                     (not ext-func-clear-de-by-dws))
                  need-loc-func-std-activate (and need-func-std-activate
                                                  (not ext-func-std-activate))
                  need-loc-func-std-backprop (and need-func-std-backprop
                                                  (not ext-func-std-backprop))
                  need-loc-func-copy-recurrent (and need-func-copy-recurrent
                                                    (not ext-func-copy-recurrent))
                  need-loc-func-cg-zero-beta (and need-func-cg-zero-beta
                                                  (not ext-func-cg-zero-beta))
                  need-loc-func-cg-beta (and need-func-cg-beta
                                             (not ext-func-cg-beta))
                  need-loc-func-cg-make-cg-updates-with-beta
                  (and need-func-cg-make-cg-updates-with-beta
                       (not ext-func-cg-make-cg-updates-with-beta))
                  need-loc-func-cg-final-adjust-weights
                  (and need-func-cg-final-adjust-weights
                       (not ext-func-cg-final-adjust-weights))
                  need-loc-func-cg-adjust-weights
                  (and need-func-cg-adjust-weights
                       (not ext-func-cg-adjust-weights))
                  need-loc-func-sd-adjust-weights-and-clear-de-by-dws
                  (and need-func-sd-adjust-weights-and-clear-de-by-dws
                       (not ext-func-sd-adjust-weights-and-clear-de-by-dws))
                  need-loc-func-improved-elman-activate
                  (and need-func-improved-elman-activate
                       (not ext-func-improved-elman-activate))
                  ;; need-loc-func-improved-elman-backprop
                  ;; (and need-func-improved-elman-backprop
                  ;;     (not ext-func-improved-elman-backprop))
                  need-loc-func-get-weight-mean
                  (and need-func-get-weight-mean
                       (not ext-func-get-weight-mean)))
            (possibly-do-flet
             `(,@(if need-loc-func-clear-de-by-dws
                     `((,loc-func-clear-de-by-dws
                        ()
                        (declare
                         ;; (:explain :variables :calls :types :boxing)
                         (optimize (speed 3) (space 0) (safety 0) (debug 0)
                                   (compilation-speed 0)))
                        (adjust-weights ',netspec ,net
                                        :clear-de-by-dws t))))
                 ,@(if need-loc-func-std-activate
                       `((,loc-func-std-activate
                          ()
                          (declare
                           ;; (:explain :variables :calls :types :boxing)
                           (optimize (speed 3) (space 0) (safety 0) (debug 0)
                                     (compilation-speed 0)))
                          (activation-fn ',netspec ,net))))
                 ,@(if need-loc-func-std-backprop
                       `((,loc-func-std-backprop
                          (dest)
                          (declare
                           ;; (:explain :variables :calls :types :boxing)
                           (optimize (speed 3) (space 0) (safety 0) (debug 0)
                                     (compilation-speed 0))
                           (type (simple-array type-act
                                               (,(layer-spec-size
                                                  (svref layer-specs (1- num-layers)))))
                                 dest))
                          (backprop-fn ',netspec ,net dest))))
                 ,@(if need-loc-func-copy-recurrent
                       `((,loc-func-copy-recurrent ()
                                                   (declare
                                                    ;; (:explain :variables :calls :types :boxing)
                                                    (optimize (speed 3) (space 0) (safety 0) (debug 0)
                                                              (compilation-speed 0)))
                                                   (activation-fn ',netspec ,net
                                                                  :activate nil
                                                                  :copy-recurrent t))))
                 ,@(if need-loc-func-cg-zero-beta
                       `((,loc-func-cg-zero-beta ()
                                                 (declare
                                                  ;; (:explain :variables :calls :types :boxing)
                                                  (optimize (speed 3) (space 0) (safety 0) (debug 0)
                                                            (compilation-speed 0)))
                                                 (beta ,layer-specs ,net
                                                       :zero-beta-save-derivs t))))
                 ,@(if need-loc-func-cg-beta
                       `((,loc-func-cg-beta ()
                                            (declare
                                             ;; (:explain :variables :calls :types :boxing)
                                             (optimize (speed 3) (space 0) (safety 0) (debug 0)
                                                       (compilation-speed 0)))
                                            (beta ,layer-specs ,net))))
                 ,@(if need-loc-func-cg-make-cg-updates-with-beta
                       `((,loc-func-cg-make-cg-updates-with-beta (beta)
                                                                 (declare
                                                                  (type type-de-by-dw beta)
                                                                  ;; (:explain :variables :calls :types :boxing)
                                                                  (optimize (speed 3) (space 0) (safety 0) (debug 0)
                                                                            (compilation-speed 0)))
                                                                 (adjust-weights ',netspec ,net
                                                                                 :save-weights ,cg-opt-save-weights-method
                                                                                 :make-cg-updates-with-beta beta))))
                 ,@(if need-loc-func-cg-final-adjust-weights
                       `((,loc-func-cg-final-adjust-weights (eta)
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
                 ,@(if need-loc-func-cg-adjust-weights
                       `((,loc-func-cg-adjust-weights (eta)
                                                      (declare
                                                       (type type-weight eta)
                                                       ;; (:explain :variables :calls :types :boxing)
                                                       (optimize (speed 3) (space 0) (safety 0) (debug 0)
                                                                 (compilation-speed 0)))
                                                      (adjust-weights ',netspec ,net
                                                                      :eta eta
                                                                      :use-saved-weights t))))
                 ,@(if need-loc-func-sd-adjust-weights-and-clear-de-by-dws
                       `((,loc-func-sd-adjust-weights-and-clear-de-by-dws ()
                                                                          (declare
                                                                           ;; (:explain :variables :calls :types :boxing)
                                                                           (optimize (speed 3) (space 0) (safety 0) (debug 0)
                                                                                     (compilation-speed 0)))
                                                                          (adjust-weights ,netspec-form ,net
                                                                                          :eta ,sd-opt-eta
                                                                                          :momentum ,sd-opt-momentum
                                                                                          :clear-de-by-dws t))))
                 #|
                 ,@(if need-loc-func-improved-elman-backprop
                 `((,loc-func-improved-elman-backprop
                 (dest this-pattern-cs all-patterns step-num pattern-num)
                 (declare
			   ;; (:explain :variables :calls :types :boxing) ; ;
                 (optimize (speed 3) (space 0) (safety 0) (debug 0)
                 (compilation-speed 0))
                 (type (simple-array type-act
                 (,(layer-spec-size
                 (svref layer-specs (1- num-layers)))))
                 dest)
                 (type (simple-array type-act ,(if (numberp num-steps)
                 `(,num-steps)
                 '(*)))
                 this-pattern-cs)
                 (type (simple-array
				  ;; numpatterns input layer act ; ;
                 (simple-array
				   ;; innermost : input layer act ; ;
                 (simple-array type-act
                 (,(layer-spec-size
                 (svref layer-specs 0))))
                 ,(if (numberp numpatterns)
                 `(,numpatterns)
                 '(*)))
                 ,(if (numberp num-steps)
                 `(,num-steps)
                 '(*)))
                 all-patterns)
                 (fixnum step-num pattern-num))
                 (backprop-fn ,netspec-form ,net dest
                 :improved-elman t
                 :improved-elman-opts
                 (:this-pattern-cs this-pattern-cs
                 :all-patterns all-patterns
                 :step-num step-num
                 :pattern-num pattern-num)))))
                 |#
		 ,@(if need-loc-func-improved-elman-activate
		       `((,loc-func-improved-elman-activate
			  ()
			  (declare
			   ;; (:explain :variables :calls :types :boxing)
			   (optimize (speed 3) (space 0) (safety 0) (debug 0)
				     (compilation-speed 0)))
			  (the type-act
			    (activation-fn ',netspec ,net
					   :activate t
					   :return-context-unit-stats t)))))
		 ,@(if need-loc-func-get-weight-mean
		       `((,loc-func-get-weight-mean
			  ()
			  (declare
			   ;; (:explain :variables :calls :types :boxing)
			   (optimize (speed 3) (space 0) (safety 0) (debug 0)
				     (compilation-speed 0)))
			  (the type-weight
			    (get-weight-mean ,netspec-form ,net))))))
	     `(declare
	       ,@(if need-loc-func-clear-de-by-dws
		     `((ftype (function () nil)
			      ,loc-func-clear-de-by-dws)))
	       ,@(if need-loc-func-std-activate
		     `((ftype (function () nil)
			      ,loc-func-std-activate)))
	       ,@(if need-loc-func-std-backprop
		     `((ftype (function ((simple-array type-act
						       (,(layer-spec-size
							  (svref layer-specs
								 (1- num-layers))))))
					nil)
			      ,loc-func-std-backprop)))
	       ,@(if need-loc-func-copy-recurrent
		     `((ftype (function () nil)
			      ,loc-func-copy-recurrent)))
	       ,@(if need-loc-func-cg-zero-beta
		     `((ftype (function () type-de-by-dw)
			      ,loc-func-cg-zero-beta)))
	       ,@(if need-loc-func-cg-beta
		     `((ftype (function () type-de-by-dw)
			      ,loc-func-cg-beta)))
	       ,@(if need-loc-func-cg-make-cg-updates-with-beta
		     `((ftype (function (type-de-by-dw) nil)
			      ,loc-func-cg-make-cg-updates-with-beta)))
	       ,@(if need-loc-func-cg-final-adjust-weights
		     `((ftype (function (type-weight) nil)
			      ,loc-func-cg-final-adjust-weights)))
	       ,@(if need-loc-func-cg-adjust-weights
		     `((ftype (function (type-weight) nil)
			      ,loc-func-cg-adjust-weights)))
	       ,@(if need-loc-func-sd-adjust-weights-and-clear-de-by-dws
		     `((ftype (function () nil)
			      ,loc-func-sd-adjust-weights-and-clear-de-by-dws)))
	       #|
                 ,@(if need-func-improved-elman-backprop
		     `((ftype (function ((simple-array type-act
         (,(layer-spec-size
         (svref layer-specs (1- num-layers)))))
         (simple-array type-act ,(if (numberp num-steps)
         `(,num-steps)
         '(*)))
         (simple-array
					  ;; numpatterns input layer act ; ;
         (simple-array
					   ;; innermost : input layer act ; ;
         (simple-array type-act
         (,(layer-spec-size
         (svref layer-specs 0))))
         ,(if (numberp numpatterns)
         `(,numpatterns)
         '(*)))
         ,(if (numberp num-steps)
         `(,num-steps)
         '(*)))
         fixnum
         fixnum) nil)
         ,loc-func-improved-elman-backprop)))
                 |#
	       ,@(if need-func-improved-elman-activate
		     `((ftype (function () type-act)
			      ,loc-func-improved-elman-activate)))
	       ,@(if need-func-get-weight-mean
		     `((ftype (function () type-weight)
			      ,loc-func-get-weight-mean))))
	     `(let* ((,error ,(coerce 0.0d0 'type-act))
		     (,iinput-patterns ,input-patterns)
		     (,idest-patterns ,dest-patterns)
		     ,@(if need-var-input-layer
			   `((,var-input-layer (svref ,net 0))))
		       ,@(if need-var-output-layer-act
			     `((,var-output-layer-act
				(layer-act-vec (svref ,net ,(1- num-layers))))))
		     ,@(if need-var-cg-numweights
			   (if cg-opt-max-cg-updates
			       `((,var-cg-numweights (if (= ,cg-opt-max-cg-updates 0)
							 ,(num-weights layer-specs)
							 (min ,cg-opt-max-cg-updates
							      ,(num-weights layer-specs)))))
			     `((,var-cg-numweights ,(num-weights layer-specs)))))
		     ,@(if need-var-cg-update-counter
			   `((,var-cg-update-counter ,var-cg-numweights)))
		     ;; do we have to get the array dimensions at runtime ?
		     ,@(if (not (numberp numpatterns))
			   `((,numpatterns
			      ,(if elman-net
				   `(array-dimension (svref ,iinput-patterns 0) 0)
				 `(array-dimension ,iinput-patterns 0)))))
		     ,@(if (and elman-net (not (numberp num-steps)))
			     `((,num-steps (array-dimension ,iinput-patterns 0))))
		     ;; The vector over patterns of arrays over steps
		     ;; with the improved-elman-correction factor for that
		     ;; pattern
		     ,@(if var-improved-elman-c
			   `((,var-improved-elman-c
			      (vector-of-n ',numpatterns
					   (make-array (list ,num-steps)
						       :element-type 'type-act))))))
		(declare (type type-act ,error)
			 ,(if elman-net
			      ;; input-patterns are num-steps
			      ;; set of numpatterns input-patterns
			      `(type (simple-array
				      ;; numpatterns input layer act
				      (simple-array
				       ;; innermost : input layer act
				       (simple-array type-act
						     (,(layer-spec-size
							(svref layer-specs 0))))
				       ,(if (numberp numpatterns)
					    `(,numpatterns)
					  '(*)))
				      ,(if (numberp num-steps)
					   `(,num-steps)
					 '(*)))
				     ,iinput-patterns)
			    ;; input patterns as normal
			    `(type (simple-array
				    ;; numpatterns input layer act
				    (simple-array type-act
						  (,(layer-spec-size
						     (svref layer-specs 0))))
				    ,(if (numberp numpatterns)
					 `(,numpatterns)
				       '(*)))
				   ,iinput-patterns))
			 ;; output patterns are same for both
			 (type (simple-array
				(simple-array type-act
					      (,(layer-spec-size
						 (svref layer-specs (1- num-layers)))))
				,(if (numberp numpatterns)
				     `(,numpatterns)
				   '(*)))
			       ,idest-patterns)
			 ,@(if need-var-input-layer
			       `((type layer ,var-input-layer)))
			 ,@(if need-var-output-layer-act
			       `((type (simple-array type-act
						     (,(layer-spec-size
							(svref layer-specs (1- num-layers)))))
				       ,var-output-layer-act)))
			 ,@(if need-var-cg-update-counter
			       `((fixnum ,var-cg-update-counter)))
			 ,@(if need-var-cg-numweights
			       `((fixnum ,var-cg-numweights)))
			 ,@(if (not (numberp numpatterns))
			       `((fixnum ,numpatterns)))
			 ,@(if (and elman-net (not (numberp num-steps)))
			       `((fixnum ,num-steps)))
			 ,@(if var-improved-elman-c
			       `((type (simple-array
					(simple-array type-act
						      ,(if (numberp num-steps)
							   `(,num-steps)
							 '(*)))
					,(if (numberp numpatterns)
					     `(,numpatterns)
					   '(*)))
				       ,var-improved-elman-c))))
		,@step-code
		,@(if write-final-error
		      `((if ,write-final-error
			    (format t "Final error is: ~A~%~%" ,error))))

		,@(if write-final-net
		      `((if ,write-final-net
			    (progn
			      (format t "Final net is:~%")
			      (write-net ,net)))))

		,(if return-final-error
		     error)))))))))
#|
;; code for updating                    ; ;
                 (update-code


)

;; VVV Improved elman vars              ; ;

;; for each timestep, the mean activation ; ;
                 (act-mean (if (and elman-net improved-elman)
(gensym "tr-act-mean-")))
;; and the weight mean                  ; ;
                 (weight-mean (if (and elman-net improved-elman)
(gensym "tr-weight-mean")))
;; the c(t)s: for the current timestep s they are ; ;
;; at timestep t (node a)               ; ;
;;                                      ; ;
;; c(t,s,a) = a                         ; ;
;; c(t+1,s,a) = c(t,s,a)*<w>*nhid*g'(<a>*<w>*nhid) ; ;
;;                                      ; ;
;; improved elman is then \sum_s<=t c(t,s,a) ; ;
                 (c-vec (if (and elman-net improved-elman)
(gensym "tr-c-vec")))

;; ^^^ Improved elman vars              ; ;


;; copy-recurrent-code                  ; ;






;; for each time-step and each pattern, ; ;
 ;; the code to activate and backprop   ; ;
                 (act-and-bprop-code
(if (and elman-net timebatch)
     ;; Here do the following:          ; ;
     ;; - with each pattern presented, copy activation ; ;
     ;;   to next pattern               ; ;
    `(pattern-iterator ',netspec ,net
                       ,current-input-patterns
                       ,dest-patterns
                       ,numpatterns
                       :batch ,batch
                       :do-backprop t
                       :do-activate t
                       :do-calc-error
                       :code-non-batch ,update-code
                       :code-post ,copy-recurrent-code

                       |#


(defmacro all-pattern-error (netspec-form net
                             input-patterns dest-patterns numpatterns
                             &key write-output-to
                             ext-activation-fn)
  "Calculates sum of squares error for all patters specified as
input-patterns and dest-patterns."
  (declare (optimize (speed 1) (space 1) (safety 1) (debug 0)
                     (compilation-speed 0)))
  (let* ((netspec (eval netspec-form))
         (layer-specs (net-spec-layer-specs netspec))
         (num-layers (car (array-dimensions layer-specs)))
         (error (gensym "error-"))
         (current-input-pattern (gensym "current-input-pattern-"))
         (current-dest-pattern (gensym "current-dest-pattern-"))
         (output-layer-act (gensym "output-layer-act-"))
         (code-post (if write-output-to
                        ;; just using count-if as a way to iterate through array - UUUH ;
                        `((progn
                            (format ,write-output-to
                                    "~a -> ~a (want ~a)~%"
                                    ,current-input-pattern
                                    ,output-layer-act
                                    ,current-dest-pattern))))))
    `(the type-act
       (let ((,error ,(coerce 0.0d0 'type-act))
             (,output-layer-act (layer-act-vec
                                 (svref ,net ,(1- num-layers)))))
         (declare (type type-act ,error)
                  (type (simple-array type-act
                                      (,(layer-spec-size
                                         (svref layer-specs (1- num-layers)))))
                        ,output-layer-act))
         (the type-act
           (progn
             (pattern-iterator ,netspec-form ,net
                               ,input-patterns
                               ,dest-patterns
                               ,numpatterns
                               :do-activate t
                               :do-calc-error t
                               :ext-func-activate ,ext-activation-fn
                               :var-error ,error
                               :var-name-current-input-pattern ,current-input-pattern
                               :var-name-current-dest-pattern ,current-dest-pattern
                               :var-output-layer-act ,output-layer-act
                               :code-post ,code-post)
             ,error))))))


(defmacro linesearch-eval-net (netspec-form net
                               &key (use-saved-weights t)
                               ext-code-error-function
                               ext-func-adjust-weights
                               (eta (the type-weight (coerce 0.0 'type-weight))))
  "Builds an evaluation function for CG-linesearches"
  (declare (optimize (speed 1) (space 1) (safety 1) (debug 0)
                     (compilation-speed 0)))

  (apply
   #'possibly-do-flet
   (if (not ext-func-adjust-weights)
       `((loc-adjust-weights-fn (eta)
                                (declare
                                 ;; (:explain :variables :calls :types :boxing)
                                 (optimize (speed 3) (space 0) (safety 0) (debug 0)
                                           (compilation-speed 0))
                                 (type type-weight eta))
                                (adjust-weights ,netspec-form
                                                ,net
                                                :eta eta
                                                :use-saved-weights ,use-saved-weights))))
   (if (not ext-func-adjust-weights)
       '(declare (ftype (function (type-weight) nil)
                  loc-adjust-weights-fn)))
   (if ext-func-adjust-weights
       `(,ext-func-adjust-weights ,eta)
       `(loc-adjust-weights-fn ,eta))
   ext-code-error-function))

(defmacro linesearch-eval-net-one-pattern (netspec net
					   use-saved-weights
					   output-layer-act
					   dest
					   loc-activation-fn
					   &key (eta (the type-weight (coerce 0.0 'type-weight))))
  (declare (optimize (speed 1) (space 1) (safety 1) (debug 0)
		     (compilation-speed 0)))
  (let* ((layer-specs (net-spec-layer-specs netspec))
	 (num-layers (car (array-dimensions layer-specs))))
    `(flet ((loc-adjust-weights-fn (eta)
	      (declare
;;;		 (:explain :variables :calls :types :boxing)
	       (optimize (speed 3) (space 0) (safety 0) (debug 0)
			 (compilation-speed 0))
	       (type type-weight eta))
	      (adjust-weights ',netspec ,net :eta eta
			      :use-saved-weights ,use-saved-weights)))
       (declare (ftype (function (type-weight) nil)
		       loc-adjust-weights-fn))
;;       (format t "linesearch-eval-net-one-pattern:~%  -> eta ~a~%" ,eta)
       (loc-adjust-weights-fn ,eta)
       ,loc-activation-fn
       (the type-act
	 (sum-squares-error ,output-layer-act
			    ,dest
			    ,(layer-spec-size
			      (svref layer-specs (1- num-layers))))))))

(defmacro improved-elman-gdash (netspec-form
				nhid*wmean
				actmean)
  "EXPERIMENTAL: Calculates improved-elman g' value"
  (let* ((netspec (eval netspec-form))
	 (layer-specs (net-spec-layer-specs netspec))
	 (x (gensym "x-")))
    `(let* ((,x (,@(layer-spec-act-fn (svref layer-specs 1))
		   (* ,nhid*wmean ,actmean))))
       (,@(layer-spec-act-fn-dash (svref layer-specs 1))
	  ;; sum will hopefully be ignored by fn
	  ,(if (layer-spec-act-fn-dash-uses-sum
		(svref layer-specs 1))
	       `(* ,nhid*wmean ,actmean))
	  ,x))))



(defmacro patterns (nodes &rest data)
  (declare (optimize (speed 1) (space 1) (safety 1) (debug 0)
		     (compilation-speed 0)))
  `(vector
    ,@(mapcan
       #'(lambda (dat)
	   `((make-array ,nodes
			 :element-type 'type-act
			 :initial-contents ',(mapcar #'(lambda (da)
							 (the type-act (coerce (eval da) 'type-act)))
						     dat))))
       data)))

(defun make-patterns (nodes &rest data)
  (apply #'vector (mapcan (lambda (dat)
                            (list
                             (make-array
                              nodes
                              :element-type 'type-act
                              :initial-contents (mapcar
                                                 (lambda (x)
                                                   (coerce x 'type-act))
                                                 dat))))
                          data)))
                                        
                                        
