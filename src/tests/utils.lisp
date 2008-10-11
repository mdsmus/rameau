(in-package :rameau-test)

(defsuite utils "Tests for the utils file")
(in-suite utils)

(test concat
  (is (equal
       "abracadabra"
       (concat "abra" "ca" "dabra"))))

(test %
  (is (eql 100.0 (% 1 1))))

(test assoc-item
  (is (eql
       'foo
       (assoc-item 'bar '((baz bas) (foo bar) (bar foo))))))

(test count-subseq
  (is (eql
       3
       (count-subseq "foo" "fofofoofofooooofofoofofo"))))

(test mostn
  (is (equal
       '(-10 -10)
       (mostn #'- '(1 2 10 3 -10 4 5 10 4 8 4 -10 10)))))

(test skip-initial-element
  (is (equal '(2 3 4 1 2) (skip-initial-element 1 '(1 1 1 1 2 3 4 1 2)))))

(test stringify
  (is (equal "mel" (stringify :mel)))
  (is (equal "11" (stringify 11)))
  (is (equal "foo" (stringify 'foo)))
  (is (equal "fof" (stringify "FoF"))))

(test repeat-string
  (is (equal "foofoofoo" (repeat-string 3 "foo"))))

(test clip
  (is (equal '(foo bar baz) (clip 3 '(foo bar baz 1 2 3))))
  (is (equal '(foo baz baz) (clip 10 '(foo baz baz)))))

(test insert
  (is (equal '((1 b) (2 c) (3 a) (4 e)) (insert '(3 a) '((1 b) (2 c) (4 e)) :key #'car))))

(test smallest
  (is (eql 10 (smallest '(100 1000 10 20 30)))))

(test advance-all
  (is (equal '(nil (10) (10 100)) (advance-all '((a) (10 10) (1 10 100))))))

(test firstn
  (is (equal '(10 20 30) (firstn '(10 20 30) 3)))
  (is (equal '(10 nil nil) (firstn '(10) 3))))

(test repeat-list
  (is (equal '(10 10 10) (repeat-list 3 10)))
  (is (equal '((10) (10) (10)) (repeat-list 3 '(10)))))

(test unzip
  (is (equal '(10 20 30 40) (unzip '((10 1) (20 2) (30 3) (40 4))))))

(test get-item
  (is (eql 10 (get-item 1 '((1 10))))))

(test sorted
  (is (equal '(1 2 3 4) (sorted '(4 3 2 1) #'<))))

(test mapcar2
  (is (equal '("foo" "bar") (mapcar2 #'string-downcase #'stringify '(foo bar)))))

(test group
  (is (equal '((a b c) (b c nil) (c nil nil)) (group '(a b c) 3))))

(test contextualize
  (is (equal '((NIL A B C) (A B C D) (B C D E) (C D E NIL) (D E NIL NIL))
             (contextualize '(a b c d e) 1 2))))

(test sort-set
  (is (equal '(1 2 3) (sort-set '(2 3 1)))))

(test string-member
  (is (equal '(foo bar baz) (string-member 'foo '(a b foo bar baz)))))

(test apush
  (is (equal '((foo bar) nil) (apush (list 'foo 'bar) (list nil)))))

(test aget
  (is (eql 'bar (aget 'foo (apush '(foo bar) (make-alist))))))

(test aset
  (let ((a (make-alist)))
    (aset 'foo a 'bar)
    (is (equal 'bar (aget 'foo a)))))

(test aincf
  (let ((a (make-alist)))
    (aincf 'foo a 42)
    (is (eql 42 (aget 'foo a)))))

(test square
  (is (eql 4 (square 2))))

(test distance
  (is (eql 100 (distance '(0) '(10)))))

(test make-keyword
  (is (eql :foo (make-keyword "FoO"))))

(test search-for-directories
  (is-false (search-for-directories "test12!" #p"/tmp/"))
  (let ((tmpdir (symbol-name (gensym))))
   (with-fixture create-tmp-dir (tmpdir)
     (is (equal (list (make-pathname :directory `(:absolute "tmp" ,tmpdir)))
                (search-for-directories tmpdir #p"/tmp/"))))))

(test pathname-subdir
  (is (equal #p"nada/mais/"
             (pathname-subdir #p"/home/kroger/foo/bar/bla.lisp"
                              #p"/home/kroger/foo/bar/nada/mais/bla.lisp"))))

(test pathname-difference
  (is (equal #p"src/foo.bar"
             (pathname-difference #p"/home/kroger/src/rameau/"
                                  #p"/home/kroger/src/rameau/src/foo.bar"))))

(test pathname-notdir
  (is (equal #p"foo.bar"
             (pathname-notdir #p "/home/kroger/src/rameau/src/foo.bar"))))

