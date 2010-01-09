;; cl-who is needed; so place into your current working DIR
(load (compile-file "load.lisp"))

;; load date-calc; also in current working DIR
(load (compile-file "date-calc.lisp"))

(defun mkfile ()
  (let ((progdescription  ;; assoc list for lazyness: (LISP . (PERL PARAMETER DESCRIPTION))
	 '(("*language*" .
	    ("Language"
	     "Global Variable in Package"
	     "Integer"
	     "0=Default, 1=English, 2=Francais, 3=Deutsch, 4=Espanol, 5=Portugues, 6=Nederlands, 7=Italiano, 8=Norsk, 9=Svenska, 10=Dansk, 11=suomi"))
	   ("decode-day-of-week" .
	    ("Decode_Day_of_Week"
	     "(STR)"
	     "DOW"
	     "Reads in a string and returns the DOW as integer with respect to *language*."))
	   ("decode-month" .
	    ("Decode_Month"
	     "(STR)"
	     "M"
	     "Returns number of month. STR can partially name the month according to *language*. Computes a (search ...:test #'char-equal)"))
	   ("decode-language" .
	    ("Decode_Language"
	     "(N)"
	     "STR"
	     "Reads in the Lang as NUM and returns the corresponding textual representation."))
	   ("fixed-window" .
	    ("fixed_window"
	     "(YY)"
	     "YYYY"
	     "Convert two digit YEAR to four digit YEAR; YEAR<=70 -> 2000+YEAR; YEAR<100&&>70  -> 1900+YEAR."))
	   ("center" .
	    ("center"
	     "(str width)"
	     "width/2 str width/2"
	     "Return a string that is WIDTH long with STRING centered in it."))
	   ("valid-year-p" .
	    ("Valid_Year"
	     "(Y)"
	     "T/NIL"
	     "Checks if Y >= 1"))
	   ("valid-month-p" .
	    ("Valid_Month"
	     "(M)"
	     "T/NIL"
	     "Checks if Y<=12 && Y>=1"))
	   ("leap-year" .
	    ("leap_year"
	    "(Y)"
	    "1/0"
	    "Returns 1 if Y is a leap year. Else 0."))
	   ("leap-year-p" .
	    (""
	    "(Y)"
	    "T/NIL"
	    "Returns T if Y is a leap year. Else NIL."))
	   ("days-in-month" .
	    ("Days_in_Month"
	    "(Y M)"
	    "D"
	    "Returns the number of days in MONTH of YEAR."))
	   ("days-in-year" .
	    ("Days_in_Year"
	    "(Y &optional M)"
	    "D"
	    "This function returns the number of days in the given YEAR and optional MONTH. If MONTH is [1..12], return the number of days in that YEAR as of the last of that MONTH."))
	   ("check-date" .
	    ("check_date"
	    "(Y M D)"
	    "1/0"
	    "This function returns t if the given three numerical values YEAR MONTH DAY constitute a valid date, and nil otherwise."))
	   ("check-business-p" .
	    ("Check_Business"
	    "(Y W DOW)"
	    "T/NIL"
	    "This function returns true if the given three numerical values YEAR WEEK DOW constitute a valid date in business format, and nil otherwise. Beware that this function does NOT compute whether a given date is a business day (i.e., Monday to Friday)! To do so, use (< (day-of-week year month day) 6) instead. DOW not CL conform."))
	   ("check-time-p" .
	    ("Check_Time"
	    "(H M S)"
	    "T/NIL"
	    "This function returns t if the given three numerical values HOUR MIN SEC constitute a valid time, and nil otherwise."))
	   ("day-of-year" .
	    ("Day_of_Year"
	    "(Y M D)"
	    "D"
	    "This function returns the sum of the number of days in the months starting with January up to and including MONTH in
    the given year YEAR. 0 on failure."))
	   ("date-to-days" .
	    ("Date_of_Days"
	    "(Y M D)"
	    "D"
	    "This function returns the (absolute) number of the day of the given date, where counting starts at the 1.Jan 1."))
	   ("day-of-week" .
	    ("Day_of_Week"
	    "(Y M D)"
	    "DOW"
	    "Returns the Number of the Day of the Week. Monday=1."))
	   ("weeks-in-year" .
	    ("Weeks_in_Year"
	    "(Y)"
	    "W"
	    "Returns the number of weeks in YEAR."))
	   ("delta-days" .
	    ("Delta_Days"
	    "(Y1 M1 D1 Y2 M2 D2)"
	    "D"
	    "Returns the diff of the two YMD values in Days."))
	   ("week-number" .
	    ("Week_Number"
	    "(Y M D)"
	    "W"
	    "This function returns the number of the week of the given Y M D lies in. If the given date lies in the LAST week of the PREVIOUS year, 0 is returned."))
	   ("week-of-year" .
	    ("Week_of_Year"
	    "(Y M D)"
	    "W Y"
	    "Returns WEEK YEAR where week is the week number of YEAR."))
	   ("add-delta-days" .
	    ("Add_Delta_Days"
	    "(Y M D dD)"
	    "Y M D"
	    "Returns YMD = YMD + dD. dD can be neagtive."))
	   ("monday-of-week" .
	    ("Monday_of_Week"
	    "(W Y)"
	    "Y M D"
	    "Return YEAR MONTH DAY corresponding to the Monday of WEEK in YEAR."))
	   ("nth-weekday-of-month-year" .
	    ("Nth_Weekday_of_Month_Year"
	    "(Y M DOW n)"
	    "Y M D"
	    "This function returns the YEAR MONTH DAY of the N-th day of week DOW is in the given MONTH and YEAR; such as, for example, the 3rd Thursday of a given month and year. DOW is not CL conform."))
	   ("standard-to-business" .
	    ("Standard_to_Business"
	    "(Y M D)"
	    "Y W DOW"
	    "Returns the Business date of Y M D."))
	   ("business-to-standard" .
	    ("Business_to_Standard"
	    "(Y W DOW)"
	    "Y M D"
	    "Returns the standard date of Y M DOW."))
	   ("delta-hms" .
	    ("Delta_HMS"
	    "(H1 M1 S1 H2 M2 S2)"
	    "H M S"
	    "This function returns H M S as the difference of H1 M1 S1 and H2 M2 S2."))
	   ("delta-dhms" .
	    ("Delta_DHMS"
	    "(D1 H1 M1 S1 D2 H2 M2 S2)"
	    "D H M S"
	    "Returns D H M S as the difference of D1 H1 M1 S1 and D2 H2 M2 S2."))
	   ("delta-ymd" .
	    ("Delta_YMD"
	    "(Y1 M1 D1 Y2 M2 D2)"
	    "Y M D"
	    "Returns Y M D as the difference of Y1 M1 D1 and Y2 M2 D2."))
	   ("delta-ymdhms" .
	    ("Delta_YMDHMS"
	    "(Y1 M1 D1 H1 M1 S1 Y2 D2 H2 M2 S2)"
	    "Y M D H M S"
	    "Returns Y M D H M S as the difference of Y1 M1 D1 H1 M1 S1 and Y2 M2 D2 H2 M2 S2."))
	   ("normalize-dhms" .
	    ("Normalize_DHMS"
	    "(D H M S)"
	    "D H M S"
	    "This function takes four arbitrary values for days, hours, minutes and seconds (which may have different signs) and renormalizes them so that the values for hours, minutes and seconds will lie in the ranges [-23..23], [-59..59] and [-59..59], respectively, and so that they have the same sign (Except for D)."))
	   ("add-delta-dhms" .
	    ("Add_Delta_DHMS"
	    "(Y M D H M S dD dH dM dS)"
	    "Y M D H M S"
	    "This function serves to add a days, hours, minutes and seconds offset to a given date and time (YEAR MONTH DAY HOUR MINUTE SECOND DDAY DHOUR DMINUTE DSECOND), in order to answer questions like \"today and now plus 7 days but minus 5 hours and then plus 30 minutes, what date and time gives that?\". Returns: Y M D H M S."))
	   ("add-year-month" .
	    ("Add_Year_Month"
	    "(Y M dY dM)"
	    "Y M"
	    "Returns YM=Y+dY+M+dM."))
	   ("add-delta-ym" .
	    ("Add_Delta_YM"
	    "(Y M D dY dM)"
	    "Y M D"
	    "Returns YM=YM+dY+dM+D"))
	   ("add-delta-ymd" .
	    ("Add_Delta_YMD"
	    "(Y M D dY dM dD)"
	    "Y M D"
	    "Returns YMD=YMD+dY+dM+dD"))
	   ("add-delta-ymdhms" .
	    ("Add_Delta_YMDHMS"
	    "(Y M D H M S dY dM dD dH dM dS)"
	    "Y M D H M S"
	    "Returns YMDHMS=YMDHMS+dY+dM+dD+dH+dM+dS"))
	   ("today" .
	    ("Today"
	    ()
	    "Y M D"
	    "Returns YMD of Today."))
	   ("now" .
	    ("Now"
	    ()
	    "H M S"
	    "Returns the time of now in HMS."))
	   ("today-and-now" .
	    ("Today_and_Now"
	    ()
	    "Y M D H M S"
	    "Returns Today and now in YMDHMS."))
	   ("this-year" .
	    ("Add_Delta_Days"
	    ()
	    "Y"
	    "Returns this year."))
	   ("date-to-text" .
	    ("Date_to_Text"
	    "(Y M D)"
	    "STR"
	    "Returns a text representation of YMD with respect to *language*."))
	   ("date-to-text-long" .
	    ("Date_to_Text_Long"
	    "(Y M D)"
	    "STR" "Returns a longer text representation of YMD with respect to *language*."))
	   ("iso-lc" .
	    ("ISO_LC"
	    "(char)"
	    "char"
	    "Converts CHAR to ISO Lower Case."))
	   ("iso-uc" .
	    ("ISO_UC"
	    "(char)"
	    "char"
	    "Converts CHAR to ISO Upper Case."))
	   ("year-to-days" .
	    (""
	    "(Y)"
	    "D"
	    "Returns the number of days for YEAR since 1 Jan 1."))
	   ("yesterday" .
	    (""
	    ()
	    "Y M D"
	    "Returns YMD of Yesterday."))
	   ("tomorrow" .
	    (""
	    ()
	    "Y M D"
	    "Returns YMD of tomorrow."))
	   ("cl-day-of-week" .
	    (""
	    ()
	    "D"
	    "Returns the DOW in CL notation. Monday=0."))
	   ("cl-check-business-p" .
	    (""
	    "(Y W DOW)"
	    "T/NIL"
	    "This function returns true if the given three numerical values YEAR WEEK DOW constitute a valid date in business format for CL (Monday=0), and nil otherwise. DOW is CL conform."))
	   ("cl-nth-weekday-of-month-year" .
	    (""
	    "(Y M D)"
	    "DOW"
	    "This function returns the (year month day) of the N-th day of week DOW in the given MONTH and YEAR; such as, for example, the 3rd Thursday of a given month and year. DOW is CL conform."))
	   ("cl-decode-day-of-week" .
	    (""
	    "(STR)"
	    "DOW"
	    "Returns number of weekday. STR can partially name the Weekday according to *language*. DOW is CL conform."))
	   ("cl-standard-to-business" .
	    (""
	    "(Y M D)"
	    "Y W DOW"
	    "Returns Business date in CL notation of given YMD."))
	   ("cl-business-to-standard" .
	    (""
	    "(Y W DOW)"
	    "Y M D"
	    "Returns the YMD of given Business date in CL notation.")))))
    ;; start the generation of web site
    (with-open-file (str "/home/schroete/date-calc/index.html" :direction :output :if-exists :supersede)
      (cl-who:with-html-output (str nil :prologue t :indent nil)
	(:html
	 (:body
	  (:h3 "Date-Calc Lisp (A port from Date::Calc Perl).")
	  (:div "Heiko Schr&ouml;ter, 2005, schroete at iup physik uni-bremen de")
	  (:p "Intended use as a general 'all-day' date calculus library.")
	  (:p "Ver: 0.2")
	  (:p "Renamed the functions by leaving out the leading 'date-calc-'.Thanks to Luigi Panzeri aka Matley for pointing to this.")
	  (:p "Usage: (load \"date-calc.lisp\") generates the package 'date-calc'.")
	  (:a :href "../lisp/date-calc.lisp"
	      (:b "The Package: date-calc.lisp")
	      :br :br)
	  (:a :href "../lisp/date-calc-0.2.tar.gz"
	      (:b "The ASDF installable package.")
	      :br :br)
	  (:a :href "../lisp/test-date-calc.lisp"
	      (:b "A test script for cmucl and sbcl: test-date-calc.lisp"))
	  (:div "(Compares against PERL Date::Calc. Needs to be installed.)")
	  (:p "The following LISP functions are exported:<br>(listed with the corresponding PERL fn)")
	  (:table :border 0 :cellpadding 2
		  (:tr :align "center"
		       (:td :bgcolor "pink"
			    (:p "LISP(PARAMETER) => Return value(s)"))
		       (:td :bgcolor "lightgray"
			    (:p "PERL:")))
		  (loop for (lisp . perl) in progdescription
			do (cl-who:htm
			    (:tr :align "left"
				 (:td :bgcolor "pink"
				      (cl-who:fmt "~A ~A => ~A" lisp (second perl) (third perl)))
				 (:td :bgcolor "lightgray"
				      (cl-who:fmt "~A" (first perl)))))))
	  (:p "Y=Year,M=Month/Minute,D=Day,H=Hour,S=Second,W=Week,DOW=Day of Week,STR=STRING (all Integer).")
	  (:p "Some lisp functions do not have a corresponding Perl function.Especially the \'cl-...\' functions which do accept or return the CL Weekday numbering scheme i.e Monday=0. See CLHS 25.1.4.1")
	  (:b "Description of the functions:")
	  (:table :border 0 :cellpadding 2
		  (loop for (lisp . perl) in progdescription
			do (cl-who:htm
			    (:tr :align "left"
				 (:td :bgcolor "lightgray"
				      (:b (cl-who:fmt "~A ~A" lisp (second perl))))
				 (:td :bgcolor "lightgray"
				      (cl-who:fmt "~A" (fourth perl)))))))
	  (:br)
	  (:a :href "../lisp/index.lisp"
	      (:b "Page created with cl-who."))
	  ))
	(values)))))


(mkfile)

