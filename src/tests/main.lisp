(in-package :rameau-main-test)

(define-test item-singular
  (assert-equal "coral" (item-singular "corais")))

(define-test arg->list
  (assert-equal '(("-a" "b" "c") ("-d")) (arg->list '("-a" "b" "c" "-d"))))

(define-test intervalo
  (assert-equal 10 (intervalo (list (make-event :pitch 10 :octave 0 :start 0 :dur 0))
                              (list (make-event :pitch 20 :octave 10 :start 10 :dur 2)))))

(define-test next-flag
  (assert-equal "-b" (next-flag '("a" "-b" "-c"))))


(define-test pos
  (assert-equal 1 (pos '("a" "-b" "-c")))
  (assert-equal 0 (pos '("a" "b" "c"))))

(define-test get-lone-flags
  ; FIXME: melhorar esses testes
  (assert-equal nil (get-lone-flags '("-b" ("c" "b")))))

(define-test get-flag-list
  (assert-equal ("b" "c" "d") (get-flag-list "-f" '(("-d" "a" "b" "c") ("-f" "b" "c" "d")))))

(define-test frac->dur-lily
  (assert-equal "4" (frac->dur-lily 1/4)))