;;;; -*- Mode: Lisp -*-
;;;; Extensions to Fare's pattern matcher

;;; Copyright (c) 2003 Matthew Danish <mrd@debian.org> 
;;; All rights reserved.
;;;
;;; Redistribution and use in source and binary forms, with or without
;;; modification, are permitted provided that the following conditions
;;; are met:
;;; 1. Redistributions of source code must retain the above copyright
;;;    notice, this list of conditions and the following disclaimer.
;;; 2. Redistributions in binary form must reproduce the above copyright
;;;    notice, this list of conditions and the following disclaimer in the
;;;    documentation and/or other materials provided with the distribution.
;;; 3. The name of the author may not be used to endorse or promote products
;;;    derived from this software without specific prior written permission.
;;;
;;; THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
;;; IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
;;; OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
;;; IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
;;; INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
;;; NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
;;; DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
;;; THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
;;; (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
;;; THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

;;;; DEFINE-ACCESSOR-MATCHER -- see docstring, and implementation of REC.
;;;; DEFRECORD --
;;;;   Just like DEFCLASS except that it
;;;;     (a) allows you to use the REC pattern matcher with the type
;;;;     (b) defines an order for the slots which can be overridden by
;;;;         the :SLOT-ORDER class option.
;;;; REC -- The pattern matcher for records, see examples.
;;;; AS -- Binds a variable and checks a pattern, like in ML. (AS <var> <pat>)
;;;; DEFMFUN, WITH-MFUNS, MFUN, MATCHFUN -- See docstrings.

(defpackage #:fare-matcher-extensions
  (:use #:common-lisp #:fare-matcher)
  (:nicknames #:match-exts)
  (:export #:define-accessor-matcher #:defrecord #:rec #:as
           #:defmfun #:with-mfuns #:mfun #:matchfun))

(in-package #:fare-matcher-extensions)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defun parse-pattern-lambda-list (ll)
    (let ((mode 'positional)
          matchers all-vars keys
          arg
          (i 0)
          (remaining ll))
      (loop until (null remaining) do
       
            (setf arg (first remaining))
            (cond ((eq arg ':named)
                   (setf mode 'named))
                  ((eq mode 'positional)
                   (push i keys)
                   (incf i)
                   (multiple-value-bind (matcher vars)
                       (pattern-matcher arg)
                     (push matcher matchers)
                     (push vars all-vars)))
                  ((eq mode 'named)
                   (push arg keys)
                   (setf remaining (rest remaining))
                   (when (null remaining)
                     (error "Uneven named pattern arguments."))
                   (multiple-value-bind (matcher vars)
                       (pattern-matcher (first remaining))
                     (push matcher matchers)
                     (push vars all-vars))))
            (setf remaining (rest remaining)))
      (values (nreverse matchers)
              (nreverse all-vars)
              (nreverse keys))))
  (defun maybe-first (x)
    (if (consp x)
        (first x)
        x)))

(defmacro define-accessor-matcher (matcher-name (type-arg key-arg)
                                   &body body)
  "Defines a new kind of matcher with the name MATCHER-NAME.  These kind
of matchers use patterns like these:

(MATCHER-NAME TYPE-OF-OBJECT POSITIONAL-1 POSITIONAL-2 ...) or
(MATCHER-NAME TYPE-OF-OBJECT :NAMED NAME1 PAT1 NAME2 PAT2 ...) or
a combination of first positional and then named patterns, ie
(MATCHER-NAME TYPE-OF-OBJECT POSITIONAL-1 :NAMED NAME1 PAT1).

TYPE-ARG and KEY-ARG are the names of the arguments which will be supplied
to the forms of BODY, containing respectively the TYPE-OF-OBJECT and a
value corresponding to the position or name of the specific slot in question.
KEY-ARG will have type (or symbol integer).  The forms of BODY are expected
to return an unevaluated lambda form or function name, that takes one
argument and returns the value of the field in that argument."

  `(flet ((get-accessor (,type-arg ,key-arg)
           ,@body))
    (define-macro-matcher ,matcher-name
        #'(lambda (type &rest pats)
            (multiple-value-bind
                  (matchers all-vars keys)
                (parse-pattern-lambda-list pats)
              (values `#'(lambda (form)
                           (m%when (typep form ',type)
                                   (m%and
                                    ,@ (loop for matcher in matchers
                                             for key in keys
                                             collect
                                             `(funcall ,matcher
                                               (funcall ,(get-accessor type
                                                                       key)
                                                form))))))
                      (when all-vars
                        (merge-matcher-variables all-vars))))))))

(defgeneric record-accessor (type key))
  
(defmacro defrecord (name
                     (&rest supers)
                     (&rest slots)
                     &rest args)
  (let* ((order-arg (assoc :slot-order args))
         (slot-names (if order-arg
                         (rest order-arg)
                         (mapcar #'maybe-first slots))))
    (when order-arg
      (setf args (remove :slot-order args
                         :key 'first)))
    `(progn
      (let ((vec (coerce ',slot-names 'vector)))
        (defmethod record-accessor ((name (eql ',name))
                                    (key integer))
          (unless (and (not (minusp key))
                       (< key (length vec)))
            (error "Invalid positional field ~A for record type ~A"
                   key name))
          `#'(lambda (obj)
               (slot-value obj ',(aref vec key))))
        (defmethod record-accessor ((name (eql ',name))
                                    (key symbol))
          (unless (find key vec)
            (error "Invalid record field name: ~A for record type ~A"
                   key name))
          `#'(lambda (obj)
               (slot-value obj ',key))))
      (defclass ,name ,supers ,slots ,@args))))

(define-accessor-matcher rec (type key)
  (record-accessor type key))

(define-macro-matcher as
    #'(lambda (var pat)
        (multiple-value-bind (matcher vars)
            (pattern-matcher pat)
          (values `#'(lambda (form)
                       (m%and (funcall ,matcher form)
                              (setf ,var form)))
                  (merge-matcher-variables (list vars (list var)))))))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defparameter *clause-beginning-markers*
    '(= || of))
  (defparameter *clause-body-markers*
    '(=> ->))
  (defun parse-clause-args (args cont)
    (cond ((null args)
           (error "Unexpected end of list, expected argument or one of ~A."
                  *clause-body-markers*))
          ((and (or (symbolp (first args))
                    (stringp (first args)))
                (find (first args) *clause-body-markers*
                      :test 'string=))
           (funcall cont nil (rest args)))
          (t
           (parse-clause-args (rest args)
                              #'(lambda (final-args remaining)
                                  (funcall cont
                                           (cons (first args)
                                                 final-args)
                                           remaining))))))
  (defun parse-clause (clauses cont)
    (cond ((consp (first clauses))
           (funcall cont
                    (first clauses)
                    (rest clauses)))
          ((find (first clauses) *clause-beginning-markers*
                 :test 'string=)
           (parse-clause-args (rest clauses)
                              #'(lambda (args remaining)
                                  (funcall cont
                                           (list (cons 'values args)
                                                 (first remaining))
                                           (rest remaining)))))
          (t
           (error "Expected either a CONS or one of ~A at beginning of clause, got: ~A."
                  *clause-beginning-markers*
                  (first clauses)))))
  
  (defun parse-matchfun-clauses (clauses)
    (cond
      ((null clauses)
       ())
      (t
       (parse-clause clauses
                     #'(lambda (clause remaining)
                         (cons clause
                               (parse-matchfun-clauses remaining)))))))

  (defun process-matchfun (clauses)
    (let* ((clauses
            (parse-matchfun-clauses clauses))
           (param-count
            (loop for clause in clauses
                  for pat = (first clause)
                  maximizing
                  (if (and (consp pat)
                           (eq 'values (first pat)))
                      (length (rest pat))
                      1)))
           (params (loop repeat param-count collect (gensym "PARAM"))))
      (values params 
              `(ematch (values ,@params)
                ,@clauses)))))


(defmacro defmfun (name &rest clauses)
  "Creates a function called NAME which pattern matches its arguments
against various clauses.  Clauses have a grammar of either:
<open-paren> <pattern> <forms>... <close-paren>
or:
<begin> <pattern1> <pattern2> ... <patternn> <separator> <form>
where
<begin> is one of the values of *CLAUSE-BEGINNING-MARKERS*
and <separator> is one of the values of *CLAUSE-SEPARATOR-MARKERS*.
Each <pattern(i)> is considered to be a member of a VALUES pattern."
  (multiple-value-bind (params match-form)
      (process-matchfun clauses)
    `(defun ,name ,params
      ,match-form)))

(defmacro with-mfuns ((&rest funs) &body body)
  "Like LABELS, but see DEFMFUN for syntax of clauses."
  `(labels ,(loop for fun in funs
                  for name = (first fun)
                  for clauses = (rest fun)
                  collect
                  (multiple-value-bind (params match-form)
                        (process-matchfun clauses)
                    `(,name ,params ,match-form)))
    ,@body))

(defmacro matchfun (&rest clauses)
  "Like LAMBDA, but see DEFMFUN for syntax of clauses."
  (multiple-value-bind (params match-form)
      (process-matchfun clauses)
    `#'(lambda ,params ,match-form)))

(defmacro mfun (&rest clauses)
  "See MATCHFUN"
  `(matchfun ,@clauses))

#||

;; Examples:

(defrecord foo ()
  ((bar :initarg :bar)
   (baz :initarg :baz))
  ;; by default, it would be (BAR BAZ)
  (:slot-order baz bar))

(ifmatch (rec foo x :named bar y)
         (make-instance 'foo :bar 1 :baz 2)
         (list x y))


(defmfun foo
    = () => ()   
    = (cons x xs) => (append (foo xs) (list x)))

(with-mfuns
    ((foo = () => ()
          = (cons x xs) => (append (foo xs) (list x))))
  
  (foo (list 1 2 3)))

(funcall ((lambda (f)
            (lambda (x)
              (funcall f f x)))
          (mfun of f () -> ()
                || f (cons x xs) -> (append (funcall f f xs)
                                            (list x))))
         (list 1 2 3))

||#