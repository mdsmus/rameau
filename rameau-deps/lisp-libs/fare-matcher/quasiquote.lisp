;;; -*- Mode: Lisp ; Base: 10 ; Syntax: ANSI-Common-Lisp -*-
;;; fare-matcher friendly implementation of Quasiquote
;;; Copyright (c) 2002-2006 Fahree Reedaw <fare@tunes.org>

#| "
PURPOSE

The main purpose of this n+2nd reimplementation of quasiquote,
is enable matching of quasiquoted patterns with fare-matcher.

Now, developing this implementation is also a challenge in understanding
the ins and outs of quasiquotation, and in exploring the way it interacts
with extended support for constant-building syntactic constructs.
And this, at least to me is as much fun as it is an intellectual challenge. :-)


INTERACTION WITH FARE-MATCHER

This implementation of quasiquote requires the FARE-MATCHER system.

It enables quasiquotation inside FARE-MATCHER patterns.
However, as a limitation to such use, note that as long as
the pattern-matcher isn't extended to match APPEND patterns,
which typically requires backtracking, then those quasiquote templates
that expand into something using APPEND can't be used as patterns to match.
This mostly restricts the use of ,@ or ,. to the end of a list.

This implementation also uses FARE-MATCHER internally,
which allows to tremendously simplify the simplifier
used to normalize quasiquote-using expressions.
This simplifier in turn is necessary to simplify APPEND patterns
into CONS LIST* and LIST patterns for use with FARE-MATCHER.


REFERENCES

Essential documents consulted while implementing this file:
Alan Bawden's paper: http://www.bawden.org/ftp/pepm99.ps.gz
CLtL2: http://www.supelec.fr/docs/cltl/clm/node367.html
CLHS: http://www.lisp.org/HyperSpec/Body/sec_2-4-6.html
Slate reference manual section 2.6.2 on quoting and unquoting:
    http://slate.tunes.org/doc/progman/node12.html#SECTION00046200000000000000


NOTES

* We provide for a read-time quasiquote expander as well as
 a macro-expansion-time quasiquote expander.
 The read-time expander handles #() syntax correctly
 but mightn't be as efficient as the built-in reader in the common case,
 whereas the macro-expansion-time sees #() too late (see BUGS).
 To use the macro-expansion-time one, uncomment the line that declares
 feature :quasiquote-at-macro-expansion-time.


TO DO

* The CLHS doesn't tell anything about multi-dimensional arrays;
 however, this is the opportunity to define a MUP: Meta Unquote Protocol.
 The MUP would allow to extend the quasiquote mechanism with support
 for new constant-building syntactic constructs as such constructs are defined.
 Maybe we will end up with a full-fledge declarative infrastructure
 for a Parser-Preprocessor-Pretty-Printer, like camlp4 only more declarative.

* Can we improve performance?
 Statically compile and optimize the patterns for the simplifier?

* Implement the MUP with an abstract API for new readers;
 as examples, provide readers for existing syntax that can be toggled
 as either unquote-aware or not: #(), #A, etc.

* Implement tagged (and multiple-valued?) quasiquotes, unquotes and quotes.


BUGS:

* It looks like there are nasty bugs in the simplifier.
 Maybe start again afresh with a MUP for CONS?

* This version works inside simple vectors, so as to support
 unquoting inside the #(...) syntax as the standard mandates.
 However, doing that at macro-expansion time means that we disturb
 any SIMPLE-VECTOR that appears in the source code, even if it comes
 from forms other than #(...), such as #1A(...) or #.(VECTOR ...).
 This phenomenon has been documented before in the following message:
	http://groups.google.com/groups?q=author:kaz%40ashi.footprints.net&hl=en&lr=&ie=UTF-8&oe=UTF-8&safe=off&selm=cf333042.0303141409.bbf02e9%40posting.google.com&rnum=4

* Interestingly, I haven't seen the following problem stated, to know which is
 correct of `#2(1 ,@'(2 3)) or `#3(1 ,@'(2 3)). In other words, does the read
 argument to #() mean something at read-time or at vector-creation-time?
 Of course, in the original intended usage, outside of any quasiquoting,
 read-time and vector-creation-time are one and the same.
 But what when quasiquote breaks up that identity?

* Note that we do not handle unquoting inside structures
 or arrays more complex than simple vectors.

