(in-package #:rameau)
(use-package :lisp-unit)

(define-test pop2cifra
  (assert-equal '(* 2 (("c" "maj" 0) ("c" "maj" 0 "7"))) (pop2cifra 'c--7))
  (assert-equal (format nil "(c maj 0)~%(c maj 3 7)") (pop2cifra 'c__7))
  (assert-equal (format nil "(c maj 0)~%(c maj 0 7)") (pop2cifra 'c==7))
  (assert-equal  '(* 2 (("c" "maj" 0) ("c" "maj" 3 "7"))) (pop2cifra 'c_-7)))