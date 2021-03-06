;; Common Lisp bindings for GTK+ v2.x
;; Copyright 2004-2005 Espen S. Johnsen <espen@users.sf.net>
;;
;; Permission is hereby granted, free of charge, to any person obtaining
;; a copy of this software and associated documentation files (the
;; "Software"), to deal in the Software without restriction, including
;; without limitation the rights to use, copy, modify, merge, publish,
;; distribute, sublicense, and/or sell copies of the Software, and to
;; permit persons to whom the Software is furnished to do so, subject to
;; the following conditions:
;;
;; The above copyright notice and this permission notice shall be
;; included in all copies or substantial portions of the Software.
;;
;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
;; EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
;; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
;; IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
;; CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
;; TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
;; SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

;; $Id: gtkstyle.lisp,v 1.4 2007/01/14 23:19:14 espen Exp $

(in-package "GTK")


;;; Styles

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defbinding %style-font-desc-offset () int))

(defclass style (gobject)
  ((fg 
    :allocation :virtual
    :getter style-fg
    :setter (setf style-fg)
    :initarg :fg)
   (bg 
    :allocation :virtual
    :getter style-bg
    :setter (setf style-bg)
    :initarg :bg)
   (light
    :allocation :virtual
    :getter style-light
    :setter (setf style-light)
    :initarg :light)
   (dark
    :allocation :virtual
    :getter style-dark
    :setter (setf style-dark)
    :initarg :dark)
   (mid
    :allocation :virtual
    :getter style-mid
    :setter (setf style-mid)
    :initarg :mid)
   (text
    :allocation :virtual
    :getter style-text
    :setter (setf style-text)
    :initarg :text)
   (base
    :allocation :virtual
    :getter style-base
    :setter (setf style-base)
    :initarg :base)
   (text-aa
    :allocation :virtual
    :getter style-text-aa
    :setter (setf style-text-aa)
    :initarg :text-aa)
   (black
    :allocation :virtual
    :getter style-black
    :setter (setf style-black)
    :initarg :black)
   (white
    :allocation :virtual
    :getter style-white
    :setter (setf style-white)
    :initarg :white)

   (font-desc 
    :offset #.(%style-font-desc-offset)
    :allocation :alien 
    :accessor style-font-desc
    :initarg :font-desc
    :type pango:font-description)
   (xthickness 
    :allocation :alien 
    :accessor style-xthickness
    :initarg :xthickness
    :type int)
   (ythickness
    :allocation :alien 
    :accessor style-ythickness
    :initarg :ythickness
    :type int)

   (fg-gc
    :allocation :virtual
    :getter style-fg-gc)
   (bg-gc
    :allocation :virtual
    :getter style-bg-gc)
   (light-gc
    :allocation :virtual
    :getter style-light-gc)
   (dark-gc
    :allocation :virtual
    :getter style-dark-gc)
   (mid-gc
    :allocation :virtual
    :getter style-mid-gc)
   (text-gc
    :allocation :virtual
    :getter style-text-gc)
   (base-gc
    :allocation :virtual
    :getter style-base-gc)
   (text-aa-gc
    :allocation :virtual
    :getter style-text-aa-gc)
   (black-gc
    :allocation :virtual
    :getter style-black-gc)
   (white-gc
    :allocation :virtual
    :getter style-white-gc))
  (:metaclass gobject-class))


(defbinding style-copy () style
  (style style))

(defbinding style-attach () style
  (style style)
  (window window))

(defbinding style-detach () style
  (style style))


(deftype color-type () 
  '(enum :fg :bg :light :dark :mid :text :base :text-aa :white :black))

(defbinding %style-get-color () (copy-of gdk:color)
  (style style)
  (color-type color-type)
  (state state-type))

(defbinding %style-set-color () nil
  (style style)
  (color-type color-type)
  (state state-type)
  (color gdk:color))

(defbinding %style-get-gc () gdk:gc
  (style style)
  (color-type color-type)
  (state state-type))

(defun %style-get-color-vector (style color-type)
  (loop
   with states = (enum-mapping 'state-type)
   with vector = (make-array (length states))
   for (symbol index) in states
   do (setf (svref vector index) (%style-get-color style color-type symbol))
   finally (return vector)))

(defun %style-set-color-vector (style color-type vector)
  (loop
   for (symbol index) in (enum-mapping 'state-type)
   do (%style-set-color style color-type symbol (svref vector index))))

(defun %style-get-gc-vector (style color-type)
  (loop
   with states = (enum-mapping 'state-type)
   with vector = (make-array (length states))
   for (symbol index) in states
   do (setf (svref vector index) (%style-get-gc style color-type symbol))
   finally (return vector)))

(defmacro define-style-color-accessor (name type)
  `(progn
     (defun ,name (style &optional state)
       (if state
	   (%style-get-color style ,type state)
	 (%style-get-color-vector style ,type)))
     (defun (setf ,name) (color style &optional state)
       (if state
	   (%style-set-color style ,type state color)
	 (%style-set-color-vector style ,type color)))))

(define-style-color-accessor style-fg :fg)
(define-style-color-accessor style-bg :bg)
(define-style-color-accessor style-light :light)
(define-style-color-accessor style-dark :dark)
(define-style-color-accessor style-mid :mid)
(define-style-color-accessor style-text :text)
(define-style-color-accessor style-base :base)
(define-style-color-accessor style-text-aa :text-aa)

(defun style-black (style)
  (%style-get-color style :black :normal))

(defun style-white (style)
  (%style-get-color style :black :normal))

(defmacro define-style-gc-reader (name type)
  `(defun ,name (style &optional state)
     (if state
	 (%style-get-gc style ,type state)
       (%style-get-gc-vector style ,type))))

(define-style-gc-reader style-fg-gc :fg)
(define-style-gc-reader style-bg-gc :bg)
(define-style-gc-reader style-light-gc :light)
(define-style-gc-reader style-dark-gc :dark)
(define-style-gc-reader style-mid-gc :mid)
(define-style-gc-reader style-text-gc :text)
(define-style-gc-reader style-base-gc :base)
(define-style-gc-reader style-text-aa-gc :text-aa)

(defun style-black-gc (style)
  (%style-get-gc style :black :normal))

(defun style-white-gc (style)
  (%style-get-gc style :white :normal))
