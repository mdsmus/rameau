(in-package #:rameau-test)

(def-suite chords :description "Tests for the chords file")
(in-suite chords)

(test chord-interval-code
  (is (equal '(7 :min) (chord-interval-code "c" "bes")))
  (is (equal '(2 :maj) (chord-interval-code "c" "d"))))

(test expand-multiplications
  (is (equal
    '(foo foo foo bar bar (foo))
    (rameau::expand-multiplications '((* 3 foo) (* 2 bar) (foo)))))
  (is (equal
    '(foo bar foo bar (foo))
    (rameau::expand-multiplications '((* 2 foo bar) (foo))))))


(test parse-multiplication
  (is (equal '(* 2 :a) (rameau::parse-multiplication "a*2"))))

(test return-inversion
  (is (equal 2 (return-inversion "c" "g"))))

(test parse-chord
  (is (equalp (make-chord :root "c" :mode "" :7th "7") (parse-chord "c7")))
  (is (equalp (make-chord :root "bb" :mode "m" :7th "") (parse-chord "bbm")))
  (is (equalp (make-chord :root "a" :mode "" :7th "") (parse-chord "a"))))

(test transpose-chords
  (is (equalp 
    (list (parse-chord "D") (parse-chord "E"))
    (transpose-chords (list (parse-chord "c") (parse-chord "d")) 14))))

(test compare-answer-sheet
  (is-true (compare-answer-sheet (parse-chord "ab") (parse-chord "g#") 'tempered))
  (is-false (compare-answer-sheet (parse-chord "ab") (parse-chord "g#"))))