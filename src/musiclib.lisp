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

(defparameter *tempered-system* '(c (c 1) d (d 1) e f (f 1) g (g 1) a (a 1) b))

(defparameter *systems* '((tonal (*tonal-system* 96))
                          (tempered (*tempered-system* 12))))

(defparameter *accidentals* '((lily ("es" "is"))
                              (latin ("b" "#"))))

;; As variáveis acima não devem ser acessadas diretamente. Use
;; get-system-notes, get-sharp, get-flat
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun get-system (name)
  (second (assoc-item name *systems*)))

(defun assoc-item (item alist)
  "Returns a item from a alist. "
  (second (assoc item alist)))

(defun get-system-notes (system)
  "Returns a table defining notes in the system defined."
  (symbol-value (first (assoc-item system *systems*))))

(defun note-name (number &optional (system 'tonal))
  "Retorna o nome da nota "
  (nth number (get-system-notes system)))

(defun get-accidental (representation fn)
  (funcall fn (assoc-item representation *accidentals*)))

(defun get-sharp (representation)
  (get-accidental representation #'second))

(defun get-flat (representation)
  (get-accidental representation #'first))

(defun repeat-string (n string)
  "Repeat a string n times."
  (with-output-to-string (s)
    (loop for x from 1 to (abs n) do (format s string))))

(defun print-accidentals (repr acc)
  "Return a string of a note according to a representation a
accidental."
  (repeat-string acc (funcall (if (>= acc 0) #'get-sharp #'get-flat) repr)))
  
(defun concat (&rest args)
  (apply #'concatenate 'string args))

(defun print-note (representation note-code)
  (format nil "~(~a~)~a" (first note-code) (print-accidentals representation (second note-code))))

(defun module (n &optional (system 'tonal))
  (mod n (get-system system)))

(defun transpose (note index &optional (system 'tonal))
  (module (+ note index) system))

(defun inversion (note &optional (index 0) (system 'tonal))
  (module (- (* 2 index) note) system))

(defun rotate (set &optional (n 1))
  (append (subseq set n) (subseq set 0 n)))
 
;;; SETS

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

;;; TODO ver tabela intervalos tonais jamary
(defun interval (note1 note2 &optional (system 'tempered))
  (module (- note1 note2) system))

(defun last1 (list)
  (first (last list)))

(defun ordenate (set)
  (sort set #'<))

(defun exclude-repetition (set)
  (let ((novo-set ()))
    (loop for x in set unless (member x novo-set)
       do (push x novo-set))
    (nreverse novo-set)))

(defun sets-permutations (set)
  (loop
     for rotation in (set-rotate (ordenate (exclude-repetition set)))
     for set-size = (interval (last1 rotation) (first rotation))
     for set-beg-size = (interval (second rotation) (first rotation))
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
      (smaller-sets (sort-sets (append (sets-permutation-sorted nf-inversion)
                                       (sets-permutation-sorted nf-transposition))))))))

(defun equal-sets? (set1 set2 &optional (form 'normal))
  (if (eql form 'normal)
      (when (equal (set-transpose-to-0 (normal-form set1))
                   (set-transpose-to-0 (normal-form set2)))
        t)
      (when (equal (prime-form set1) (prime-form set2)) t)))