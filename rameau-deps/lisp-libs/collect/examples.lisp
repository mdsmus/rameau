; Factorials

(defun fac (n)
  (collect (reduce #'* 1) (x)
    (step x 1 (<= x n) (1+ x))))


; Add vectors

(defun add-vectors (&rest vectors)
  (let ((l (collect max ((length v))
		    (in v vectors))))
    (collect (array sum (l) :initial-element 0) (i x)
      (in v vectors)
      (in (i x) v))))


; Quick sort

(defun qsort (l)
  (cond
   ((or (null l) 
	(null (cdr l)))
    l)
   (t
    (let ((parts 
          (collect (array (list) (2)) ((if (< x (car l)) 0 1) x) 
	    (in (x) (cdr l)))))
      `(,@(qsort (aref parts 0)) ,(car l) ,@(qsort (aref parts 1)))))))


; Matrix multiplication. 
; a is assumed to have dimensions i-dim x j-dim, and b j-dim x k-dim

(defun matmul (a b i-dim j-dim k-dim)
  (collect (array sum (i-dim k-dim)) (i k (* (aref a i j) (aref b j k)))
    (step i 0 (< i i-dim) (1+ i))
    (step j 0 (< j j-dim) (1+ j))
    (step k 0 (< k k-dim) (1+ k))))


; Freq finds the most common element of a sequence

(defun freq (l)
  (let 
      ((table 
       (collect (hash-table sum) (x 1)
	 (in x l))))
    (collect (reduce #'(lambda (old new)
			 (if (> (car new) (car old))
			     new old)) '(0))
      ((list v k))
      (in (k v) table))))


; Perms builds a list of all permutations of a list.

(defun perms (l)
  (cond
   ((null l) (list nil))
   (t (collect list ((cons a b))
       (in a l)
       (in b (perms (remove a l)))))))


; Anagram takes a list of strings and an integer, and returns lists of
; those strings, for which there are at least n permutations

(defun anagram (l n)
  (let
      ((table (collect (hash-table (list) :test #'equal) (key s)
		(in (s) l)
		(let key (sort (copy-seq s) #'char<)))))
    (collect (list) (l)
      (in (k l) table)
      (when (>= (length l) n)))))
