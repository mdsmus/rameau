(in-package :rameau)

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
  (assert-equal "fof" (stringify "FoF")))

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

(lisp-unit:define-test octave-from-string
  (lisp-unit:assert-equal 8  (octave-from-string ""))
  (lisp-unit:assert-equal 7  (octave-from-string ","))
  (lisp-unit:assert-equal 6  (octave-from-string ",,"))
  (lisp-unit:assert-equal 9  (octave-from-string "'"))
  (lisp-unit:assert-equal 10 (octave-from-string "''"))
  )



(define-test clip
  (assert-equal '(foo bar baz) (clip 8 '(foo bar baz 1 2 3)))
  (assert-equal '(foo baz baz) (clip 10 '(foo baz baz))))

(define-test insere
  (assert-equal '((1 b) (2 c) (3 a) (4 e)) (insere '(3 a) '((1 b) (2 c) (4 e)))))

