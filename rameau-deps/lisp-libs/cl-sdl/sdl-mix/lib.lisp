;;;; -*- Mode: Lisp -*-
;;;; Author: Matthew Danish <mrd@debian.org>
;;;; SDL Mixer FFI

(defpackage #:sdl-mixer
  (:use #:common-lisp #:sdl-gl-uffi-macros #:sdl)
  (:nicknames #:sdl-mix #:mix)
  (:export #:sdl-mixer)
  (:documentation "Simple DirectMedia Layer binding"))

(in-package #:sdl-mixer)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (def-library-properties sdl-mixer ("SDL_mixer" "libSDL_mixer")
    :depends-on (sdl)
    :module sdl-mixer)
  (load-defined-foreign-library 'sdl-mixer))

