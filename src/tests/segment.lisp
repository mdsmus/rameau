(in-package #:rameau)

(def-suite segment :description "Tests for the segment file" :in all)
(in-suite segment)

(test sonorities
  (is (equalp
    (sonorities
     (list (make-event :PITCH 0 :OCTAVE 10 :DUR 1/4 :start 0)
           (make-event :PITCH 55 :OCTAVE 9 :DUR 1/4 :start 0)
           (make-event :PITCH 28 :OCTAVE 9 :DUR 1/4 :start 0)
           (make-event :PITCH 0 :OCTAVE 9 :DUR 1/4 :start 0)
           (make-event :PITCH 83 :OCTAVE 9 :DUR 1/4 :start 1/4)
           (make-event :PITCH 55 :OCTAVE 9 :DUR 1/4 :start 1/4)
           (make-event :PITCH 14 :OCTAVE 9 :DUR 1/4 :start 1/4)
           (make-event :PITCH 55 :OCTAVE 8 :DUR 1/4 :start 1/4)
           (make-event :PITCH 0 :OCTAVE 10 :DUR 1/4 :start 1/2)
           (make-event :PITCH 55 :OCTAVE 9 :DUR 1/4 :start 1/2)
           (make-event :PITCH 28 :OCTAVE 9 :DUR 1/4 :start 1/2)
           (make-event :PITCH 0 :OCTAVE 9 :DUR 1/4 :start 1/2)))
    (list
     (list (make-event :PITCH 0 :OCTAVE 10 :DUR 1/4 :start 0)
           (make-event :PITCH 55 :OCTAVE 9 :DUR 1/4 :start 0)
           (make-event :PITCH 28 :OCTAVE 9 :DUR 1/4 :start 0)
           (make-event :PITCH 0 :OCTAVE 9 :DUR 1/4 :start 0))
     (list (make-event :PITCH 83 :OCTAVE 9 :DUR 1/4 :start 1/4)
           (make-event :PITCH 55 :OCTAVE 9 :DUR 1/4 :start 1/4)
           (make-event :PITCH 14 :OCTAVE 9 :DUR 1/4 :start 1/4)
           (make-event :PITCH 55 :OCTAVE 8 :DUR 1/4 :start 1/4))
     (list (make-event :PITCH 0 :OCTAVE 10 :DUR 1/4 :start 1/2)
           (make-event :PITCH 55 :OCTAVE 9 :DUR 1/4 :start 1/2)
           (make-event :PITCH 28 :OCTAVE 9 :DUR 1/4 :start 1/2)
           (make-event :PITCH 0 :OCTAVE 9 :DUR 1/4 :start 1/2))))))

