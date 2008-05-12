(defpackage :genoslib
  (:import-from #:arnesi "AIF" "IT" "LAST1")
  (:shadowing-import-from #:rameau-base #:defun #:defmacro #:defparameter #:defvar #:defstruct)
  (:use #:cl)
  (:export #:defun #:defmacro #:defparameter #:defvar #:defstruct
           #:defclass #:defgeneric #:tempered #:tonal #:a    #:a
   #:b
   #:c
   #:d
   #:e
   #:f
   #:g
   #:aes
   #:bes
   #:ces
   #:des
   #:ees
   #:fes
   #:gis
   #:ais
   #:bis
   #:cis
   #:dis
   #:eis
   #:fis
   #:gis
))

(in-package :genoslib)

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
    (fresh-line *debug-io*)
    (apply #'format *debug-io* (concat " => DEBUG: " format-string) args)
    (force-output *debug-io*)))

(defun dbg-indent (id indent format-string &rest args)
  "Print indented debugging info if (DEBUG ID) has been specified. [DONTCHECK]"
  (when (member id *dbg-ids*)
    (fresh-line *debug-io*)
    (dotimes (i indent) (princ " " *debug-io*))
    (apply #'format *debug-io* (concat " => DEBUG: " format-string) args)))

(defun rameau-debug (&rest ids)
  "Start dbg output on the given ids. [DONTCHECK]"
  (setf *dbg-ids* (union ids *dbg-ids*)))

(defun rameau-undebug (&rest ids)
  "Stop dbg on the ids. With no ids, stop dbg altogether. [DONTCHECK]"
  (setf *dbg-ids* (if (null ids)
                      nil
                      (set-difference *dbg-ids* ids))))

(defun add-lily-ext (file)
  "Add a .ly extension to filename \\texttt{file} if nonexistent."
  (if (has-ext? file) file (concat file ".ly")))

(defun add-pop-ext (file)
  "Add a .pop extension to filename \\texttt{file} if nonexistent."  
  (if (has-ext? file) file (concat file ".pop")))

(defun has-ext? (file)
  "Heuristic check to see whether filename \\texttt{file} has an extension."
  (find #\. file))

(defun remove-ext (file)
  "Heuristic for removing a file's extension."
  (subseq file 0 (position #\. file)))

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

(defun skip (element list &key (test #'equal))
  "Skip every initial occurence of \\texttt{element} in \\texttt{list}."
  (if (funcall test element (first list))
      (skip element (rest list) :test test)
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

(defcached string->symbol (string)
  "Convert the string \\texttt{string} to a symbol."
  (let ((*package* (find-package :rameau)))
    (intern (string-upcase string) :rameau)))


(defun destringify (coisa)
  "Reverses the operation of stringify in a few interesting cases."
  (let ((*package* (find-package :rameau)))
    (cond ((numberp coisa) coisa)
          ((stringp coisa) (read-from-string (string-upcase coisa)))
          (t coisa))))

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

(defun firstn (list n)
  "Return the first \\texttt{n} elements of \\texttt{list}, or \\texttt{n} nulls."
  (loop for i from 0 to (1- n) collect
       (nth i list)))

(defun repeat-list (n list)
  "Repeat \\texttt{n} times the element \\texttt{list}, forming a list."
  (if (> n 0)
      (cons list (repeat-list (- n 1) list))))

(defun read-file-as-sexp (file)
  "Read file named \\texttt{file} as a single sexp. [DONTCHECK]"
  (read-from-string (format nil "(~a)" (file-string file))))

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

(defun char->symbol (char)
  "Returns the symbol for the character \\texttt{char}."
  (intern (string-upcase (string char)) :rameau))

(defun split-word (word)
  "Splits word \\texttt{word} into a list of characters and returns
their symbolic representations."
  (loop for char across word collect (char->symbol char)))

(defun split-opts (string)
  "Split the options in command-line argument \\texttt{string}."
  (mapcan (lambda (s) (split-word (delete #\- s)))
          (cl-ppcre:split #\Space string)))

(defun split-dados (dados)
  "Split string \\texttt{dados} using commas as separators."
  (cl-ppcre:split "," dados))

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
  (if (and a b)
      (loop for i in a
         for j in b
         sum (square (- i j)))
      most-positive-fixnum))
