(defpackage :genoslib
  (:import-from #:arnesi "AIF" "IT" "LAST1" "ENABLE-SHARP-L-SYNTAX")
  (:shadowing-import-from #:rameau-base #:defun #:defmacro #:defparameter #:defvar #:defstruct)
  (:import-from #:alexandria "SWITCH" "FLATTEN")
  (:use #:cl #:iterate)
  (:export
   #:tempered
   #:tonal
   )
  (:documentation "The core utilities developed by Genos. Generic lisp functions and musical niceties."))

(in-package :genoslib)

(enable-sharp-l-syntax)

(defun % (x total)
  (unless (= 0 total)
    (/ (* x 100.0) total)))

(defun stringify (obj)
  "Convert \\texttt{obj} to a string according to predefined conventions."
  (let ((*package* (find-package :rameau)))
    (format nil "~(~a~)" obj)))

(defun clip (size list)
  "Clip \\texttt{list} to size \\texttt{size}."
  (remove-if #'null (firstn list size)))

(defun insert (element list &key (less #'<) (key #'identity))
  "Insert \\texttt{element} into \\texttt{list} in a sorted position."
  (if list
      (let ((fe (funcall key element))
            (fl (funcall key (first list))))
        (if (funcall less fe fl)
            (cons element list)
            (cons (first list) (insert element (rest list) :key key :less less))))
      (list element)))

;;; Norvig's functions for debugging in PAIP, p. 124

(defvar *dbg-ids* nil "identifiers used by dbg")
(setf *debug-io* *error-output*)

(defun dbg (id format-string &rest args)
  "Print debugging info if (DEBUG ID) has been specified. [DONTCHECK]"
  (when (member id *dbg-ids* :test #'string=)
    (fresh-line *standard-output*)
    (apply #'format t (concat " => DEBUG: " format-string) args)
    (force-output *standard-output*)))

(defun dbg-indent (id indent format-string &rest args)
  "Print indented debugging info if (DEBUG ID) has been specified. [DONTCHECK]"
  (when (member id *dbg-ids*)
    (fresh-line *debug-io*)
    (dotimes (i indent) (princ " " *debug-io*))
    (apply #'format *debug-io* (concat " => DEBUG: " format-string) args)))

(defun rameau-debug (id)
  "Start dbg output on the given ids. [DONTCHECK]"
  (format t "Debugging ~a~%" id)
  (push id *dbg-ids*))

(defun rameau-undebug (&rest ids)
  "Stop dbg on the ids. With no ids, stop dbg altogether. [DONTCHECK]"
  (setf *dbg-ids* (if (null ids)
                      nil
                      (set-difference *dbg-ids* ids))))

(defmacro defcached (funcname args &body body)
  "Defines \\texttt{funcname} just as defun, but with a cache around it. [DONTCHECK]"
  (labels ((varnames (symbols)
             (cons 'list
                   (loop for s in symbols unless (and (symbolp s)
                                                      (eql #\&  (aref (symbol-name s) 0)))
                         collect (if (atom s) s (first s))))))
    (let ((cache (gensym)))
      `(let ((,cache (make-hash-table :test #'equal)))
         (defun ,funcname ,args
           (aif (gethash ,(varnames args) ,cache)
                it
                (setf (gethash ,(varnames args) ,cache) (progn ,@body))))))))

(defun concat (&rest strings)
  "Concatenate strings \\texttt{strings}."
  (apply #'concatenate 'string strings))

(defun sort-set (set)
  "Sort a set in crescent order. "
  (sorted set #'<))

(defun rotations (list)
  "Get all rotations possible for \\texttt{list}."
  (iter (for i from 0 below (length list))
        (collect (append (last list i)
                         (butlast list i)))))

(defun skip-initial-element (element list &key (test #'equal))
  "Skip every initial occurence of \\texttt{element} in \\texttt{list}."
  (if (funcall test element (first list))
      (skip-initial-element element (rest list) :test test)
      list))

(defun count-subseq (sub seq &optional (start -1) (acc 0))
  "Count the number of occurences of \\texttt{sub} in \\texttt{seq}."
  (let ((s (search sub seq :start2 (+ start 1))))
    (if s
        (count-subseq sub seq s (+ acc 1))
        acc)))

(defun smallest (list &optional (test #'identity))
  "The smallest element of \\texttt{list}, according to \\texttt{test}."
  (when list
    (reduce #'min list :key test)))

(defun repeat-string (n string)
  "Repeat a string n times. EXAMPLE: (repeat-string 3 \"foo\") returns
  \"foofoofoo\"."
  (with-output-to-string (s)
    (dotimes (i (abs n)) (format s string))))

(defun advance-all (list)
  "Advances every list in \\texttt{list}."
  (mapcar #'cdr list))

(defun assoc-item (item alist)
  "Returns the item keyed by \\texttt{item} from the alist \\texttt{alist}. "
  (second (assoc item alist)))

(defun mostn (pred list)
  "Reimplementation of \\texttt{mostn} from On Lisp. Finds the elements of \\texttt{list}
that have the largest value according to \\texttt{pred}."
  (when list
    (let ((max-value (funcall pred (first list)))
          (list-max nil))
      (dolist (el list)
        (cond ((> (funcall pred el) max-value)
               (setf max-value (funcall pred el))
               (setf list-max (list el)))
              ((= (funcall pred el) max-value)
               (push el list-max))))
      list-max)))

(defun file-string (path)
  "Suck up an entire file from \\texttt{path} into a freshly-allocated string,
returning two values: the string and the number of bytes read. [DONTCHECK]"
  (with-open-file (s path #+sbcl :external-format #+sbcl :utf-8 )
    (let* ((len (file-length s))
           (data (make-string len :initial-element #\Space))
           (*package* (find-package :rameau)))
      (values data (read-sequence data s)))))

(defun binary-file-string (path)
  "Suck up an entire file from \\texttt{path} into a freshly-allocated byte-string,
returning two values: the string and the number of bytes read. [DONTCHECK]"
  (with-open-file (s path #+sbcl :element-type '(unsigned-byte 8) )
    (let ((file-data (make-array (file-length s)
                                 :element-type '(unsigned-byte 8))))
      (read-sequence file-data s)
      file-data)))

(defun firstn (list n)
  "Return the first \\texttt{n} elements of \\texttt{list}, or \\texttt{n} nulls."
  (loop for i from 0 to (1- n) collect
        (nth i list)))

(defun repeat-list (n list)
  "Repeat \\texttt{n} times the element \\texttt{list}, forming a list."
  (if (> n 0)
      (cons list (repeat-list (- n 1) list))))

(defun read-from-string-as-sexp (file &optional (case :upcase))
  "Read from string \\texttt{file} as a single sexp. [DONTCHECK]"
  (let ((*readtable* (copy-readtable *readtable*)))
    (setf (readtable-case *readtable*) case)
    (read-from-string (format nil "(~a)" file))))

(defun read-file-as-sexp (file &optional (case :upcase))
  "Read file named \\texttt{file} as a single sexp. [DONTCHECK]"
  (read-from-string-as-sexp (file-string file) case))

(defun unzip (lista)
  "Transform the list of pairs \\texttt{lista} in a pair of lists."
  (loop for el in lista
        nconc (list (first el)) into lista1
        nconc (list (second el)) into lista2
        finally (return (values lista1 lista2))))

(defun get-item (item lista &optional (test #'equal))
  "Get item keyed by \\texttt{item} in alist \\texttt{lista}. It uses
equal by default, so it is good for getting string keys."
  (second (assoc item lista :test test)))

(defun sorted (lista ord &key (key #'identity))
  "Returns a sorted copy of list \\texttt{lista} ordered by \\texttt{ord}."
  (sort (copy-list lista) ord :key key))

(defun mapcar2 (fn1 fn2 list)
  "mapcar + compose."
  (mapcar (lambda (x) (funcall fn1 (funcall fn2 x))) list))

(defun group (lista n)
  "Groups the elements of \\texttt{lista} in groups of \\texttt{n} elements.
Every element is part of \\texttt{n} groups. The list is padded with nulls."
  (when lista
    (cons (firstn lista n) (group (rest lista) n))))

(defun contextualize (segments before after)
  "Contextualize music \\texttt{segments} by putting \\texttt{before} segments before and \\texttt{after} segments after each segment."
  (butlast (group (append (repeat-list before nil) segments)
                  (+ 1 before after))
           (max 0 (1- after))))

(defun string-member (item list)
  "Tests whether there is an item in \\texttt{list} with the same
string representation as \\texttt{item}."
  (member (stringify item) list :test #'equal :key #'stringify))

;; Alist helper functions

(defun make-alist ()
  "Makes a helped alist. [DONTCHECK]"
  (list nil))

(defun apush (obj place)
  "Destructively modifies list \\texttt{place} and puts \\texttt{obj}
as its car."
  (let ((ap (car place))
        (dp (cdr place)))
    (setf (car place) obj
          (cdr place) (cons ap dp)))
  place)

(defun aget (key list &optional default)
  "Get element keyed by \\texttt{key} from alist \\texttt{list}. If it
does not exist, insert and return \\texttt{default} unless default is
null or 'erro."
  (aif (assoc key list :test #'equal)
       (second it)
       (progn
         (when (and default (not (eq default 'erro)))
           (apush (list key default) list))
         default)))

(defmacro aset (key list value)
  "Set the value for \\texttt{key} in alist \\texttt{list}."
  `(if (eq 'erro (aget ,key ,list 'erro))
       (apush (list ,key ,value) ,list)
       (setf (second (assoc ,key ,list :test #'equal)) ,value)))

(defmacro aincf (key list &optional (amount 1))
  "Increment the value of \\texttt{key} in alist \\texttt{list} by \\texttt{amount}."
  `(if (eq 'erro (aget ,key ,list 'erro))
       (aset ,key ,list ,amount)
       (incf (car (cdr (assoc ,key ,list :test #'equal))) ,amount)))

(defmacro square (x)
  (let ((n (gensym)))
    `(let ((,n ,x))
       (* ,n ,n))))

(defun distance (a b)
  "The euclidian distance between lists \\texttt{a} and \\texttt{b}."
  (if (and a b)
      (loop for i in a
            for j in b
            sum (square (- i j)))
      most-positive-fixnum))

(defun make-keyword (string)
  "Make \\texttt{string} into a keyword."
  (intern (string-upcase string) (find-package :keyword)))

(defun sublist-of-args (list char)
  "Return the sublist of \\texttt{list} for the arg in \\texttt{char}."
  ;; tem um bug quando repete proxima flag imediatamente: (@a foo @a bar)
  ;; entra em loop recursivo
  (labels ((next-flag (list)
             (iter (for item in (rest list))
                   (unless (consp item)
                     (let ((x (if (stringp item)
                                  item
                                  (symbol-name item))))
                       (if (and (< 0 (length x)) (equal char (aref x 0)))
                           (return item))))))
           (pos (list flag)
             (let ((pos (position flag list :test #'equalp)))
               (aif pos pos 0))))
    (when list
      (aif (next-flag list)
           (let ((p (pos list it)))
             (cons (subseq list 0 p)
                   (sublist-of-args (nthcdr p list) char)))
           (list list)))))

(defun argmax (function start end)
  "The maximum \\texttt{n} between \\texttt{start} and \\texttt{end}
  according to \\texttt{function}."
  (let ((argmax 0)
        (max most-negative-double-float))
    (iter (for column from start below end)
          (for v = (funcall function column))
          (when (< max v)
            (setf max v
                  argmax column)))
    (values argmax max)))

(defun normalize (zero one min max value)
  "Draw a line from \\texttt{zero} = \\texttt{min} to \\texttt{one} = \\texttt{max} and find \\texttt{value} in it." 
  (let ((value (- value min))
        (max (- max min)))
    (if (/= 0 max)
        (+ zero
           (* one (/ value max)))
        zero)))

(defun deep-copy (value)
  (let ((name (concat "/tmp/foo" (stringify (random 10)))))
    (cl-store:store value name)
    (cl-store:restore name)))

(defun hash->ordered-list (table output cmp)
  (sorted (iter (for (k v) in-hashtable table)
                (collect (funcall output k v)))
          cmp))

(defun ilog (x)
  (if (equal x 0)
      most-negative-double-float
      (log x)))

(defun compute-z :private (r n)
  (iter (for k in (append (list 0) r (list (- (* 2 (last1 r)) (first (last r 2))))))
        (for j previous k)
        (for i previous j)
        (for nk in (append (list 0) n (list 0)))
        (for nj previous nk)
        (when (and i j k)
          (collect (if (or (equal nj 0)
                           (equal k i))
                       1
                       (* 2 (/ nj (- k i))))))))

(defun dexp :private (x)
  "Computes (exp (coerce x 'double-float))"
  (exp (coerce x 'double-float)))

(defun compute-r* :private (n r)
  (let ((x-still-good t))
    (append
     (iter (for nr+1 in n)
           (for nr previous nr+1)
           (for rr+1 in r)
           (for rr previous rr+1)
           (when (and nr+1 nr rr+1 rr)
             (for x = (* (1+ rr) (/ nr+1 nr)))
             (for y = (* (1+ rr) (/ (dexp (1+ rr)) (dexp rr))))
             (for in = (> (abs (- x y))
                          (* 1.96d0 (sqrt (abs
                                           (* (* (1+ rr) (1+ rr))
                                              (/ nr+1 (* nr nr))
                                              (1+ (/ nr+1 nr))))))))
             (when (and x-still-good (not in))
               (setf x-still-good nil))
             (if x-still-good (collect x) (collect y))))
     (list (* (1+ (last1 r)) (/ (dexp (1+ (last1 r))) (dexp (last1 r))))))))

(defun compute-p :private (r* n-prime P0 total-r total-r*)
  (iter (for rr* in r*)
        (for nn in n-prime)
        (collect (* (- 1 P0) (/ (* total-r (/ rr* nn))
                                total-r*)))))

(defun good-turing-reestimate (vector xdim ydim)
  "Good-Turing reestimation of probabilities, extracted from
\\url{http://www.grsampson.net/AGtf1.html}."
  (iter (for i from 0 below xdim)
        (let ((freqfreq (make-hash-table :test #'equal))
              (all-zero t))
          (iter (for j from 0 below ydim)
                (when (not (eql 0 (aref vector i j)))
                  (setf all-zero nil))
                (incf (gethash (aref vector i j) freqfreq 0)))
          (if all-zero
              (iter (for j from 0 below ydim)
                    (setf (aref vector i j) (log (coerce (/ 1 ydim) 'double-float))))
              (let* ((freq (hash->ordered-list freqfreq #L(list !1 !2) #L(< (first !1) (first !2))))
                     (r (cdr (mapcar #'first freq))) ; the frequencies in the data
                     (n (cdr (mapcar #'second freq))) ; the number of times each frequency shows up
                     (total (iter (for rr in r) (for nn in n) (sum (* rr nn)))) ; the total number of observations
                     (r* (compute-r* n r))
                     (total-r (iter (for rr in r) (sum rr)))
                     (total-r* (iter (for rr in r*) (sum rr)))
                     (n-prime (mapcar #'* n r*))
                     (P0 (if (eql 0 total) 1d0  (/ (* total-r (/ (first n) total)) total-r*))) ; the expected frequency of unseen events
                     (p (compute-p r* n-prime P0 total-r total-r*)))
                (iter (for j from 0 below ydim)
                      (dbg :good-turing " j ~a  i ~a r ~a p ~a~%"
                           j i r p)
                      (when (and (position (aref vector i j) r)
                                 (nth (position (aref vector i j) r :test #'eql) p)
                                 (< (nth (position (aref vector i j) r :test #'eql) p)
                                    0))
                        (error "Valor menor que 0 ~a~%" p))
                      (setf (aref vector i j)
                            (log (coerce (cond ((= 0 (aref vector i j)) 
                                                (/ P0 (second (first freq))))
                                               ((and (= 1 (length r))
                                                     (not (= 0 (aref vector i j))))
                                                0.5d0)
                                               (t (nth (position (aref vector i j) r) p)))
                                         'double-float))))
                (dbg :good-turing "R ~a,N ~a, ~%    i ~a, r* ~a, ~% r*total ~a,   n-prime ~a, ~%   P0 ~a, freq ~a~%"
                     r n i r* (iter (for r in r*) (sum r)) n-prime P0 freq)))))
  vector)

(defun exp-add (vector i yd)
  (iter (for j from 0 below yd)
        (sum (exp (aref vector i j)))))

(defun exp-map (vector i yd)
  (iter (for j from 0 below yd)
        (collect (exp (aref vector i j)))))

;; (format t "~a~%" (exp-add (good-turing-reestimate (make-array (list 1 12) :initial-contents '((0 0 0 11 11 1 2 1 1 1 0 1))) 1 12) 0 12))
;; (format t "~a~%" (exp-add (rameau-fhmm:dirichlett-smooth (make-array (list 1 12) :initial-contents '((0 0 0 11 11 1 2 1 1 1 0 1))) 1 12) 0 12))

(defun make-number-hash-table (function list)
  "Makes a hash table associating the elements of \\textt{list} with incresing integers."
  (let ((table (make-hash-table :test function)))
    (iter (for i from 0)
          (for el in list)
          (setf (gethash el table) i))
    table))

(defun search-string-in-list (substring list &key (key #'identity))
  "Search for string in a list using a substring."
  (first (remove-if-not #L(search substring (funcall key !1) :test #'equalp) list)))

(defun make-int (value)
  "Coerce value into an integer."
  (if (integerp value)
      value
      (parse-integer value)))