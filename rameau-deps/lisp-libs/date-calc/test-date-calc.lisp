(load "date-calc.lisp")

;;; *lst* = LISP . PERL PARAMETER
(defparameter *lst* '((date-calc:date-calc-add-delta-days . ("Add_Delta_Days" (2005 10 12 -1000)))
		      (date-calc:date-calc-add-delta-ym . ("Add_Delta_YM" (2005 10 15 1 3)))
		      (date-calc:date-calc-add-delta-days . ("Add_Delta_Days" (2005 10 25 -10)))
		      (date-calc:date-calc-add-delta-days . ("Add_Delta_Days" (1897 1 2 1341)))
		      (date-calc:date-calc-add-delta-days . ("Add_Delta_Days" (1945 3 1 -2345)))
		      (date-calc:date-calc-add-delta-ymd . ("Add_Delta_YMD" (1928 3 1 -5 32 41)))
		      (date-calc:date-calc-add-delta-ymd . ("Add_Delta_YMD" (1736 12 29 2 -32 41)))
		      (date-calc:date-calc-add-delta-ymd . ("Add_Delta_YMD" (1845 1 1 0 124 -41)))
		      (date-calc:date-calc-days-in-year . ("Days_in_Year" (1824 12)))
		      (date-calc:date-calc-days-in-year . ("Days_in_Year" (1976 10)))
		      (date-calc:date-calc-days-in-year . ("Days_in_Year" (2005 3)))
		      (date-calc:date-calc-days-in-month . ("Days_in_Month" (1904 2)))
		      (date-calc:date-calc-days-in-month . ("Days_in_Month" (1976 9)))
		      (date-calc:date-calc-days-in-month . ("Days_in_Month" (2005 3)))
		      (date-calc:date-calc-weeks-in-year . ("Weeks_in_Year" (1904)))
		      (date-calc:date-calc-weeks-in-year . ("Weeks_in_Year" (1874)))
		      (date-calc:date-calc-weeks-in-year . ("Weeks_in_Year" (2003)))
		      (date-calc:date-calc-leap-year . ("leap_year" (1904)))
		      (date-calc:date-calc-leap-year . ("leap_year" (1900)))
		      (date-calc:date-calc-leap-year . ("leap_year" (2004)))
		      (date-calc:date-calc-day-of-year . ("Day_of_Year" (1904 10 2)))
		      (date-calc:date-calc-day-of-year . ("Day_of_Year" (1873 11 12)))
		      (date-calc:date-calc-day-of-year . ("Day_of_Year" (2004 1 2)))
		      (date-calc:date-calc-date-to-days . ("Date_to_Days" (20 10 2)))
		      (date-calc:date-calc-date-to-days . ("Date_to_Days" (200 10 2)))
		      (date-calc:date-calc-date-to-days . ("Date_to_Days" (2000 10 2)))
		      (date-calc:date-calc-day-of-week . ("Day_of_Week" (1901 6 20)))
		      (date-calc:date-calc-day-of-week . ("Day_of_Week" (901 6 20)))
		      (date-calc:date-calc-day-of-week . ("Day_of_Week" (2901 6 20)))
		      (date-calc:date-calc-week-of-year . ("Week_of_Year" (1983 6 20)))
		      (date-calc:date-calc-week-of-year . ("Week_of_Year" (1765 1 29)))
		      (date-calc:date-calc-week-of-year . ("Week_of_Year" (2005 12 20)))
		      (date-calc:date-calc-monday-of-week . ("Monday_of_Week" (20 1921)))
		      (date-calc:date-calc-monday-of-week . ("Monday_of_Week" (1 1974)))
		      (date-calc:date-calc-monday-of-week . ("Monday_of_Week" (52 2003)))
		      (date-calc:date-calc-nth-weekday-of-month-year . ("Nth_Weekday_of_Month_Year" (1900 4 4 2)))
		      (date-calc:date-calc-nth-weekday-of-month-year . ("Nth_Weekday_of_Month_Year" (1785 12 1 3)))
		      (date-calc:date-calc-nth-weekday-of-month-year . ("Nth_Weekday_of_Month_Year" (2001 4 4 4)))
		      (date-calc:date-calc-standard-to-business . ("Standard_to_Business" (2001 4 4)))
		      (date-calc:date-calc-standard-to-business . ("Standard_to_Business" (875 12 24)))
		      (date-calc:date-calc-standard-to-business . ("Standard_to_Business" (2324 2 28)))
		      (date-calc:date-calc-business-to-standard . ("Business_to_Standard" (875 52 2)))
		      (date-calc:date-calc-business-to-standard . ("Business_to_Standard" (2001 14 3)))
		      (date-calc:date-calc-business-to-standard . ("Business_to_Standard" (2324 9 4)))
		      (date-calc:date-calc-delta-days . ("Delta_Days" (2324 9 4 1789 1 1)))
		      (date-calc:date-calc-delta-dhms . ("Delta_DHMS" (1765 9 4 10 10 10 2789 1 1 11 11 11)))
		      (date-calc:date-calc-delta-dhms . ("Delta_DHMS" (2765 9 4 10 10 10 1989 1 1 11 11 11)))
		      (date-calc:date-calc-delta-ymd . ("Delta_YMD" (2765 9 4 1989 2 23)))
		      (date-calc:date-calc-delta-ymd . ("Delta_YMD" (765 9 4 2989 2 23)))
		      (date-calc:date-calc-delta-ymdhms . ("Delta_YMDHMS" (2765 9 4 10 10 10 1989 1 1 11 11 11)))
		      (date-calc:date-calc-delta-ymdhms . ("Delta_YMDHMS" (1965 9 4 10 10 10 2008 12 31 11 11 11)))
		      (date-calc:date-calc-normalize-dhms . ("Normalize_DHMS" (3 354 123 3245)))
		      (date-calc:date-calc-add-delta-dhms . ("Add_Delta_DHMS" (1965 9 4 10 10 10 3 34 25 -100)))
		      (date-calc:date-calc-add-delta-ym . ("Add_Delta_YM" (1965 9 4 25 10)))
		      (date-calc:date-calc-add-delta-ymd . ("Add_Delta_YMD" (1965 9 4 25 1340 234)))
		      (date-calc:date-calc-add-delta-ymdhms . ("Add_Delta_YMDHMS" (1965 9 4 10 10 10 25 1340 234 11 11 11)))
		      (date-calc:date-calc-today . ("Today" ()))
		      (date-calc:date-calc-today . ("Today" ()))
		      (date-calc:date-calc-decode-month . ("Decode_Month" ("September")))
		      (date-calc:date-calc-decode-day-of-week . ("Decode_Day_of_Week" ("Monday")))))


