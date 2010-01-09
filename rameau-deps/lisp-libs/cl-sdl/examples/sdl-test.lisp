;;;;
;;;; SDL and OpenGL bindings tests
;;;; =============================
;;;;
;;;; written in 2002 by Timo Tossavainen (tt@cs.uta.fi)
;;;;
;;;; TODO: write a real test suite

;; Uncomment the following line if you get floating point errors
;; (my old machine Cel300A@450 got divide by zero errors with Riva TNT)
;; Set float traps equal to default C settings on X86. Uncommenting will cause
;; problems in Lisp error handling (i.e. will not catch all float errors).
; #+X86(set-floating-point-modes :traps '(:invalid) :precision-control :64-bit)

;(require :gl)
;(require :sdl)

(defpackage #:sdl-test
  (:use #:common-lisp)
  (:export #:start))

(in-package #:sdl-test)

;; Initialization of SDL and GL to sensible values
(defun init-sdl-with-gl ()
  (sdl:init sdl:+init-video+)
  (sdl:set-gl-attributes :red-size 4 :blue-size 4 :green-size 4
			 :doublebuffer 1 :depth-size 16)
  (let ((surface (sdl:set-video-mode 640 480 16 (logior sdl:+opengl+
							sdl:+resizable+))))
    (format t "GL Rendering Context Bit Depths Obtained:~%")
    (multiple-value-bind (s r) (sdl:gl-get-attribute sdl:+gl-red-size+)
      (format t "RED:    ~A ~A~%" s r))
    (multiple-value-bind (s g) (sdl:gl-get-attribute sdl:+gl-green-size+)
      (format t "GREEN:  ~A ~A~%" s g))
    (multiple-value-bind (s b) (sdl:gl-get-attribute sdl:+gl-blue-size+)
      (format t "BLUE:   ~A ~A~%" s b))
    (multiple-value-bind (s d) (sdl:gl-get-attribute sdl:+gl-doublebuffer+)
      (format t "DOUBLEBUFFER: ~A ~A~%" s (when d 'yes)))
    (sdl:wm-set-caption "SDL and GL Event Test" nil)
    (gl:viewport 0 0 640 480)
    (gl:matrix-mode gl:+projection+)
    (gl:load-identity)
    (gl:frustum (/ -640.0d0 480.0d0) (/ 640.0d0 480.0d0)
		1.0d0 -1.0d0 0.0d0 20.0d0)
    surface))

;; The following arrays are used to test vertex and color arrays

(declaim (type (simple-array single-float) *vertex* *color*)
	 (single-float *angle*))

(defvar *vertex*
  (make-array 15 :element-type 'single-float
              :initial-contents '(  0.0f0   0.0f0 1.0f0
                                  0.5f0   0.0f0 0.0f0
                                  -0.35f0 -0.35f0 0.0f0
                                  -0.35f0  0.35f0 0.0f0
                                  0.0f0   0.0f0 -1.0f0 )))
(defvar *color*
  (make-array 15
              :element-type 'single-float
              :initial-contents '(1.0f0 1.0f0 1.0f0
                                  1.0f0 0.0f0 0.0f0
                                  0.0f0 1.0f0 0.0f0
                                  0.0f0 0.0f0 1.0f0
                                  0.0f0 0.0f0 0.0f0)))
						 
(defvar *angle* 0.0f0)

;; Update and draw the scene (a rotating smoothly colored triangle)
(defun update-gl ()
  (declare (optimize speed (safety 1)))

  (gl:clear-color 0.0f0 0.0f0 0.0f0 1.0f0)
  (gl:clear gl:+color-buffer-bit+)
  (gl:matrix-mode gl:+modelview+)
  (gl:load-identity)
  (gl:translate-f 0.0f0 -0.5f0 0.5f0)
  (gl:begin gl:+triangles+)
  (gl:color-3f 1.0f0 0.0f0 0.0f0)
  (gl:vertex-2f -0.5f0 0.0f0)
  (gl:color-3f   0.0f0 1.0f0 0.0f0)
  (gl:vertex-2f  0.0f0 1.0f0)
  (gl:color-3f   0.0f0 0.0f0 1.0f0)
  (gl:vertex-2f  0.5f0 0.0f0)
  (gl:end)
  (sdl:gl-swap-buffers))

#+nil
(defun update-gl ()
;  (declare (optimize speed (safety 0)))
  (incf *angle* 2.0f0)
  (when (> *angle* 360.0f0)
    (decf *angle* 360.0f0))
  (gl:clear-color 0.0f0 0.0f0 0.0f0 1.0f0)
  (gl:clear gl:+color-buffer-bit+)
  (gl:matrix-mode gl:+modelview+)
  (gl:disable gl:+depth-test+)
  (gl:disable gl:+cull-face+)
  (gl:load-identity)
  (gl:with-vertex-array (*vertex* :type single-float :size 3)
    (gl:enable-client-state gl:+color-array+)
    (gl:color-pointer 3 gl:+float+ 0 (aref-sap *color* 0))
    (gl:translate-f 0.0f0 0.0f0 -1.1f0)
    (gl:rotate-f *angle* 1.0f0 1.0f0 0.0f0)
    (gl:begin gl:+triangles+)

    (gl:vertex-3f 1.0f0 0.0f0 0.0f0)
    (gl:vertex-3f 0.0f0 1.0f0 0.0f0)
    (gl:vertex-3f -1.0f0 0.0f0 0.0f0)
    (gl:array-element 1)
    (gl:array-element 2)
    (gl:array-element 0)

    (gl:array-element 2)
    (gl:array-element 3)
    (gl:array-element 0)

    (gl:array-element 3)
    (gl:array-element 4)
    (gl:array-element 0)

    (gl:array-element 2)
    (gl:array-element 1)
    (gl:array-element 5)

    (gl:array-element 3)
    (gl:array-element 2)
    (gl:array-element 5)

    (gl:array-element 4)
    (gl:array-element 3)
    (gl:array-element 5)
	  
    (gl:end)
    (gl:disable-client-state gl:+color-array+))
  (sdl:gl-swap-buffers))

;; The main SDL event loop (elegant, ain't it ?... just kidding)

(defun run-sdl-event-loop ()
  (sdl:event-loop
   (:key-down (key)
	      (when (= key (char-code #\q))
		(return)))
   (:mouse-button-up (button x y)
		     (format t "Mouse button up: ~A (~A, ~A)~%" button x y))
   (:mouse-button-down (button x y)
		       (format t "Mouse button dn: ~A (~A, ~A)~%" button x y))
   (:quit ()
	  (return))
   (:resize (width height)
	    (format t "Resized width = ~A height = ~A~%" width height))
   (:idle ()
	  (update-gl))))

;; The main program to test SDL event handling and GL graphics

(defun test-sdl-events ()
  (unwind-protect
      (progn
	(init-sdl-with-gl)
	(format t "OpenGL Information~%------------------~%Vendor: ~A~%Version: ~A~%Renderer: ~A~%Extensions: ~A~%"
		(gl:get-string gl:+vendor+)
		(gl:get-string gl:+renderer+)
		(gl:get-string gl:+version+)
		(gl:get-string gl:+extensions+))
	(run-sdl-event-loop))
    (sdl:quit)))
	
(defun start ()
  (test-sdl-events))
