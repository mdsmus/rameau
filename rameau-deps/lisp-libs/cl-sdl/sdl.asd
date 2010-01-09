;;;; -*- Mode: Lisp -*-
;;;; Author: Matthew Danish <mrd@debian.org>
;;;; ASDF System Definition

(in-package #:asdf)

(defsystem sdl
    :components ((:module :sdl
                          :components
                          ((:file "sdl")
                           (:file "util"
                                  :depends-on ("sdl"))
                           (:file "sdl-ext"
                                  :depends-on ("sdl"
                                               "util"))
                           (:file "cl-sdl"
                                  :depends-on ("sdl"
                                               "sdl-ext")))))
    :depends-on (sdl-ffi))


