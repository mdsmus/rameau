(defpackage :genos-utils
  (:import-from #:arnesi "AIF" "IT" "LAST1" "ENABLE-SHARP-L-SYNTAX" "ACOND")
  (:shadowing-import-from #:genos-base #:defun #:defmacro #:defparameter
                          #:defvar #:defstruct)
  (:import-from #:alexandria "SWITCH" "FLATTEN")
  (:use #:cl #:iterate)
  (:documentation "The core utilities developed by Genos. Generic lisp
  functions."))

(in-package :genos-utils)

(enable-sharp-l-syntax)

(defun % (x total)
  "Represent @var{x} as a percentual on @var{total}"
  (unless (= 0 total)
    (/ (* x 100.0) total)))

(defun stringify (obj)
  "Convert @var{obj} to a string according to predefined conventions."
  (let ((*package* (find-package :rameau)))
    (format nil "~(~a~)" obj)))

(defun clip (size list)
  "Clip @var{list} to size @var{size}."
  (remove-if #'null (firstn list size)))

(defun insert (element list &key (less #'<) (key #'identity))
  "Insert @var{element} into @var{list} in a sorted position."
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
  "Print debugging info if (DEBUG ID) has been specified. [NOTEST]"
  (when (member id *dbg-ids* :test #'string=)
    (fresh-line *standard-output*)
    (apply #'format t (concat " => DEBUG: " format-string) args)
    (force-output *standard-output*)))

(defun dbg-indent (id indent format-string &rest args)
  "Print indented debugging info if (DEBUG ID) has been specified. [NOTEST]"
  (when (member id *dbg-ids*)
    (fresh-line *debug-io*)
    (dotimes (i indent) (princ " " *debug-io*))
    (apply #'format *debug-io* (concat " => DEBUG: " format-string) args)))

(defun rameau-debug (id)
  "Start dbg output on the given ids. [NOTEST]"
  (format t "Debugging ~a~%" id)
  (push id *dbg-ids*))

(defun rameau-undebug (&rest ids)
  "Stop dbg on the ids. With no ids, stop dbg altogether. [NOTEST]"
  (setf *dbg-ids* (if (null ids)
                      nil
                      (set-difference *dbg-ids* ids))))

(defmacro defcached (funcname args &body body)
  "Defines @var{funcname} just as defun, but with a cache around it. [NOTEST]"
  (labels ((varnames (symbols)
             (cons 'list
                   (loop for s in symbols
                         unless (and (symbolp s)
                                     (eql #\&  (aref (symbol-name s) 0)))
                         collect (if (atom s) s (first s))))))
    (let ((cache (gensym)))
      `(let ((,cache (make-hash-table :test #'equal)))
         (defun ,funcname ,args
           (aif (gethash ,(varnames args) ,cache)
                it
                (setf (gethash ,(varnames args) ,cache)
                      (progn ,@body))))))))

(defun concat (&rest strings)
  "Concatenate strings @var{strings}."
  (apply #'concatenate 'string strings))

(defun sort-set (set)
  "Sort a set in crescent order. "
  (sorted set #'<))

(defun rotations (list)
  "Get all rotations possible for @var{list}."
  (iter (for i from 0 below (length list))
        (collect (append (last list i)
                         (butlast list i)))))

(defun skip-initial-element (element list &key (test #'equal))
  "Skip every initial occurence of @var{element} in @var{list}."
  (if (funcall test element (first list))
      (skip-initial-element element (rest list) :test test)
      list))

(defun count-subseq (sub seq &optional (start -1) (acc 0))
  "Count the number of occurences of @var{sub} in @var{seq}."
  (let ((s (search sub seq :start2 (+ start 1))))
    (if s
        (count-subseq sub seq s (+ acc 1))
        acc)))

(defun smallest (list &optional (test #'identity))
  "The smallest element of @var{list}, according to @var{test}."
  (when list
    (reduce #'min list :key test)))

(defun repeat-string (n string)
  "Repeat a string n times."
  (with-output-to-string (s)
    (dotimes (i (abs n)) (format s string))))

(defun advance-all (list)
  "Advances every list in @var{list}."
  (mapcar #'cdr list))

(defun assoc-item (item alist)
  "Returns the item keyed by @var{item} from the alist @var{alist}. "
  (second (assoc item alist)))

(defun mostn (pred list)
  "Reimplementation of @var{mostn} from On Lisp. Finds the elements of @var{list}
that have the largest value according to @var{pred}."
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
  "Suck up an entire file from @var{path} into a freshly-allocated string,
returning two values: the string and the number of bytes read. [NOTEST]"
  (with-open-file (s path #+sbcl :external-format #+sbcl :utf-8 )
    (let* ((len (file-length s))
           (data (make-string len :initial-element #\Space))
           (*package* (find-package :rameau)))
      (values data (read-sequence data s)))))

(defun binary-file-string (path)
  "Suck up an entire file from @var{path} into a freshly-allocated byte-string,
returning two values: the string and the number of bytes read. [NOTEST]"
  (with-open-file (s path #+sbcl :element-type '(unsigned-byte 8) )
    (let ((file-data (make-array (file-length s)
                                 :element-type '(unsigned-byte 8))))
      (read-sequence file-data s)
      file-data)))

(defun firstn (list n)
  "Return the first @var{n} elements of @var{list}, or @var{n} nulls."
  (loop for i from 0 to (1- n) collect
        (nth i list)))

(defun repeat-list (n list)
  "Repeat @var{n} times the element @var{list}, forming a list."
  (if (> n 0)
      (cons list (repeat-list (- n 1) list))))

(defun read-from-string-as-sexp (file &optional (case :upcase))
  "Read from string @var{file} as a single sexp. [NOTEST]"
  (let ((*readtable* (copy-readtable *readtable*)))
    (setf (readtable-case *readtable*) case)
    (read-from-string (format nil "(~a)" file))))

(defun read-file-as-sexp (file &optional (case :upcase))
  "Read file named @var{file} as a single sexp. [NOTEST]"
  (read-from-string-as-sexp (file-string file) case))

(defun unzip (lista)
  "Transform the list of pairs @var{lista} in a pair of lists."
  (loop for el in lista
        nconc (list (first el)) into lista1
        nconc (list (second el)) into lista2
        finally (return (values lista1 lista2))))

(defun get-item (item lista &optional (test #'equal))
  "Get item keyed by @var{item} in alist @var{lista}. It uses
equal by default, so it is good for getting string keys."
  (second (assoc item lista :test test)))

(defun sorted (lista ord &key (key #'identity))
  "Returns a sorted copy of list @var{lista} ordered by @var{ord}."
  (sort (copy-list lista) ord :key key))

(defun mapcar2 (fn1 fn2 list)
  "mapcar + compose."
  (mapcar (lambda (x) (funcall fn1 (funcall fn2 x))) list))

(defun group (lista n)
  "Groups the elements of @var{lista} in groups of @var{n} elements.
Every element is part of @var{n} groups. The list is padded with nulls."
  (when lista
    (cons (firstn lista n) (group (rest lista) n))))

(defun contextualize (segments before after)
  "Contextualize music @var{segments} by putting @var{before} segments
before and @var{after} segments after each segment."
  (butlast (group (append (repeat-list before nil)
                          segments
                          (repeat-list after nil))
                  (+ 1 before after))
           (+ before after)))

(defun string-member (item list)
  "Tests whether there is an item in @var{list} with the same
string representation as @var{item}."
  (member (stringify item) list :test #'equal :key #'stringify))

;; Alist helper functions

(defun make-alist ()
  "Makes an empty alist, to be used with other alist helper functions
in this package. [NOTEST]"
  (list nil))

(defun apush (obj place)
  "Destructively modifies alist @var{place} and puts @var{obj} as its
car."
  (let ((ap (car place))
        (dp (cdr place)))
    (setf (car place) obj
          (cdr place) (cons ap dp)))
  place)

(defun aget (key list &optional default)
  "Get element keyed by @var{key} from alist @var{list}. If it does
not exist, insert and return @var{default} unless default is null or
'erro."
  (aif (assoc key list :test #'equal)
       (second it)
       (progn
         (when (and default (not (eq default 'erro)))
           (apush (list key default) list))
         default)))

(defmacro aset (key list value)
  "Set the value for @var{key} in alist @var{list}."
  `(if (eq 'erro (aget ,key ,list 'erro))
       (apush (list ,key ,value) ,list)
       (setf (second (assoc ,key ,list :test #'equal)) ,value)))

(defmacro aincf (key list &optional (amount 1))
  "Increment the value of @var{key} in alist @var{list} by
@var{amount}."
  `(if (eq 'erro (aget ,key ,list 'erro))
       (aset ,key ,list ,amount)
       (incf (car (cdr (assoc ,key ,list :test #'equal))) ,amount)))

(defmacro square (x)
  "Expands to the square of @var{x}"
  (let ((n (gensym)))
    `(let ((,n ,x))
       (* ,n ,n))))

(defun distance (a b)
  "The euclidian distance between lists @var{a} and @var{b}."
  (if (and a b)
      (loop for i in a
            for j in b
            sum (square (- i j)))
      most-positive-fixnum))

(defun make-keyword (string)
  "Make @var{string} into a keyword."
  (intern (string-upcase string) (find-package :keyword)))

(defun sublist-of-args (list char)
  "Return the sublist of @var{list} for the arg in @var{char}."
  ;; tem um bug quando repete proxima flag imediatamente: (@a foo @a
  ;; bar) entra em loop recursivo
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
  "The maximum @var{n} between @var{start} and @var{end}
  according to @var{function}."
  (let ((argmax 0)
        (max most-negative-double-float))
    (iter (for column from start below end)
          (for v = (funcall function column))
          (when (< max v)
            (setf max v
                  argmax column)))
    (values argmax max)))

(defun normalize (zero one min max value)
  "Draw a line from @var{zero} = @var{min} to @var{one} = @var{max}
and find @var{value} in it."
  (let ((value (- value min))
        (max (- max min)))
    (if (/= 0 max)
        (+ zero
           (* one (/ value max)))
        zero)))

(defun deep-copy (value) 
  "Very ugly hack to do a deep copy of @var{value}"
  (let ((*print-readably* t))
    (read-from-string (format nil "~s" value))))

(defun hash->ordered-list (table output cmp)
  "Create an ordered list with the elements of hashtable @var{hash}
ordered by @var{cmp} and using @var{output} as a key."
  (sorted (iter (for (k v) in-hashtable table)
                (collect (funcall output k v)))
          cmp))

(defun ilog (x)
  "A convenient function to avoid floating-point underflow when
computing (log 0)"
  (if (equal x 0)
      most-negative-double-float
      (log x)))

(defun compute-z :private (r n)
  (iter (for k in (append (list 0) r (list (- (* 2 (last1 r))
                                              (first (last r 2))))))
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

(defun least-squares (logr logz)
  (if (< 2 (length logr))
      (let* ((rbar (/ (reduce #'+ logr) (length logr)))
             (zbar (/ (reduce #'+ logz) (length logz)))
             (beta (/ (iter (for r in logr)
                         (for z in logz)
                         (sum (* (- r rbar) (- z zbar))))
                   (iter (for r in logr)
                         (sum (square (- r rbar))))))
             (alpha (- zbar (* rbar beta))))
        (list alpha beta))
      (list 0 1)))

(defun regress (r params)
  (destructuring-bind (alpha beta) params
    (dexp (+ alpha (* beta r)))))
         
(defun compute-r* :private (n r params)
  (let ((x-still-good t))
    (append
     (iter (for nr+1 in n)
           (for nr previous nr+1)
           (for rr+1 in r)
           (for rr previous rr+1)
           (when (and nr+1 nr rr+1 rr)
             (for x = (* (1+ rr) (/ nr+1 nr)))
             (for y = (* (1+ rr) (/ (regress (1+ rr) params) (regress rr params))))
             (for in = (> (abs (- x y))
                          (* 1.96d0 (sqrt (abs
                                           (* (* (1+ rr) (1+ rr))
                                              (/ nr+1 (* nr nr))
                                              (1+ (/ nr+1 nr))))))))
             (when (or (and x-still-good (not in))
                       (/= rr+1 (1+ rr)))
               (setf x-still-good nil))
             (if x-still-good (collect x) (collect y))))
     (list (* (1+ (last1 r)) (/ (regress (1+ (last1 r)) params) (regress (last1 r) params)))))))

(defun compute-p :private (r* nn P0 total-r total-r*)
  (mapcar #L(* (- 1 P0) (/ !1 nn)) r*))

(defun good-turing-reestimate (vector xdim ydim)
  "Good-Turing reestimation of probabilities, extracted from
this @link{paper}{http://www.grsampson.net/AGtf1.html}."
  (iter (for i from 0 below xdim)
        (let ((freqfreq (make-hash-table :test #'equal))
              (all-zero t))
          (iter (for j from 0 below ydim)
                (when (not (eql 0 (aref vector i j)))
                  (setf all-zero nil))
                (incf (gethash (aref vector i j) freqfreq 0)))
          (if all-zero
              (iter (for j from 0 below ydim)
                    (setf (aref vector i j)
                          (log (coerce (/ 1 ydim) 'double-float))))
              (let* ((freq (hash->ordered-list freqfreq
                                               #L(list !1 !2)
                                               #L(< (first !1) (first !2))))
                     ;; the frequencies in the data
                     (r (cdr (mapcar #'first freq)))
                     ;; the number of times each frequency shows up
                     (n (cdr (mapcar #'second freq)))
                     (z (compute-z r n))
                     (regr (least-squares (mapcar #'ilog r) (mapcar #'ilog z)))
                     ;; the total number of observations
                     (total (iter (for rr in r) (for nn in n) (sum (* rr nn))))
                     (r* (compute-r* n r regr))
                     (total-r (reduce #'+ r))
                     (total-r* (reduce #'+ r*))
                     (n-prime (mapcar #'* n r*))
                     ;; the expected frequency of unseen events
                     (P0 (if (eql 0 total) 1d0  (/ (first n) total))) 
                     (p (compute-p r* (reduce #'+ n-prime) P0 total-r total-r*)))
                (iter (for j from 0 below ydim)
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
                (dbg :good-n-r-total "#N~%~{~a~%~}#R:~{~a~%~}#p:~{~a~%~}#Total:~a~%"
                     n r p total)))))
  vector)

(defun exp-add (vector i yd)
  "Sums (exp x) for x in @var{vector} using @var{i} as a first index and going
up to @var{yd} on the second dimension"
  (iter (for j from 0 below yd)
        (sum (exp (aref vector i j)))))

(defun exp-map (vector i yd)
  "Collects (exp x) for x in @var{vector} using @var{i} as a first index and going
up to @var{yd} on the second dimension"
  (iter (for j from 0 below yd)
        (collect (exp (aref vector i j)))))

(defun make-number-hash-table (function list)
  "Makes a hash table associating the elements of \\textt{list} with
incresing integers."
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

(defun search-for-directories (name dir)
  "Return the full pathname of the first subdirectory in @var{dir}
that has the string @var{name} in it. @var{Dir} must be a pathname."
  (first (remove-if-not #L(member name (rest (pathname-directory !1)) :test #'search)
                        (directory (merge-pathnames "*" dir)))))

(defun pathname-notdir (pathname)
  "Return a pathname with just the filename and extension, i.e.
without the directory."
  (make-pathname :name (pathname-name pathname)
                 :type (pathname-type pathname)))

(defun pathname-subdir (pathname1 pathname2)
  "Returns a pathname with the extra subdirectories that
@var{pathname2} has in relation to @var{pathname2}."
  (make-pathname :directory
                 (cons :relative (subseq (pathname-directory pathname2)
                                         (length (pathname-directory pathname1))))))

(defun pathname-difference (pathname1 pathname2)
  "Returns a pathname with the difference between @var{pathname2} and
@var{pathname1}. It is usualy useful when both pathnames have similar
structures."
  (let ((filename (pathname-notdir pathname2))
        (dir (pathname-subdir pathname1 pathname2)))
    (merge-pathnames filename dir)))

(defun pathname-replace-directory (pathname from to result-type)
  (let ((path (pathname-difference (translate-logical-pathname from)
                                   pathname)))
    (merge-pathnames (make-pathname :directory (pathname-directory path)
                                    :name (pathname-name path)
                                    :type result-type)
                     (translate-logical-pathname to))))

(defun pathnames-equal-p (pathname1 pathname2)
  (and (pathnamep pathname1)
       (pathnamep pathname2)
       ;; don't check for host and device
       ;;(equal (pathname-host pathname1) (pathname-host pathname2))
       ;;(equal (pathname-device pathname1) (pathname-device pathname2))
       (equal (pathname-directory pathname1) (pathname-directory pathname2))
       (equal (pathname-name pathname1) (pathname-name pathname2))
       (equal (pathname-type pathname1) (pathname-type pathname2))
       (or (equal (pathname-version pathname1) (pathname-version pathname2))
           (and (member (pathname-version pathname1) '(:newest nil))
                (member (pathname-version pathname2) '(:newest nil))
                t))))

(defun logical-pathname-namestring (logical-pathname)
  "Accepts a logical pathname and returns the namestring of the
pathname translation."
  (namestring (translate-logical-pathname logical-pathname)))

(defun logical-pathname-directory (logical-pathname)
  "Accepts a logical pathname and returns the directory of the
pathname translation. Useful to use in the :directory keyword of a
make-pathname."
  (pathname-directory (translate-logical-pathname logical-pathname)))

(defmacro with-output-file ((stream filespec) &body body)
  `(with-open-file (,stream ,filespec :direction :output :if-exists :supersede)
     ,@body))

(defun make-analysis-file (type &rest args)
  "Creates a pathname for a lilypond file in the format a-b-c.ly."
  (make-pathname :directory
                 (pathname-directory
                  (translate-logical-pathname "rameau:analysis;"))
                 :type type
                 :name (format nil "~{~a~^-~}" args)))

(defun dashs->space (string)
  "Replace all dashs in a string by spaces."
  (substitute #\Space #\- string))

(defun quote-string (string)
  "Add a pair of double quotes to a string."
  (format nil "\"~a\"" string))

(defun run-lily (options result-path result-file)
  #+sbcl (progn
           (sb-posix:chdir result-path)
           (sb-ext:run-program "lilypond"
                               (append (list "-f" "ps")
                                       (when (arg :png options) (list "--png"))
                                       (list (file-namestring result-file)))
                               :search t)))

(defun run-gv (options ps-file)
  #+sbcl (sb-ext:run-program "gv"
                             (list (file-namestring ps-file))
                             :search t))
