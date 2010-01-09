;;;; -*- Mode: Lisp -*-
;;;; Author: Matthew Danish <mrd@debian.org>
;;;; ASDF System Definition
(in-package #:asdf)

(defsystem sdl-mix
    :components ((:module :sdl-mix
                          :components ((:file "sdl-mix"
                                              :depends-on ("lib"))
                                       (:file "lib"))))
    :depends-on (sdl sdl-ffi))
