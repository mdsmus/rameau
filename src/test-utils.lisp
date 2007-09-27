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
