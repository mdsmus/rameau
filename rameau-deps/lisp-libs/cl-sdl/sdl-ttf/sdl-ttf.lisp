;;;; -*- Mode: Lisp -*-
;;;; Authors: Matthew Danish <mrd@debian.org>
;;;;          Kenny Tilton
;;;; SDL TTF FFI

(in-package #:sdl-ttf)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (in-module sdl-ttf))

(def-foreign-constant +style-normal+ 0)
(def-foreign-constant +style-bold+ 1)
(def-foreign-constant +style-italic+ 2)
(def-foreign-constant +style-underline+ 4)

(def-foreign-type font* (* void))


(def-foreign-routine ("TTF_Init" init) int)

(def-foreign-routine ("TTF_OpenFont" open-font) (* void)
  (file c-string)
  (ptsize int))

;;; Set and retrieve the font style
;;; This font style is implemented by modifying the font glyphs, and
;;; doesn't reflect any inherent properties of the truetype font file.

(def-foreign-routine ("TTF_GetFontStyle" get-font-style) int
  (font font*))

(def-foreign-routine ("TTF_SetFontStyle" set-font-style) void
  (font font*)
  (style int))

(def-foreign-routine ("TTF_FontHeight" font-height) int
  (font font*))

;;; Get the offset from the baseline to the top of the font
;;; This is a positive value, relative to the baseline.
(def-foreign-routine ("TTF_FontAscent" font-ascent) int
  (font font*))

;;; Get the offset from the baseline to the bottom of the font
;;; This is a negative value, relative to the baseline.
(def-foreign-routine ("TTF_FontDescent" font-descent) int
  (font font*))

;;; Get the recommended spacing between lines of text for this font
(def-foreign-routine ("TTF_FontLineSkip" font-line-skip) int
  (font font*))

;;; Get the metrics (dimensions) of a glyph
(def-foreign-routine ("TTF_GlyphMetrics" glyph-metrics) int
  (font font*)
  (character uint16)
  (minx (* int))
  (maxx (* int))
  (miny (* int))
  (maxy (* int))
  (advance (* int)))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defparameter *font-types*
    '("Text" "UTF8" "UNICODE"))
  (defun unicode-c-string (args)
    (cond ((atom args)
           (if (eql 'c-string args)
               '(* uint16)
               args))
          ((consp args)
           (mapcar #'unicode-c-string args)))))

(macrolet ((frob (cname lispname module ret-type &rest args)
             `(progn
               ,@(loop for type in *font-types* collecting
                       (let ((c (format nil cname type))
                             (l (intern (string-upcase (format nil
                                                               lispname
                                                               type)))))
                         
                         `(def-foreign-routine (,c ,l :module ,module)
                           ,ret-type
                           ,@(if (equal "UNICODE" type)
                                 (unicode-c-string args)
                                 args)))))))
  (frob "TTF_Size~A" "size-~A" sdl-ttf int
        (font font*)
        (text c-string)
        (width (* int))
        (height (* int)))
  (frob "render_~A_solid" "render-~A-solid" sdl-ttf-stub
        (:struct-pointer surface)
        (font font*)
        (text c-string)
        (fg (:struct-pointer color)))
  (frob "TTF_Render~A_Shaded" "render-~A-shaded" sdl-ttf
        (:struct-pointer surface)
        (font font*)
        (text c-string)
        (fg (:struct color))
        (bg (:struct color)))
  (frob "TTF_Render~A_Blended" "render-~A-blended" sdl-ttf
        (:struct-pointer surface)
        (font font*)
        (text c-string)
        (fg (:struct color))))

(def-foreign-routine ("TTF_RenderGlyph_Solid" render-glyph-solid)
    (:struct-pointer surface)
  (font font*) 
  (ch uint16)
  (fg (:struct color)))

(def-foreign-routine ("TTF_RenderGlyph_Shaded" render-glyph-shaded)
    (:struct-pointer surface)
  (font font*)
  (ch uint16)
  (fg (:struct color))
  (bg (:struct color)))

(def-foreign-routine ("TTF_RenderGlyph_Blended" render-glyph-blended)
    (:struct-pointer surface)
  (font font*)
  (ch uint16)
  (fg (:struct color)))

(def-foreign-routine ("TTF_CloseFont" close-font)
    void
  (font font*))

(def-foreign-routine ("TTF_Quit" quit)
    void)
