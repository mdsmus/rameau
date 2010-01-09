This README file describes an implementation of list comprehensions
for Common Lisp. 

To install, simply load the file collect.lsp into your favorite Common
Lisp implementation.

Several programming languages (for example Haskell, Erlang, Python)
have a feature called list comprehensions to facilitate manipulating
lists.  I have implemented a similar feature in Common Lisp. Besides
lists, my implementation also handles other data structures such as
arrays and hash tables. 


RECENT CHANGES

The collect macro combines iteration and collection. I added two
macros that allow the mechanisms for iteration and collection to be
used separately, see the end of this document. Also, I fixed a bug
concerning the initialization of arrays (thanks to Ryan Randall for
finding it).


BASIC IDEA

For example, the expression

  (collect list ((* x x))
    (in x '(1 2 3 4 5 6 7 8)))

evaluates to 

  (1 4 9 16 25 36 49 64)

In general, a collect expression has three parts; 

  1. a collection type, describing the data structure where the result
     is collected,

  2. a list of expressions giving the values to be inserted followed
     by    

  3. one or more clauses. 

I summarize the syntax at the end of this document.


To filter lists:

  (collect list ((* x x))
    (in x '(1 2 3 4 5 6 7 8))
    (when (= (mod x 2) 0)))

returns

  (4 16 36 64),

i.e., the list of squares of the even values of x.


We can also iterate over several lists, for example

  (collect list ((list x y))
    (in x '(1 2 3 4 5))
    (in y '(1 2 3 4 5)))

returns

  ((1 1) (1 2) (1 3) (1 4) (1 5) (2 1) (2 2) (2 3) (2 4) (2 5) (3 1)
   (3 2) (3 3) (3 4) (3 5) (4 1) (4 2) (4 3) (4 4) (4 5) (5 1) (5 2) 
   (5 3) (5 4) (5 5))


and 

  (collect list ((list x y))
    (in x '(1 2 3 4 5))
    (in y '(1 2 3 4 5))
    (when (< x y)))

returns those pairs where the first element is less than the second,
i.e.,

  ((1 2) (1 3) (1 4) (1 5) (2 3) (2 4) (2 5) (3 4) (3 5) (4 5))


EXTENSIONS

The simplest form of list comprehensions only work with lists, and
only clauses corresponding to the "in" and "when" clauses in the above
description are allowed.  My implementation of list comprehensions
generalizes the concept in two ways; first, the implementation allows
accumulating the result in other data structures besides lists,
second, new control structures are introduced allowing a more detailed
control over the iteration.



MANIPULATING HASH TABLES

As mentioned, my implementation also allows manipulation of arrays and
hash tables. The expression

  (collect (vector) ((* x x))
    (in (x) '(1 2 3 4 5 6 7 8)))

builds the array

  #(1 4 9 16 25 36 49 64)

Naturally it is also possible to iterate over arrays, say


  (collect list ((* x x))
    (in x '#(1 2 3 4 5 6 7 8)))


Suppose that a is bound to a hash table mapping some European
countries to their capitals:

england -> london
france -> paris
spain -> madrid

The expression 

  (collect list ((list k v))
    (in (k v) a))

returns the list

((SPAIN MADRID) (FRANCE PARIS) (ENGLAND LONDON))

In other words, the variables k and v become bound to each key-value
pair of the hash table.


To build a hash table, write

  (collect (hash-table t) (x (* x x))
    (in x '(1 2 3)))

which will build a hash table mapping each of the integers 1, 2 and 3
to its square (I'll explain the argument t later).

Any argument to hash-table (besides the first argument) is simply
passed to the function make-hash-table. Thus, if we plan to use
strings as keys in the table we might want to write

  (collect (hash-table t :test #'equal) (x x)
    (in x '("foo" "bar" "bletch")))


Inverting a hash table is easy. If a is as above, write

  (collect (hash-table t) (v k)
    (in (k v) a))

to produce a table where the atom london maps to england etc.


But sometimes many keys have the same value. Suppose for example 
that we have a table mapping cities to their countries; say 

berlin -> germany 
hamburg -> germany
liverpool -> england 
london -> england
lyon -> france
paris -> france

Suppose that *h* is the hash table (assuming the clisp implementation)

#S(HASH-TABLE EQL (PARIS . FRANCE) (LYON . FRANCE) (LONDON . ENGLAND)
   (LIVERPOOL . ENGLAND) (HAMBURG . GERMANY) (BERLIN . GERMANY))

and consider the same expression as above:

> (collect (hash-table t) (v k)
    (in (k v) *h*))

#S(HASH-TABLE EQL (GERMANY . BERLIN) (ENGLAND . LIVERPOOL) (FRANCE . LYON))


Since the table only stores one element with each key, there will be
at most one city associated with each country.

The type expression (hash-table t) means that we will associate a
single value with each key. (Similarly, an expression 

  (collect t (x) (in x l))

will return a single element of l).


Since the collection type for hash tables takes another collection
type as argument, a collect expression can accumulate data in
arbitrarily complicated data structures. To collect the data in a hash
table where each key maps to a list of values, use the collection type
(hash-table list). Now, inverting the table *h* gives a table mapping
each country to a list of cities:-

> (collect (hash-table list) (v k)
    (in (k v) *h*))

#S(HASH-TABLE EQL (GERMANY HAMBURG BERLIN) (ENGLAND LONDON LIVERPOOL)
   (FRANCE PARIS LYON))

If we prefer the results in a vector:

> (collect (hash-table vector) (v k)
    (in (k v) *h*))

#S(HASH-TABLE EQL (FRANCE . #(LYON PARIS)) (ENGLAND . #(LIVERPOOL LONDON))
   (GERMANY . #(BERLIN HAMBURG)))




LET-CLAUSES

Let-clauses are convenient in implementing complex iterations. For
example, suppose we have a list of pairs 

  '((paris france) (london england) (madrid spain)) 

and wish to build a similar hash table:

  (collect (hash-table t) (k v)
    (in pair l)
    (let k (car pair))
    (let v (cadr pair)))


DO-CLAUSES

Do-clauses are used for side effects. For example, the following
prints the contents of a hash table:

(collect nil ()
  (in (k v) h)
  (do (format t "~a = ~a~%" k v)))

Computed sequences

A clause

(step <var> <init-exp> <next-exp>)

will bind the variable <var> to the elements of an unbounded sequence, where the first
element is computed by evaluating the <init-exp> and subsequent values
are computed by evaluating <next-exp>, which may contain references to
the previous value of <var>. For example,
\begin{verbatim}
(step x 0 (+ 1 x)) 

will bind x to each natural number.


Terminating iteration

A clause 

(while <exp>) 

will terminate the iteration as soon as the expression
<exp> evaluates to nil.


PARALLEL ITERATION

A clause 
\begin{verbatim}
(for <clause>*) 
\end{verbatim}
combines several in- and step- clauses. All iterations are performed
in parallel. For example, the clause
\begin{verbatim}
(for (in x '(a b c))
     (in y '(2 3 5 7 11)))
\end{verbatim}
gives us three iterations; in the first x is bound to the atom a and y
to the integer 1, in the second x is bound to b and y to 2, and in the
last iteration x and y are bound to the atom c and the integer 3, respectively.


(defun fac (n)
  (collect t (r)
    (for (step i 0 (1+ n))
         (step r 1 (* r i)))
    (while (<= i n))))

 
MORE EXAMPLES

Suppose we want to find groups of words that are each other's
permutations, i.e., containing the same letters in another order.

(defun anagram (l n)
  (let
      ((table (collect (hash-table (list) :test #'equal) (key s)
		(in (s) l)
		(let key (sort (copy-seq s) #'char<)))))
    (collect (list) (l)
      (in (k l) table)
      (when (>= (length l) n)))))

The program takes a list of strings and an integer, and returns those
groups of words that are larger than n. For example, the call 

  (anagram '("foo" "oof" "fo" "ofo" "of" "ba" "bar" "bart" "rab") 2)

returns

(("bar" "rab") ("fo" "of") ("foo" "oof" "ofo"))

The program builds an intermediate equal-hash-table (called "table")
in which each string is stored using a key obtained by sorting the
letters of the string. Next the table is scanned for keys with at
least n entries. For each such key, the corresponding list is added to
the output.

The following function builds a list of all permutations of a list.


(defun perms(l)
  (cond
   ((null l) (list nil))
   (t (collect list ((cons a b))
       (in a l)
       (in b (perms (remove a l)))))))

For example, 

  (perms '(a b c))

returns

  ((A B C) (A C B) (B A C) (B C A) (C A B) (C B A))





SUMMARY

The goal of this exercise was to find out what it would be like to
have access to list comprehensions in Lisp, and whether the concept
could be generalized to handle all data structures in Lisp. 

I have recently added the ability to iterate over several sequences
simultaneously, building and iterating over multi-dimensional arrays,
and other ways to collect data, for example by summing or finding the
maximum. These features are not documented, but you'll find examples
of their use in the file examples.lsp.





NEW ADDITIONS: ITERATION AND COLLECTION AS SEPARATE MACROS	

Suppose that what we really need is general, flexible, extendible
looping constructs. So I defined separarte constructs for iteration
and collecting data.

(iter clause* . body)

Parallel iteration, given clauses, as defined above.

Example:

(iter 
    ((in x '(1 2 3)) 
     (in y '(5 6 7 8))) 
  (print (list x y)))

prints 

(1 5) 
(2 6) 
(3 7) 


Now, assume that we want to collect the result in a data structure.

The macro

(with-collection f kind . body)

collects the result in a data structure of type kind. For example


(with-collection add list (dotimes (i 5) (add i)))

returns

(0 1 2 3 4),

(with-collection add vector (dotimes (i 5) (add i)))

returns

#(0 1 2 3 4), and

(with-collection add sum (dotimes (i 5) (add i)))

returns 

10.


Naturally, with-collect and iter may be combined.


(with-collection add list 
  (iter 
      ((in x '(1 2 3)) 
       (in y '(5 6 7 8))) 
    (add (list x y))))

gives

((1 5) (2 6) (3 7))


Since with-collection creates a closure that may be passed to
functions we can write, say a recursive function to collect the atoms
of a deep list:

(defun flatten (x f) 
   (cond 
    ((null x) nil)
    ((atom x) (funcall f x))
    ((consp x) 
     (flatten (car x) f)
     (flatten (cdr x) f))))


With this definition of flatten,

(with-collection add list 
  (flatten '(1 (2 3) 4 (5 ((6)))) #'add))

returns

(1 2 3 4 5 6)
