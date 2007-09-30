(in-package #:rameau)
(use-package :lisp-unit)

(define-test cifra->acorde
  (assert-equal '(c maj 0 7+) (cifra->acorde 'C7M)))
