;;;; -*- Mode: Lisp -*-
;;;; Author: Matthew Danish <mrd@debian.org>
;;;; ASDF System Definition
(in-package #:asdf)

(defsystem sdl-img
    :components ((:module :sdl-img
                          :components ((:file "sdl-img"
                                              :depends-on ("lib"))
                                       (:file "lib"))))
    :depends-on (sdl sdl-ffi))