;;;;
;;;;
;;;;
;;; Prepare the PERL intro and PERL exit
(defparameter *perl-intro* "eval \"use Date::Calc qw(:all)\";
if($@) {
  print \"Date::Calc not found. Exiting.\n\";
  exit 1;
}
my @arr =  ")

(defparameter *perl-exit* "print \"@arr\"; exit;")

;;; Do PERL function call
;; SBCL CMUCL
(defun get-perl-value (intro func exite)
  (let ((myret))
    (with-output-to-string (from-perl-stream)
      (with-input-from-string (to-perl-stream (concatenate 'string intro func exite))
	(let ((mystruc (run-program "/usr/bin/perl" '()
				    :input to-perl-stream
				    :output from-perl-stream
				    :error :output
				    :wait t)))
	  (if mystruc
	      (progn
		(setf myret (get-output-stream-string from-perl-stream))
		(process-close mystruc))))))
    myret))

;; Paul Graham token splitter
(defun constituent (c)
  (and (graphic-char-p c)
       (not (char= c #\Space))))

;; Paul Graham token splitter
(defun tokens (str test start)
  (let ((p1 (position-if test str :start start)))
    (if p1
	(let ((p2 (position-if #'(lambda (c)
				   (not (funcall test c)))
			       str :start p1)))
	  (cons (subseq str p1 p2)
		(if p2
		    (tokens str test p2)
		    nil)))
	nil)))

;; Create the PERL function string
(defun mk-perl-func-arg-str (name args)
  (with-output-to-string (s)
    (format s "~A(~A" name (first args))
    (dolist (a (cdr args))
      (format s ",~A" a))
    (format s ");")))

(defun main ()
  (loop for (fn . args) in *lst*
	do (format t "~A~A => ~A~%" fn (second args)
		   (let ((lsp-list (multiple-value-list (apply fn (second args)))) ; get date-calc package fn result
			 (perl-list (mapcar #'(lambda (str) (parse-integer str)) ; convert STR -> NUM
					    (tokens	; SPLIT the PERL result STR
					     (get-perl-value ; call PERL Date::Calc
					      *perl-intro*
					      (mk-perl-func-arg-str (first args) (second args)) ; create the Perl fn call
					      *perl-exit*)
					     #'constituent 0))))
		     (if (equal lsp-list perl-list)
			 T
			 (list lsp-list perl-list))))))