* Note that in the case of the macro-expansion-time expander,
 we do not check for lone unquote syntax before macro expansion,
 which may lead this implementation to accept hacks
 that are not valid according to the standard, such as
 macros that produce unbalanced unquote syntax markers.

* Certainly, the implementation of quasiquote should be "opened"
 so as to allow new syntactic features to take advantage of it.
 Then, maybe we can redefine our own proper reader behaviour for #(...)
 and each MUP-supporting piece of syntax, on top of the MUP?

 Note that copying and modifying read-tables is expensive, that dynamically
 modifying and restoring read-tables might interfere with #. syntax, and that
 caching modified read-tables will interfere with any subsequent modification
 of a cached read-table, comparison not being possible.
 This means that if we wanted the MUP to adapt to existing extensions
 without modifying existing code, we would have to intercept the definition
 of syntax reading functions before they are fed to either SET-MACRO-CHARACTER
 or SET-DISPATCH-MACRO-CHARACTER. Spooky.
 Now, this also requires that the current depth of quasiquoting be consulted
 any time any of the MUP-enabled constructors is read.

* The principle of the MUP is that
 = structure readers that don't want to support unquote MUST be wrapped into
  something that dynamically binds *quasiquote-level* to 0.
 = structure readers #C(ARGSYNTAX) that do want to support unquote
  MUST accumulate formal arguments to a structure constructor
  into a list ARGUMENTS, then, if *quasiquote-level* is 0, behave like
  #.(apply `#CONSTRUCTOR `#ARGUMENTS)
  otherwise, behave like
  ,(apply `#CONSTRUCTOR `#ARGUMENTS)
  where #CONSTRUCTOR is the name of the constructor for given structure,
  and #ARGUMENTS is whichever arguments have been deduced from the syntax,
  which may include as many levels of unquotations as *quasiquote-level* says.
  Note that in a strong sense, #. is like , assuming an infinite tower of
  read-time evaluators a la 3-LISP.

* Note that the above is obscured because we're trying to discuss
 the behaviour of quasiquote-containing programs without having
 a meta-level quasiquoting facility that could distinguish
 between what is constant or variable at the meta-level independently from
  what is constant or variable at the base level:
 #CONSTRUCTOR and #ARGUMENTS would be better specified
 through a special meta-level unquotation, the above expressions
 being in a corresponding special quasiquotation.
 A feature that would allow for clear separation of levels of meta-language
 would be a tagged quasiquote feature, as in Slate (http://slate.tunes.org/).

* This version is not safe with respect to quasiquoting expressions
 where appear some marker symbols interned in the FARE-QUASIQUOTE package --
 such expressions may lead to confusion between the body of expressions
 being quasiquoted and the internal quasiquote infrastructure.
 Any objects used as markers instead of these interned symbols
 would lead to the same "bug" if somehow used inside quasiquoted expressions;
 but at least, non-interned symbols or gensyms would allow to avoid this bug
 in expressions being READ. The "perfect" solution would be to use
 objects GENSYMed at the moment a given QUASIQUOTE is read,
 and kept in a lexical variable to prevent introspective cheat by #. syntax.
 Then, after simplifying expressions, we could pass the read expression
 through functions that would SUBSTitute proper symbols for the markers,
 from the quasiquote package if pretty-printing is to be supported,
 or otherwise from the CL package.
 Note that this would have to be interleaved with support for working
 inside vectors and other syntax. This is all very tricky
 and until further notice is left as an exercise to the intrepid reader.
 Thus, while the behaviour of our implementation isn't strictly correct,
 we don't go through the hassle of modifying it into something
 much less readable just for the sake of preventing code that would
 deliberately confuse the quasiquote engine.
 Now, if we imagine that some code were dynamically generated
 based on system introspection, that could contain some of our magic markers,
 then this code would have to be made safe for interaction with QUASIQUOTE;
 this might (or might not?) require making QUASIQUOTE 100% fool-proof.

* This implementation simplifies quasiquoting of literals
 and other self-evaluating objects into the object itself,
 instead of a `(QUOTE ,object) expression.
 This is also the behaviour of the simplifier in CMUCL and SBCL,
 but some people have expressed concerns that it might not be
 strictly allowed in letter or spirit by the Common Lisp standards.
 We believe that our behaviour is correct in both letter and spirit;
 but in any case, a more literally correct (pun intended) behaviour
 with respect to the CL standards can be achieved by defining
 the feature QUASIQUOTE-QUOTES-LITERALS (untested).

* The idea of making circular data-structures work within quasiquotation
 makes my head ache with overarching pain. I make no attempt to try that,
 and most conspicuously not in the simplifier. You're crazier than I am
 if you do it and do it right.

PS: If you're able to follow this discussion, you impress me.
Come join the TUNES project!

" |#

(in-package :fare-quasiquote)

(eval-when (:compile-toplevel :load-toplevel :execute)
; comment/uncomment the line below to enable/disable some simplifications:
;(pushnew :quasiquote-quotes-literals *features*)
; comment/uncomment the line below to enable/disable some simplifications:
;(pushnew :quasiquote-at-macro-expansion-time *features*)
)

(eval-when (:compile-toplevel :load-toplevel :execute)
; the below instruction enables pattern-matching for the simplifier.
(copy-function-matcher
 list  cl:list
 list* cl:list*
 cons  cl:cons
 quote cl:quote
 vector cl:vector)

(make-single-arg-form quote kwote)
(make-single-arg-form quasiquote)
(make-single-arg-form unquote)
(make-single-arg-form unquote-splicing)

(defmacro quote (x) (list 'cl:quote x))
(defmacro quasiquote (x) (quasiquote-expand x))
(defmacro unquote (x)
  (declare (ignore x))
  (error "unquote only allowed within quasiquote"))
(defmacro unquote-splicing (x)
  (declare (ignore x))
  (error "unquote-splicing disallowed outside quasiquote"))

(define-symbol-matcher knil
  '#'(lambda (form)
       (or (null form)
	   (and (quotep form) (null (single-arg form)))
	   (m%fail))))
(defparameter knil
  #+quasiquote-quotes-literals (kwote nil)
  #-quasiquote-quotes-literals nil)
);eval-when

(defparameter *quasiquote-level* 0
  "current depth of quasiquote nesting")

(defun quasiquote-expand (x)
  (let ((e (expand x)))
    (if (<= 1 *quasiquote-level*)
	(simplify e)
	e)))

(defun expand (x)
  "Expand a quasiquoted form in single object context"
  (cond
   ((literalp x) #+quasiquote-quotes-literals (kwote x)
		 #-quasiquote-quotes-literals x)
   ((or (symbolp x) (quotep x)) (kwote x))
   ((quasiquotep x) (expand (quasiquote-expand (single-arg x))))
   ((unquotep x) (insert (single-arg x)))
   ((unquote-splicing-p x) (error "can only splice in list context"))
   ((consp x) (k-append (expand-list (car x)) (expand (cdr x))))
   #+quasiquote-at-macro-expansion-time
   ((simple-vector-p x)
    (k-vector (quasiquote-expand (coerce x 'cl:list))))
   (t ;(warning "unrecognized object in quasiquote")
      (kwote x))))

(defun expand-list (x)
  "Expand a quasiquoted form in list context"
  (cond
   ((literalp x) (k-list #+quasiquote-quotes-literals (kwote x)
			 #-quasiquote-quotes-literals x))
   ((or (symbolp x) (quotep x)) (k-list (kwote x)))
   ((quasiquotep x) (expand-list (quasiquote-expand (single-arg x))))
   ((unquotep x) (k-list (single-arg x)))
   ((unquote-splicing-p x) (insert (single-arg x)))
   ((consp x) (k-list (k-append (expand-list (car x))
				(expand (cdr x)))))
   #+quasiquote-at-macro-expansion-time
   ((simple-vector-p x)
    (k-vector (quasiquote-expand (coerce x 'cl:list))))
   (t ;(warning "unrecognized object in quasiquote")
      (k-list (kwote x)))))

(defun simplify-head (x)
  ;;; You don't want to know just how ugly this would be
  ;;; without pattern-matching
  ;;; However, a better implementation would attempt simplifications
  ;;; at the place where things are constructed:
  ;;; simplifications for LIST* would happen where LIST* is called, etc.
  ;;; An even better implementation would do deforestation on the declarative
  ;;; combination of the two rewrite systems.
  (labels ((s (x)
   (match x
    ;; constant folding
    ((cons (and c (or 'cons 'list* 'list 'append
		      'vector 'make-vector
		      #-quasiquote-at-macro-expansion-time 'n-vector))
	   (and l (when (all-constant-forms-p l))))
     (s (kwote (apply c (unfold-constant-forms l)))))
    ;; simplify list* and its particular case cons
    ((list 'list* l)
     l)
    ((cons (or 'cons 'list*) (rcons l knil))
     (apply #'k-list l))
    ;((cons (or 'cons 'list*) (rcons l1 (list (or 'quote 'cl:quote) l2)))
    ; (if (proper-list-p l2)
    ;   (apply #'k-list (append l1 (protect-constant-forms l2)))
    ;   x))
    ((cons (or 'cons 'list*)
	   (rcons l1 (cons (and c (or 'cons 'list* 'list)) l2)))
     (s (cons (list-extender c) (append l1 l2))))
    ((list 'list* y z)
     (if (unquote-splicing-p y) x (k-cons y z)))
    ;; simplify vectors
    #-quasiquote-at-macro-expansion-time
    ((list 'n-vector knil l)
     (s (list 'make-vector l)))
    ((list 'make-vector (cons 'list l))
     (cons 'vector l))
    ;; simplify append
    ((list 'append)
     knil)
    ((list* 'append knil l)
     (s (apply #'k-append l)))
    ((cons 'append (rcons l knil))
     (s (apply #'k-append l)))
    ((cons 'append (rcons l1 (cons 'append l2)))
     (s (cons 'append (append l1 l2))))
    ((cons 'append (cons (cons 'append l1) l2))
     (s (cons 'append (append l1 l2))))
    ((list* 'append (list 'quote kl) ll)
     (s (cons 'list*
	      (rcons (protect-constant-forms kl)
		     (s (apply #'k-append ll))))))
    ((list* 'append (cons 'list l1) l2)
     (s (cons 'list* (rcons l1 (s (apply #'k-append l2))))))
    ((list* 'append (cons (or 'cons 'list*) (rcons l1 l2)) l3)
     (s (cons 'list* (rcons l1 (s (k-append l2 (s (apply #'k-append l3))))))))
    ((list 'append l)
     (if (unquote-splicing-p l) x l))
    ; append treatment should be redone, and allow for better constant folding,
    ; resimplifying a whole list of append arguments when need be.
    (* x))))
  (s x)))

(defun simplify (x)
  (match x
    ((list 'quote *) x) ; do NOT go under quasiquote-generated quotes
    ;;; mind that this ISN'T cl:quote above.
    ((cons a b) (simplify-head (cons (simplify a) (simplify b))))
    (* x)))

;(defun simplify (x) x)

; we want our own tokens, but they must evaluate the usual way.
(defsubst list (&rest r) (apply #'cl:list r))
(defsubst append (&rest r) (apply #'cl:append r))
(defsubst list* (&rest r) (apply #'cl:list* r))
(defsubst cons (x y) (cl:cons x y))
(defsubst vector (&rest r) (apply #'cl:vector r))
(defsubst make-vector (l) (apply #'cl:vector l))

(defun k-vector (l) (list 'make-vector l))
(defun k-list (&rest r) (cons 'list r))
(defun k-append (&rest r) (cons 'append r))
(defun k-list* (&rest r) (cons 'list* r))
(defun k-cons (x y) (list 'cons x y))
(defun insert (x) x)

(defun list-extender (c)
  (case c
    ((cons list*) 'list*)
    ((list) 'list)
    (t (error "not a list constructor ~A" c))))

(defun self-evaluating-p (x)
  (or (literalp x)
      (not (or (symbolp x) (combinationp x) ; (simple-vector-p x)
	       ))))
(defun constant-form-p (x)
  (or #-quasiquote-quotes-literals (self-evaluating-p x)
      (quotep x)))
(defun all-constant-forms-p (l)
  (every #'constant-form-p l))
(defun unfold-constant-form (x)
  (if (quotep x) (single-arg x) x))
(defun unfold-constant-forms (l)
  (mapcar #'unfold-constant-form l))
(defun protect-constant-form (x)
  (if (self-evaluating-p x) x (kwote x)))
(defun protect-constant-forms (l)
  (mapcar #'protect-constant-form l))

(define-macro-matcher quasiquote
  #'(lambda (x) (pattern-matcher (quasiquote-expand x))))

#+quasiquote-at-macro-expansion-time
(defun enable-met-quasiquote (&optional (readtable *readtable*))
  (set-macro-character
   #\` #'(lambda (stream char)
	   (declare (ignore char))
	   (make-quasiquote (read stream t nil t)))
   nil readtable)
  (set-macro-character
   #\, #'(lambda (stream char)
	   (declare (ignore char))
	   (case (peek-char nil stream t nil t)
	     ((#\@ #\.)
	      (read-char stream t nil t)
	      (make-unquote-splicing (read stream t nil t)))
	     (otherwise (make-unquote (read stream t nil t)))))
   nil readtable)
  nil)

; Note: it would be a *very bad* idea to use quasiquote:quote
; in the expansion of the macro-character #\'

#-quasiquote-at-macro-expansion-time
(progn

(defun read-quasiquote (stream)
  (let ((*quasiquote-level* (1+ *quasiquote-level*)))
    (quasiquote-expand (read stream t nil t))))

(defun read-unquote (stream)
  (let ((*quasiquote-level* (1- *quasiquote-level*)))
    (unless (>= *quasiquote-level* 0) (error "unquote outside quasiquote"))
    (make-unquote (read stream t nil t))))

(defun read-unquote-splicing (stream)
  (let ((*quasiquote-level* (1- *quasiquote-level*)))
    (unless (>= *quasiquote-level* 0) (error "unquote outside quasiquote"))
    (make-unquote-splicing (read stream t nil t))))

(defun n-vector (n contents)
  (if (null n) (apply 'vector contents)
    (let ((a (make-array n :element-type t)))
      (when (and (null contents) (> n 0))
	(error "non-zero length vector with empty contents"))
      (loop for i below n with x
	do (unless (null contents) (setq x (pop contents)))
	do (setf (aref a i) x))
      (when contents
	(error "provided contents larger than declared vector length"))
      a)))

(defun read-vector (stream n)
; http://www.lisp.org/HyperSpec/Body/sec_2-4-8-3.html
  (let ((contents (read-delimited-list #\) stream t)))
    (if (> *quasiquote-level* 0)
	(make-unquote (list 'n-vector n (quasiquote-expand contents)))
	(n-vector n contents))))

(defun enable-rt-quasiquote (&optional (readtable *readtable*))
  (set-macro-character
   #\` #'(lambda (stream char)
	   (declare (ignore char))
	   (read-quasiquote stream))
   nil readtable)
  (set-macro-character
   #\, #'(lambda (stream char)
	   (declare (ignore char))
	   (case (peek-char nil stream t nil t)
	     ((#\@ #\.)
	      (read-char stream t nil t)
	      (read-unquote-splicing stream))
	     (otherwise (read-unquote stream))))
   nil readtable)
  (set-dispatch-macro-character
   #\# #\(
   #'(lambda (stream subchar arg)
	   (declare (ignore subchar))
	   (read-vector stream arg))
   readtable)
  nil)
nil)

#-quasiquote-at-macro-expansion-time
(defun enable-quasiquote (&optional (readtable *readtable*))
  (enable-rt-quasiquote readtable))

#+quasiquote-at-macro-expansion-time
(defun enable-quasiquote (&optional (readtable *readtable*))
  (enable-met-quasiquote readtable))

#|
; This version of princ allows one to see
; inside of your implementation's version of quasiquoted expressions...

(defun rprinc (x)
  "hand-made princ that allows to see inside quasiquotes
(results are implementation-dependent)"
  (labels
      ((rprinc-list (x)
         (princ "(")
	 (rprinc-list-contents x)
	 (princ ")"))
       (rprinc-list-contents (x)
         (rprinc (car x))
	 (rprinc-cdr (cdr x)))
       (rprinc-cdr (x)
         (if x (if (consp x)
		   (progn
		     (princ " ")
		     (rprinc-list-contents x))
		 (progn
		   (princ " . ")
		   (rprinc x))))))
    (cond
     ((consp x) (rprinc-list x))
     (t (princ x)))
    x))

; You can test the quasiquote implementation like this:

(in-package :fare-quasiquote)
(enable-quasiquote)

(setq b 11)
(TTEST*
 ('``a :result '(quote (quote a)))
 ('`(a ,b)
  :result '(list (quote a) b))
 ('``(a ,b)
  :result '(quote (list (quote a) b)))
 (`(a ,b)
  :result '(a 11))
 ((ifmatch `(a ,x ,@y) '(a b c d) (list x y))
  :result '(b (c d)))
 ((format nil "~(~A~)" '(1 2 3)) :result "(1 2 3)")
 ((format nil "(~{~A~^ ~})" '`(a ,b ,@c .,d)))
 ((format nil "~%(~{~A~^ ~})" '`(,@c .,d)))
)

|#
