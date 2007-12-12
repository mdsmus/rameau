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
