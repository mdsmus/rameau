(defpackage :cl-op
  (:use :cl)
  (:export #:op
           #:op*))
           
(defpackage :cl-op.hof
  (:use :cl)
  (:export #:flip
           #:disjoin
           #:conjoin
           #:compose
           #:generator))
