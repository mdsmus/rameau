(in-package :rameau)
(use-package :lisp-unit)

(define-test files-range
  (assert-equal '("001" "002" "003") (files-range '("1" "3"))))

(define-test first-string
  (assert-equal "bla" (first-string "bla" nil))
  (assert-equal "bla" (first-string "bla" '("b")))
  (assert-equal "abacate"   (first-string "a" '("bola" "casa" "abacate"))))



(define-test extrai-diff
  (assert-equal 10 (extrai-diff (list (make-evento :pitch 10 :octave 0) (make-evento :pitch 20 :octave 10)))))



(define-test extrai-feature-list
  (assert-equal '(1/2 0 0 0 0 0 0 0 0 0 1/2 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
                (extrai-feature-list (list (make-evento :pitch 10 :octave 0) (make-evento :pitch 20 :octave 10)) 10)))


