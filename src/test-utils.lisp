(in-package :rameau)

(use-package '#:lisp-unit)

(define-test compara-notas
  (assert-true
   (compara-notas (make-evento :pitch 0 :octave 1)
                  (make-evento :pitch 0 :octave 2)))
  (assert-false
   (compara-notas (make-evento :pitch 0 :octave 2)
                  (make-evento :pitch 0 :octave 1)))
  (assert-false
   (compara-notas (make-evento :pitch 55 :octave 1)
                  (make-evento :pitch 14 :octave 1)))
  (assert-true
   (compara-notas (make-evento :pitch 55 :octave 1)
                  (make-evento :pitch 14 :octave 2))))

(define-test concat
  (assert-equal
   "abracadabra"
   (concat "abra" "ca" "dabra")))


(define-test assoc-item
  (assert-equal
   'foo
   (assoc-item 'bar '((baz bas) (foo bar) (bar foo)))))

(define-test count-subseq
  (assert-equal
   3
   (count-subseq "foo" "fofofoofofooooofofoofofo")))

(define-test expande-multiplicacoes
  (assert-equal
   '(foo foo foo bar bar (foo))
   (expande-multiplicacoes '((* 3 foo) (* 2 bar) (foo)))))

(define-test last1
  (assert-equal
   'foo
   (last1 '(d gb g lkfglkd kfglk dlfgk dkf foo))))

(define-test lista-notas
  (assert-equal
   '("c" "e" "g" "c")
   (lista-notas
    (list
     (make-evento :PITCH 0 :OCTAVE 10 :DUR 1/4 :INICIO 0)
     (make-evento :PITCH 55 :OCTAVE 9 :DUR 1/4 :INICIO 0)
     (make-evento :PITCH 28 :OCTAVE 9 :DUR 1/4 :INICIO 0)
     (make-evento :PITCH 0 :OCTAVE 9 :DUR 1/4 :INICIO 0)))))

(define-test max-predicado
  (assert-equal
   '(-10 -10)
   (max-predicado #'- '(1 2 10 3 -10 4 5 10 4 8 4 -10 10))))

(define-test add-lily-ext
  (assert-equal "foo.ly" (add-lily-ext "foo")))

(define-test add-pop-ext
  (assert-equal "foo.pop" (add-pop-ext "foo")))

(define-test tem-ext?
  (assert-true (tem-ext? "foo.ext"))
  (assert-false (tem-ext? "foo-sem-ext")))

(define-test tira-extensao
  (assert-equal "foo" (tira-extensao "foo.ext")))

(define-test troca-extensao
  (assert-equal "foo.ly" (troca-extensao "foo.ext" ".ly")))

(define-test pula
  (assert-equal '(2 3 4 1 2) (pula 1 '(1 1 1 1 2 3 4 1 2))))

(define-test stringify
  (assert-equal "mel" (stringify :mel))
  (assert-equal "11" (stringify 11))
  (assert-equal "foo" (stringify 'foo))
  (assert-equal "foo" (stringify "FoF")))

(define-test string->symbol
  (assert-equal '|123| (string->symbol "123"))
  (assert-equal 'foo (string->symbol "foo")))

(define-test symbol->number
  (assert-equal 2 (symbol->number "foodfood" '("bar" "foo")))
  (assert-equal -2 (symbol->number "foodfood" '("foo" "bar"))))

(define-test destringify
  (assert-equal :baz (destringify :baz))
  (assert-equal 'foo (destringify "foo"))
  (assert-equal 12 (destringify 12)))

(define-test repeat-string
  (assert-equal "foofoofoo" (repeat-string 3 "foo")))

(define-test exclude-repetition
  (assert-equal '(1 2 3) (exclude-repetition '(1 2 1 3))))