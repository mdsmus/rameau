(in-package #:rameau)
(use-package :lisp-unit)

(define-test get-system-item
  (assert-equal '(*TONAL-SYSTEM* 96 *TONAL-INTERVALS*) (get-system-item 'tonal))
  (assert-equal '(*TEMPERED-SYSTEM* 12 *TEMPERED-INTERVALS*) (get-system-item 'tempered)))

(define-test get-system-module
    (assert-equal 96 (get-system-module 'tonal))
    (assert-equal 12 (get-system-module 'tempered)))

(define-test get-system-intervals
    (assert-equal
     '((1 JUST) (1 AUG) (1 AUG 2) (1 AUG 3) (1 AUG 4) (1 AUG 5) (1 AUG 6) (2 DIM 6)
       (2 DIM 5) (2 DIM 4) (2 DIM 3) (2 DIM 2) (2 DIM) (2 MIN) (2 MAJ) (2 AUG)
       (2 AUG 2) (2 AUG 3) (2 AUG 4) (2 AUG 5) (2 AUG 6) (3 DIM 6) (3 DIM 5)
       (3 DIM 4) (3 DIM 3) (3 DIM 2) (3 DIM) (3 MIN) (3 MAJ) (3 AUG) (3 AUG 2)
       (3 AUG 3) (3 AUG 4) (3 AUG 5) (3 AUG 6) (4 DIM 6) (4 DIM 5) (4 DIM 4)
       (4 DIM 3) (4 DIM 2) (4 DIM) (4 JUST) (4 AUG) (4 AUG 2) (4 AUG 3) (4 AUG 4)
       (4 AUG 5) (4 AUG 6) (4 AUG 7) (5 DIM 6) (5 DIM 5) (5 DIM 4) (5 DIM 3)
       (5 DIM 2) (5 DIM) (5 JUST) (5 AUG) (5 AUG 2) (5 AUG 3) (5 AUG 4) (5 AUG 5)
       (5 AUG 6) (6 DIM 6) (6 DIM 5) (6 DIM 4) (6 DIM 3) (6 DIM 2) (6 DIM) (6 MIN)
       (6 MAJ) (6 AUG) (6 AUG 2) (6 AUG 3) (6 AUG 4) (6 AUG 5) (6 AUG 6) (7 DIM 6)
       (7 DIM 5) (7 DIM 4) (7 DIM 3) (7 DIM 2) (7 DIM) (7 MIN) (7 MAJ) (7 AUG)
       (7 AUG 2) (7 AUG 3) (7 AUG 4) (7 AUG 5) (7 AUG 6) (8 DIM 6) (8 DIM 5)
       (8 DIM 4) (8 DIM 3) (8 DIM 2) (8 DIM) (8 JUST))
     (get-system-intervals 'tonal))
    (assert-equal
     '((1 JUST) (2 MIN) (2 MAJ) (3 MIN) (3 MAJ) (4 JUST)
       (5 DIM) (5 JUST) (6 MIN) (6 MAJ) (7 MIN) (7 MAJ) (8 JUST))
     (get-system-intervals 'tempered)))

(define-test get-accidentals
    (assert-equal '("es" "is") (get-accidentals 'lily))
    (assert-equal '("b" "#") (get-accidentals 'latin)))

(define-test %get-accidental
    (assert-equal "es" (%get-accidental 'lily #'first))
    (assert-equal "is" (%get-accidental 'lily #'second))
    (assert-equal nil (%get-accidental 'lily #'third))
    (assert-equal "b" (%get-accidental 'latin #'first))
    (assert-equal "#" (%get-accidental 'latin #'second))
    (assert-equal nil (%get-accidental 'latin #'third)))
    
(define-test get-sharp
  (assert-equal "is" (get-sharp 'lily))
  (assert-equal "#" (get-sharp 'latin)))

(define-test get-flat
  (assert-equal "es" (get-flat 'lily))
  (assert-equal "b" (get-flat 'latin)))

(define-test get-interval-name
  (assert-equal 'diminished (get-interval-name 'dim))
  (assert-equal 'augmented (get-interval-name 'aug))
  (assert-equal 'major (get-interval-name 'maj))
  (assert-equal 'minor (get-interval-name 'min)))

(define-test get-interval-quantity
  (assert-equal nil (get-interval-quantity 0))
  (assert-equal nil (get-interval-quantity 1))
  (assert-equal 'double (get-interval-quantity 2))
  (assert-equal 'triple (get-interval-quantity 3))
  (assert-equal 'quadruple (get-interval-quantity 4))
  (assert-equal 'pentuple (get-interval-quantity 5))
  (assert-equal 'hextuple (get-interval-quantity 6))
  (assert-equal 'heptuple (get-interval-quantity 7)))

(define-test code->note
  (assert-equal '(c 0) (code->note 0))
  (assert-equal '(c -1) (code->note 95))
  (assert-equal '(d 0) (code->note 14))
  (assert-equal '(c 0) (code->note 96))
  (assert-equal '(c 0) (with-system tempered (code->note 0)))
  (assert-equal '(b 0) (with-system tempered (code->note 95)))
  (assert-equal '(d 0) (with-system tempered (code->note 14)))
  (assert-equal '(c 0) (with-system tempered (code->note 96))))

(define-test %note->code
  (assert-equal 0 (%note->code 'c))
  (assert-equal 14 (%note->code 'd))
  (assert-equal 0 (with-system tempered (%note->code 'c)))
  (assert-equal 2 (with-system tempered (%note->code 'd))))

(define-test note?
  (assert-true (note? "cis"))
  (assert-true (note? "cIs"))
  (assert-true (note? "c##"))
  (assert-false (note? "c##is#"))
  (assert-false (note? "cis#"))
  (assert-false (note? "s"))
  (assert-false (note? "foo")))

(define-test number-of-accidentals
   (assert-equal 1 (number-of-accidentals "cis" 'lily))
   (assert-equal 2 (number-of-accidentals "cisis" 'lily))
   (assert-equal 5 (number-of-accidentals "cisisisisis" 'lily))
   (assert-equal 0 (number-of-accidentals "c" 'lily))
   (assert-equal -1 (number-of-accidentals "ees" 'lily))
   (assert-equal -1 (number-of-accidentals "ces" 'lily))
   (assert-equal -2 (number-of-accidentals "ceses" 'lily))
   (assert-equal -5 (number-of-accidentals "ceseseseses" 'lily)))

(define-test match-note-representation
    (assert-equal nil (match-note-representation "cis" 'latin))
    (assert-equal nil (match-note-representation "c#" 'lily))
    (assert-equal 1 (match-note-representation "c#" 'latin))
    (assert-equal 1 (match-note-representation "cis" 'lily)))

(define-test %parse-note
  (assert-equal 95 (%parse-note "ces" 'lily 'tonal))
  (assert-equal 0 (%parse-note "c" 'lily 'tonal))
  (assert-equal 1 (%parse-note "c#" 'latin 'tonal)))

(define-test note->code
  (assert-equal 0 (note->code "c"))
  (assert-equal 13 (note->code "des"))
  (assert-equal 1 (with-system tempered (note->code "db")))
  (assert-equal 2 (with-system tempered (note->code "c##")))
  (assert-equal 1 (with-system tempered (note->code "c#"))))

(define-test print-accidentals
  (assert-equal "isisis" (print-accidentals 3 'lily))
  (assert-equal "eseses" (print-accidentals -3 'lily))
  (assert-equal "###" (print-accidentals 3 'latin))
  (assert-equal "bbb" (print-accidentals -3 'latin)))

(define-test print-note
  (assert-equal "cis" (print-note '(c 1) 'lily))
  (assert-equal "c#" (print-note '(c 1) 'latin))
  (assert-equal "ceseses" (print-note '(c -3) 'lily))
  (assert-equal "dbbb" (print-note '(d -3) 'latin)))

(define-test module
  (assert-equal 1 (module 97))
  (assert-equal 1 (module 1))
  (assert-equal 1 (with-system tempered (module 97)))
  (assert-equal 1 (with-system tempered (module 13))))

(define-test transpose
  (assert-equal 3 (transpose 0 3))
  (assert-equal 1 (with-system tempered (transpose 0 13)))
  (assert-equal 32 (transpose 0 320)))

(define-test inversion
  (assert-equal 7 (with-system tempered (inversion 5 0)))
  (assert-equal 91 (inversion 5 0)))

(define-test interval
  (assert-equal 4 (interval 7 3))
  (assert-equal 52 (interval 13 57)))

(define-test interval->code
  (let ((intervals '((1 just) (1 aug) (1 aug 2) (1 aug 3) (1 aug 4) (1 aug 5) (1 aug 6)
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
                   (8 dim 6) (8 dim 5) (8 dim 4) (8 dim 3) (8 dim 2) (8 dim) (8 just))))
    (loop
       for i in intervals
       for n from 0 to (length intervals) do
         (assert-equal i (interval->code n)))))

(define-test code->interval
  (assert-equal 29 (code->interval '(3 aug)))
  (assert-equal 0 (code->interval '(1 just)))
  (assert-equal 3 (with-system tempered (code->interval '(2 aug))))
  (assert-equal 3 (with-system tempered (code->interval '(3 min)))))

(define-test print-interval
  (assert-equal "double augmented second" (print-interval 16)))

(define-test rotate
  (assert-equal '(0 3 4 7) (rotate '(0 3 4 7) 0))
  (assert-equal '(3 4 7 0) (rotate '(0 3 4 7) 1))
  (assert-equal '(4 7 0 3) (rotate '(0 3 4 7) 2))
  (assert-equal '(7 0 3 4) (rotate '(0 3 4 7) 3))
  (assert-equal '(0 3 4 7) (rotate '(0 3 4 7) 4))
  (assert-equal '(3 4 7 0) (rotate '(0 3 4 7) 5))
  (assert-equal '(7 0 3 4) (rotate '(0 3 4 7) -1)))

(define-test set-rotate
  (assert-equal '((0 3 7) (3 7 0) (7 0 3)) (with-system tempered (set-rotate '(0 3 7)))))

(define-test set-inversion
  (assert-equal '(0 9 5) (with-system tempered (set-inversion '(0 3 7) 0)))
  (assert-equal '(0 93 89) (set-inversion '(0 3 7) 0)))

(define-test set-transpose
  (assert-equal '(3 6 10) (with-system tempered (set-transpose '(0 3 7) 3)))
  (assert-equal '(3 17 24) (with-system tonal (set-transpose '(0 14 21) 3))))

(define-test set-transpose-to-0
  (assert-equal '(0 10 8) (with-system tempered (set-transpose-to-0 '(9 7 5)))))

(define-test set-intervals
  (assert-equal '(3 4 5) (with-system tempered (set-intervals '(0 3 7)))))

(define-test set-symmetric?
  (assert-equal nil (with-system tempered (set-symmetric? '(0 4 7))))
  (assert-equal t (with-system tempered (set-symmetric? '(0 3 6 9)))))

(define-test set-form-list
  (assert-equal (list '((0 3 7) 7 3) '((3 7 0) 9 4) '((7 0 3) 8 5))
                          (with-system tempered (set-form-list '(0 3 7)))))

(define-test sort-form-list
  (assert-equal '(((0 3 7) 7 3) ((7 0 3) 8 5) ((3 7 0) 9 4))
                          (sort-form-list '(((0 3 7) 7 3) ((3 7 0) 9 4) ((7 0 3) 8 5)))))

(define-test smaller-sets
  (assert-equal '(((0 3 7) 7 3))
                          (with-system tempered
                            (smaller-sets '(((0 3 7) 7 3) ((7 0 3) 8 5) ((3 7 0) 9 4))))))

(define-test smaller-sets-comparisson
  (assert-equal '(0 3 7)
                          (with-system tempered
                            (smaller-sets-comparisson '(((0 3 7) 7 3) ((0 4 7) 7 4))))))

(define-test smallest-set
  (assert-equal '(0 3 7) (with-system tempered
                                     (smallest-set '(((0 3 7) 7 3) ((0 4 7) 7 4))))))

(define-test normal-form
  (assert-equal '(0 4 7) (with-system tempered (normal-form '(7 4 0)))))

(define-test prime-form
  (assert-equal '(0 3 7) (with-system tempered (prime-form '(4 7 0)))))

(define-test set-equal?
  (assert-equal nil (with-system tempered (set-equal? '(0 3 7) '(0 4 7) 'normal)))
  (assert-equal t (with-system tempered (set-equal? '(0 3 7) '(0 4 7) 'prime))))

(define-test latin->lily
  (assert-equal "ces" (latin->lily "cb"))
  (assert-equal "cisis" (latin->lily "c##")))

(define-test lily->latin
  (assert-equal "cb" (lily->latin "ces"))
  (assert-equal "c##" (lily->latin "cisis")))


(define-test rest?
  (assert-false (rest? "c"))
  (assert-false (rest? "cis"))
  (assert-true (rest? "R")))