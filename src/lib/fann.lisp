;; Wrapper da biblioteca de redes neurais FANN para a FFI do sbcl

(defpackage :fann
  (:use :cl :uffi))

(in-package :fann)


(load-foreign-library "libfann.so")




