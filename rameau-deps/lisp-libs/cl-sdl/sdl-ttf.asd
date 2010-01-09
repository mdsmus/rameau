;;;; -*- Mode: Lisp -*-
;;;; Author: Matthew Danish <mrd@debian.org>
;;;; ASDF System Definition
(in-package #:asdf)

(defsystem sdl-ttf
    :components ((:module :sdl-ttf
                          :components ((:file "sdl-ttf"
                                              :depends-on ("lib"))
                                       (:file "lib")
                                       (:file "cl-sdl-ttf"
                                              :depends-on ("sdl-ttf")))))
    :depends-on (sdl sdl-ffi))

