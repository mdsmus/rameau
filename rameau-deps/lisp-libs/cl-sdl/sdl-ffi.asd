;;;; -*- Mode: Lisp -*-
;;;; Author: Matthew Danish <mrd@debian.org>
;;;; ASDF System Definition

(in-package #:asdf)

(defsystem sdl-ffi
    :components ((:module :ffi
                          :components ((:file "uffi"))))
    :depends-on (uffi))
