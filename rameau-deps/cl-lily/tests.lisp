(in-package #:cl-lily)

(def-suite cl-lily :description "Tests for the parser file")
(in-suite cl-lily)

(test get-parsed-notes-string
  (is-true
   (event-equal
    (list
     (make-event :key '(C MAJOR) :time-sig 1 :PITCH 0 :OCTAVE 0 :DUR 1/4 :start 0)
     (make-event :key '(C MAJOR) :time-sig 1 :PITCH 0 :OCTAVE 0 :DUR 1/4 :start 0)
     (make-event :key '(C MAJOR) :time-sig 1 :PITCH 14 :OCTAVE 0 :DUR 1/4 :start 1/4)
     (make-event :key '(C MAJOR) :time-sig 1 :PITCH 14 :OCTAVE 0 :DUR 1/4 :start 1/4)
     (make-event :key '(C MAJOR) :time-sig 1 :PITCH 28 :OCTAVE 0 :DUR 1/4 :start 1/2)
     (make-event :key '(C MAJOR) :time-sig 1 :PITCH 28 :OCTAVE 0 :DUR 1/4 :start 1/2)
     (make-event :key '(C MAJOR) :time-sig 1 :PITCH 41 :OCTAVE 0 :DUR 1/4 :start 3/4)
     (make-event :key '(C MAJOR) :time-sig 1 :PITCH 41 :OCTAVE 0 :DUR 1/4 :start 3/4))
    (get-parsed-notes-string "\\score { <<
\\new Staff {  c d e f }
\\new Staff {  c d e f }
>> }")))
  (is-true
   (event-equal
    (list
     (make-event :key '(C MAJOR) :time-sig 1 :PITCH 55 :OCTAVE 1 :DUR 1/4 :start 0)
     (make-event :key '(C MAJOR) :time-sig 1 :PITCH 28 :OCTAVE 1 :DUR 1/4 :start 0)
     (make-event :key '(C MAJOR) :time-sig 1 :PITCH 0 :OCTAVE 1 :DUR 1/4 :start 0))
    (get-parsed-notes-string "<<
  \\new Staff \\relative c'' {
    g
  }
  \\new Staff \\relative c' {
    e
  }
  \\new Staff \\relative c' {
    c
  }
>>")))
  
  (is-true
   (event-equal
    (list
     (make-event :key '(C MAJOR) :time-sig 1 :PITCH 55 :OCTAVE 1 :DUR 1/4 :start 0)
     (make-event :key '(C MAJOR) :time-sig 1 :PITCH 28 :OCTAVE 1 :DUR 1/4 :start 0)
     (make-event :key '(C MAJOR) :time-sig 1 :PITCH 0 :OCTAVE 1 :DUR 1/4 :start 0))
   (get-parsed-notes-string
    "<<
  \\new Staff <<
    \\new Voice \\relative c'' {
      \\voiceOne
      g
    }
    \\new Voice \\relative c' {
      \\voiceTwo
      e
    }
  >>
  \\new Staff \\relative c' {
    \\clef bass
    c
  }
>>")))
  
  (is-true
   (event-equal
    (get-parsed-notes-string "
\\header {
  file = \"ex001.ly\"
  objetivo = \"tonica dominante tônica\"
}
\\score {
  <<
    \\new Staff {
      \\relative c'' {
        \\time 3/4
        c b c
      }
    }
    \\new Staff {
      \\relative c'' {
        \\time 3/4
        g g g
      }
    }
    \\new Staff {
      \\relative c' {
        \\time 3/4
        e d e
      }
    } % isso é um comentário
    \\new Staff {
      \\relative c' {
        \\time 3/4
        c g | c
      }
    }
  >>
}")
    (list (make-event :key '(C MAJOR) :time-sig "3/4" :PITCH 0 :OCTAVE 2 :DUR 1/4 :start 0)
          (make-event :key '(C MAJOR) :time-sig "3/4" :PITCH 55 :OCTAVE 1 :DUR 1/4 :start 0)
          (make-event :key '(C MAJOR) :time-sig "3/4" :PITCH 28 :OCTAVE 1 :DUR 1/4 :start 0)
          (make-event :key '(C MAJOR) :time-sig "3/4" :PITCH 0 :OCTAVE 1 :DUR 1/4 :start 0)
          (make-event :key '(C MAJOR) :time-sig "3/4" :PITCH 83 :OCTAVE 1 :DUR 1/4 :start 1/4)
          (make-event :key '(C MAJOR) :time-sig "3/4" :PITCH 55 :OCTAVE 1 :DUR 1/4 :start 1/4)
          (make-event :key '(C MAJOR) :time-sig "3/4" :PITCH 14 :OCTAVE 1 :DUR 1/4 :start 1/4)
          (make-event :key '(C MAJOR) :time-sig "3/4" :PITCH 55 :OCTAVE 0 :DUR 1/4 :start 1/4)
          (make-event :key '(C MAJOR) :time-sig "3/4" :PITCH 0 :OCTAVE 2 :DUR 1/4 :start 1/2)
          (make-event :key '(C MAJOR) :time-sig "3/4" :PITCH 55 :OCTAVE 1 :DUR 1/4 :start 1/2)
          (make-event :key '(C MAJOR) :time-sig "3/4" :PITCH 28 :OCTAVE 1 :DUR 1/4 :start 1/2)
          (make-event :key '(C MAJOR) :time-sig "3/4" :PITCH 0 :OCTAVE 1 :DUR 1/4 :start 1/2))))
  (is-true
   (event-equal
    (get-parsed-notes-string "{ foo = { c d e} \\foo }")
   (list
    (make-event :key '(C MAJOR) :time-sig 1 :PITCH 0 :OCTAVE 0 :DUR 1/4 :start 0)
    (make-event :key '(C MAJOR) :time-sig 1 :PITCH 14 :OCTAVE 0 :DUR 1/4 :start 1/4)
    (make-event :key '(C MAJOR) :time-sig 1 :PITCH 28 :OCTAVE 0 :DUR 1/4 :start 1/2))))
  (is-true
   (event-equal
    (get-parsed-notes-string "{ foo = { c } \\foo foo = { d } \\foo }")
    (list
     (make-event :key '(C MAJOR) :time-sig 1 :PITCH 0 :OCTAVE 0 :DUR 1/4 :start 0)
     (make-event :key '(C MAJOR) :time-sig 1 :PITCH 14 :OCTAVE 0 :DUR 1/4 :start 1/4))))
  )


(test correct-times
  (is (equal
    (event-dur (make-event :key '(C MAJOR) :time-sig 1 :PITCH 0 :OCTAVE 0 :DUR 9/2 :start 0))
    (let ((nota (make-event :key '(C MAJOR) :time-sig 1 :PITCH 0 :OCTAVE 0 :DUR 3 :start 0)))
      (correct-times 3/2 nota)
      (event-dur nota)))))

(test correct-durations
  (is (equal
    '(4 4 4 8 8)
    (let ((notas
           (list
            (make-event :key '(C MAJOR) :time-sig 1 :pitch 1
                        :octave 1
                        :start 0
                        :dur 4)
            (make-event :key '(C MAJOR) :time-sig 1 :pitch 2
                        :octave 1
                        :start 0
                        :dur 0)
            (make-event :key '(C MAJOR) :time-sig 1 :pitch 3
                        :octave 1
                        :start 0
                        :dur 0)
            (make-event :key '(C MAJOR) :time-sig 1 :pitch 3
                        :octave 1
                        :start 0
                        :dur 8)
            (make-event :key '(C MAJOR) :time-sig 1 :pitch 4
                        :octave 1
                        :start 0
                        :dur 0))))
      (correct-durations notas)
      (mapcar #'event-dur notas)))))

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
