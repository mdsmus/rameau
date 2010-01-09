;;;; -*- Mode: Lisp -*-
;;;; Draw and maintain a board for the game of Go
;;;; Author: Matthew Danish <mrd@debian.org>

(defpackage #:goban-sdl
  (:use #:common-lisp)
  (:nicknames #:gbsdl)
  (:export #:start))

(in-package #:goban-sdl)

(defparameter *screen-width* 640)
(defparameter *screen-height* 480)

(defparameter *padding-factor* 48)
(defparameter *left-side-factor* 32)
(defparameter *top-side-factor* 24)
(defparameter *hspacing-factor* 28)
(defparameter *vspacing-factor* 20)


(defvar *padding-x*)
(defvar *padding-y*)
(defvar *x1*)
(defvar *y1*)
(defvar *x-spacer*)
(defvar *y-spacer*)
(defvar *w*)
(defvar *h*)
(defvar *x2*)
(defvar *y2*)
(defvar *radius*)
(defvar *text-x*)
(defvar *text-y*)

(defvar *board*)

(defvar *font*)
(defparameter *font-file* (sdl-data:data-file "bboron" "ttf"))
(defparameter *font-size* 18)

(defun set-video-mode ()
  (setf *padding-x* (truncate *screen-width* *padding-factor*)
        *padding-y* (truncate *screen-height* *padding-factor*)
        *x1* (truncate *screen-width* *left-side-factor*)
        *y1* (truncate *screen-height* *top-side-factor*)
        *x-spacer* (truncate *screen-width* *hspacing-factor*)
        *y-spacer* (truncate *screen-height* *vspacing-factor*)
        *w* (* 18 *x-spacer*)
        *h* (* 18 *y-spacer*)
        *x2* (+ *x1* *w*)
        *y2* (+ *y1* *h*)
        *radius* (1- (truncate (min *x-spacer* *y-spacer*) 2))
        *text-x* (+ (* 2 *padding-x*)
                    *x1*
                    (* 20 *x-spacer*))
        *text-y* *y1*)
  
  (sdl:set-video-mode *screen-width*
                      *screen-height*
                      16
                      (logior sdl:+resizable+
                              sdl:+swsurface+
                              sdl:+doublebuf+)))

(defun init-sdl (&key (title "Go Ban"))
  (sdl:init (logior sdl:+init-video+ sdl:+init-noparachute+))
  (let ((surface (set-video-mode)))
    (when (sgum:null-pointer-p surface)
      (error "Unable to set video mode"))
    (sdl:wm-set-caption title nil)
    surface))

(defun run-sdl-event-loop (surface update-fn mouse-fn)
  (sdl:event-loop
   (:key-down (scan-code key mod unicode)
              (format t "Key down: ~A~%"
                      (if (< key 256)
                          (code-char key)
                          key))
              (when (= (char-code #\q) key)
                (return-from run-sdl-event-loop nil)))
   (:key-up (scan-code key mod unicode)
            (format t "Key up: ~A~%"
                      (if (< key 256)
                          (code-char key)
                          key)))
   (:mouse-button-up (button x y)
                     (format t "Mouse button up: ~A (~A, ~A)~%" button x y)
                     (funcall mouse-fn button x y :up))
   (:mouse-button-down (button x y)
                       (format t "Mouse button dn: ~A (~A, ~A)~%" button x y))
   (:quit ()
          (return))
   (:resize (width height)
            (setf *screen-width* width
                  *screen-height* height
                  surface (set-video-mode))
            (format t "Resized width = ~A height = ~A~%" width height))
   (:idle ()
          (funcall update-fn surface))))

(defmacro with-game-vars (vars &body body)
  `(symbol-macrolet ,(loop for v in vars collect
                           `(,v ,(intern (format nil "*~A*" v))))
    ,@body))

(defun place-piece (x y color)
  (setf (aref *board* x y)
        color))

(defun piece-at (i j)
  (aref *board* i j))

(defvar *turn* :black)
(defun default-mouse-handler (button x y up-or-down)
  (when (and (eq up-or-down :up)
             (eq button :left))
    (with-game-vars (x1 y1 radius x-spacer y-spacer)
      (let (i j quot-x rem-x quot-y rem-y)
        (multiple-value-setq (quot-x rem-x)
          (truncate (- x x1) x-spacer))
        (multiple-value-setq (quot-y rem-y)
          (truncate (- y y1) y-spacer))
        (setf i (cond ((<= rem-x radius)
                       quot-x)
                      ((>= rem-x (- x-spacer radius))
                       (1+ quot-x)))
              j (cond ((<= rem-y radius)
                       quot-y)
                      ((>= rem-y (- y-spacer radius))
                       (1+ quot-y))))
        (when (and i j (null (piece-at i j)))
          (place-piece i j *turn*)
          (setf *turn*
                (if (eq *turn* :black)
                    :white
                    :black)))))))
        
          

(defun draw-board (surface)
  (with-game-vars (w h padding-x padding-y radius
                     x-spacer y-spacer x1 y1 x2 y2)
    (sdl:draw-filled-rectangle surface
                               (- x1 padding-x)
                               (- y1 padding-y)
                               (+ w (* 2 padding-x))
                               (+ h (* 2 padding-y))
                               255 200 0)
    (dotimes (i 19)
      (let ((x (+ x1 (* i x-spacer)))
            (y (+ y1 (* i y-spacer))))
        (sdl:draw-line surface
                       x
                       y1
                       x
                       y2
                       0 0 0)
        (sdl:draw-line surface
                       x1
                       y
                       x2
                       y
                       0 0 0)))
    (dotimes (i 19)
      (dotimes (j 19)
        (let ((x (+ x1 (* i x-spacer)))
              (y (+ y1 (* j y-spacer))))
          (case (aref *board* i j)
            ((black :black)
             (sdl:draw-filled-circle surface x y radius 0 0 0))
            ((white :white)
             (sdl:draw-filled-circle surface x y radius 255 255 255))))))
    #+nil
    (sdl:update-rect surface x1 y1 w h)))

(defun draw-game-status (surface)
  (cl-sdl-ttf:with-solid-text (s *font* (format nil "Turn: ~A" *turn*)
                                 255 255 255)
    (sgum:with-foreign-objects ((rect sdl:rect))
      (setf (sdl:rect-x rect) *text-x*
            (sdl:rect-y rect) *text-y*)
      (sdl:blit-surface s sgum:+null-pointer+ surface rect)
      #+nil
      (sdl:update-rect surface
                       *text-x*
                       *text-y*
                       (sdl:rect-w rect)
                       (sdl:rect-h rect)))))

(defun update-screen (surface)
  (sdl:draw-filled-rectangle surface
                             0 0 *screen-width* *screen-height*
                             0 0 0)
  (draw-board surface)
  (draw-game-status surface)
  (sdl:flip surface))

(defun start (&key (width 640) (height 480) (title "Go Ban"))
  (let ((*screen-width* width)
        (*screen-height* height)
        (surface nil)
        (*board* (make-array '(19 19) :initial-element nil)))
    (setf *turn* :black)
    (unwind-protect
         (progn
           (setf surface (init-sdl :title title))
           (when surface
             (sdl-ttf:init)
             (unwind-protect
                  (progn
                    (setf *font* (sdl-ttf:open-font *font-file* *font-size*))
                    (when *font*
                      (run-sdl-event-loop surface
                                          #'update-screen
                                          #'default-mouse-handler)))
               (when *font*
                 (sdl-ttf:close-font *font*)))))
      (sdl:quit))))
