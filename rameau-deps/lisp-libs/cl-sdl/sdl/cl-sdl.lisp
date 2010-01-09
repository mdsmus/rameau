;;;; -*- Mode: Lisp -*-
;;;; Author: Matthew Danish <mrd@debian.org>
;;;; A Lispier interface to SDL

(defpackage #:cl-sdl
  (:use #:common-lisp #:sdl-gl-uffi-macros)
  (:export #:draw-rectangle
           #:draw-pixel
           #:get-pixel
           #:show-bmp
           #:load-bmp
           #:draw-line
           #:update-screen
           #:clear-screen
           #:draw-filled-rectangle
           #:with-vraster
           #:fill-vraster
           #:vraster-line))

(in-package #:cl-sdl)

(defmacro with-possible-lock-and-update ((surface check-lock-p update-p x y w h) &body body)
  (let ((locked-p (gensym "LOCKED-P"))
        (exit (gensym "EXIT")))
    `(let ((,locked-p nil))
      (block ,exit
        (when ,check-lock-p
          (when (sdl:must-lock-p ,surface)
            (when (< (sdl:lock-surface ,surface)
                     0)
              (return-from ,exit (values)))
            (setf ,locked-p t)))
        (progn ,@body)
        (when ,locked-p
          (sdl:unlock-surface ,surface))
        (when ,update-p
          (sdl:update-rect ,surface ,x ,y ,w ,h))))))

(defun draw-rectangle (surface x y w h r g b &key (check-lock-p t) (update-p t) (clipping-p t))
  (check-types x y (unsigned-byte 16))
  (check-types w h (unsigned-byte 16))
  (check-types r g b (unsigned-byte 8))
  (when clipping-p
    (let ((sw (sdl:surface-w surface))
          (sh (sdl:surface-h surface))
          (x2 (+ x w))
          (y2 (+ y h)))
      (setf x (sdl:clamp x 0 (1- sw))
            y (sdl:clamp y 0 (1- sh))
            x2 (sdl:clamp x2 0 (1- sw))
            y2 (sdl:clamp y2 0 (1- sh))
            w (- x2 x)
            h (- y2 y))))
  (with-possible-lock-and-update (surface check-lock-p update-p
                                          x y (1+ w) (1+ h))
    (sdl:draw-rectangle surface x y w h r g b))
  (values))

(defun draw-filled-rectangle (surface x y w h r g b &key (check-lock-p t) (update-p t) (clipping-p t))
  (check-types x y (unsigned-byte 16))
  (check-types w h (unsigned-byte 16))
  (check-types r g b (unsigned-byte 8))
  (when clipping-p
    (let ((sw (sdl:surface-w surface))
          (sh (sdl:surface-h surface))
          (x2 (+ x w))
          (y2 (+ y h)))
      (setf x (sdl:clamp x 0 (1- sw))
            y (sdl:clamp y 0 (1- sh))
            x2 (sdl:clamp x2 0 (1- sw))
            y2 (sdl:clamp y2 0 (1- sh))
            w (- x2 x)
            h (- y2 y))))
  (with-possible-lock-and-update (surface check-lock-p update-p
                                          x y (1+ w) (1+ h))
    (sdl:draw-filled-rectangle surface x y w h r g b))
  (values))

(defun draw-pixel (surface x y r g b &key (check-lock-p t) (update-p t) (clipping-p t))
  (check-types x y (unsigned-byte 16))
  (check-types r g b (unsigned-byte 8))
  (block clipped
    (when clipping-p
      (let ((sw (sdl:surface-w surface))
            (sh (sdl:surface-h surface)))
        (when (or (< x 0)
                  (< y 0)
                  (>= x sw)
                  (>= y sh))
          (return-from clipped nil))))
    (with-possible-lock-and-update (surface check-lock-p update-p x y 1 1)
      (sdl:draw-pixel surface x y r g b)))
  (values))

(defun get-pixel (surface x y &key (check-lock-p t))
  (check-types x y (unsigned-byte 16))
  (with-possible-lock-and-update (surface check-lock-p nil x y 1 1)
    (sdl:get-pixel surface x y)))

(defun load-bmp (file)
  (let ((f (probe-file file)))
    (when f
      (maybe-null->nil
       (sdl:load-bmp (namestring f))))))

(defun show-bmp (file surface x y)
  (check-types x y (unsigned-byte 16))
  (let ((f (probe-file file)))
    (when f
      (sdl:show-bmp (namestring f)
                    surface
                    x y)))
  (values))

(defun draw-line (surface x1 y1 x2 y2 r g b &key (check-lock-p t) (update-p t) (clipping-p t))
  (check-types x1 y1 x2 y2 (unsigned-byte 16))
  (check-types r g b (unsigned-byte 8))
  (let ((sw (sdl:surface-w surface))
        (sh (sdl:surface-h surface)))
    (when clipping-p
      (setf x1 (sdl:clamp x1 0 (1- sw))
            x2 (sdl:clamp x2 0 (1- sw))
            y1 (sdl:clamp y1 0 (1- sh))
            y2 (sdl:clamp y2 0 (1- sh))))
    (with-possible-lock-and-update (surface check-lock-p update-p 0 0 sw sh)
      (sdl:draw-line surface x1 y1 x2 y2 r g b)))
  (values))

(defun update-screen (surface)
  (sdl:update-rect surface 0 0
                   (sdl:surface-w surface)
                   (sdl:surface-h surface))
  (values))

(defun clear-screen (surface &rest args)
  (apply #'draw-filled-rectangle surface 0 0
         (sdl:surface-w surface)
         (sdl:surface-h surface)
         0 0 0 args)
  (values))

;; vraster -- used to fill arbitrary convex polygons.
;; A structure with 2 arrays, holding the top and bottom
;; pixel positions for each x position.  Filling draws
;; a series of vertical lines for each x position from
;; top to bottom.

(defun vraster-line (buffer x1 y1 x2 y2 &key (clipping-p t))
  (check-types x1 y1 x2 y2 (unsigned-byte 16))
  (when clipping-p
    (let ((sw-1 (1- (sdl:vraster-length buffer)))
          (sh-1 (1- (sdl:vraster-surface-height buffer))))
      ;; for now
      (setf x1 (sdl:clamp x1 0 sw-1)
            x2 (sdl:clamp x2 0 sw-1)
            y1 (sdl:clamp y1 0 sh-1)
            y2 (sdl:clamp y2 0 sh-1))))
  (sdl:vraster-line buffer x1 y1 x2 y2)
  (values))

(defun fill-vraster (surface buffer r g b)
  (check-types r g b (unsigned-byte 8))
  (sdl:fill-vraster surface buffer r g b)
  (values))

(defmacro with-vraster ((buffer surface) &body body)
  `(let ((,buffer (sdl:make-vraster ,surface)))
    (unwind-protect (progn ,@body)
      (sdl:free-vraster ,buffer))))

