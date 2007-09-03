;; note-code is a list representing a note name and it's accidentals.
;;   Examples: (c 2)  is C## (c double-sharp)
;;             (d -1) is Db (d flat)

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

(defun concat (&rest args)
  (apply #'concatenate 'string args))

(defun last1 (list)
  (first (last list)))

(defun ordenate (set)
  (sort set #'<))

(defun exclude-repetition (set)
  (let ((novo-set ()))
    (loop for x in set unless (member x novo-set)
       do (push x novo-set))
    (nreverse novo-set)))

(defun repeat-string (n string)
  "Repeat a string n times."
  (with-output-to-string (s)
    (loop for x from 1 to (abs n) do (format s string))))

(defun string->symbol (string)
  (intern (string-upcase string)))

(defun assoc-item (item alist)
  "Returns a item from a alist. "
  (second (assoc item alist)))

(defun get-system-item (item)
  (assoc-item item *systems*))

(defun get-system-notes (item)
  "Returns a table defining notes in the system defined."
  (symbol-value (first (get-system-item item))))

(defun get-system-module (name)
  (second (get-system-item name)))

(defun get-system-intervals (name)
  (symbol-value (third (get-system-item name))))

(defun code->note (number &optional (system 'tonal))
  "Retorna o nome da nota dado o seu código numérico."
  (nth number (get-system-notes system)))

(defun note->code-basic (note &optional (system 'tonal))
  "Aceita um símbolo representando uma nota e retorna seu código
numérico."
  (case system
    (tonal (position note (get-system-notes system) :key #'first))
    (tempered (position note (get-system-notes system)))))

(defun note->code (note &optional (system 'tonal))
  "Retorna o código numérico da nota, dada sua representação em
string. Ela é inteligente o suficiente para saber que 'aes' usa a
representação do lilypond e 'd#' usa a representação 'latin'."
  (cond ((eql (length note) 1) (note->code-basic (string->symbol note) system))
        ((search-accidental note 'lily) (parse-note note 'lily system))
        ((search-accidental note 'latin) (parse-note note 'latin system))
        (t (error "tipo de nota não conhecida"))))

(defun parse-note (note representation system)
  (let ((note-code-tonal
         (position (list (string->symbol (subseq note 0 1))
                         (number-of-accidentals (subseq note 1) representation))
                   (get-system-notes 'tonal)
                   :test #'equal)))
    (case system
      (tonal note-code-tonal)
      (tempered (module note-code-tonal 'tempered)))))

(defun symbol->number (string string-list)
  "Usa uma lista para mapear strings e caracteres. Essa função conta
quantas ocorrências tem do caractere na lista de mapeamento e retorna
esse valor. Essa função é usada para contar quantos acidentes ou
oitavas uma nota tem."
  (destructuring-bind (flat sharp) string-list
    (cond ((search sharp string) (count (char sharp 0) string))
          ((search flat string) (- (count (char flat 0) string)))
          (t 0))))

(defun number-of-accidentals (acc-string representation)
  "Returns the numeric value of a string of accidentals according to
representation. For instance, if acc-string is 'eseses' the function
returns -3. Be careful not to pass a string representing a note as the
first argument to this function, otherwise it could mistakenly return
-2 for 'ees'."
  (case representation
    (lily (symbol->number acc-string (get-accidentals 'lily)))
    (latin (symbol->number acc-string (get-accidentals 'latin)))))

(defun search-accidental (note representation)
    (or (search (get-flat representation) note)
        (search (get-sharp representation) note)))

(defun get-accidentals (representation)
  "Retorna os acidentes de uma representação específica."
  (assoc-item representation *accidentals*))

(defun get-accidental (representation fn)
  "Retorna um acidente específico dentro da representação. Fn deve ser
ou #'first ou #'second. Essa é uma função de baixo nível. As funções
get-shap ou get-flat devem ser usadas no lugar."
  (funcall fn (get-accidentals representation)))

(defun get-sharp (representation)
  (get-accidental representation #'second))

(defun get-flat (representation)
  (get-accidental representation #'first))

(defun print-accidentals (repr acc)
  "Return a string of a note according to a representation a
accidental."
  (repeat-string acc (funcall (if (>= acc 0) #'get-sharp #'get-flat) repr)))
  
(defun print-note (representation note-code)
  (format nil "~(~a~)~a" (first note-code) (print-accidentals representation (second note-code))))

(defun module (n &optional (system 'tonal))
  (mod n (get-system-module system)))

(defun transpose (note index &optional (system 'tonal))
  (module (+ note index) system))

(defun inversion (note &optional (index 0) (system 'tonal))
  (module (- (* 2 index) note) system))

(defun interval (note1 note2 &optional (system 'tonal))
  (module (- note1 note2) system))

(defun interval-name (interval &optional (system 'tonal))
  "Return "
  (nth interval (get-system-intervals system)))

;;; SETS

(defun rotate (set &optional (n 1))
  (append (subseq set n) (subseq set 0 n)))

(defun set-inversion (notes &optional (index 0) (system 'tonal))
  (mapcar (lambda (note) (inversion note index system)) notes))

(defun set-transpose (notes index &optional (system 'tonal))
  (mapcar (lambda (note) (transpose note index system)) notes))

(defun set-transpose-to-0 (notes)
  "Assume que o sistema é tempered"
  (set-transpose notes (- (first notes)) 'tempered))
  
(defun set-rotate (set)
  (loop for x from 0 to (1- (length set)) collect (rotate set x)))x

(defun set-intervals (set)
    (mapcar (lambda (a b) (module (- b a) 'tempered)) set (rotate set)))

(defun set-simetric? (set)
  (if (= (length (exclude-repetition (set-intervals set))) 1) t))

(defun sets-permutations (set)
  (loop
     for rotation in (set-rotate (ordenate (exclude-repetition set)))
     for set-size = (interval (last1 rotation) (first rotation) 'tempered)
     for set-beg-size = (interval (second rotation) (first rotation) 'tempered)
     collect (list rotation set-size set-beg-size)))

;; TODO: melhor nome
(defun sort-sets (set)
  (sort set #'< :key #'cadr))
  
(defun smaller-sets (sorted-list)
  (remove-if #'(lambda (x) (> x (cadar sorted-list))) sorted-list :key #'cadr))

(defun smaller-sets-comparisson (smaller-sets)
  (caar (sort smaller-sets #'< :key #'caddr)))

(defun smallest-set (smaller-sets)
  (if (= (length smaller-sets) 1)
      (caar smaller-sets)
      (smaller-sets-comparisson smaller-sets)))

(defun normal-form (set)
  "Se smaller-sets só tiver um elemento a forma normal é ela, se todos
os subconjuntos tiverem os mesmos set-size e set-beg-size é porque o
acorde é simetrico (e.g. acorde diminuto). checa logo se o set é
simetrico antes de fazer qualquer coisa."
  (if (set-simetric? set)
      set
      (smallest-set (smaller-sets (sort-sets (sets-permutations set))))))

(defun prime-form (set)
  (let ((nf-transposition (set-transpose (normal-form set) 0 'tempered))
        (nf-inversion (set-inversion (normal-form set) 0 'tempered)))
    (set-transpose-to-0
     (smallest-set
      (smaller-sets (sort-sets (append (sets-permutations nf-inversion)
                                       (sets-permutations nf-transposition))))))))

(defun equal-sets? (set1 set2 &optional (form 'normal))
  (case form
    (normal (when (equal (set-transpose-to-0 (normal-form set1))
                         (set-transpose-to-0 (normal-form set2)))
              t))
    (prime (when (equal (prime-form set1) (prime-form set2)) t))))