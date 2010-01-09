;;;; -*- Mode: Lisp -*-
;;;; Author: Matthew Danish <mrd@debian.org>
;;;; TTF demo

(defpackage #:ttf-demo-1
  (:use #:common-lisp)
  (:nicknames #:ttf1)
  (:export #:start))

(in-package #:ttf-demo-1)

(defparameter *screen-width* 640)
(defparameter *screen-height* 480)
(defvar *surface*)
(defvar *font*)
(defparameter *font-sizes* #(8 12 18 24 36))
(defparameter *font-path* (sdl-data:data-file "bboron" "ttf"))
(defvar *choose-type* 0)

(defparameter *strings*
  (let ((vec (make-array 0
                         :element-type 'string
                         :adjustable t
                         :fill-pointer t)))
    (loop for sym being each external-symbol in :common-lisp do
          (vector-push-extend (string-downcase (symbol-name sym)) vec))
    vec))

(defun choose-font (string-len)
  (case *choose-type*
    (0
     (random (length *font*)))
    (1
     (case string-len
       ((0 1 2 3) 4)
       ((4 5 6 7) 3)
       ((8 9 10 11) 2)
       ((12 13 14 15) 1)
       (otherwise 0)))))

(defun update-screen ()
  (let* ((string (aref *strings* (random (length *strings*))))
         (font (aref *font* (choose-font (length string))))
         (r (random 256))
         (g (random 256))
         (b (random 256))
         (x (random *screen-width*))
         (y (random *screen-height*)))
    (cl-sdl-ttf:with-solid-text (s font string r g b)
      (sgum:with-foreign-objects ((rect sdl:rect))
        (setf
         (sdl:rect-x rect) x
         (sdl:rect-y rect) y)
        (sdl:blit-surface s sgum:+null-pointer+
                          *surface* rect)
        (sdl:update-rect *surface* x y 
                         (sdl:rect-w rect) (sdl:rect-h rect))))))

(defun handle-key (key)
  (cond ((= key (char-code #\c))
         (cl-sdl:clear-screen *surface*))
        ((= key (char-code #\t))
         (setf *choose-type*
           (mod (1+ *choose-type*) 2))
         (write-line
          (if (zerop *choose-type*)
              "Random font-size"
              "Longer symbol-name => smaller font-size")))))

(defun start-event-loop ()
  (sdl:event-loop
   (:idle ()
          (update-screen))
   (:key-down (scan-code key mod unicode)
              (cond ((= key (char-code #\q))
                     (return))
                    (t (handle-key key))))))

(defun free-fonts (fonts)
  (loop for font across fonts do
        (unless (sgum:null-pointer-p font)
          (sdl-ttf:close-font font))))

(defun start ()
  (sdl:init sdl:+init-video+)
  (sdl-ttf:init)
  (let ((*surface* (sdl:set-video-mode *screen-width*
                                       *screen-height*
                                       16 sdl:+swsurface+)))
    (when (sgum:null-pointer-p *surface*)
      (error "Unable to make surface"))
    (unwind-protect
        (let ((*font* (map 'vector 
                        #'(lambda (size)
                            (sdl-ttf:open-font *font-path* size))
                        *font-sizes*)))
          (when (some #'(lambda (f) (sgum:null-pointer-p f))
                      *font*)
            (free-fonts *font*)
            (error "Unable to load fonts"))
          (sdl:wm-set-caption "CL-SDL-TTF Demo 1" nil)
          (unwind-protect
              (start-event-loop)
            (free-fonts *font*)))
      (sdl:quit))))
