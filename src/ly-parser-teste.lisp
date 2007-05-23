(use-package :lisp-unit)

(define-test number-of-accidentals
   (assert-equal 1 (number-of-accidentals "cis"))
   (assert-equal 2 (number-of-accidentals "cisis"))
   (assert-equal 5 (number-of-accidentals "cisisisisis"))
   (assert-equal 0 (number-of-accidentals "c"))
   (assert-equal -1 (number-of-accidentals "ces"))
   (assert-equal -2 (number-of-accidentals "ceses"))
   (assert-equal -5 (number-of-accidentals "ceseseseses"))
   )

(define-test note-number
  (assert-equal 0  (note-number #\c *tonal*))
  (assert-equal 14 (note-number #\d *tonal*))
  (assert-equal 83 (note-number #\b *tonal*))
  (assert-equal 0  (note-number #\c *tempered*))
  (assert-equal 2  (note-number #\d *tempered*))
  (assert-equal 11 (note-number #\b *tempered*))
  )

(define-test note-from-string
  (assert-equal 0  (note-from-string "c"))
  (assert-equal 14 (note-from-string "d"))
  (assert-equal 1  (note-from-string "cis"))
  (assert-equal 0  (note-from-string "c" *tempered*))
  (assert-equal 2  (note-from-string "d" *tempered*))
  (assert-equal 1  (note-from-string "cis" *tempered*))
  )

(define-test octave-from-string
  (assert-equal 8  (octave-from-string ""))
  (assert-equal 7  (octave-from-string ","))
  (assert-equal 6  (octave-from-string ",,"))
  (assert-equal 9  (octave-from-string "'"))
  (assert-equal 10 (octave-from-string "''"))
  )

(define-test cria-nota
  (assert-equal 0 (evento-pitch (cria-nota "c")))
  (assert-equal nil (evento-dur (cria-nota "c")))
  (assert-equal 8 (evento-octave (cria-nota "c")))
  (assert-equal 0 (evento-inicio (cria-nota "c")))
  )


(define-test parser
  (assert-equalp
   (list
    (make-evento :PITCH 0 :OCTAVE 8 :DUR 1/4 :INICIO 0)
    (make-evento :PITCH 0 :OCTAVE 8 :DUR 1/4 :INICIO 0)
    (make-evento :PITCH 14 :OCTAVE 8 :DUR 1/4 :INICIO 1/4)
    (make-evento :PITCH 14 :OCTAVE 8 :DUR 1/4 :INICIO 1/4)
    (make-evento :PITCH 28 :OCTAVE 8 :DUR 1/4 :INICIO 1/2)
    (make-evento :PITCH 28 :OCTAVE 8 :DUR 1/4 :INICIO 1/2)
    (make-evento :PITCH 41 :OCTAVE 8 :DUR 1/4 :INICIO 3/4)
    (make-evento :PITCH 41 :OCTAVE 8 :DUR 1/4 :INICIO 3/4))
   (parse-string "\\score { <<
\\new Staff { c d e f }
\\new Staff { c d e f }
>> }")))


;(run-tests number-of-accidentals)
;(run-tests note-number)
;(run-tests note-from-string)
;(run-tests octave-from-string)
;(run-tests cria-nota)
;(run-tests parser)

(run-tests)

