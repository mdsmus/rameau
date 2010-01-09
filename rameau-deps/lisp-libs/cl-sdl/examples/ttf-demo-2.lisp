;;;; -*- Mode: Lisp -*-
;;;; Author: Matthew Danish <mrd@debian.org>
;;;; TTF demo

(defpackage #:ttf-demo-2
  (:use #:common-lisp)
  (:nicknames #:ttf2)
  (:export #:start))

(in-package #:ttf-demo-2)

(defparameter *screen-width* 640)
(defparameter *screen-height* 480)
(defvar *surface*)
(defvar *font*)
(defparameter *font-sizes* (coerce (loop for x from 4 upto 24 by 1 collect x) 'vector))
(defparameter *font-path* (sdl-data:data-file "arial" "ttf"))
(defvar *frames-per-second* 0)
(defvar *frames* 0)
(defvar *previous-fps-calc* 0)

(defparameter *strings*
  (let ((vec (make-array 0
                         :element-type 'string
                         :adjustable t :fill-pointer t)))
    (loop for sym being each external-symbol in :common-lisp do
          (vector-push-extend (string-downcase (symbol-name sym)) vec))
    vec))

(defstruct visible
  string font-number r g b x y)

(defparameter *scale* 1.1)
(defvar *adjusted-scale* 1.1)

(defparameter *number-visible* 75)
(defvar *visible*)

(defun init-visible (&optional (nth nil) (box-x *screen-width*) (box-y *screen-height*))
  (flet ((setn (n)
           (let ((string (aref *strings* (random (length *strings*))))
                 (font 0)
                 (x (- (random box-x)
                       (truncate box-x 2)))
                 (y (- (random box-y)
                       (truncate box-y 2)))
                 (r (random 256))
                 (g (random 256))
                 (b (random 256)))
             (when (and (= x 0) (= y 0))
               (setf x 1 y 1))
             (setf (aref *visible* n)
                   (make-visible :string string
                                 :font-number font
                                 :x x :y y :r r :g g :b b)))))
    (if (integerp nth)
        (setn nth)
        (dotimes (n *number-visible*)
          (setn n)))))

(defun update-screen ()
  (let* ((sw/2 (truncate *screen-width* 2))
         (sh/2 (truncate *screen-height* 2))
         (len (length *font*))
         (sw/2/len (truncate sw/2 len))
         (sh/2/len (truncate sh/2 len))
         (x.y-thresh (loop for i from 1 upto len collecting
                           `(,(* i sw/2/len) . ,(* i sh/2/len)))))
    (sdl:draw-filled-rectangle *surface*
                               0 0
                               *screen-width* *screen-height*
                               0 0 0)
    (loop for visible across *visible* 
          for n from 0 do
          (let ((string (visible-string visible))
                (font (aref *font* (visible-font-number visible)))
                (x (+ (truncate (visible-x visible))
                      sw/2))
                (y (+ (truncate (visible-y visible))
                      sh/2)))
            (multiple-value-bind (w h)
                (cl-sdl-ttf:size-text font string)
              (decf x (truncate w 2))
              (decf y (truncate h 2)))
            (cl-sdl-ttf:with-solid-text (s font string 
                                           (visible-r visible)
                                           (visible-g visible)
                                           (visible-b visible))
              (sgum:with-foreign-objects ((rect sdl:rect))
                (setf
                 (sdl:rect-x rect) x
                 (sdl:rect-y rect) y)
                (sdl:blit-surface s sgum:+null-pointer+
                                  *surface* rect)))


            ;; Adjust the scale relative to the frames per second
            (setf *adjusted-scale*
                  (if (zerop *frames-per-second*)
                      *scale*
                      (1+ (/ (1- *scale*)
                             *frames-per-second*
                             1/30))))
            
            (setf (visible-x visible)
                  (* *adjusted-scale* (visible-x visible)))
            (setf (visible-y visible)
                  (* *adjusted-scale* (visible-y visible)))
            (block determine-font
              (loop for (xt . yt) in x.y-thresh 
                    for i from 0 do
                    (when (and (< (abs (visible-x visible)) xt)
                               (< (abs (visible-y visible)) yt))
                      (setf (visible-font-number visible) i)
                      (return-from determine-font)))
              (init-visible n 49 49)))))
  (sdl:flip *surface*)
  (incf *frames*)
  (when (>= (- (get-universal-time)
               *previous-fps-calc*)
            5)
    (setf *frames-per-second* (/ *frames* 5)
          *frames* 0
          *previous-fps-calc* (get-universal-time))
    (format t "~&Frames per second: ~F~%"
            *frames-per-second*)))

(defun handle-key (key)
  (cond ((= key (char-code #\c))
         (init-visible))))

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
  (setf *visible* (make-array *number-visible* :element-type 'visible))
  (init-visible)
  (let ((*surface* (sdl:set-video-mode *screen-width* *screen-height* 16 
                                       (logior sdl:+swsurface+
                                               sdl:+doublebuf+))))
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
          (sdl:wm-set-caption "CL-SDL-TTF Demo 2" nil)
          (setf *previous-fps-calc* (get-universal-time))
          (unwind-protect
              (start-event-loop)
            (free-fonts *font*)))
      (sdl:quit))))
