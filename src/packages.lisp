(in-package :cl-user)

(defpackage #:rameau
  ;;(:export #:emite-evento)
  (:use #:cl))

(defpackage #:rameau-test
  (:use #:cl #:rameau)
  (:export #:test))
