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

(lisp-unit:define-test cria-nota
  (assert-equal 0 (evento-pitch (car (sequencia-de-notas-notas (cria-nota "c")))))
  (assert-equal nil (evento-dur (car (sequencia-de-notas-notas (cria-nota "c")))))
  (assert-equal 8 (evento-octave (car (sequencia-de-notas-notas (cria-nota "c")))))
  (assert-equal 0 (evento-inicio (car (sequencia-de-notas-notas (cria-nota "c")))))
  )


(lisp-unit:define-test coloca-expressoes-em-sequencia
  (lisp-unit:assert-equal
   '(0 0 0 0 1/4 1/4 1/4 1/4 1/2 1/2 1/2 1/2)
   (mapcar
    #'evento-inicio
    (sequencia-de-notas-notas
     (coloca-expressoes-em-sequencia
      (list
       (make-sequencia-de-notas
        :notas
        (list
         (make-evento :PITCH 0 :OCTAVE 10 :DUR 1/4 :INICIO 0)
         (make-evento :PITCH 55 :OCTAVE 9 :DUR 1/4 :INICIO 0)
         (make-evento :PITCH 28 :OCTAVE 9 :DUR 1/4 :INICIO 0)
         (make-evento :PITCH 0 :OCTAVE 9 :DUR 1/4 :INICIO 0))
        :inicio 0
        :dur 1/4)
       (make-sequencia-de-notas
        :notas
        (list
         (make-evento :PITCH 83 :OCTAVE 9 :DUR 1/4 :INICIO 0)
         (make-evento :PITCH 55 :OCTAVE 9 :DUR 1/4 :INICIO 0)
         (make-evento :PITCH 14 :OCTAVE 9 :DUR 1/4 :INICIO 0)
         (make-evento :PITCH 55 :OCTAVE 8 :DUR 1/4 :INICIO 0))
        :inicio 0
        :dur 1/4)
       (make-sequencia-de-notas
        :notas
        (list
         (make-evento :PITCH 0 :OCTAVE 10 :DUR 1/4 :INICIO 0)
         (make-evento :PITCH 55 :OCTAVE 9 :DUR 1/4 :INICIO 0)
         (make-evento :PITCH 28 :OCTAVE 9 :DUR 1/4 :INICIO 0)
         (make-evento :PITCH 0 :OCTAVE 9 :DUR 1/4 :INICIO 0))
        :inicio 0
        :dur 1/4)))))))

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

(define-test lista-notas
  (assert-equal
   '("c" "e" "g" "c")
   (lista-notas
    (list
     (make-evento :PITCH 0 :OCTAVE 10 :DUR 1/4 :INICIO 0)
     (make-evento :PITCH 55 :OCTAVE 9 :DUR 1/4 :INICIO 0)
     (make-evento :PITCH 28 :OCTAVE 9 :DUR 1/4 :INICIO 0)
     (make-evento :PITCH 0 :OCTAVE 9 :DUR 1/4 :INICIO 0)))))

(define-test pitches
  (assert-equal '(0 55 28 0) (pitches
                              (list
                               (make-evento :PITCH 0 :OCTAVE 10 :DUR 1/4 :INICIO 0)
                               (make-evento :PITCH 55 :OCTAVE 9 :DUR 1/4 :INICIO 0)
                               (make-evento :PITCH 28 :OCTAVE 9 :DUR 1/4 :INICIO 0)
                               (make-evento :PITCH 0 :OCTAVE 9 :DUR 1/4 :INICIO 0)))))


(define-test calcula-duracoes
  (assert-equal '(1/4) (calcula-duracoes
                     (list (list
                            (make-evento :PITCH 0 :OCTAVE 10 :DUR 1/4 :INICIO 0)
                            (make-evento :PITCH 55 :OCTAVE 9 :DUR 1/4 :INICIO 0)
                            (make-evento :PITCH 28 :OCTAVE 9 :DUR 1/4 :INICIO 0)
                            (make-evento :PITCH 0 :OCTAVE 9 :DUR 1/4 :INICIO 0))))))


                     

(define-test temperado
  (assert-equalp (list (list
                       (make-evento :PITCH 0 :OCTAVE 10 :DUR 1/4 :INICIO 0)
                       (make-evento :PITCH 7 :OCTAVE 9 :DUR 1/4 :INICIO 0)
                       (make-evento :PITCH 4 :OCTAVE 9 :DUR 1/4 :INICIO 0)
                       (make-evento :PITCH 0 :OCTAVE 9 :DUR 1/4 :INICIO 0)))
                (temperado (list (list
                       (make-evento :PITCH 0 :OCTAVE 10 :DUR 1/4 :INICIO 0)
                       (make-evento :PITCH 55 :OCTAVE 9 :DUR 1/4 :INICIO 0)
                       (make-evento :PITCH 28 :OCTAVE 9 :DUR 1/4 :INICIO 0)
                       (make-evento :PITCH 0 :OCTAVE 9 :DUR 1/4 :INICIO 0))))))
