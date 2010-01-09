;;;; -*- Mode: Lisp -*-
;;;; Authors: Matthew Danish <mrd@debian.org>
;;;;          Kenny Tilton
;;;; SDL TTF Lispy interface

(defpackage #:cl-sdl-ttf
  (:use #:common-lisp #:sdl-gl-uffi-macros #:sdl)
  (:export #:open-font
           #:size-text
           #:size-utf8
           #:size-unicode
           #:glyph-metrics
           #:render-solid-text
           #:with-solid-text))

(in-package #:cl-sdl-ttf)

(defun open-font (font-file point-size)
  "Opens string or pathname FONT-FILE at POINT-SIZE size.  Returns descriptor,
or NIL on failure."
  (let ((file (probe-file font-file)))
    (when file
      (maybe-null->nil
       (sdl-ttf:open-font (namestring file)
                          point-size)))))

(defun size-text (font text)
  "Returns width and height values for given FONT descriptor and TEXT string."
  (with-foreign-objects ((width int) (height int))
    (sdl-ttf:size-text font text width height)
    (values (deref-pointer width int)
            (deref-pointer height int))))

(defun size-utf8 (font text)
  "Returns width and height values for given FONT descriptor and TEXT UTF8
string."
  (with-foreign-objects ((width int) (height int))
    (sdl-ttf:size-utf8 font text width height)
    (values (deref-pointer width int)
            (deref-pointer height int))))

(defun size-unicode (font text)
  "Returns width and height values for given FONT descriptor and TEXT
UNICODE vector."
  (with-foreign-objects ((width int) (height int))
    (with-unicode-string (ustring text)
      (sdl-ttf:size-text font ustring width height)
      (values (deref-pointer width int)
              (deref-pointer height int)))))

(defun render-text-solid (font text r g b)
  "Renders TEXT to a returned surface with given FONT and colors R, G, B.
Color values are to be 0...255."
  (check-types r g b (unsigned-byte 8))
  (with-foreign-objects ((color color))
    (setf (color-r color) r
          (color-g color) g
          (color-b color) b)
    (maybe-null->nil
     (sdl-ttf:render-text-solid font text color))))

(defmacro with-solid-text ((surface-var font text r g b) &body body)
  `(let ((,surface-var (render-text-solid ,font ,text ,r ,g ,b)))
    (unwind-protect
         (progn (cond ((null ,surface-var)
                       (warn "RENDER-TEXT-SOLID failed, skipping: ~A" ',body))
                      (t ,@body)))
      (free-surface ,surface-var))))

(defun glyph-metrics (font char)
  "Returns minx, maxx, miny, maxy, and advance for the given FONT and
character CHAR."
  (with-foreign-objects ((minx int)
                         (maxx int)
                         (miny int)
                         (maxy int)
                         (advance int))
    (sdl-ttf:glyph-metrics font
                           (char-code char)
                           minx
                           maxx
                           miny
                           maxy
                           advance)
    (values (deref-pointer minx int)
            (deref-pointer maxx int)
            (deref-pointer miny int)
            (deref-pointer maxy int)
            (deref-pointer advance int))))
