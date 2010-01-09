;;;; -*- Mode: Lisp -*-
;;;; Author: Matthew Danish <mrd@debian.org>
;;;; SDL Image FFI

(in-package #:sdl-image)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (in-module sdl-image)
  (defparameter *supported-types*
    '(#+nil "TGA"
      "BMP" "PNM" "XPM" "XCF" "PCX" "GIF" "JPG" "TIF" "LBM" "PNG")))

;; TGA is supported, but not fully.  There is no IMG_isTGA function.

(def-foreign-routine ("IMG_Load" load) (:struct-pointer sdl:surface)
  (file c-string))

(def-foreign-routine ("IMG_Load_RW" load-rw) (:struct-pointer sdl:surface)
  (src sdl:rwops*)
  (freesrc int))

(def-foreign-routine ("IMG_LoadTyped_RW" load-typed-rw)
    (:struct-pointer sdl:surface)
  (src sdl:rwops*)
  (freesrc int)
  (type c-string))

(def-foreign-routine ("IMG_ReadXPMFromArray" read-xpm-from-array)
    (:struct-pointer sdl:surface)
  (xpm (* (* :unsigned-char))))

(def-foreign-routine ("IMG_LoadTGA_RW" load-tga-rw)
    (:struct-pointer sdl:surface)
  (src sdl:rwops*))

(defmacro def-img-routine ((c-name-str lisp-name-str) ret-type &rest args)
  `(progn
    ,@(loop for type in *supported-types* collect
            (let ((c-name (format nil c-name-str type))
                  (lisp-name (intern (string-upcase (format nil
                                                            lisp-name-str
                                                            type)))))
              `(def-foreign-routine (,c-name ,lisp-name) ,ret-type
                ,@args)))))

(def-img-routine ("IMG_Load~A_RW" "load-~A-rw")
    (:struct-pointer sdl:surface)
  (src sdl:rwops*))

(def-img-routine ("IMG_is~A" "is-~A")
    (:struct-pointer sdl:surface)
  (src sdl:rwops*))
