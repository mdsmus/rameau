(in-package :rameau-test)

(define-test files-range
  (assert-equal '("001" "002" "003") (files-range '("1" "3"))))

(define-test extract-diff
  (assert-equal 10 (extract-diff (list (make-event :pitch 10 :octave 0) (make-event :pitch 20 :octave 10)))))

(define-test extract-feature-list
  (assert-equal '(1/2 0 0 0 0 0 0 0 0 0 1/2 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
                (extract-feature-list (list (make-event :pitch 10 :octave 0) (make-event :pitch 20 :octave 10)) 10)))



