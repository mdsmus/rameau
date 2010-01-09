;;; -*- Mode: Lisp ; Base: 10 ; Syntax: ANSI-Common-Lisp -*-
;;; Lisp2-style Erlang/ML-like Extensible Pattern-Matcher for Common LISP
;;; Copyright (c) 2002-2008 Fahree Reedaw <fare@tunes.org>
#| "
This software is now being packaged for use with asdf-install.
The homepage for this software is
	http://www.cliki.net/fare-matcher
In case you want the latest version of the software, check the CVS at:
	http://fare.tunes.org/cgi-bin/viewcvs.cgi/fare/lisp/fare-matcher/
This package depends on package fare-utils in neighbouring CVS directory.

This software is released under the bugroff license. Use at your own risk.
	http://www.geocities.com/SoHo/Cafe/5947/bugroff.html
At the insistence of several hackers, I hereby state what is obvious to me,
that they can reuse any software released under the bugroff license
and publish it as part or totality of packages under any other license
they see fit, if it really matters to them, including a BSD-style license
or a MIT license. Yes they can. Of course, if they choose a proprietary
software license, they only deserve scorn. But even that, they may do!



See examples of use at the bottom of the file,
and in other files in this repository.
Help wanted in writing documentation.
(I'd help you write it by answering your questions.)

Install this package with:
(asdf-install:install :fare-matcher) ; XXX FIXME
Use this package with:
(asdf:oos 'asdf:load-op :fare-matcher)
" |#

(in-package :fare-matcher)

#| "
This is my attempt at a pattern matcher.

Semantic Design goals:
* ML- or Erlang-like semantics for pattern matching.
* Integration to the lexical environment:
 Variables in a match pattern are bound lexically around the form's body.
* Unlike destructuring-bind, follow the same Lisp2 paradigm
 of source-level lists specifying a generic pattern to call and its arguments.
 This also allows to trivially distinguish between variables and pattern names
 by a simple syntactic positional criterion.
* Extensibility through definition of new generic patterns,
 either functions or macros, by defining new names
 or having algebraic designators.
* No backtracking or unification implemented,
 but leaving possibility for such thing as an extension.

Implementation goals:
* macro-expansion-time transformation of pattern into recognizing code.
* This first version is no frills:
  no attempt at algorithmic efficiency, optimization or backtracking.
* Optimized for human simplicity.
* Highly-factored using higher-order functions and macros.
* Underlying control structures are to be abstract enough
 so that backtracking could be added by replacing them.

Implementation choices:
* the (ifmatch pattern form body...) macro expands into a
 (let (,@vars) (when (funcall ,matcher ,form) ,@body))
 where (pattern-matcher pattern) returns (values matcher vars)
* matching code uses matcher-passing style - that's good.
* macro-expansion code uses a direct synthesis technique - that's bad.
 It means that all bindings for the match are common to all the matching forms,
 which requires a bit of discipline from writers of LIKE-WHEN clauses
 so that nothing evil should happen.
 Instead, we should use a monadic lexical-environment-passing-style
 that would create bindings as the match progresses.
 (Or just put the bindings in a special variable!)
* not much of any error detection is done,
 and when there is, error reporting is minimal.
* not any pattern optimization is done by the matching macros (however,
 since patterns are expanded into lisp code at macro-expansion time,
 the compiler might still do a few optimizations and produce reasonable code).

To Do list:
* add better patterns for matching structures and classes
* add macros for defining simple patterns of patterns,
  both in matching and in building.
* add lots of error checking
* make for a better propagation of bindings within internal clauses of
  the pattern matcher (due to like-when). -- binding-passing style(?)
* add non-linearity???
* add backtracking, based on a CPS transform??? Or use Screamer?
* add first-class patterns (?)
* add pattern merging and optimization (!?) or maybe declarations?
 Factor the matching of identical initial patterns.
* add better documentation about the pattern matcher (???)
* add support for documentation strings in pattern defining forms
* add support for optional, rest and keyword arguments in defining forms
* add reader-macros for very common cases, if needed.
* have the equivalent of compiler-macros so as to define patterns to use
 when the patterns match a known pattern. E.g. when appending something
 to a list of known length (before or after), the matching procedure is simple.
* convert everything for use with some kind of first-class environments.
* implement VALUES to match multiple values

Documentation:
Lisp2 style means that instead of writing
        (destructuring-bind
	  (a b (c d ()) . e)
	  foo
	  (bar a b c d e))
You'd write
        (letm
	  (list* a b (list c d ()) e)
	  foo
	  (bar a b c d e))
The pattern might look heavier, because we match forms with an explicit
constructor in the head of a pattern, instead of matching nested lists as is,
with a few known "magic" values like &rest to introduce special behaviour.
But this design is precisely what makes the pattern matching more expressive:
it makes the pattern language more regular, it makes it match
the programming language, and most importantly, it makes it *extensible*.
You can trust that any symbol in head position is a pattern name,
while any symbol in parameter position is a variable name,
except if it is a pattern symbol macro, or if the head was a pattern macro,
in which case the macro controls the meaning of the pattern.

The only predefined pattern symbol macros are _ and * that match everything.
I used to have T match anything (top) and NIL match nothing (bottom),
which was consistent with the class system, but nobody liked it,
so instead they are considered (together with keywords) as literals
that match the constants T and NIL. You can still use (OF-TYPE T) and
(OF-TYPE NIL) if you would. I chose _ after the common usage in ML,
but then I added * too because it is consistent with its use in
type descriptions (for DEFTYPE or TYPEP). In a future release, I may
declare as obsolete the use of _, unless some user objects.

Predefined functional patterns are CONS, LIST, LIST*, VECTOR,
that match corresponding objects with a known arity.

Predefined macro patterns are QUOTE, VALUES, LIKE-WHEN, AND, WHEN, OF-TYPE,
SLOT*, ACCESSOR*, that respectively match a literal constant, the value
of an expression, a pattern with a guard condition, the conjunction of
several patterns, just a guard condition, any value of given type,
any object with slots as specified, and object with accessors as specified.
In fare-clos, it is also possible to match against an INSTANCE of a class
with slots specified by initargs.

IFMATCH tries to match a pattern with an expression,
and conditionally executes either the success form
in a properly extended lexical environment,
or the failure form in the original lexical environment,
depending on whether the match succeeded (with freshly bound variables) or not.
MATCH (that I won't rename to COND-MATCH) tries to match a given expression
with several patterns, and executes the body of the matching clause if found.
EMATCH is like MATCH except that when no match is found,
it raises an error instead of returning NIL.

With this paradigm, matching patterns are thus dual from normal forms.
I like to think of all forms as patterns, with some patterns being
in "deconstruction position" (left-hand side of a match clause),
and other patterns being in "construction position" (right-hand side
of a match clause).
Although the current implementation follows Erlang (or ML-like) semantics
for matching, this paradigm can be generalized to non-deterministic settings,
where you'd obtain something much like Oz or Mercury, unifying functional
and logic programming -- however, I haven't even attempted to implement
non-determinism (maybe this could be done using Screamer).

NB: Actually, I had first thought about this pattern-matcher when I was more
of a Lisp1 fan, and the fact that Lisp2 was much more natural for the pattern
matcher finished to turn me into a Lisp2 fan.

PS: multiple values were implemented in 2003 by Matthew Danish <mrd@debian.org>

Simple tests available with
(fare-matcher::test-matcher)
" |#

(eval-when (:compile-toplevel :load-toplevel :execute)

(defvar *regs* '()
 "A lazily-extended list of variables for use in generated code.")
(defun make-reg (n) (conc-gensym "R" n))
(defun make-regs (n m)
  (if (= n m) nil
    (cons (make-reg n) (make-regs (1+ n) m))))
(defun nregs (n &optional m)
  (when m (return-from nregs (subseq (nregs (+ m n)) m)))
  (when (length<n-p *regs* n)
    (setq *regs* (nconc *regs* (make-regs (length *regs*) n))))
  (subseq *regs* 0 n))

(defvar *form '#:form)
(defvar *failure-continuation '#:failure-continuation)
(defvar *m%point '#:m%point)

(propmacros symbol-matcher function-matcher)
(make-single-arg-form macro)

(defun count-values (pattern)
  (if (and (consp pattern)
           (eq 'values (first pattern)))
      (length (rest pattern))
    1))

(defun construct-values-closure (val-count exp)
  "construct a form that will save the values from exp and build a closure
that can spit these values back at will, knowing that
there will be at most val-count values"
  (let ((vars (nregs val-count)))
    `(multiple-value-bind ,vars ,exp
       #'(lambda ()
	   (values ,@vars)))))

(defun construct-values-closure-nary (exp)
  "construct a form that will save the values from exp and build a closure that
can spit these values back at will, not knowing how many values there will be."
  (let ((var (first (nregs 1))))
    `(let ((,var (multiple-value-list ,exp)))
       #'(lambda ()
	   (apply values ,var)))))

(defmacro match (exp &rest clauses)
  "tries to match EXP successively with each clause's pattern,
until a match is found (if any -- otherwise return NIL),
and then execute the body of the pattern in the lexical environment
extended by the variables defined by the matched pattern."
  (if (null clauses)
      (if (eq exp *form) nil `(progn ,exp nil)) ;;; nothing (left) to match
    (let* ((first-clause (car clauses))
	   (other-clauses (cdr clauses))
	   (first-pattern (car first-clause))
	   (first-body (cdr first-clause))
	   (matchform
	    `(ifmatch ,first-pattern ,*form
		      (progn ,@first-body)
		      (match ,*form ,@other-clauses))))
      (if (eq exp *form)
	  matchform
	`(let ((,*form
		,(construct-values-closure
		  (loop for (pat nil) in clauses
		    maximizing (count-values pat))
		  exp)))
	   (declare (ignorable ,*form))
	   ,matchform)))))

(defmacro ifmatch (pattern exp &optional (ifmatches t) iffails)
  "tries to match EXP with the pattern PATTERN,
and execute the IFMATCHES form in a lexical environment
extended with the matched variables in case of a match,
or otherwise the IFFAILS form in the calling lexical environment."
  (multiple-value-bind (matcher vars) (pattern-matcher pattern)
    (let ((form-rebinder
           (unless (eq exp *form)
             `((,*form
                ,(construct-values-closure (count-values pattern)
                                           exp))))))
      `(flet ((,*failure-continuation () ,iffails))
        #+(or cmu sbcl) (declare (ignorable #',*failure-continuation))
        (let (,@form-rebinder ,@vars)
          ,@(when form-rebinder `((declare (ignorable ,*form))))
          (funcall (block ,*m%point
                     (multiple-value-call ,matcher (funcall ,*form))
                     #'(lambda () ,ifmatches))))))))
(define-abbrevs ifm ifmatch)
(defmacro ematch (exp &rest clauses)
  `(match ,exp ,@clauses (* (error "match-failed"))))
(defmacro letm (pattern val &body body)
  `(ematch ,val (,pattern ,@body)))
(defun eql-matcher (val)
  "matcher for a given value"
  `#'(lambda (,*form) (m%when (eql ,*form ',val))))
(defun pattern-matcher (clause)
  (cond
   ((literalp clause)
    (eql-matcher clause))
   ((symbolp clause)
    (aif (symbol-matcher clause)
	 (values it nil)
	 (values
	  `#'(lambda (,*form) (setf ,clause ,*form))
	  (list clause))))
   ((combinationp clause)
    (let ((head (car clause))
	  (args (cdr clause)))
      (aif (combination-matcher head)
	   (apply it args)
	   (error "unrecognized matching form ~A" head))))
   (t (error "pattern not recognized"))))
(defun combination-matcher (head)
  (aif (function-matcher head)
       (if (macrop it) (single-arg it)
	 (function-to-macro-matcher it))))
(defun function-to-macro-matcher (f)
  #'(lambda (&rest args)
    (mvbind (arg-matchers arg-var-lists)
	    (mapcar2 #'pattern-matcher args)
	    (values `(funcall ,f ,@arg-matchers)
		    (merge-matcher-variables arg-var-lists)))))
(defun merge-matcher-variables (arg-var-lists)
  (reduce #'merge-variables/2 arg-var-lists))
(defun merge-variables/2 (varlist1 varlist2)
  (reduce #'add-variable varlist2 :initial-value varlist1))
(defun add-variable (varlist var)
  (if (member var varlist) (error "variables can't appear twice in match")
    (append varlist (list var))))

(defmacro define-symbol-matcher (x fun)
  `(setf (symbol-matcher ',x) ,fun))
(defmacro define-macro-matcher (x fun)
  `(setf (function-matcher ',x) (make-macro ,fun)))
(defmacro define-function-matcher (x fun)
  `(setf (function-matcher ',x) ,fun))
(defmacro copy-symbol-matcher (&rest l)
  `(progn ,@(mapcar #'(lambda (x)
			`(setf (symbol-matcher ',(car x))
			       (symbol-matcher ',(cdr x))))
		    (plist->alist l))))
(defmacro copy-symbol-and-matcher (&rest l)
  `(progn (copy-symbol-matcher ,@l)
	  (copy-symbol-value ,@l)))
(defmacro copy-function-matcher (&rest l)
  `(progn ,@(mapcar #'(lambda (x)
			`(setf (function-matcher ',(car x))
			       (function-matcher ',(cdr x))))
		    (plist->alist l))))
(defmacro copy-function-and-matcher (&rest l)
  `(progn (copy-function-matcher ,@l)
	  (copy-symbol-function ,@l)))

(defun constructor-matcher-to-function-matcher (fun arity)
  (let ((mvars (nregs arity))
	(vvars (nregs arity arity)))
    `#'(lambda ,mvars
	    #'(lambda (,*form)
		(mvbind ,vvars (funcall ,fun ,*form)
			(m%and ,@(mapcar #'(lambda (m v) `(funcall ,m ,v))
					 mvars vvars)))))))
(defmacro define-constructor-matcher (name arity fun)
  `(define-function-matcher ,name
     ',(constructor-matcher-to-function-matcher fun arity)))

(defmacro define-varary-constructor-matcher (name fun)
  `(define-macro-matcher ,name
     #'(lambda (&rest mlist)
	 (let ((arity (length mlist)))
	   (apply (function-to-macro-matcher
		   (constructor-matcher-to-function-matcher
		    `#'(lambda (,*form) (funcall ,',fun ,*form ,arity))
		    arity))
		  mlist)))))

;;; NB: can't be defconstant since constantly might return non-EQL functions
(defun m%success (&rest args) (declare (ignore args)) nil)
(defmacro m%fail () `(return-from ,*m%point #',*failure-continuation))
(defmacro m%values (&rest rest) `(values ,@rest))
(defmacro m%succeed () `(return-from ,*m%point #'m%success))
(defmacro m%and (&rest rest) `(progn ,@rest))
(defmacro m%when (x &body body) `(if ,x (progn ,@body) (m%fail)))
(defmacro m%or (&rest clauses)
  (if (null clauses)
    `(m%fail)
    `(flet ((,*failure-continuation () (m%or ,@(cdr clauses))))
        #+(or cmu sbcl) (declare (ignorable #',*failure-continuation))
       (funcall (block ,*m%point ,(car clauses) (m%succeed))))))

; These two don't seem to be very popular:
;(define-symbol-matcher t `#'(lambda (,*form) (declare (ignore ,*form)) nil))
;(define-symbol-matcher nil `#'(lambda (,*form) (declare (ignore ,*form)) (m%fail)))
(define-symbol-matcher _ `#'m%success) ; matches everything
(define-symbol-matcher * `#'m%success) ; matches everything

(define-macro-matcher quote #'eql-matcher)

(define-macro-matcher value
  #'(lambda (sexp)
      `#'(lambda (,*form) (m%when (eql ,*form ,sexp)))))
(define-macro-matcher of-type
  #'(lambda (type)
      `#'(lambda (,*form) (m%when (typep ,*form ',type)))))
(define-macro-matcher satisfies
  #'(lambda (predicate)
      `#'(lambda (,*form) (m%when (funcall ,predicate ,*form)))))


; we ought to execute the bodies of as and when in environments
; where only the bound variables are in the scope.
; Tricky - means we must be use a matcher-passing transform
; rather than the current matcher synthetizer.
; also, because x can appear both in the both of a (value ...)
; and as a variable to bind, we must bind values to fresh variables,
; and only make them appear as the programmer's value when needed - ouch.
(define-macro-matcher when
  #'(lambda (cond)
      (values `#'(lambda (,*form)
		   (declare (ignore ,*form))
		   (m%when ,cond))
	      nil)))
(define-macro-matcher like-when
  ; (like-when foo bar) == (and foo (when bar))
  #'(lambda (pat cond)
      (mvbind (matcher vars) (pattern-matcher pat)
	 (values `#'(lambda (,*form)
		    (m%and (funcall ,matcher ,*form)
			   (m%when ,cond)))
		 vars))))
(define-macro-matcher and
  #'(lambda (&rest args)
      (mvbind (arg-matchers arg-var-lists)
	      (mapcar2 #'pattern-matcher args)
	    (values `#'(lambda (,*form)
			 (m%and ,@(mapcar #'(lambda (m) `(funcall ,m ,*form))
					  arg-matchers)))
		     (merge-matcher-variables arg-var-lists)))))
(define-macro-matcher or
  ; FIXME: several branches of an OR pattern can't share variables;
  ; variables from all branches are visible in guards and in the body,
  ; and previous branches may have bound variables before failing.
  ; This is rather bad.
  #'(lambda (&rest args)
      (mvbind (arg-matchers arg-var-lists)
	      (mapcar2 #'pattern-matcher args)
	    (values `#'(lambda (,*form)
			 (m%or ,@(mapcar #'(lambda (m) `(funcall ,m ,*form))
					  arg-matchers)))
		     (merge-matcher-variables arg-var-lists)))))

(define-constructor-matcher cons 2
  #'(lambda (form)
      (m%when (consp form)
	(m%values (car form) (cdr form)))))
(define-varary-constructor-matcher list
  #'(lambda (form n)
     (m%when (and (listp form) (length=n-p form n))
	     (apply #'values form))))
(define-varary-constructor-matcher list*
  #'(lambda (form n)
     (m%when (and (listp form) (length>=n-p form (1- n)))
	     (apply #'values (rcons (firstn (1- n) form)
				    (nthcdr (1- n) form))))))

(define-constructor-matcher rcons 2
  #'(lambda (form)
      (m%when (and (consp form) (listp form))
	(m%values (butlast form) (car (last form))))))
(define-varary-constructor-matcher rlist*
  #'(lambda (form n)
     (m%when (and (listp form) (length>=n-p form n))
	     (apply #'values (cons (butlast form (1- n))
				   (last form (1- n)))))))

(define-varary-constructor-matcher vector
  #'(lambda (form n)
     (m%when (and (vectorp form) (= (length form) n))
	     (apply #'values (coerce form 'list)))))

(defun many-form-matcher (accessor-accessor)
  #'(lambda (&rest arglist)
      (let ((matchers '())
	    (var-lists '()))
	(mapc #'(lambda (x)
		  (let* ((accessor (first x))
			 (pat (second x)))
		    (mvbind (matcher vars) (pattern-matcher pat)
		      (push `(funcall ,matcher
				      ,(funcall accessor-accessor
						accessor *form))
			    matchers)
		      (push vars var-lists))))
	      arglist)
	(values
	 `#'(lambda (,*form)
	      `(m%and ,,@(nreverse matchers)))
	 (merge-matcher-variables var-lists)))))
(define-macro-matcher slot*
  (many-form-matcher
   #'(lambda (slot-name form) `(slot-value ,form ',slot-name))))
(define-macro-matcher accessor*
  (many-form-matcher
   #'(lambda (accessor-name form) `(,accessor-name ,form))))

(define-macro-matcher values
  #'(lambda (&rest pats)
      (let ((rest-param (gensym))
	    matchers all-vars params opt-preds
	    (lambda-list (list '&optional)))
	(dolist (pat pats)
	  (multiple-value-bind (matcher vars)
	      (pattern-matcher pat)
	    (push matcher matchers)
	    (push vars all-vars)
	    (push (gensym) params)
	    (push (gensym) opt-preds)
	    (push `(,(first params)
		    nil
		    ,(first opt-preds))
		  lambda-list)))
	(push '&rest lambda-list)
	(push rest-param lambda-list)
	(setf matchers (nreverse matchers)
	      all-vars (nreverse all-vars)
	      params (nreverse params)
	      opt-preds (nreverse opt-preds)
	      lambda-list (nreverse lambda-list))
	;; purpose of all this is to allow the matcher function to
	;; be called with any arity
	(values `#'(lambda ,lambda-list
		     (declare (dynamic-extent ,rest-param ,@params)
			      (ignore ,rest-param))
		     (m%and
		      ,@(loop for matcher in matchers
			  for param in params
			  for opt-pred in opt-preds
			  collect
			  `(when ,opt-pred
			     (funcall ,matcher ,param)))))
		(merge-matcher-variables all-vars)))))

#+cmu
(copy-function-matcher
 lisp::backq-list cl:list
 lisp::backq-list* cl:list*
 lisp::backq-cons cl:cons
 lisp::backq-vector cl:vector)

#+sbcl
(copy-function-matcher
 sb-impl::backq-list cl:list
 sb-impl::backq-list* cl:list*
 sb-impl::backq-cons cl:cons
 sb-impl::backq-vector cl:vector)

#+clisp
(define-macro-matcher system::backquote
  #'(lambda (&rest r)
      (let* ((system::*backquote-optimize-append* t)
	     (system::*backquote-optimize-cons* t)
	     (system::*backquote-optimize-list* t)
	     (system::*backquote-optimize-nconc* t)
	     (system::*backquote-optimize-vector* t)
	     (exp (macroexpand-1 (cons 'system::backquote r))))
	(pattern-matcher exp))))

);eval-when

#| "
Notes:

The basic principle of the matcher is precisely what I envisioned,
and is correct; it is extensible as should.
However, the internals are very rough --
you can feel it's obviously a first try.
The principle of producing pattern-passing code is nice.
But the current code creates all the bindings at the beginning of the match,
and the matcher should be written in binding-passing code.
There also needs be improvements to the infrastructure
to build pattern constructors, so that you may build
pattern constructors and destructors at the same time
(much like you do when you define ML types).
Being able to deconstruct functions would be nice,
but it implies the use of Screamer or some other backtracking infrastructure.
Now, that would precisely be a nice thing to try,
because that's were the notion of linearity of continuations and bindings
wrt some space become interesting.
So that's definitely something I'll have to experiment with.
Nobody reported using the matcher --
ML/Erlang style pattern matching seemingly isn't popular with LISP hackers.
In any case, though the general design is what I want,
the current pattern matcher is still not elaborate enough
for the tricks I intended when I wrote that scheme code in the tunes cvs.
" |#

#+DO-TEST
(defun test-matcher ()
  "a few forms to test the pattern matcher."
  (defun my-length (x)
    (ematch x
      ((cons * tail) (1+ (my-length tail)))
      ('nil 0)))
  (TTEST*
   ((ifmatch (cons * (cons x y)) '(1 (2 3) 4) (list x y)) :result '((2 3) (4)))
   ((ifmatch (like-when (cons x y) (eql x y)) '(2 . 2) x) :result 2)
   ((ifmatch (and (cons x y) (when (eql x y))) '(2 . 2) x) :result 2)
   ((ifmatch (and (cons a 1) (cons 2 b)) '(2 . 1) (list a b)) :result '(2 1))
   ((ifmatch (list a b) '(1 2) (list b a)) :result '(2 1))
   ((ifmatch (list* a b c) '(1 2 3 4) (list a b c)) :result '(1 2 (3 4)))
   ((ifmatch (and x (cons (of-type integer) *)) '(2) x) :result '(2))
   ((let ((res 2))
      (ifmatch (cons 'reply (cons (value (+ 1 res)) (cons msg 'nil)))
	       '(reply 3 foo) (list res msg)))
    :result '(2 FOO))
   ((let ((res 2))
      (ifmatch (list 'reply (value (+ 1 res)) msg) '(reply 3 foo)
	  (list res msg)))
    :result '(2 FOO))
   ((my-length '(1 2 3)) :result 3)))
