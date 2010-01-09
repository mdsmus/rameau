;;;; -*- Mode: Lisp -*-
;;;; Author: Matthew Danish <mrd@debian.org>
;;;; OpenGL ASDF System Definition

(in-package #:asdf)

(defsystem opengl
    :components ((:module :opengl
                          :components
                          ((:file "gl")
                           (:file "gl-ext"
                                  :depends-on ("gl"))
                           (:file "glu"
                                  :depends-on ("gl")))))
    :depends-on (sdl sdl-ffi))

