(in-package :rameau-test)
(use-package :cl-lily)

(define-test event-end
  (assert-equal
   1
   (event-end (make-event :key '(C MAJOR) :time-sig 1 :start 1/2 :dur 1/2))))

(define-test but-a-fifth-apart
  (assert-true
   (cl-lily::but-a-fifth-apart (make-event :key '(C MAJOR) :time-sig 1 :pitch 0 :octave 0)
                                (make-event :key '(C MAJOR) :time-sig 1 :pitch 28 :octave 0)))
  (assert-true
   (cl-lily::but-a-fifth-apart (make-event :key '(C MAJOR) :time-sig 1 :pitch 0 :octave 0)
                               (make-event :key '(C MAJOR) :time-sig 1 :pitch 28 :octave 1)))
  (assert-false
   (cl-lily::but-a-fifth-apart (make-event :key '(C MAJOR) :time-sig 1 :pitch 55 :octave 1)
                               (make-event :key '(C MAJOR) :time-sig 1 :pitch 28 :octave 1)))
  (assert-true
   (with-system tonal
     (cl-lily::but-a-fifth-apart (make-event :key '(C MAJOR) :time-sig 1 :pitch 0)
                                 (make-event :key '(C MAJOR) :time-sig 1 :pitch 5)))))

(define-test do-relative
  (assert-true
   (event-equal
    (list (make-event :key '(C MAJOR) :time-sig 1 :PITCH 0 :OCTAVE 2 :DUR 1/4 :start 0)
          (make-event :key '(C MAJOR) :time-sig 1 :PITCH 7 :OCTAVE 1 :DUR 1/4 :start 1/4)
          (make-event :key '(C MAJOR) :time-sig 1 :PITCH 0 :OCTAVE 2 :DUR 1/4 :start 1/2)
          (make-event :key '(C MAJOR) :time-sig 1 :PITCH 5 :OCTAVE 2 :DUR 1/4 :start 3/4)
          (make-event :key '(C MAJOR) :time-sig 1 :PITCH 0 :OCTAVE 2 :DUR 1/4 :start 1)
          (make-event :key '(C MAJOR) :time-sig 1 :PITCH 7 :OCTAVE 1 :DUR 1/4 :start 5/4)
          (make-event :key '(C MAJOR) :time-sig 1 :PITCH 0 :OCTAVE 2 :DUR 1/4 :start 3/2))
    
    (with-system tempered (get-parsed-notes-string "
\\score {
  \\new Staff \\relative c''{
    c g c f c g c
  }
}")))))

(lisp-unit:define-test make-note
  (assert-equal 0 (event-pitch (car (note-sequence-notas (make-note "c")))))
  (assert-equal nil (event-dur (car (note-sequence-notas (make-note "c")))))
  (assert-equal 0 (event-octave (car (note-sequence-notas (make-note "c")))))
  (assert-equal 0 (event-start (car (note-sequence-notas (make-note "c")))))
  )


(lisp-unit:define-test sequence-expressions
  (lisp-unit:assert-equal
   '(0 0 0 0 1/4 1/4 1/4 1/4 1/2 1/2 1/2 1/2)
   (mapcar
    #'event-start
    (note-sequence-notas
     (sequence-expressions
      (list
       (make-note-sequence
        :notas
        (list
         (make-event :key '(C MAJOR) :time-sig 1 :PITCH 0 :OCTAVE 10 :DUR 1/4 :start 0)
         (make-event :key '(C MAJOR) :time-sig 1 :PITCH 55 :OCTAVE 9 :DUR 1/4 :start 0)
         (make-event :key '(C MAJOR) :time-sig 1 :PITCH 28 :OCTAVE 9 :DUR 1/4 :start 0)
         (make-event :key '(C MAJOR) :time-sig 1 :PITCH 0 :OCTAVE 9 :DUR 1/4 :start 0))
        :start 0
        :dur 1/4)
       (make-note-sequence
        :notas
        (list
         (make-event :key '(C MAJOR) :time-sig 1 :PITCH 83 :OCTAVE 9 :DUR 1/4 :start 0)
         (make-event :key '(C MAJOR) :time-sig 1 :PITCH 55 :OCTAVE 9 :DUR 1/4 :start 0)
         (make-event :key '(C MAJOR) :time-sig 1 :PITCH 14 :OCTAVE 9 :DUR 1/4 :start 0)
         (make-event :key '(C MAJOR) :time-sig 1 :PITCH 55 :OCTAVE 8 :DUR 1/4 :start 0))
        :start 0
        :dur 1/4)
       (make-note-sequence
        :notas
        (list
         (make-event :key '(C MAJOR) :time-sig 1 :PITCH 0 :OCTAVE 10 :DUR 1/4 :start 0)
         (make-event :key '(C MAJOR) :time-sig 1 :PITCH 55 :OCTAVE 9 :DUR 1/4 :start 0)
         (make-event :key '(C MAJOR) :time-sig 1 :PITCH 28 :OCTAVE 9 :DUR 1/4 :start 0)
         (make-event :key '(C MAJOR) :time-sig 1 :PITCH 0 :OCTAVE 9 :DUR 1/4 :start 0))
        :start 0
        :dur 1/4)))))))

(define-test event-<
  (assert-true
   (event-< (make-event :key '(C MAJOR) :time-sig 1 :pitch 0 :octave 1)
                  (make-event :key '(C MAJOR) :time-sig 1 :pitch 0 :octave 2)))
  (assert-false
   (event-< (make-event :key '(C MAJOR) :time-sig 1 :pitch 0 :octave 2)
                  (make-event :key '(C MAJOR) :time-sig 1 :pitch 0 :octave 1)))
  (assert-false
   (event-< (make-event :key '(C MAJOR) :time-sig 1 :pitch 55 :octave 1)
                  (make-event :key '(C MAJOR) :time-sig 1 :pitch 14 :octave 1)))
  (assert-true
   (event-< (make-event :key '(C MAJOR) :time-sig 1 :pitch 55 :octave 1)
                  (make-event :key '(C MAJOR) :time-sig 1 :pitch 14 :octave 2))))

(define-test list-events
  (assert-equal
   '("c" "e" "g" "c")
   (list-events
    (list
     (make-event :key '(C MAJOR) :time-sig 1 :PITCH 0 :OCTAVE 10 :DUR 1/4 :start 0)
     (make-event :key '(C MAJOR) :time-sig 1 :PITCH 55 :OCTAVE 9 :DUR 1/4 :start 0)
     (make-event :key '(C MAJOR) :time-sig 1 :PITCH 28 :OCTAVE 9 :DUR 1/4 :start 0)
     (make-event :key '(C MAJOR) :time-sig 1 :PITCH 0 :OCTAVE 9 :DUR 1/4 :start 0)))))

(define-test pitches
  (assert-equal '(0 55 28 0) (pitches
                              (list
                               (make-event :key '(C MAJOR) :time-sig 1 :PITCH 0 :OCTAVE 10 :DUR 1/4 :start 0)
                               (make-event :key '(C MAJOR) :time-sig 1 :PITCH 55 :OCTAVE 9 :DUR 1/4 :start 0)
                               (make-event :key '(C MAJOR) :time-sig 1 :PITCH 28 :OCTAVE 9 :DUR 1/4 :start 0)
                               (make-event :key '(C MAJOR) :time-sig 1 :PITCH 0 :OCTAVE 9 :DUR 1/4 :start 0)))))


(define-test durations
  (assert-equal '(1/4) (durations
                     (list (list
                            (make-event :key '(C MAJOR) :time-sig 1 :PITCH 0 :OCTAVE 10 :DUR 1/4 :start 0)
                            (make-event :key '(C MAJOR) :time-sig 1 :PITCH 55 :OCTAVE 9 :DUR 1/4 :start 0)
                            (make-event :key '(C MAJOR) :time-sig 1 :PITCH 28 :OCTAVE 9 :DUR 1/4 :start 0)
                            (make-event :key '(C MAJOR) :time-sig 1 :PITCH 0 :OCTAVE 9 :DUR 1/4 :start 0))))))


                     

(define-test temperado
  (assert-equalp (list (list
                       (make-event :key '(C MAJOR) :time-sig 1 :PITCH 0 :OCTAVE 10 :DUR 1/4 :start 0)
                       (make-event :key '(C MAJOR) :time-sig 1 :PITCH 7 :OCTAVE 9 :DUR 1/4 :start 0)
                       (make-event :key '(C MAJOR) :time-sig 1 :PITCH 4 :OCTAVE 9 :DUR 1/4 :start 0)
                       (make-event :key '(C MAJOR) :time-sig 1 :PITCH 0 :OCTAVE 9 :DUR 1/4 :start 0)))
                (temperado (list (list
                       (make-event :key '(C MAJOR) :time-sig 1 :PITCH 0 :OCTAVE 10 :DUR 1/4 :start 0)
                       (make-event :key '(C MAJOR) :time-sig 1 :PITCH 55 :OCTAVE 9 :DUR 1/4 :start 0)
                       (make-event :key '(C MAJOR) :time-sig 1 :PITCH 28 :OCTAVE 9 :DUR 1/4 :start 0)
                       (make-event :key '(C MAJOR) :time-sig 1 :PITCH 0 :OCTAVE 9 :DUR 1/4 :start 0))))))