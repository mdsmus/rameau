;; note-code is a list representing a note name and it's accidentals.
;;   Examples: (c 2)  is C## (c double-sharp)
;;             (d -1) is Db (d flat)
;; interval-code is alist representing an interval

(defparameter *tonal-system*
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
    (c -6) (c -5) (c -4) (c -3) (c -2) (c -1))
  "A table with note-codes for every note in Jamary's table (p. 18).")

(defparameter *tonal-intervals*
  '((1 just) (1 aug) (1 aug 2) (1 aug 3) (1 aug 4) (1 aug 5) (1 aug 6)
    (2 dim 6) (2 dim 5) (2 dim 4) (2 dim 3) (2 dim 2) (2 dim) (2 min) (2 maj) (2 aug)
    (2 aug 2) (2 aug 3) (2 aug 4) (2 aug 5) (2 aug 6) 
    (3 dim 6) (3 dim 5) (3 dim 4) (3 dim 3) (3 dim 2) (3 dim)
    (3 min) (3 maj) (3 aug) (3 aug 2) (3 aug 3) (3 aug 4) (3 aug 5) (3 aug 6)
    (4 dim 6) (4 dim 5) (4 dim 4) (4 dim 3) (4 dim 2) (4 dim)
    (4 just) (4 aug) (4 aug 2) (4 aug 3) (4 aug 4) (4 aug 5) (4 aug 6) (4 aug 7)
    (5 dim 6) (5 dim 5) (5 dim 4) (5 dim 3) (5 dim 2) (5 dim)
    (5 just) (5 aug) (5 aug 2) (5 aug 3) (5 aug 4) (5 aug 5) (5 aug 6)
    (6 dim 6) (6 dim 5) (6 dim 4) (6 dim 3) (6 dim 2) (6 dim)
    (6 min) (6 maj) (6 aug) (6 aug 2) (6 aug 3) (6 aug 4) (6 aug 5) (6 aug 6)
    (7 dim 6) (7 dim 5) (7 dim 4) (7 dim 3) (7 dim 2) (7 dim)
    (7 min) (7 maj) (7 aug) (7 aug 2) (7 aug 3) (7 aug 4) (7 aug 5) (7 aug 6)
    (8 dim 6) (8 dim 5) (8 dim 4) (8 dim 3) (8 dim 2) (8 dim) (8 just))
  "A table with the code for tonal intervals according to Jamary (p.
  21). The format is (inverval kind quantity). For instance, (3 min)
  represents a minor third; (3 dim 2) represents double-diminished
  third. Quantity is optional when equal to 1.")

(defparameter *tempered-intervals*
  '((1 just) (2 min) (2 maj) (3 min) (3 maj) (4 just)
    (5 dim) (5 just) (6 min) (6 maj) (7 min) (7 maj) (8 just)))

(defparameter *tempered-system* '(c (c 1) d (d 1) e f (f 1) g (g 1) a (a 1) b))

(defparameter *systems* '((tonal (*tonal-system* 96 *tonal-intervals*))
                          (tempered (*tempered-system* 12 *tempered-intervals*))))

(defparameter *accidentals* '((lily ("es" "is"))
                              (latin ("b" "#"))))

