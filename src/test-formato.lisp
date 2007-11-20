(in-package :rameau)

(define-test fim-evento
  (assert-equal
   1
   (fim-evento (make-evento :inicio 1/2 :dur 1/2))))

(define-test menos-de-uma-quinta
  (assert-true
   (menos-de-uma-quinta (make-evento :pitch 0 :octave 0)
                        (make-evento :pitch 28 :octave 0)))
  (assert-true
   (menos-de-uma-quinta (make-evento :pitch 0 :octave 0)
                        (make-evento :pitch 28 :octave 1)))
  (assert-false
   (menos-de-uma-quinta (make-evento :pitch 55 :octave 1)
                        (make-evento :pitch 28 :octave 1)))
  (assert-true
   (with-system tempered
     (menos-de-uma-quinta (make-evento :pitch 0)
                          (make-evento :pitch 5))))
  (assert-true
   (with-system tonal
     (menos-de-uma-quinta (make-evento :pitch 0)
                          (make-evento :pitch 5)))))

(define-test relativiza
  (assert-equalp (with-system tempered (parse-string "
\\score {
  \\new Staff \\relative c''{
    c g c f c g c
  }
}"))
                
                (list (make-evento :PITCH 0 :OCTAVE 10 :DUR 1/4 :INICIO 0)
                      (make-evento :PITCH 7 :OCTAVE 9 :DUR 1/4 :INICIO 1/4)
                      (make-evento :PITCH 0 :OCTAVE 10 :DUR 1/4 :INICIO 1/2)
                      (make-evento :PITCH 5 :OCTAVE 10 :DUR 1/4 :INICIO 3/4)
                      (make-evento :PITCH 0 :OCTAVE 10 :DUR 1/4 :INICIO 1)
                      (make-evento :PITCH 7 :OCTAVE 9 :DUR 1/4 :INICIO 5/4)
                      (make-evento :PITCH 0 :OCTAVE 10 :DUR 1/4 :INICIO 3/2))))
