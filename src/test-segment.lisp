(in-package #:rameau)
(use-package 'lisp-unit)


(lisp-unit:define-test sonorities
  (lisp-unit:assert-equalp
   (sonorities
    (list (make-evento :PITCH 0 :OCTAVE 10 :DUR 1/4 :INICIO 0)
          (make-evento :PITCH 55 :OCTAVE 9 :DUR 1/4 :INICIO 0)
          (make-evento :PITCH 28 :OCTAVE 9 :DUR 1/4 :INICIO 0)
          (make-evento :PITCH 0 :OCTAVE 9 :DUR 1/4 :INICIO 0)
          (make-evento :PITCH 83 :OCTAVE 9 :DUR 1/4 :INICIO 1/4)
          (make-evento :PITCH 55 :OCTAVE 9 :DUR 1/4 :INICIO 1/4)
          (make-evento :PITCH 14 :OCTAVE 9 :DUR 1/4 :INICIO 1/4)
          (make-evento :PITCH 55 :OCTAVE 8 :DUR 1/4 :INICIO 1/4)
          (make-evento :PITCH 0 :OCTAVE 10 :DUR 1/4 :INICIO 1/2)
          (make-evento :PITCH 55 :OCTAVE 9 :DUR 1/4 :INICIO 1/2)
          (make-evento :PITCH 28 :OCTAVE 9 :DUR 1/4 :INICIO 1/2)
          (make-evento :PITCH 0 :OCTAVE 9 :DUR 1/4 :INICIO 1/2)))
   (list
    (list (make-evento :PITCH 0 :OCTAVE 10 :DUR 1/4 :INICIO 0)
          (make-evento :PITCH 55 :OCTAVE 9 :DUR 1/4 :INICIO 0)
          (make-evento :PITCH 28 :OCTAVE 9 :DUR 1/4 :INICIO 0)
          (make-evento :PITCH 0 :OCTAVE 9 :DUR 1/4 :INICIO 0))
    (list (make-evento :PITCH 83 :OCTAVE 9 :DUR 1/4 :INICIO 1/4)
          (make-evento :PITCH 55 :OCTAVE 9 :DUR 1/4 :INICIO 1/4)
          (make-evento :PITCH 14 :OCTAVE 9 :DUR 1/4 :INICIO 1/4)
          (make-evento :PITCH 55 :OCTAVE 8 :DUR 1/4 :INICIO 1/4))
    (list (make-evento :PITCH 0 :OCTAVE 10 :DUR 1/4 :INICIO 1/2)
          (make-evento :PITCH 55 :OCTAVE 9 :DUR 1/4 :INICIO 1/2)
          (make-evento :PITCH 28 :OCTAVE 9 :DUR 1/4 :INICIO 1/2)
          (make-evento :PITCH 0 :OCTAVE 9 :DUR 1/4 :INICIO 1/2)))))

