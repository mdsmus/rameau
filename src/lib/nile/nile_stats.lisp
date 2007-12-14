
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

;;;; $Id: nile_stats.lisp,v 1.21 1999/09/28 11:02:45 slink Exp $

(defpackage nile_stats
  (:use common-lisp)
  (:export endingstats
	   beginningstats
	   lang-similarity
	   regularity
	   tabular
	   mean-word-length
	   analyse
	   extractpopstats))

(in-package :nile_stats)

;;;; Input  : Language of a population (from show-words)
;;;; Returns: Stat-Array for endings

(defun endingstats (words)
  "Calculates probabilities of all suffixes considered for a language from
a BATALI-style simulation

words: Language of a population (from get-words)

Returns a statistics-hash for referents
          (eq hash-table, keys are referents
          values are equal hash tables with suffixes as keys
          and probabilities as values"
  (let ((stats-hash (make-hash-table :test #'eq)))
    (mapc #'(lambda (meaning-stats)
	      (let* ((meaning (car meaning-stats))
		     (ref (car meaning))
		     (ref-hash (or (gethash ref stats-hash)
				   (setf (gethash ref stats-hash) 
				     (make-hash-table :test #'equal)))))
		;; (format t "ref ~a pred ~a hash ~a~%" ref pred ref-hash)
		(dolist (statentry (cdr meaning-stats))
		  (let* ((seq (car statentry))
			 (prob (cdr statentry))
			 (seqlength (length seq)))
		    (cond
		     ((>= seqlength 4)
		      ;; make stats for last two and last
		      (let ((lasttwo (nthcdr (- seqlength 2) seq)))
			(incf (gethash lasttwo ref-hash 0) prob)
			(incf (gethash (cdr lasttwo) ref-hash 0) prob)))
		     ((or (= seqlength 2) (= seqlength 3))
		      ;; make stats for last one
		      (incf (gethash '(nil short) ref-hash 0) prob)
		      (incf (gethash (last seq) ref-hash 0) prob))
		     (t
		      (incf (gethash '(nil short) ref-hash 0) prob)
		      (incf (gethash '(length1) ref-hash 0) prob)))))))
	  words)
    stats-hash))

(defun file2list (file)
  "Reads file and returns a list with all lines of it"
  (with-open-file (stream file)
    (do* ((line (read stream nil 'eof) (read stream nil 'eof))
	  (list (cons nil nil))
	  (last list (cdr last)))
	((eq line 'eof) (cdr list))
      (setf (cdr last) (cons line nil)))))

(defun beginningstats (words)
  "Calculates probabilities of all prefixes considered for a language from
a BATALI-style simulation

words: Language of a population (from get-words)

Returns a statistics-hash for predicates
          (eq hash-table, keys are predicates
          values are equal hash tables with prefixes as keys
          and probabilities as values"
  (let ((stats-hash (make-hash-table :test #'eq)))
    (mapc #'(lambda (meaning-stats)
	      (let* ((meaning (car meaning-stats))
		     (pred (cdr meaning))
		     (pred-hash (or (gethash pred stats-hash)
				    (setf (gethash pred stats-hash) 
				      (make-hash-table :test #'equal)))))
		(dolist (statentry (cdr meaning-stats))
		  ;;		  (format t "bstats: doing ~a~%" statentry)
		  (let* ((seq (car statentry))
			 (prob (cdr statentry))
			 (seqlength (length seq)))
		    (cond
		     ((>= seqlength 3)
		      ;; make stats for forst two and first
		      (let ((firsttwo (list (first seq) (second seq))))
			(incf (gethash firsttwo pred-hash 0) prob)
			(incf (gethash (list (first seq)) pred-hash 0) prob)))
		     ((= seqlength 2)
		      ;; make stats for first
		      (incf (gethash '(nil short) pred-hash 0) prob)
		      (incf (gethash (list (first seq)) pred-hash 0) prob))
		     (t
		      (incf (gethash '(nil short) pred-hash 0) prob)
		      (incf (gethash '(length1) pred-hash 0) prob)))))))
	  words)
    stats-hash))


(defconstant *row-order* '((:HAPPY . 0)
			   (:SAD . 1)
			   (:ANGRY . 2)
			   (:TIRED . 3)
			   (:EXCITED . 4)
			   (:SICK . 5)
			   (:HUNGRY . 6)
			   (:THIRSTY . 7)
			   (:SILLY . 8)
			   (:SCARED . 9)))
(defconstant *col-order* '((:ME . 0)
			   (:WE . 1)
			   (:MIP . 2)
			   (:YOU . 3)
			   (:YALL . 4)
			   (:YUP . 5)
			   (:YUMI . 6)
			   (:ONE . 7)
			   (:THEY . 8)
			   (:ALL . 9)))

(defun samebeginning (one another)
  "Returns t if the two proseqs one and another have an eq beginning,
nil otherwise"
  (let ((truth t))
    (declare (boolean truth))
    (mapc #'(lambda (a b)
	      (setf truth (and truth
			       (eq a b))))
	  one
	  another)
    truth))

(defun sameending (one another)
  "Returns t if the two proseqs one and another have an eq ending,
nil otherwise"
  (let ((truth t))
    (declare (boolean truth))
    (mapc #'(lambda (a b)
	      (setf truth (and truth
			       (eq a b))))
	  (reverse one)
	  (reverse another))
    truth))

(defun word-equal (word1 word2)
  "Returns t if the lists word1 and word2 have the same number
of elements which are all eq, nil otherwise"
  (cond 
   ((and (consp word1) (consp word2)
	 (eq (car word1) (car word2)))
    (word-equal (cdr word1) (cdr word2)))
   ((and (not word1) (not word2)
	 t))
   (t nil)))

(defun word-similarity (word1 word2)
  "Returns the fraction of elements which are eq in the proseqs
word1 and word2 up to the length of the shortest of both"
  (let ((equals 0)
	(count 0))
    (mapc #'(lambda (c1 c2)
	      (if (eq c1 c2)
		  (incf equals))
	      (incf count))
	  word1 word2)
    (/ equals count)))

;;;; Does only work for output of show-words for the language of 
;;;; one net (probabilities of 1 always)

(defun lang-similarity (lang1 lang2)
  "For languages lang1 and lang2 as generated by get-words,
returns the two similarity measures (equal, similar) calculated
by word-equal and word-similarity, averaged over all words

All words of lang1 and lang2 must have probabilities of 1"
  (let ((equal-stat-sum 0)
	(similar-stat-sum 0)
	(stat-count 0))
    ;; go through meanings of lang1
    (mapc #'(lambda (lang1entry)
	      ;; entry is e.g.
	      ;; ((ME . TIRED) ((C A D C) . 1))
	      (let* ((meaning (car lang1entry))
		     (lang2entry (assoc meaning lang2 :test #'equal))
		     (word1 (caadr lang1entry))
		     (word2 (caadr lang2entry)))
		(incf stat-count)
		(if (word-equal word1 word2)
		    (incf equal-stat-sum))
		(incf similar-stat-sum
		      (word-similarity word1 word2))))
	  lang1)
    (values (/ equal-stat-sum stat-count)
	    (/ similar-stat-sum stat-count))))
					 
;;;; calculates average probability of all most
;;;; probable constituents (from stats)
;;;;
;;;; argument: analyses as from analyse

(defun regularity (&rest analyses)
  "Retuns the average probabilities of most probable constituents of
analyses (as generated by analyse)"
  (let ((sum 0.0)
	(count 0))
    ;; avarage over most probable beginning/ending for each meaning
    (dolist (thisstat analyses)
      (dolist (thisline thisstat)
	(incf sum (cdr (cadr thisline)))
	(incf count)))
    (/ sum count)))

(defun printbold (word beginning ending
		  &key (stream t))
  "Helper for tabular: Prints word to stream in LaTeX notation,
making bold beginning and ending"
  (let* ((samebeg (samebeginning word beginning))
	 (sameend (sameending word ending))
	 (wlength (length word))
	 (bolds (append
		 (if samebeg
		     beginning
		   (make-sequence 'list (length beginning)))
		 (let ((diff (- (length word)
				(length beginning)
				(length ending))))
		   (if (and sameend
			  (>= diff 0))
		       (append
			(make-sequence 'list diff)
			ending)
		     (make-sequence 'list (max 0
					       (- (length word)
						  (length beginning)))))))))
    (mapc #'(lambda (char bold)
	      (if bold
		  (format stream "{\\bf ~a}" char)
		(format stream "~a"
			(string-downcase 
			 (format nil "~a" char)))))
	  word bolds)))
		  
(defun tabular (lang &key name 
			  ((:bstats bstats-in))
			  ((:estats estats-in))
			  (stream t))
  "Writes to stream a Batali-style language table in LaTeX for language
lang (as generated by get-words). A label can be provided in name, as well
as precalculated beginning- and endingstats in bstats and estats,
respectively"
  (let ((bstats (or bstats-in
		    (analyse (beginningstats lang))))
	(estats (or estats-in
		    (analyse (endingstats lang)))))
    (let (rows)
      (dolist (line lang)
	(let* ((meaning (car line))
	       (ref (car meaning))
	       (pred (cdr meaning))
	       (row (or (assoc pred rows)
			(car (push (cons pred nil) rows))))
	       (item (or (assoc ref (cdr row))
			 (car (push (cons ref nil) (cdr row))))))
	  (setf (cdr item) (cadr line))))
      
      
      (setf rows (sort rows #'(lambda (a b)
				(<= (cdr (assoc a *row-order*))
				    (cdr (assoc b *row-order*))))
		       :key #'car))
      
      
      (mapc #'(lambda (row) 
		(setf (cdr row) (sort (cdr row) #'(lambda (a b)
						    (<= (cdr (assoc a *col-order*))
							(cdr (assoc b *col-order*))))
				      :key #'car)))
	    rows)
      
      (format stream "\\begin{table}[htb]~%")
      (format stream "\\dsoff~%\\begin{center}~%")
      (format stream "\\tiny~%")
      (format stream "\\setlength{\\savetabcolsep}{\\tabcolsep}~%")
      (format stream "\\setlength{\\tabcolsep}{0.3em}~%")
      (format stream "\\begin{tabular}{|l||l|l|l|l|l|l|l|l|l|l|}~%")
      (format stream "\\hline~%")
      (format stream "Regularity ")
      (mapc #'(lambda (column)
		(format stream " & {\\em ~a}" 
			(string-downcase
			 (format nil "~a"(car column)))))
	    (cdr (car rows)))
      (format stream "\\\\~%")
      (format stream "~a\\% " (floor (* 100 (regularity bstats estats))))
      (mapc #'(lambda (column)
		(let* ((ref (car column))
		       (mostprobableforref
			(car (car (cdr (assoc ref estats)))))
		       (percent
			(cdr (car (cdr (assoc ref estats))))))
		  (format stream " & -")
		  (mapc #'(lambda (x)
			    (princ x stream))
			mostprobableforref)
		  (format stream " ~a\\\% " (floor (* 100 percent)))))
	    (cdr (car rows)))
      (format stream "\\\\~%\\hline~%\\hline~%")
      (mapc #'(lambda (row)
		(let* ((predicate (car row))
		       (mostprobableforpred
			(car (car (cdr (assoc predicate bstats)))))
		       (percent
			(cdr (car (cdr (assoc predicate bstats))))))
		  ;; write predicate
		  ;; (format stream "\\raisebox{1.5ex}[-1.5ex]{ ~a} " (car row))
		  (format stream "{\\em ~a} "
			  (string-downcase 
			   (format nil "~a" (car row))))
		  ;; write words
		  (mapc #'(lambda (column)
			    (let* ((ref (car column))
				   (word (cadr column))
				   (mostprobableforref
				    (car (car (cdr (assoc ref estats))))))
			      (format stream " & ")
			      (printbold word 
					 mostprobableforpred
					 mostprobableforref
					 :stream stream)))
			(cdr row))
		  ;; new line
		  (format stream " \\\\~%")
		  ;; write stats
		  (mapc #'(lambda (x)
			    (princ x stream))
			mostprobableforpred)
		  (format stream "- ~a\\\% " (floor (* 100 percent)))
		  (mapc #'(lambda (column)
			    (format stream " & ")
			    ;; write probability
			    (format stream " (~d \\\%) " (floor (* 100 (cddr column)))))
			(cdr row))
		  (format stream " \\\\~%")
		  (format stream "\\hline~%")))
	    rows)
      (format stream "\\end{tabular}~%")
      (format stream "\\setlength{\\tabcolsep}{\\savetabcolsep}~%")
      (format stream "\\end{center}~%")
      (format stream "\\dson~%\\caption{Results from {\\tt ~a}}~%" 
	      (map 'string #'(lambda (x) x)
		   (mapcan #'(lambda (elem)
			       (if (char= elem #\_)
				   (list #\\ #\_)
				 (list elem)))
			   (map 'list #'(lambda (x) x)
				  name))))
      (format stream "\\end{table}~%")
      nil)))

(defun tabular-text (lang &key name 			       
			       ((:bstats bstats-in))
			       ((:estats estats-in))
			       (stream t))
  "Writes to stream a Batali-style language table in ASCII format for language
lang (as generated by get-words). A label can be provided in name, as well
as precalculated beginning- and endingstats in bstats and estats,
respectively"
  (let ((bstats (or bstats-in
		    (analyse (beginningstats lang))))
	(estats (or estats-in
		    (analyse (endingstats lang)))))
    (let (rows)
      (dolist (line lang)
	(let* ((meaning (car line))
	       (ref (car meaning))
	       (pred (cdr meaning))
	       (row (or (assoc pred rows)
			(car (push (cons pred nil) rows))))
	       (item (or (assoc ref (cdr row))
			 (car (push (cons ref nil) (cdr row))))))
	  (setf (cdr item) (cadr line))))
      
      
      (setf rows (sort rows #'(lambda (a b)
				(<= (cdr (assoc a *row-order*))
				    (cdr (assoc b *row-order*))))
		       :key #'car))
      
      
      (mapc #'(lambda (row) 
		(setf (cdr row) (sort (cdr row) #'(lambda (a b)
						    (<= (cdr (assoc a *col-order*))
							(cdr (assoc b *col-order*))))
				      :key #'car)))
	    rows)
      
      (if name
	  (format stream "~C[H~C[2J~a~%Regularity" #\esc #\esc name)
	(format stream "~C[H~C[2JRegularity" #\esc #\esc))
      
      (mapc #'(lambda (column)
		(format stream "~11,8T~(~a~)"
			(car column)))
	    (cdr (car rows)))
      (format stream "~%~a\%" (floor (* 100 (regularity bstats estats))))
      (mapc #'(lambda (column)
		(let* ((ref (car column))		       
		       (mostprobableforref
			(car (car (cdr (assoc ref estats)))))
		       (percent
			(cdr (car (cdr (assoc ref estats))))))
		  (format stream "~11,8T-")
		  (mapc #'(lambda (x)
			    (princ x stream))
			mostprobableforref)
		  (format stream " ~a\%" (floor (* 100 percent)))))
	    (cdr (car rows)))
      (format stream "~%")
      (mapc #'(lambda (row)
		(let* ((predicate (car row))
		       (mostprobableforpred
			(car (car (cdr (assoc predicate bstats)))))
		       (percent
			(cdr (car (cdr (assoc predicate bstats))))))
		  ;; write predicate
		  ;; (format stream "\\raisebox{1.5ex}[-1.5ex]{ ~a} " (car row))
		  (format stream "~(~a~)"
			  (car row))
		  ;; write words
		  (mapc #'(lambda (column)
			    (let* ((ref (car column))
				   (word (cadr column))
				   (mostprobableforref
				    (car (car (cdr (assoc ref estats))))))
			      (format stream "~11,8T")
			      (mapc #'(lambda (char)
					(format stream "~a" char))
				    word)))
			(cdr row))

		  ;; new line
		  (format stream "~%")
		  ;; write stats
		  (mapc #'(lambda (x)
			    (princ x stream))
			mostprobableforpred)
		  (format stream "- ~a\%" (floor (* 100 percent)))
		  (mapc #'(lambda (column)
			    ;; write probability
			    (format stream "~11,8T(~d \%)" (floor (* 100 (cddr column)))))
			(cdr row))
		  (format stream "~%")))
	    rows)
      nil)))



;; input: lang-file as written by 
;; extractpopstats


(defun mean-word-length (file)
  "Calculates the mean word length of language in file,
as generated by extractpopstats"
  (with-open-file (stats file)
    (let ((lang (read stats))
	  (num-exprs 0)
	  (sum-length 0))
      (dolist (expr-stats lang)
	;; expr-stats is e.g. ((:ME . :ANGRY) ((#\D #\D #\A) . 0.96666664) ((#\D #\D #\A #\D) . 0.033333335))
	(dolist (word-stats (cdr expr-stats))
	  ;; word-stats is e.g. ((#\D #\D #\A) . 0.96666664)
	  (incf sum-length (* (length (car word-stats))
			      (cdr word-stats))))
	(incf num-exprs))
      (/ sum-length num-exprs))))

;; = sum( p(word)*length(word))
#|
(defun mean-word-length (file)
  (with-open-file (stats file)
    (do ((line (read stats nil 'eof) (read stats nil 'eof))
	 (sum 0.0)
	 (word-stat-hash (make-hash-table :test #'equal)))
	((eq line 'eof) sum)
      (dolist (statentry (cdr line))
	(let* ((prob (cdr statentry))
	       (seq (car statentry))
	       (seqlength (length seq)))
	  (incf sum (* prob seqlength)))))))
|#

(defun sumup (list)
  "Sums up elements of list"
  (let ((sum 0))
    (mapcar #'(lambda (elem)
		(incf sum (cdr elem)))
	    list)
    sum))

;;(defun stathash2statlist (stathash)

(defun analyse (stats)
  "Generates for stats as returned by endingstats and beginningstats a list
of the considered constituents for each predicate/referent and their
probabilites.

Return-Value: ((referent/predicate (constituent . probability) ...) ...)"
  (let (result)
    (maphash #'(lambda (referent ending-stat-hash)
		 (let ((stat-list nil))
		   (maphash #'(lambda (ending stats)
				(if (> (length ending) 1)
				    (push (cons ending (/ stats 10.0))
					  stat-list)))
			    ending-stat-hash)
		   (let ((final-stats
			  (let ((sorted (sort stat-list
					      #'>=
					      :key #'cdr)))
			    (if (caaar sorted)
				;; not nil
				sorted
			      ;; else nil - get stats for one ending char
			      (let ((stat-list nil))
				(maphash #'(lambda (ending stats)
					     (if (= (length ending) 1)
						 (push (cons ending (/ stats 10.0))
						       stat-list)))
					 ending-stat-hash)
				(sort stat-list
				      #'>=
				    :key #'cdr))))))
		     (push (cons referent final-stats)
			   result))))
	     stats)
    (nreverse result)))

(defun extractpopstats (file get-words-func 
			&key (verbose t)
			     (do-table t)
			     (do-lang t)
			     (lang-file-suffix ".lang")
			     (do-regstats t))
  "For a logfile as written to std-out by nile_batali:run-simulation
extract the languages from all population dumps, write latex language
tables, language-files and a regularity-stats file.

What exactly to do can be specified by the arguments do-table, do-lang
and do-regstats.

file is the pathname of the logile
the function to extract a language from a population has to be given
as get-words-fund (e.g. #'nile_batali:get-words)"
  (with-open-file (stream file)
    (let ((regstats-stream 
	   (if do-regstats
	       (open (concatenate 'string file ".regstats")
		     :direction :output :if-exists :supersede))))
      (do ((this-line-position (file-position stream)
			       (file-position stream))
	   (line (read-line stream nil 'eof)
		 (read-line stream nil 'eof))
	   (round 0))
	  ((eq line 'eof))
	(declare (fixnum round))
	(cond 
	 ((and (>= (length line) 6)
	       (string-equal "Stats:" line :end2 6))
	  (setq round
	    (read-from-string (subseq line 
				      (+ (search "Round " line) 6))
			      nil 0)))
	 ((and (>= (length line) 6)
	       (string-equal "#(#(#S" line :end2 6))
	  (if verbose
	      (format t "Processing pop file ~a round ~a~%"
		      file round))
	  (file-position stream this-line-position)
	  (let* ((pop (read stream))
		 (lang (funcall get-words-func pop))
		 (bstats (if (or do-regstats do-table)
			     (analyse (beginningstats lang))))
		 (estats (if (or do-regstats do-table)
			     (analyse (endingstats lang))))
		 (regularity (if do-regstats
				 (regularity bstats estats))))
	    ;; this should be a population
	    ;; now: - write regularity to additional stats
	    ;;        file
	    (if do-regstats
		(format regstats-stream
			"Round ~a Regularity ~a~%"
			round regularity))
	    ;;      - Write language to additional file
	    (if do-lang
		(with-open-file (lang-stream
				  (format nil "~a.round-~a~a"
					  file 
					  round
					  lang-file-suffix)
				 :direction :output :if-exists :supersede)
		  (format lang-stream "~S~%" lang
			  :right-margin 80
			  :level 0 :length 0)))
	    ;;      - Write table to additional file
	    (if do-table
		(with-open-file (tabular-stream
				 (format nil "~a.round-~a.tab.tex"
					 file round)
				 :direction :output :if-exists :supersede)
		  (tabular lang 
			   :name (format nil "~a \\rm Round ~a" file round)
			   :bstats bstats
			   :estats estats
			   :stream tabular-stream)))))))
      (if regstats-stream
	  (close regstats-stream)))))
