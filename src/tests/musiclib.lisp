(in-package #:rameau-test)

(def-suite musiclib :description "Tests for the musiclib file" :in all)
(in-suite musiclib)

(test octave-from-string
  (is (= 0  (octave-from-string "")))
  (is (= -1  (octave-from-string ",")))
  (is (= -2  (octave-from-string ",,")))
  (is (= 1  (octave-from-string "'")))
  (is (= 2 (octave-from-string "''"))))

(test code->notename
  (is (equal '(:c 0) (code->notename 0)))
  (is (equal '(:c -1) (code->notename 95)))
  (is (equal '(:d 0) (code->notename 14)))
  (is (equal '(:c 0) (code->notename 96)))
  (is (equal '(:c 0) (with-system tempered (code->notename 0))))
  (is (equal '(:b 0) (with-system tempered (code->notename 95))))
  (is (equal '(:d 0) (with-system tempered (code->notename 14))))
  (is (equal '(:c 0) (with-system tempered (code->notename 96)))))

(test note?
  (is-true (note? "cis"))
  (is-true (note? "cIs"))
  (is-true (note? "c##"))
  (is-false (note? "c##is#"))
  (is-false (note? "cis#"))
  (is-false (note? "s"))
  (is-false (note? "foo")))

(test number-of-accidentals
  (is (= 1 (number-of-accidentals "cis" :lily)))
  (is (= 2 (number-of-accidentals "cisis" :lily)))
  (is (= 5 (number-of-accidentals "cisisisisis" :lily)))
  (is (= 0 (number-of-accidentals "c" :lily)))
  (is (= -1 (number-of-accidentals "ees" :lily)))
  (is (= -1 (number-of-accidentals "ces" :lily)))
  (is (= -2 (number-of-accidentals "ceses" :lily)))
  (is (= -5 (number-of-accidentals "ceseseseses" :lily))))

(test match-note-representation
  (is (eql nil (match-note-representation "cis" :latin)))
  (is (eql nil (match-note-representation "c#" :lily)))
  (is (= 1 (match-note-representation "c#" :latin)))
  (is (= 1 (match-note-representation "cis" :lily))))

(test get-accidental
  (is (equal "#" (get-accidental 'sharp :latin)))
  (is (equal "is" (get-accidental 'sharp :lily)))
  (is (equal "b" (get-accidental 'flat :latin)))
  (is (equal "es" (get-accidental 'flat :lily))))

(test get-octave
  (is (equal "'" (get-octave 'up :lily)))
  (is (equal "," (get-octave 'down :lily))))

(test parse-note
  (is (= 0 (parse-note "c")))
  (is (= 13 (parse-note "des")))
  (is (= 14 (parse-note "d")))
  (is (= 1  (parse-note "cis")))
  (is (= 1 (with-system tempered (parse-note "db"))))
  (is (= 2 (with-system tempered (parse-note "c##"))))
  (is (= 1 (with-system tempered (parse-note "c#")))))

(test print-accidentals
  (is (equal "isisis" (print-accidentals 3 :lily)))
  (is (equal "eseses" (print-accidentals -3 :lily)))
  (is (equal "###" (print-accidentals 3 :latin)))
  (is (equal "bbb" (print-accidentals -3 :latin))))

(test print-note
  (is (equal "cis" (print-note '(c 1) :lily)))
  (is (equal "c#" (print-note '(c 1) :latin)))
  (is (equal "ceseses" (print-note '(c -3) :lily)))
  (is (equal "dbbb" (print-note '(d -3) :latin))))

(test module
  (is (= 1 (module 97)))
  (is (= 1 (module 1)))
  (is (= 1 (with-system tempered (module 97))))
  (is (= 1 (with-system tempered (module 13)))))

(test transpose
  (is (= 3 (transpose 0 3)))
  (is (= 1 (with-system tempered (transpose 0 13))))
  (is (= 32 (transpose 0 320))))

(test inversion
  (is (= 7 (with-system tempered (inversion 5 0))))
  (is (= 91 (inversion 5 0))))

(test interval
  (is (= 4 (interval 7 3)))
  (is (= 52 (interval 13 57))))

(test code->interval
  (is (= 29 (code->interval '(3 :aug))))
  (is (= 0 (code->interval '(1 :perfect))))
  (is (= 3 (with-system tempered (code->interval '(2 :aug)))))
  (is (= 3 (with-system tempered (code->interval '(3 :min))))))

(test print-interval
  (is (equal "double augmented second" (print-interval 16))))

(test %rotate
  (is (equal '(0 3 4 7) (%rotate '(0 3 4 7) 0)))
  (is (equal '(3 4 7 0) (%rotate '(0 3 4 7) 1)))
  (is (equal '(4 7 0 3) (%rotate '(0 3 4 7) 2)))
  (is (equal '(7 0 3 4) (%rotate '(0 3 4 7) 3)))
  (is (equal '(0 3 4 7) (%rotate '(0 3 4 7) 4)))
  (is (equal '(3 4 7 0) (%rotate '(0 3 4 7) 5)))
  (is (equal '(7 0 3 4) (%rotate '(0 3 4 7) -1))))

(test set-rotate
  (is (equal '((0 3 7) (3 7 0) (7 0 3)) (with-system tempered (set-rotate '(0 3 7))))))

(test set-inversion
  (is (equal '(0 9 5) (with-system tempered (set-inversion '(0 3 7) 0))))
  (is (equal '(0 93 89) (set-inversion '(0 3 7) 0))))

(test set-transpose
  (is (equal '(3 6 10) (with-system tempered (set-transpose '(0 3 7) 3))))
  (is (equal '(3 17 24) (with-system tonal (set-transpose '(0 14 21) 3)))))

(test set-transpose-to-0
  (is (equal '(0 10 8) (with-system tempered (set-transpose-to-0 '(9 7 5))))))

(test set-intervals
  (is (equal '(3 4 5) (with-system tempered (set-intervals '(0 3 7))))))

(test set-symmetric?
  (is (eql nil (with-system tempered (set-symmetric? '(0 4 7)))))
  (is (eql t (with-system tempered (set-symmetric? '(0 3 6 9))))))

(test set-form-list
  (is (equal (list '((0 3 7) 7 3) '((3 7 0) 9 4) '((7 0 3) 8 5))
                 (with-system tempered (set-form-list '(0 3 7))))))

(test sort-form-list
  (is (equal '(((0 3 7) 7 3) ((7 0 3) 8 5) ((3 7 0) 9 4))
                 (sort-form-list '(((0 3 7) 7 3) ((3 7 0) 9 4) ((7 0 3) 8 5))))))

(test smaller-sets
  (is (equal '(((0 3 7) 7 3))
                 (with-system tempered
                   (smaller-sets '(((0 3 7) 7 3) ((7 0 3) 8 5) ((3 7 0) 9 4)))))))

(test smaller-sets-comparisson
  (is (equal '(0 3 7)
                 (with-system tempered
                   (smaller-sets-comparisson '(((0 3 7) 7 3) ((0 4 7) 7 4)))))))

(test smallest-set
  (is (equal '(0 3 7) (with-system tempered
                            (smallest-set '(((0 3 7) 7 3) ((0 4 7) 7 4)))))))

(test normal-form
  (is (equal '(0 4 7) (with-system tempered (normal-form '(7 4 0))))))

(test prime-form
  (is (equal '(0 3 7) (with-system tempered (prime-form '(4 7 0))))))

(test set-equal?
  (is (eql nil (with-system tempered (set-equal? '(0 3 7) '(0 4 7) 'normal))))
  (is (eql t (with-system tempered (set-equal? '(0 3 7) '(0 4 7) 'prime)))))

(test latin->lily
  (is (equal "ces" (latin->lily "cb")))
  (is (equal "cisis" (latin->lily "c##"))))

(test lily->latin
  (is (equal "cb" (lily->latin "ces")))
  (is (equal "c##" (lily->latin "cisis"))))


(test rest?
  (is-false (rest? "c"))
  (is-false (rest? "cis"))
  (is-true (rest? "R")))

(test notename->code
  (is (= 10 (notename->code (code->notename 10))))
  (is (= 10 (with-system tempered
                      (notename->code (code->notename 10)))))) 

(test enharmonicaly-equal-p
  (is-true  (enharmonicaly-equal-p  "a#" "bb")))