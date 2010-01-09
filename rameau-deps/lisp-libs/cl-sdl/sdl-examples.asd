;;;; -*- Mode: Lisp -*-
;;;; Author: Matthew Danish <mrd@debian.org>
;;;; ASDF System Definition
(in-package #:asdf)

(defsystem sdl-examples
    :components ((:module :examples
                          :components
                          ((:file "2d-test"
                                  :depends-on ("data"))
                           (:file "example1")
                           
                           (:file "data"))))
    :depends-on (sdl))


