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

(define-test mostn
  (assert-equal
   '(-10 -10)
   (mostn #'- '(1 2 10 3 -10 4 5 10 4 8 4 -10 10))))

(define-test add-lily-ext
  (assert-equal "foo.ly" (add-lily-ext "foo")))

(define-test add-pop-ext
  (assert-equal "foo.pop" (add-pop-ext "foo")))

(define-test has-ext?
  (assert-true (has-ext? "foo.ext"))
  (assert-false (has-ext? "foo-sem-ext")))

(define-test remove-ext
  (assert-equal "foo" (remove-ext "foo.ext")))

(define-test skip
  (assert-equal '(2 3 4 1 2) (skip 1 '(1 1 1 1 2 3 4 1 2))))

(define-test stringify
  (assert-equal "mel" (stringify :mel))
  (assert-equal "11" (stringify 11))
  (assert-equal "foo" (stringify 'foo))
  (assert-equal "fof" (stringify "FoF")))

(define-test string->symbol
  (assert-equal '|123| (string->symbol "123"))
  (assert-equal 'foo (string->symbol "foo")))

(define-test destringify
  (assert-equal :baz (destringify :baz))
  (assert-equal 'foo (destringify "foo"))
  (assert-equal 12 (destringify 12)))

(define-test repeat-string
  (assert-equal "foofoofoo" (repeat-string 3 "foo")))

(define-test clip
  (assert-equal '(foo bar baz) (clip 3 '(foo bar baz 1 2 3)))
  (assert-equal '(foo baz baz) (clip 10 '(foo baz baz))))

(define-test insert
  (assert-equal '((1 b) (2 c) (3 a) (4 e)) (insert '(3 a) '((1 b) (2 c) (4 e)) :key #'car)))

(define-test smallest
  (assert-equal 10 (smallest '(100 1000 10 20 30))))

(define-test advance-all
  (assert-equal '(nil (10) (10 100)) (advance-all '((a) (10 10) (1 10 100)))))

(define-test firstn
  (assert-equal '(10 20 30) (firstn '(10 20 30) 3))
  (assert-equal '(10 nil nil) (firstn '(10) 3)))

(define-test repeat-list
  (assert-equal '(10 10 10) (repeat-list 3 10))
  (assert-equal '((10) (10) (10)) (repeat-list 3 '(10))))

(define-test unzip
  (assert-equal '(10 20 30 40) (unzip '((10 1) (20 2) (30 3) (40 4)))))

(define-test get-item
  (assert-equal 10 (get-item 1 '((1 10)))))

(define-test char->symbol
  (assert-equal 'a (char->symbol #\a)))

(define-test split-word
  (assert-equal '(f o o) (split-word "foo")))

(define-test split-opts
  (assert-equal '(f f o o b a r b z q) (split-opts "-f foo bar -b -z -q")))

(define-test split-dados
  (assert-equal '("a" " b c") (split-dados "a, b c")))

(define-test sorted
  (assert-equal '(1 2 3 4) (sorted '(4 3 2 1) #'<)))

(define-test mapcar2
  (assert-equal '("foo" "bar") (mapcar2 #'string-downcase #'stringify '(foo bar))))

(define-test group
  (assert-equal '((a b c) (b c nil) (c nil nil)) (group '(a b c) 3)))

(define-test contextualize
  (assert-equal '((NIL A B C) (A B C D) (B C D E) (C D E NIL) (D E NIL NIL))
                (contextualize '(a b c d e) 1 2)))


(define-test sort-set
  (assert-equal '(1 2 3) (sort-set '(2 3 1))))

(define-test string-member
  (assert-equal '(foo bar baz) (string-member 'foo '(a b foo bar baz))))

(define-test apush
  (assert-equal '((foo bar) nil) (apush (list 'foo 'bar) (list nil))))

(define-test aget
  (assert-equal 'bar (aget 'foo (apush '(foo bar) (make-alist)))))

(define-test aset
  (let ((a (make-alist)))
    (aset 'foo a 'bar)
    (assert-equal 'bar (aget 'foo a))))

(define-test aincf
  (let ((a (make-alist)))
    (aincf 'foo a 42)
    (assert-equal 42 (aget 'foo a))))


(define-test square
  (assert-equal 4 (square 2)))

(define-test distance
  (assert-equal 100 (distance '(0) '(10))))

(define-test flatten
  (assert-equal '(0 1 2 3) (flatten '(((0 ) 1) (((((()))(2) 3)))))))