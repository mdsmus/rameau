;;;; -*- Mode: Lisp -*-
;;;; Author: Matthew Danish <mrd@debian.org>
;;;; SDL TTF FFI

(defpackage #:sdl-ttf
  (:use #:common-lisp #:sdl-gl-uffi-macros #:sdl)
  (:shadow #:init #:quit)
  (:nicknames #:ttf)
  (:export #:sdl-ttf)
  (:documentation "Simple DirectMedia Layer binding"))

(in-package #:sdl-ttf)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (def-library-properties sdl-ttf ("SDL_ttf" "libSDL_ttf")
    :depends-on (sdl)
    :module sdl-ttf)

  (def-library-properties sdlttfstub ("sdlttfstub")
    :depends-on (sdl-ttf)
    :module sdl-ttf-stub)
  
  (load-defined-foreign-library 'sdlttfstub))
