(in-package #:rameau)

(define-test %chord-interval-code
  (assert-equal '(7 min) (%chord-interval-code "c" "bes"))
  (assert-equal '(2 maj) (%chord-interval-code "c" "d")))

(define-test expand-multiplications
  (assert-equal
   '(foo foo foo bar bar (foo))
   (expand-multiplications '((* 3 foo) (* 2 bar) (foo))))
  (assert-equal
   '(foo bar foo bar (foo))
   (expand-multiplications '((* 2 foo bar) (foo)))))


(define-test parse-multiplication
  (assert-equal '(* 2 a) (parse-multiplication "a*2")))

(define-test return-inversion
  (assert-equal 2 (return-inversion "c" "g")))

(define-test parse-chord
  (assert-equalp (make-chord :fundamental "c" :7th "7") (parse-chord "c7"))
  (assert-equalp (make-chord :fundamental "bb" :mode "m") (parse-chord "bbm"))
  (assert-equalp (make-chord :fundamental "a") (parse-chord "a")))



(define-test transpose-chords
  (assert-equalp 
                  (list (parse-chord "D") (parse-chord "E"))
                  (transpose-chords (list (parse-chord "c") (parse-chord "d")) 14)))

(define-test compara-gabarito-temperado
  (assert-true (compara-gabarito-temperado (parse-chord "ab") (parse-chord "g#"))))

(define-test compara-gabarito-tonal
  (assert-false (compara-gabarito-tonal (parse-chord "ab") (parse-chord "g#"))))