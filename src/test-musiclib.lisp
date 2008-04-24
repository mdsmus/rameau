(in-package #:rameau)
(use-package :lisp-unit)

(define-test octave-from-string
  (assert-equal 0  (octave-from-string ""))
  (assert-equal -1  (octave-from-string ","))
  (assert-equal -2  (octave-from-string ",,"))
  (assert-equal 1  (octave-from-string "'"))
  (assert-equal 2 (octave-from-string "''")))

(define-test code->notename
  (assert-equal '(c 0) (code->notename 0))
  (assert-equal '(c -1) (code->notename 95))
  (assert-equal '(d 0) (code->notename 14))
  (assert-equal '(c 0) (code->notename 96))
  (assert-equal '(c 0) (with-system tempered (code->notename 0)))
  (assert-equal '(b 0) (with-system tempered (code->notename 95)))
  (assert-equal '(d 0) (with-system tempered (code->notename 14)))
  (assert-equal '(c 0) (with-system tempered (code->notename 96))))

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

(define-test get-accidental
    (assert-equal "#" (get-accidental 'sharp 'latin))
  (assert-equal "is" (get-accidental 'sharp 'lily))
  (assert-equal "b" (get-accidental 'flat 'latin))
  (assert-equal "es" (get-accidental 'flat 'lily)))

(define-test get-octave
    (assert-equal "'" (get-octave 'up 'lily))
  (assert-equal "," (get-octave 'down 'lily)))

(define-test parse-note
  (assert-equal 0 (parse-note "c"))
  (assert-equal 13 (parse-note "des"))
  (assert-equal 14 (parse-note "d"))
  (assert-equal 1  (parse-note "cis"))
  (assert-equal 1 (with-system tempered (parse-note "db")))
  (assert-equal 2 (with-system tempered (parse-note "c##")))
  (assert-equal 1 (with-system tempered (parse-note "c#"))))

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

(define-test notename->code
  (assert-equal 10 (notename->code (code->notename 10)))
  (assert-equal 10 (with-system tempered
                     (notename->code (code->notename 10)))))

(define-test enharmonicaly-equal-p
  (assert-true  (enharmonicaly-equal-p  "a#" "bb")))