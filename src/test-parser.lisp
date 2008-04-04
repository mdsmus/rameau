(in-package #:rameau)

(lisp-unit:define-test parse-string
  (lisp-unit:assert-equalp
   (list
    (make-evento :key nil :time-sig nil :PITCH 0 :OCTAVE 8 :DUR 1/4 :INICIO 0)
    (make-evento :key nil :time-sig nil :PITCH 0 :OCTAVE 8 :DUR 1/4 :INICIO 0)
    (make-evento :key nil :time-sig nil :PITCH 14 :OCTAVE 8 :DUR 1/4 :INICIO 1/4)
    (make-evento :key nil :time-sig nil :PITCH 14 :OCTAVE 8 :DUR 1/4 :INICIO 1/4)
    (make-evento :key nil :time-sig nil :PITCH 28 :OCTAVE 8 :DUR 1/4 :INICIO 1/2)
    (make-evento :key nil :time-sig nil :PITCH 28 :OCTAVE 8 :DUR 1/4 :INICIO 1/2)
    (make-evento :key nil :time-sig nil :PITCH 41 :OCTAVE 8 :DUR 1/4 :INICIO 3/4)
    (make-evento :key nil :time-sig nil :PITCH 41 :OCTAVE 8 :DUR 1/4 :INICIO 3/4))
   (parse-string "\\score { <<
\\new Staff { c d e f }
\\new Staff { c d e f }
>> }"))
  (lisp-unit:assert-equalp
   (list
    (make-evento :key nil :time-sig nil :PITCH 55 :OCTAVE 9 :DUR 1/4 :INICIO 0)
    (make-evento :key nil :time-sig nil :PITCH 28 :OCTAVE 9 :DUR 1/4 :INICIO 0)
    (make-evento :key nil :time-sig nil :PITCH 0 :OCTAVE 9 :DUR 1/4 :INICIO 0))
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
>>"))
  (lisp-unit:assert-equalp
   (list
    (make-evento :key nil :time-sig nil :PITCH 55 :OCTAVE 9 :DUR 1/4 :INICIO 0)
    (make-evento :key nil :time-sig nil :PITCH 28 :OCTAVE 9 :DUR 1/4 :INICIO 0)
    (make-evento :key nil :time-sig nil :PITCH 0 :OCTAVE 9 :DUR 1/4 :INICIO 0))
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
>>"))
  (lisp-unit:assert-equalp
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
   (list (make-evento :key nil :time-sig nil :PITCH 0 :OCTAVE 10 :DUR 1/4 :INICIO 0)
         (make-evento :key nil :time-sig nil :PITCH 55 :OCTAVE 9 :DUR 1/4 :INICIO 0)
         (make-evento :key nil :time-sig nil :PITCH 28 :OCTAVE 9 :DUR 1/4 :INICIO 0)
         (make-evento :key nil :time-sig nil :PITCH 0 :OCTAVE 9 :DUR 1/4 :INICIO 0)
         (make-evento :key nil :time-sig nil :PITCH 83 :OCTAVE 9 :DUR 1/4 :INICIO 1/4)
         (make-evento :key nil :time-sig nil :PITCH 55 :OCTAVE 9 :DUR 1/4 :INICIO 1/4)
         (make-evento :key nil :time-sig nil :PITCH 14 :OCTAVE 9 :DUR 1/4 :INICIO 1/4)
         (make-evento :key nil :time-sig nil :PITCH 55 :OCTAVE 8 :DUR 1/4 :INICIO 1/4)
         (make-evento :key nil :time-sig nil :PITCH 0 :OCTAVE 10 :DUR 1/4 :INICIO 1/2)
         (make-evento :key nil :time-sig nil :PITCH 55 :OCTAVE 9 :DUR 1/4 :INICIO 1/2)
         (make-evento :key nil :time-sig nil :PITCH 28 :OCTAVE 9 :DUR 1/4 :INICIO 1/2)
         (make-evento :key nil :time-sig nil :PITCH 0 :OCTAVE 9 :DUR 1/4 :INICIO 1/2)))
  (lisp-unit:assert-equalp
   (parse-string "{ foo = { c d e} \\foo }")
   (list
    (make-evento :key nil :time-sig nil :PITCH 0 :OCTAVE 8 :DUR 1/4 :INICIO 0)
    (make-evento :key nil :time-sig nil :PITCH 14 :OCTAVE 8 :DUR 1/4 :INICIO 1/4)
    (make-evento :key nil :time-sig nil :PITCH 28 :OCTAVE 8 :DUR 1/4 :INICIO 1/2)))
  (lisp-unit:assert-equalp
   (parse-string "{ foo = { c } \\foo foo = { d } \\foo }")
   (list
    (make-evento :key nil :time-sig nil :PITCH 0 :OCTAVE 8 :DUR 1/4 :INICIO 0)
    (make-evento :key nil :time-sig nil :PITCH 14 :OCTAVE 8 :DUR 1/4 :INICIO 1/4)))
  )


(lisp-unit:define-test acerta-times
  (lisp-unit:assert-equal
   (evento-dur (make-evento :key nil :time-sig nil :PITCH 0 :OCTAVE 8 :DUR 9/2 :INICIO 0))
   (let ((nota (make-evento :key nil :time-sig nil :PITCH 0 :OCTAVE 8 :DUR 3 :INICIO 0)))
     (acerta-times 3/2 nota)
     (evento-dur nota))))

(lisp-unit:define-test ajusta-duracao
  (lisp-unit:assert-equal
   '(4 4 4 8 8)
   (let ((notas
          (list
           (make-evento :key nil :time-sig nil :pitch 1
                        :octave 1
                        :inicio 0
                        :dur 4)
           (make-evento :key nil :time-sig nil :pitch 2
                        :octave 1
                        :inicio 0
                        :dur nil)
           (make-evento :key nil :time-sig nil :pitch 3
                        :octave 1
                        :inicio 0
                        :dur nil)
           (make-evento :key nil :time-sig nil :pitch 3
                        :octave 1
                        :inicio 0
                        :dur 8)
           (make-evento :key nil :time-sig nil :pitch 4
                        :octave 1
                        :inicio 0
                        :dur nil))))
     (ajusta-duracao notas)
     (mapcar #'evento-dur notas))))

(lisp-unit:define-test do-nothing
  (lisp-unit:assert-false (do-nothing "vlA")))

(lisp-unit:define-test empty-octave
  (lisp-unit:assert-equal
   ""
   (empty-octave)))
