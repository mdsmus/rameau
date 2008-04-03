(in-package :rameau-main)
(use-package :lisp-unit)

(define-test item-singular
  (assert-equal "coral" (item-singular "corais")))

(define-test arg->list
  (assert-equal '(("-a" "b" "c") ("-d")) (arg->list '("-a" "b" "c" "-d"))))

(define-test intervalo
  (assert-equal 10 (intervalo (list (make-evento :pitch 10 :octave 0 :inicio 0 :dur 0))
                              (list (make-evento :pitch 20 :octave 10 :inicio 10 :dur 2)))))

(define-test next-flag
  (assert-equal "-b" (next-flag '("a" "-b" "-c"))))


(define-test pos
  (assert-equal 1 (pos '("a" "-b" "-c")))
  (assert-equal 0 (pos '("a" "b" "c"))))

(define-test get-lone-flags
  ; FIXME: melhorar esses testes
  (assert-equal nil (get-lone-flags '("-b" ("c" "b")))))