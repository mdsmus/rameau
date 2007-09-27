(in-package :rameau)
(use-package '#:lisp-unit)

(define-test fim-evento
  (assert-equal
   1
   (fim-evento (make-evento :inicio 1/2 :dur 1/2))))

(define-test menos-de-uma-quarta
  (assert-true
   (menos-de-uma-quarta (make-evento :pitch 0 :octave 0)
                        (make-evento :pitch 28 :octave 0)))
  (assert-true
   (menos-de-uma-quarta (make-evento :pitch 0 :octave 0)
                        (make-evento :pitch 28 :octave 1)))
  (assert-false
   (menos-de-uma-quarta (make-evento :pitch 55 :octave 1)
                        (make-evento :pitch 28 :octave 1)))
  (assert-false
   (with-system tempered
     (menos-de-uma-quarta (make-evento :pitch 0)
                          (make-evento :pitch 5))))
  (assert-true
   (with-system tonal
     (menos-de-uma-quarta (make-evento :pitch 0)
                          (make-evento :pitch 5)))))

