(in-package #:rameau)
(use-package 'lisp-unit)


(lisp-unit:define-test segmentos-minimos
  (lisp-unit:assert-equalp
   (segmentos-minimos
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

(define-test normaliza-notas
  (lisp-unit:assert-equalp
    (multiple-value-bind (a b)
        (normaliza-notas
         (list
          (make-evento :pitch 1
                       :octave 1
                       :inicio 0
                       :dur 2)
          (make-evento :pitch 2
                       :octave 1
                       :inicio 0
                       :dur 2)
          (make-evento :pitch 3
                       :octave 1
                       :inicio 0
                       :dur 5)
          (make-evento :pitch 4
                       :octave 1
                       :inicio 0
                       :dur 4)))
      a)
    (list
     (make-evento :pitch 1
                  :octave 1
                  :inicio 0
                  :dur 2)
     (make-evento :pitch 2
                  :octave 1
                  :inicio 0
                  :dur 2)
     (make-evento :pitch 3
                  :octave 1
                  :inicio 0
                  :dur 2)
     (make-evento :pitch 4
                  :octave 1
                  :inicio 0
                  :dur 2)))

  (lisp-unit:assert-equalp
    (multiple-value-bind
          (a b)
        (normaliza-notas
         (list
          (make-evento :pitch 1
                       :octave 1
                       :inicio 0
                       :dur 2)
          (make-evento :pitch 2
                       :octave 1
                       :inicio 0
                       :dur 2)
          (make-evento :pitch 3
                       :octave 1
                       :inicio 0
                       :dur 5)
          (make-evento :pitch 4
                       :octave 1
                       :inicio 0
                       :dur 4)))
      b)
    (list
     (make-evento :pitch 4
                  :octave 1
                  :inicio 2
                  :dur 2)
     (make-evento :pitch 3
                  :octave 1
                  :inicio 2
                  :dur 3))))
