(defpackage #:nehe-tutorials
  (:use #:common-lisp)
  (:import-from #:sdl-data
                #:data-file)
  (:nicknames #:nehe)
  (:export #:run-tutorial))

(in-package #:nehe-tutorials)

(defvar *frames* 0)
(defvar *start-time* 0)

(defun initgl0 ()
  (gl:shade-model gl:+smooth+)
  #+nil (sdl:set-gl-attributes :red-size 4 :blue-size 4 :green-size 4
			 :doublebuffer 1 :depth-size 16)
  (gl:clear-color 0.0f0 0.0f0 0.0f0 0.0f0)
  (gl:clear-depth 1.0d0)
  (gl:enable gl:+depth-test+)
  (gl:depth-func gl:+lequal+)
  (gl:hint gl:+perspective-correction-hint+ gl:+nicest+)
  t)

(defun event-loop0 (surface update-fn resize-fn handle-keypress-fn bpp video-flags)
  (declare (ignorable surface))
  (sdl:event-loop
   (:key-down (key)
	      (if (= key (char-code #\q))
                  (return)
                  (funcall handle-keypress-fn key)))
   (:mouse-button-up (button x y)
		     (format t "Mouse button up: ~A (~A, ~A)~%" button x y))
   (:mouse-button-down (button x y)
		       (format t "Mouse button dn: ~A (~A, ~A)~%" button x y))
   (:quit ()
	  (return))
   (:resize (width height)
	    (format t "Resized width = ~A height = ~A~%" width height)
            (sdl:free-surface surface)
            (setf surface
                  (sdl:set-video-mode width height bpp video-flags))
            (funcall resize-fn surface width height))
   (:idle ()
	  (progn (funcall update-fn surface)
                 (incf-frames)))))

(defun resize0 (surface width height)
  (when (zerop height)
    (setf height 1))
  (let ((ratio (coerce (/ width height) 'double-float)))
    (gl:viewport 0 0 width height)
    (gl:matrix-mode gl:+projection+)
    (gl:load-identity)
    (glu:perspective 45.0d0 ratio 0.1d0 100.0d0)
    (gl:matrix-mode gl:+modelview+)
    (gl:load-identity)
    t))

(defun init-sdl (&key (width 640) (height 480) (bpp 16) (init-gl-fn #'initgl0) (event-loop-fn #'event-loop0) (update-fn #'identity) (resize-fn #'resize0) (handle-keypress-fn #'identity) (video-flags (logior sdl:+opengl+ sdl:+resizable+ sdl:+gl-doublebuffer+ sdl:+hwpalette+)))
  (sdl:init sdl:+init-video+)
  
  (multiple-value-bind (hw-available-p blit-hw-p)
      (sdl:query-video-info :hw-available :blit-hw)
    (setf video-flags (logior video-flags
                              (if hw-available-p
                                  sdl:+hwsurface+
                                  sdl:+swsurface+)
                              (if blit-hw-p
                                  sdl:+hwaccel+
                                  0))))
  (setf *frames* 0
        *start-time* (get-universal-time))
  (sdl:gl-set-attribute sdl:+gl-doublebuffer+ 1)
  (let ((surface (sdl:set-video-mode width height bpp video-flags)))
    (when (sgum:null-pointer-p surface)
      (error "Failed to obtain surface"))
    (unless (funcall init-gl-fn)
      (error "Failed to initialize GL"))
    (funcall resize-fn surface width height)
    (unwind-protect (funcall event-loop-fn surface update-fn resize-fn handle-keypress-fn bpp video-flags)
      (progn (sdl:free-surface surface)
             (sdl:quit)))
    (values)))

(defun incf-frames ()
  (incf *frames*)
  (let* ((time (get-universal-time))
         (delta (- time *start-time*)))
    (when (>= delta 5)
      (format t "~&~A frames in ~A seconds = ~A FPS~%"
              *frames* delta (float (/ *frames* delta)))
      (setf *frames* 0
            *start-time* time))))

(defvar *tutorial-table* (make-hash-table))

(defun register-tutorial (n &rest args)
  (setf (gethash n *tutorial-table*)
        args))

(defun run-tutorial (n)
  (let ((args (gethash n *tutorial-table*)))
    (apply #'init-sdl args)))