;; As variáveis acima não devem ser acessadas diretamente. Use
;; get-system-notes, get-sharp, get-flat, etc.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun concat (&rest strings)
  "Concatenate a bunch of strings."
  (apply #'concatenate 'string strings))

(defun last1 (list)
  "Retuns the last element of a list."
  (first (last list)))

(defun sort-set (set)
  "Sort a set in crescent order. "
  (sort set #'<))

(defun exclude-repetition (set)
  "Exclude all repetitions from a set."
  (let ((novo-set ()))
    (loop for x in set unless (member x novo-set)
       do (push x novo-set))
    (nreverse novo-set)))

(defun symbol->number (string string-list)
  "Essa função conta quantas ocorrências tem do caractere na lista de
mapeamento e retorna esse valor. Essa função é usada para contar
quantos acidentes ou oitavas uma nota tem."
  (destructuring-bind (flat sharp) string-list
    (cond ((search sharp string) (count (char sharp 0) string))
          ((search flat string) (- (count (char flat 0) string)))
          (t 0))))

(defun repeat-string (n string)
  "Repeat a string n times. EXAMPLE: (repeat-string 3 \"foo\") returns
  \"foofoofoo\"."
  (with-output-to-string (s)
    (loop for x from 1 to (abs n) do (format s string))))

(defun string->symbol (string)
  "Convert a string to a symbol."
  (intern (string-upcase string)))

(defun assoc-item (item alist)
  "Returns an item from a alist. "
  (second (assoc item alist)))

(defun get-system-item (item)
  "Get the value list from *systems*."
  (assoc-item item *systems*))

(defun get-system-notes (system)
  "Returns a table defining notes in the system."
  (symbol-value (first (get-system-item system))))

(defun get-system-module (system)
  "Returns the numeric value to be used as a module in the defined
system."
  (second (get-system-item system)))

(defun get-system-intervals (system)
  "Returns a table defining intervals in the system."
  (symbol-value (third (get-system-item system))))

(defun get-accidentals (representation)
  "Retorna os acidentes de uma representação específica."
  (assoc-item representation *accidentals*))

(defun get-accidental (representation fn)
  "Retorna um acidente específico dentro da representação. Fn deve ser
ou #'first ou #'second. Essa é uma função de baixo nível. As funções
get-shap ou get-flat devem ser usadas no lugar."
  (funcall fn (get-accidentals representation)))

(defun get-sharp (representation)
  "Returns a string with a sharp in representation.
EXAMPLE: (get-sharp 'latin) returns #."
  (get-accidental representation #'second))

(defun get-flat (representation)
  "Returns a string with a flat in representation.
EXAMPLE: (get-flat 'lily) return es."
  (get-accidental representation #'first))

(defun code->note (number &optional (system 'tonal))
  "Retorna o nome da nota dado o seu código numérico."
  (nth number (get-system-notes system)))

(defun note->code-basic (note &optional (system 'tonal))
  "Aceita um símbolo representando uma nota e retorna seu código
numérico."
  (case system
    (tonal (position note (get-system-notes system) :key #'first))
    (tempered (position note (get-system-notes system)))))

(defun number-of-accidentals (acc-string representation)
  "Returns the numeric value of a string of accidentals according to
representation. For instance, if acc-string is 'eseses' the function
returns -3. Be careful not to pass a string representing a note as the
first argument to this function, otherwise it could mistakenly return
-2 for 'ees'."
  (case representation
    (lily (symbol->number acc-string (get-accidentals 'lily)))
    (latin (symbol->number acc-string (get-accidentals 'latin)))))

(defun match-note-representation (note representation)
  "Returns non-nil if a note matches the representation.
EXAMPLE: (match-note-representation \"cis\" 'latin) returns nil."
    (or (search (get-flat representation) note)
        (search (get-sharp representation) note)))

(defun parse-note (note representation system)
  "Returns the numeric code for a note according with the representation and system.
EXAMPLE: (parse-note \"ces\" 'tonal) returns 95. This is a low level
function, you should use note->code instead."
  (let ((note-code-tonal
         (position (list (string->symbol (subseq note 0 1))
                         (number-of-accidentals (subseq note 1) representation))
                   (get-system-notes 'tonal)
                   :test #'equal)))
    (case system
      (tonal note-code-tonal)
      (tempered (module note-code-tonal 'tempered)))))

(defun note->code (note &optional (system 'tonal))
  "Retorna o código numérico da nota, dada sua representação em
string. Essa função é inteligente o suficiente para saber que 'aes'
usa a representação do lilypond e 'd#' usa a representação 'latin'."
  (cond ((eql (length note) 1) (note->code-basic (string->symbol note) system))
        ((match-note-representation note 'lily) (parse-note note 'lily system))
        ((match-note-representation note 'latin) (parse-note note 'latin system))
        (t (error "tipo de nota não conhecida"))))

(defun print-accidentals (acc repr)
  "Return a string of a note according to the numeric value of an
accidental and a representation. EXAMPLE: (print-accidentals 3 'lily)
returns isisis."
  (repeat-string acc (funcall (if (>= acc 0) #'get-sharp #'get-flat) repr)))
  
(defun print-note (note-code representation)
  "Retuns a string of a note according to a note-code and representation.
Example: (print-note '(c 1) 'lily) return cis."
  (format nil "~(~a~)~a" (first note-code) (print-accidentals (second note-code) representation)))

(defun module (n &optional (system 'tonal))
  "Returns the module according to a system.
EXAMPLE: (module 96 'tonal) returns 96 and (module 96 'tempered)
returns 0."
  (mod n (get-system-module system)))

(defun transpose (note index &optional (system 'tonal))
  "Transpose one note according to a transposition index. The note
must have a numeric value."
  (module (+ note index) system))

(defun inversion (note &optional (index 0) (system 'tonal))
  "Invert one note according to an index. The note must have a numeric
value."
  (module (- (* 2 index) note) system))

(defun interval (note1 note2 &optional (system 'tonal))
  "Returns the interval of two notes according to a system. The notes
must have a numeric value."
  (module (- note1 note2) system))

(defun interval-name (interval &optional (system 'tonal))
  "Returns an interval-code of an interval. The interval must have a
numeric value."
  (nth interval (get-system-intervals system)))

;;; SETS

(defun rotate (set &optional (n 1))
  "Retuns the n rotation of a set."
  (append (subseq set n) (subseq set 0 n)))

(defun set-rotate (set)
  "Retuns a list with all rotations of a set."
  (loop for x from 0 to (1- (length set)) collect (rotate set x)))

(defun set-inversion (set &optional (index 0) (system 'tonal))
  "Retuns a new set that is the invertion of the input set."
  (mapcar (lambda (note) (inversion note index system)) set))

(defun set-transpose (set index &optional (system 'tonal))
  "Retuns a new set that is the transposition of the input set."
  (mapcar (lambda (note) (transpose note index system)) set))

(defun set-transpose-to-0 (set)
  "Transpose a set so it begins with 0."
  (set-transpose set (- (first set)) 'tempered))
  
(defun set-intervals (set)
  "Retuns a list with the intervals between the consecutive notes of a set.
EXAMPLE: (set-intervals '(0 3 7)) returns (3 4 5). In this list 5 is
the interval between the last and first note."
  (mapcar (lambda (a b) (module (- b a) 'tempered)) set (rotate set)))

(defun set-symmetric? (set)
  "Test if a set is symmetric, i.e. if all its intervals are equal. (0
3 6 9) is an example of a symmetric set."
  (if (= (length (exclude-repetition (set-intervals set))) 1) t))

(defun set-form-list (set)
  "Generate a form-list of an set. A form-list is a list with each
permutation of a set, including the overall interval of the set, and
the inverval between the second and first note. This format is used to
determine the normal and prime form. EXAMPLE: (set-form-list '(0 3 7))
returns (((0 3 7) 7 3) ((3 7 0) 9 4) ((7 0 3) 8 5))."
  (loop
     for rotation in (set-rotate (sort-set (exclude-repetition set)))
     for set-size = (interval (last1 rotation) (first rotation) 'tempered)
     for set-beg-size = (interval (second rotation) (first rotation) 'tempered)
     collect (list rotation set-size set-beg-size)))

(defun sort-form-list (set)
  "Sort a form-list by the overall interval of the set."
  (sort set #'< :key #'cadr))
  
(defun smaller-sets (sorted-list)
  "Retuns a new form-list with the smaller rotations."
  (remove-if #'(lambda (x) (> x (cadar sorted-list))) sorted-list :key #'cadr))

(defun smaller-sets-comparisson (smaller-sets)
  "Sort a form-list of smaller rotations, sort it by the inverval of
the first and second notes, and returns the smallest set of all. This
is a low level function. You should use smallest-set instead."
  (caar (sort smaller-sets #'< :key #'caddr)))

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
  "Retuns the prime form of a set.
EXAMPLE: (prime-form '(1 7 3)) returns (0 2 6)."
  (let ((nf-transposition (set-transpose (normal-form set) 0 'tempered))
        (nf-inversion (set-inversion (normal-form set) 0 'tempered)))
    (set-transpose-to-0
     (smallest-set
      (smaller-sets (sort-form-list (append (set-form-list nf-inversion)
                                            (set-form-list nf-transposition))))))))

(defun equal-sets? (set1 set2 &optional (form 'normal))
  "Test if two sets are the same. The default option is to see if the
sets are equal by transposition. The option 'prime tests if the sets
are also equal by inversion.
EXAMPLE: (equal-sets? '(0 3 7) '(8 1 4)) returns T."
  (case form
    (normal (when (equal (set-transpose-to-0 (normal-form set1))
                         (set-transpose-to-0 (normal-form set2)))
              t))
    (prime (when (equal (prime-form set1) (prime-form set2)) t))))
