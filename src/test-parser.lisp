(in-package #:rameau)

(lisp-unit:define-test parse-string
  (lisp-unit:assert-true
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
    (parse-string "\\score { <<
\\new Staff { c d e f }
\\new Staff { c d e f }
>> }")))
  (lisp-unit:assert-true
   (event-equal
    (list
     (make-event :key '(C MAJOR) :time-sig 1 :PITCH 55 :OCTAVE 1 :DUR 1/4 :start 0)
     (make-event :key '(C MAJOR) :time-sig 1 :PITCH 28 :OCTAVE 1 :DUR 1/4 :start 0)
     (make-event :key '(C MAJOR) :time-sig 1 :PITCH 0 :OCTAVE 1 :DUR 1/4 :start 0))
    (parse-string "<<
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
  
  (lisp-unit:assert-true
   (event-equal
    (list
     (make-event :key '(C MAJOR) :time-sig 1 :PITCH 55 :OCTAVE 1 :DUR 1/4 :start 0)
     (make-event :key '(C MAJOR) :time-sig 1 :PITCH 28 :OCTAVE 1 :DUR 1/4 :start 0)
     (make-event :key '(C MAJOR) :time-sig 1 :PITCH 0 :OCTAVE 1 :DUR 1/4 :start 0))
   (parse-string
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
  
  (lisp-unit:assert-true
   (event-equal
    (parse-string "
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
  (lisp-unit:assert-true
   (event-equal
    (parse-string "{ foo = { c d e} \\foo }")
   (list
    (make-event :key '(C MAJOR) :time-sig 1 :PITCH 0 :OCTAVE 0 :DUR 1/4 :start 0)
    (make-event :key '(C MAJOR) :time-sig 1 :PITCH 14 :OCTAVE 0 :DUR 1/4 :start 1/4)
    (make-event :key '(C MAJOR) :time-sig 1 :PITCH 28 :OCTAVE 0 :DUR 1/4 :start 1/2))))
  (lisp-unit:assert-true
   (event-equal
    (parse-string "{ foo = { c } \\foo foo = { d } \\foo }")
    (list
     (make-event :key '(C MAJOR) :time-sig 1 :PITCH 0 :OCTAVE 0 :DUR 1/4 :start 0)
     (make-event :key '(C MAJOR) :time-sig 1 :PITCH 14 :OCTAVE 0 :DUR 1/4 :start 1/4))))
  )


(lisp-unit:define-test correct-times
  (lisp-unit:assert-equal
   (event-dur (make-event :key '(C MAJOR) :time-sig 1 :PITCH 0 :OCTAVE 0 :DUR 9/2 :start 0))
   (let ((nota (make-event :key '(C MAJOR) :time-sig 1 :PITCH 0 :OCTAVE 0 :DUR 3 :start 0)))
     (correct-times 3/2 nota)
     (event-dur nota))))

(lisp-unit:define-test correct-durations
  (lisp-unit:assert-equal
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
                        :dur nil)
           (make-event :key '(C MAJOR) :time-sig 1 :pitch 3
                        :octave 1
                        :start 0
                        :dur nil)
           (make-event :key '(C MAJOR) :time-sig 1 :pitch 3
                        :octave 1
                        :start 0
                        :dur 8)
           (make-event :key '(C MAJOR) :time-sig 1 :pitch 4
                        :octave 1
                        :start 0
                        :dur nil))))
     (correct-durations notas)
     (mapcar #'event-dur notas))))

