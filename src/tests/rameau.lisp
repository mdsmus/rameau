(in-package :rameau-test)

(def-suite rameau :description "Tests for the rameau file" :in all)
(in-suite rameau)

(test files-range
  (is (equal '("001" "002" "003") (files-range '("1" "3")))))

(test extract-diff
  (is (= 10 (extract-diff (list (make-event :pitch 10 :octave 0) (make-event :pitch 20 :octave 10))))))

(test extract-feature-list
  (is (equal '(1/2 0 0 0 0 0 0 0 0 0 1/2 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                   0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                   0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
                 (extract-feature-list (list (make-event :pitch 10 :octave 0) (make-event :pitch 20 :octave 10)) 10))))



