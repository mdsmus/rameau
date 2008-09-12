(in-package #:genoslib)
(export '(a b c d e f g
          a# b# c# d# e# f# g#
          ab bb cb db eb fb gb
          maj min dim aug perfect
          sharp flat up down lily latin prime))

(defvar *system* 'tonal)

(defmacro with-system (system &body body)
  "[DONTCHECK]"
  `(let ((*system* ',system))
     (declare (special *system*))
     ,@body))

(defmacro deftemplates (name &body templates)
  "[DONTCHECK]"
  `(defparameter ,name ',templates))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun get-system-item (item)
  "Get the value list from each system. tonal-system is a table with
note-codes for every note in Jamary's table (p. 18). Tonal-intervals
is a table with the code for tonal intervals according to Jamary (p.
21). The format is (inverval kind quantity). For instance, (3 min)
represents a minor third; (3 dim 2) represents double-diminished
third. Quantity is optional when equal to 1. [DONTCHECK]"
  (let ((tonal-system
         '((c 0)  (c 1)  (c 2)  (c 3)  (c 4)  (c 5)  (c 6)
           (d -7) (d -6) (d -5) (d -4) (d -3) (d -2) (d -1)
           (d 0)  (d 1)  (d 2)  (d 3)  (d 4)  (d 5)  (d 6)
           (e -7) (e -6) (e -5) (e -4) (e -3) (e -2) (e -1)
           (e 0)  (e 1)  (e 2)  (e 3)  (e 4)  (e 5)  (e 6)
           (f -6) (f -5) (f -4) (f -3) (f -2) (f -1)
           (f 0)  (f 1)  (f 2)  (f 3)  (f 4)  (f 5)  (f 6) (f 7)
           (g -6) (g -5) (g -4) (g -3) (g -2) (g -1)
           (g 0)  (g 1)  (g 2)  (g 3)  (g 4)  (g 5)  (g 6)
           (a -7) (a -6) (a -5) (a -4) (a -3) (a -2) (a -1)
           (a 0)  (a 1)  (a 2)  (a 3)  (a 4)  (a 5)  (a 7)
           (b -7) (b -6) (b -5) (b -4) (b -3) (b -2) (b -1)
           (b 0)  (b 1)  (b 2)  (b 3)  (b 4)  (b 5)  (b 7)
           (c -6) (c -5) (c -4) (c -3) (c -2) (c -1)))
        (tonal-intervals
         '((1 perfect) (1 aug) (1 aug 2) (1 aug 3) (1 aug 4) (1 aug 5) (1 aug 6)
           (2 dim 6) (2 dim 5) (2 dim 4) (2 dim 3) (2 dim 2) (2 dim) (2 min) (2 maj) (2 aug)
           (2 aug 2) (2 aug 3) (2 aug 4) (2 aug 5) (2 aug 6) 
           (3 dim 6) (3 dim 5) (3 dim 4) (3 dim 3) (3 dim 2) (3 dim)
           (3 min) (3 maj) (3 aug) (3 aug 2) (3 aug 3) (3 aug 4) (3 aug 5) (3 aug 6)
           (4 dim 6) (4 dim 5) (4 dim 4) (4 dim 3) (4 dim 2) (4 dim)
           (4 perfect) (4 aug) (4 aug 2) (4 aug 3) (4 aug 4) (4 aug 5) (4 aug 6) (4 aug 7)
           (5 dim 6) (5 dim 5) (5 dim 4) (5 dim 3) (5 dim 2) (5 dim)
           (5 perfect) (5 aug) (5 aug 2) (5 aug 3) (5 aug 4) (5 aug 5) (5 aug 6)
           (6 dim 6) (6 dim 5) (6 dim 4) (6 dim 3) (6 dim 2) (6 dim)
           (6 min) (6 maj) (6 aug) (6 aug 2) (6 aug 3) (6 aug 4) (6 aug 5) (6 aug 6)
           (7 dim 6) (7 dim 5) (7 dim 4) (7 dim 3) (7 dim 2) (7 dim)
           (7 min) (7 maj) (7 aug) (7 aug 2) (7 aug 3) (7 aug 4) (7 aug 5) (7 aug 6)
           (1 dim 6) (1 dim 5) (1 dim 4) (1 dim 3) (1 dim 2) (1 dim) (8 perfect)))
        (tempered-intervals
         '((1 perfect) (2 min) (2 maj) (3 min) (3 maj) (4 perfect)
           (5 dim) (5 perfect) (6 min) (6 maj) (7 min) (7 maj) (8 perfect)))
        (tempered-system
         '((c 0) (c 1) (d 0) (d 1) (e 0) (f 0)
           (f 1) (g 0) (g 1) (a 0) (a 1) (b 0))))
    (assoc-item item `((tonal (,tonal-system 96 ,tonal-intervals))
                       (tempered (,tempered-system 12 ,tempered-intervals))))))

(defun get-system-notes (system)
  "Returns a table defining notes in the system. [DONTCHECK]"
  (first (get-system-item system)))

(defun get-notes ()
  "Returns a table defining notes in the system. [DONTCHECK]"
  (if (eq 'tempered *system*)
      (get-system-notes 'tempered)
      (get-system-notes 'tonal)))

(defun get-system-module (system)
  "Returns the numeric value to be used as a module in the defined
system. [DONTCHECK]"
  (second (get-system-item system)))

(defun get-module ()
  "Returns the numeric value to be used as a module in the current
system. [DONTCHECK]"
  (second (get-system-item *system*)))

(defun get-system-intervals (system)
  "Returns a table defining intervals in the system. [DONTCHECK]"
  (third (get-system-item system)))

(defun get-accidental (accidental representation)
  "Returns a string with the accidental in a specific
    representation. \\example{(get-accidental 'sharp 'latin)}{\\#}"
  (assoc-item accidental
              (assoc-item representation '((lily ((flat "es")
                                                  (sharp "is")))
                                           (latin ((flat "b")
                                                   (sharp "#")))))))

(defun get-octave (octave representation)
  "Returns a string with the octave in a specific
    representation. \\example{(get-octave 'central 'lily)}{\"\"}"
  (assoc-item octave
              (assoc-item representation '((lily ((down ",")
                                                  (up "'")))
                                           (latin ((down "-1")
                                                   (up "1")))))))

(defun get-interval-name (short)
  "Returns the full name of a chord for the abbreviated
representation. \\example{(get-interval-name \\rq dim)}{diminished}.
[DONTCHECK]"
  (assoc-item short '((min minor)
                      (maj major)
                      (perfect perfect)
                      (aug augmented)
                      (dim diminished))))

(defun get-interval-quantity (num)
  "Returns a word representing the numeric quantity of a chord.
\\example{(get-interval-quantity 3)}{triple}. [DONTCHECK]"
  (assoc-item num '((2 double)
                    (3 triple)
                    (4 quadruple)
                    (5 pentuple)
                    (6 hextuple)
                    (7 heptuple))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun octave-from-string (octave &optional (representation 'lily))
  "Returns the numeric representation of a octave represented as
string. The central octave has the value 8."
  (let ((up (get-octave 'up representation))
        (down (get-octave 'down representation)))
    (cond ((search up octave) (count-subseq up octave))
          ((search down octave) (- (count-subseq down octave)))
          (t 0))))

(defun code->notename (number)
  "Returns a note nome in the format (name accidentals) given its
numeric code."
  (nth (module number) (get-system-notes *system*)))

(defun number-of-accidentals (acc-string representation)
  "Returns the numeric value of a string of accidentals according to
representation. For instance, if acc-string is ``eseses'' the function
returns -3. Be careful not to pass a string representing a note as the
first argument to this function, otherwise it could mistakenly return
-2 for ``ees''."
  (let ((sharp (get-accidental 'sharp representation))
        (flat (get-accidental 'flat representation)))
    (cond ((search sharp acc-string) (count-subseq sharp acc-string))
          ((search flat acc-string) (- (count-subseq flat acc-string)))
          (t 0))))

(defun match-note-representation (note representation)
  "Returns non-nil if a note matches the representation.
EXAMPLE: (match-note-representation \"cis\" 'latin) returns nil."
  (or (search (get-accidental 'flat representation) note)
      (search (get-accidental 'sharp representation) note)))

(defun %my-position (&rest args)
  (apply #'position args))

(defun %parse-note (note representation system)
  "Returns the numeric code for a note according with the representation and system.
EXAMPLE: \\begin{verbatim}(%parse-note \"ces\" 'lily 'tonal)\\end{verbatim} returns 95.
This is a low level function, you should use parse-note instead."
  (let ((note-code-tonal
         (%my-position (list (string->symbol (subseq note 0 1))
                             (number-of-accidentals (subseq note 1) representation))
                       (get-system-notes 'tonal)
                       :test #'equal))
        (note-code-tempered
         (+ (%my-position (list (string->symbol (subseq note 0 1)) 0)
                          (get-system-notes 'tempered)
                          :test #'equal)
            (number-of-accidentals (subseq note 1) representation))))
    (case system
      (tonal note-code-tonal)
      (tempered note-code-tempered))))

(let ((test-note (cl-ppcre:create-scanner "^[a-g]((es)*|(is)*|#*|b*)$" :case-insensitive-mode t)))
  (defun note? (string)
    "Test if a string can represent a note."
    (cl-ppcre:scan test-note string)))

(defun rest? (string)
  "Testa se uma string pode representar um silêncio"
  (cl-ppcre:scan "^[sSRr]$" string))

(defun parse-note (note)
  "Returns the numeric code of a pitch, given its representation as a
string. This function is smart enought to know that ``aes'' is
lilypond's representation and ``d\\#'' is latin's representation."
  (flet ((%note->code (note)
           "Aceita um símbolo representando uma nota e retorna seu
código numérico. Essa é uma função auxiliar que funciona apenas para
notas sem acidentes, como 'd', 'e', etc. EXEMPLO: (\\%note->code \"d\")
retorna 14."
           (case *system*
             (tonal (position (list note 0)
                              (get-system-notes *system*) :test #'equal))
             (tempered (position (list note 0)
                                 (get-system-notes *system*) :test #'equal)))))
    (when (note? note)
      (let ((note (string-downcase note)))
        (module 
         (cond ((eql (length note) 1) (%note->code (string->symbol note)))
               ((match-note-representation note 'lily) (%parse-note note 'lily *system*))
               ((match-note-representation note 'latin) (%parse-note note 'latin *system*))
               (t (error "type of note is unknown"))))))))

(defun notename->code (note)
  "Returns the numeric code of a note represented as a list of (note
accidental) as code->notename would return."
  (position note (get-notes) :test #'equal))

(defun enharmonicaly-equal-p (notea noteb)
  "Compare if two notes are enarmonically equivalent. Both notes
should be represented as strings."
  (with-system tempered
    (equal (parse-note notea) (parse-note noteb))))

(defun print-accidentals (acc repr)
  "Returns a string of a note according to the numeric value of an
accidental and a representation. EXAMPLE: (print-accidentals 3 'lily)
returns isisis."
  (repeat-string acc (get-accidental (if (>= acc 0) 'sharp 'flat) repr)))

(defcached print-note (note-code &optional (representation 'latin))
  "Retuns a string of a note according to a note-code and representation.
Example: (print-note '(c 1) 'lily) return cis."
  (format nil "~(~a~)~a" (first note-code) (print-accidentals (second note-code) representation)))

(defun latin->lily (note)
  "Accepts a string with a note in latin representation and returns a
note using lilypond's representation."
  (print-note (code->notename (parse-note (stringify note))) 'lily))

(defun lily->latin (note)
  "Accepts a string with a note in lilypond representation and returns
a note using latin representation."
  (print-note (code->notename (parse-note note)) 'latin))

(defun module (n)
  "Returns the module according to a system.
EXAMPLE: (module 96 'tonal) returns 96 and (module 96 'tempered)
returns 0."
  (mod n (get-system-module *system*)))

(defun transpose (note index)
  "Transpose one note according to a transposition index. The note
must have a numeric value."
  (module (+ note index)))

(defun inversion (note &optional (index 0))
  "Invert one note according to an index. The note must have a numeric
value."
  (module (- (* 2 index) note)))

(defun interval (note1 note2)
  "Returns the interval of two notes according to a system. The notes
must have a numeric value."
  (module (- note1 note2)))

(defun interval->code (interval)
  "Returns an interval-code of an interval. The interval must have a
numeric value."
  (nth interval (get-system-intervals *system*)))

(defun code->interval (code)
  "Retuns a interval of an interval-code.
EXAMPLE: (code->interval '(3 aug)) returns 29."
  (module (position code (get-system-intervals 'tonal) :test #'equal)))

(defun print-interval (interval)
  "Returns the name of an interval. EXAMPLE: (print-interval 16)
returns double augmented second."
  (destructuring-bind (int type &optional quantity) (interval->code interval)
    (format nil "~@[~(~a~) ~]~(~a~) ~:r" (get-interval-quantity quantity)
            (get-interval-name type) int)))

;;; SETS

(defun %rotate (set &optional (n 1))
  "Retuns the n rotation of a set. 0 means no rotation, 1 the first
rotation, and so on. This function is cyclic."
  (let ((mod-n (mod n (length set))))
    (append (subseq set mod-n) (subseq set 0 mod-n))))

(defun set-rotate (set)
  "Retuns a list with all rotations of a set."
  (loop for x from 0 to (1- (length set)) collect (%rotate set x)))

(defun set-inversion (set &optional (index 0))
  "Retuns a new set that is the invertion of the input set."
  (mapcar (lambda (note) (inversion note index)) set))

(defun set-transpose (set index)
  "Retuns a new set that is the transposition of the input set."
  (mapcar (lambda (note) (transpose note index)) set))

(defun set-transpose-to-0 (set)
  "Transpose a set so it begins with 0. Only on a tempered system."
  (set-transpose set (- (first set))))

(defun set-intervals (set)
  "Retuns a list with the intervals between the consecutive notes of a set.
EXAMPLE: (set-intervals '(0 3 7)) returns (3 4 5). In this list 5 is
the interval between the last and first note."
  (mapcar (lambda (a b) (module (- b a))) set (%rotate set)))

(defun set-symmetric? (set)
  "Test if a set is symmetric, i.e. if all its intervals are equal. (0
3 6 9) is an example of a symmetric set."
  (if (= (length (remove-duplicates (set-intervals set))) 1) t))

(defun set-form-list (set)
  "Generate a form-list of an set. A form-list is a list with each
permutation of a set, including the overall interval of the set, and
the inverval between the second and first note. This format is used to
determine the normal and prime form. EXAMPLE: (set-form-list '(0 3 7))
returns (((0 3 7) 7 3) ((3 7 0) 9 4) ((7 0 3) 8 5))."
  (loop
        for rotation in (set-rotate (sort-set (remove-duplicates set)))
        for set-size = (interval (last1 rotation) (first rotation))
        for set-beg-size = (interval (second rotation) (first rotation))
        collect (list rotation (module set-size) (module set-beg-size))))

(defun sort-form-list (set)
  "Sort a form-list by the overall interval of the set."
  (sorted set #'< :key #'cadr))

(defun smaller-sets (sorted-list)
  "Retuns a new form-list with the smaller rotations."
  (remove-if #'(lambda (x) (> x (cadar sorted-list))) sorted-list :key #'cadr))

(defun smaller-sets-comparisson (smaller-sets)
  "Sort a form-list of smaller rotations, sort it by the inverval of
the first and second notes, and returns the smallest set of all. This
is a low level function. You should use smallest-set instead."
  (caar (sorted smaller-sets #'< :key #'caddr)))

(defun smallest-set (smaller-sets)
  "If the form-list only has one option, returns the set inside it.
Otherwise compare the other sets to see which has the smallest
interval between the first and second notes."
  (if (= (length smaller-sets) 1)
      (caar smaller-sets)
      (smaller-sets-comparisson smaller-sets)))

(defun normal-form (set)
  "Returns the normal form of a set.
EXAMPLE: (normal-form '(1 7 3)) returns (1 3 7)."
  (if (set-symmetric? set)
      set
      (smallest-set (smaller-sets (sort-form-list (set-form-list set))))))

(defun prime-form (set)
  "Retuns the prime form of a set. Only on a tempered system.
EXAMPLE: (prime-form '(1 7 3)) returns (0 2 6). "
  (assert (eq *system* 'tempered))
  (let ((nf-transposition (set-transpose (normal-form set) 0))
        (nf-inversion (set-inversion (normal-form set) 0)))
    (set-transpose-to-0
     (smallest-set
      (smaller-sets (sort-form-list (append (set-form-list nf-inversion)
                                            (set-form-list nf-transposition))))))))

(defun set-equal? (set1 set2 &optional (form 'normal))
  "Test if two sets are the same. The default option is to see if the
sets are equal by transposition. The option 'prime tests if the sets
are also equal by inversion.
EXAMPLE: (equal-sets? '(0 3 7) '(8 1 4)) returns T."
  (case form
    (normal (when (equal (set-transpose-to-0 (normal-form set1))
                         (set-transpose-to-0 (normal-form set2)))
              t))
    (prime (when (equal (prime-form set1) (prime-form set2)) t))))

;;; Tonal functions

(defun get-scale-mode (mode)
  (case mode
    (:major '(0 14 28 41 55 69 83))
    (:minor '(0 14 27 41 55 68 83))
    (t (error "I don't know mode ~a. Tonal modes are usualy major or minor." mode))))

(defun number->roman (number)
  "Return an upercase roman numeral."
  (format nil "~@R" number))

(defun roman->number (roman-string)
  "Convert a roman numeral from i to vii (writen as string) to it's
correspondent arabic number. It will return NIL for numbers larger
than vii because we don't use that in functional analysis. It doen't
accept iiii for 4, only iv."
  (let* ((roman-numbers '("i" "ii" "iii" "iv" "v" "vi" "vii"))
        (number (position roman-string roman-numbers :test #'equalp)))
    (when number (1+ number))))

(defun get-function-degree (tonal-function center mode)
  "Return the tonal code of the functional degree of a key. The
question that this function returns is 'what is the V degree of C
major?' tonal-function and center must be strings, although case
doesn't matter. mode should be a keyword. tonal-function can have a b
or # as a prefix (as in bvi or #iii). EXAMPLE: (get-function-degree
\"iv\" \"a\" :major) will return 14, that is D."
  (flet ((%get-function-number (string)
           (nth (1- (roman->number string)) (get-scale-mode mode))))
    (with-system tonal
      (module (+ (parse-note center)
                 (switch ((char tonal-function 0))
                   (#\b (1- (%get-function-number (subseq tonal-function 1))))
                   (#\# (1+ (%get-function-number (subseq tonal-function 1))))
                   (t (%get-function-number tonal-function))))))))

(defun number->accidental (number &optional (representation 'latin))
  "Convert a number to it's representation as accidents.
  EXAMPLE: (number->accidental -3) => \"bbb\""
  (cond ((plusp number)
         (repeat-string number (get-accidental 'sharp representation)))
        ((minusp number)
         (repeat-string number (get-accidental 'flat representation)))
        ((zerop number) "")))

(defun get-roman-function (fundamental center scale-mode)
  "Return the roman function of a fundamental in given center.
  fundamental and center must be strings while chord-mode and
  scale-mode must be keywords. get-roman-function is smart enough to
  understand different inputs for notes such as cis and c#."
  (with-system tonal
    (let* ((interval (interval (parse-note fundamental) (parse-note center)))
           (interval-code (interval->code interval))
           (base-note (nth (1- (first interval-code)) (get-scale-mode scale-mode))))
      (values (first interval-code)
              (- interval base-note)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defparameter *notas-interessantes-tonal*
  (loop for i in '(0 14 28 41 55 69  83)
        append (mapcar #'module (list (- i 2) (- i 1) i (+ i 1) (+ i 2)))))
