(in-package :rameau-test)

(defsuite format "Tests for the format file")
(in-suite format)

(test event-end
  (is (=
       1
       (event-end (make-event :key '(C MAJOR) :time-sig 1 :start 1/2 :dur 1/2)))))

(test but-a-fifth-apart
  (is-true
   (cl-lily::but-a-fifth-apart (make-event :key '(C MAJOR) :time-sig 1 :pitch 0 :octave 0)
                                (make-event :key '(C MAJOR) :time-sig 1 :pitch 28 :octave 0)))
  (is-true
   (cl-lily::but-a-fifth-apart (make-event :key '(C MAJOR) :time-sig 1 :pitch 0 :octave 0)
                               (make-event :key '(C MAJOR) :time-sig 1 :pitch 28 :octave 1)))
  (is-false
   (cl-lily::but-a-fifth-apart (make-event :key '(C MAJOR) :time-sig 1 :pitch 55 :octave 1)
                               (make-event :key '(C MAJOR) :time-sig 1 :pitch 28 :octave 1)))
  (is-true
   (with-system tonal
     (cl-lily::but-a-fifth-apart (make-event :key '(C MAJOR) :time-sig 1 :pitch 0)
                                 (make-event :key '(C MAJOR) :time-sig 1 :pitch 5)))))

(test do-relative
  (is-true
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

(test make-note
  (is (= 0 (event-pitch (car (note-sequence-notas (make-note "c"))))))
  (is (eql nil (event-dur (car (note-sequence-notas (make-note "c"))))))
  (is (= 0 (event-octave (car (note-sequence-notas (make-note "c"))))))
  (is (= 0 (event-start (car (note-sequence-notas (make-note "c"))))))
  )


(test sequence-expressions
  (equal
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

(test event-<
  (is-true
   (event-< (make-event :key '(C MAJOR) :time-sig 1 :pitch 0 :octave 1)
                  (make-event :key '(C MAJOR) :time-sig 1 :pitch 0 :octave 2)))
  (is-false
   (event-< (make-event :key '(C MAJOR) :time-sig 1 :pitch 0 :octave 2)
                  (make-event :key '(C MAJOR) :time-sig 1 :pitch 0 :octave 1)))
  (is-false
   (event-< (make-event :key '(C MAJOR) :time-sig 1 :pitch 55 :octave 1)
                  (make-event :key '(C MAJOR) :time-sig 1 :pitch 14 :octave 1)))
  (is-true
   (event-< (make-event :key '(C MAJOR) :time-sig 1 :pitch 55 :octave 1)
                  (make-event :key '(C MAJOR) :time-sig 1 :pitch 14 :octave 2))))

(test list-events
  (is (equal
    '("c" "e" "g" "c")
    (list-events
     (list
      (make-event :key '(C MAJOR) :time-sig 1 :PITCH 0 :OCTAVE 10 :DUR 1/4 :start 0)
      (make-event :key '(C MAJOR) :time-sig 1 :PITCH 55 :OCTAVE 9 :DUR 1/4 :start 0)
      (make-event :key '(C MAJOR) :time-sig 1 :PITCH 28 :OCTAVE 9 :DUR 1/4 :start 0)
      (make-event :key '(C MAJOR) :time-sig 1 :PITCH 0 :OCTAVE 9 :DUR 1/4 :start 0))))))

(test pitches
  (is (equal '(0 55 28 0) (pitches
                               (list
                                (make-event :key '(C MAJOR) :time-sig 1 :PITCH 0 :OCTAVE 10 :DUR 1/4 :start 0)
                                (make-event :key '(C MAJOR) :time-sig 1 :PITCH 55 :OCTAVE 9 :DUR 1/4 :start 0)
                                (make-event :key '(C MAJOR) :time-sig 1 :PITCH 28 :OCTAVE 9 :DUR 1/4 :start 0)
                                (make-event :key '(C MAJOR) :time-sig 1 :PITCH 0 :OCTAVE 9 :DUR 1/4 :start 0))))))


(test durations
  (is (equal '(1/4) (durations
                         (list (list
                                (make-event :key '(C MAJOR) :time-sig 1 :PITCH 0 :OCTAVE 10 :DUR 1/4 :start 0)
                                (make-event :key '(C MAJOR) :time-sig 1 :PITCH 55 :OCTAVE 9 :DUR 1/4 :start 0)
                                (make-event :key '(C MAJOR) :time-sig 1 :PITCH 28 :OCTAVE 9 :DUR 1/4 :start 0)
                                (make-event :key '(C MAJOR) :time-sig 1 :PITCH 0 :OCTAVE 9 :DUR 1/4 :start 0)))))))


                     

(test temperado
  (is (equalp (list (list
                         (make-event :key '(C MAJOR) :time-sig 1 :PITCH 0 :OCTAVE 10 :DUR 1/4 :start 0)
                         (make-event :key '(C MAJOR) :time-sig 1 :PITCH 7 :OCTAVE 9 :DUR 1/4 :start 0)
                         (make-event :key '(C MAJOR) :time-sig 1 :PITCH 4 :OCTAVE 9 :DUR 1/4 :start 0)
                         (make-event :key '(C MAJOR) :time-sig 1 :PITCH 0 :OCTAVE 9 :DUR 1/4 :start 0)))
                  (temperado (list (list
                                    (make-event :key '(C MAJOR) :time-sig 1 :PITCH 0 :OCTAVE 10 :DUR 1/4 :start 0)
                                    (make-event :key '(C MAJOR) :time-sig 1 :PITCH 55 :OCTAVE 9 :DUR 1/4 :start 0)
                                    (make-event :key '(C MAJOR) :time-sig 1 :PITCH 28 :OCTAVE 9 :DUR 1/4 :start 0)
                                    (make-event :key '(C MAJOR) :time-sig 1 :PITCH 0 :OCTAVE 9 :DUR 1/4 :start 0)))))))
