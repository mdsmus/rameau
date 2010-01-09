;;;; -*- Mode: Lisp -*-
;;;; Author: Matthew Danish <mrd@debian.org>
;;;; SDL Image FFI

(defpackage #:sdl-image
  (:use #:common-lisp #:sdl-gl-uffi-macros)
  (:shadow #:load)
  (:nicknames #:sdl-img #:img)
  (:export #:sdl-image)
  (:documentation "Simple DirectMedia Layer binding"))

(in-package #:sdl-image)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (def-library-properties sdl-image ("SDL_image" "libSDL_image")
    :depends-on (sdl:sdl)
    :module sdl-image)

  (load-defined-foreign-library 'sdl-image))
