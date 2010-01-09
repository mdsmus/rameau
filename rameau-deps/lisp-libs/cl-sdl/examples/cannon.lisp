;;;; -*- Mode: Lisp -*-

(defpackage #:cannon-game
  (:use #:cl)
  (:nicknames #:cannon)
  (:export #:start))

(in-package #:cannon)

(defvar *cannon*)

(defparameter *quad*
    '((0f0 0f0 1f0)
      ( 0.0f0 1.0f0 ) ( -1.0f0 -1.0f0 1.0f0 )
      ( 1.0f0 1.0f0 ) (  1.0f0 -1.0f0 1.0f0 )
      ( 1.0f0 0.0f0 ) (  1.0f0  1.0f0 1.0f0 )
      ( 0.0f0 0.0f0 ) ( -1.0f0  1.0f0 1.0f0 )

      (0f0 0f0 -1f0)
      ( 0.0f0 0.0f0 ) ( -1.0f0 -1.0f0 -1.0f0 )
      ( 0.0f0 1.0f0 ) ( -1.0f0  1.0f0 -1.0f0 )
      ( 1.0f0 1.0f0 ) (  1.0f0  1.0f0 -1.0f0 )
      ( 1.0f0 0.0f0 ) (  1.0f0 -1.0f0 -1.0f0 )

      (0f0 1f0 0f0)
      ( 1.0f0 1.0f0 ) ( -1.0f0  1.0f0 -1.0f0 )
      ( 1.0f0 0.0f0 ) ( -1.0f0  1.0f0  1.0f0 )
      ( 0.0f0 0.0f0 ) (  1.0f0  1.0f0  1.0f0 )
      ( 0.0f0 1.0f0 ) (  1.0f0  1.0f0 -1.0f0 )

      (0f0 -1f0 0f0)
      ( 0.0f0 1.0f0 ) ( -1.0f0 -1.0f0 -1.0f0 )
      ( 1.0f0 1.0f0 ) (  1.0f0 -1.0f0 -1.0f0 )
      ( 1.0f0 0.0f0 ) (  1.0f0 -1.0f0  1.0f0 )
      ( 0.0f0 0.0f0 ) ( -1.0f0 -1.0f0  1.0f0 )

      (1f0 0f0 0f0)
      ( 0.0f0 0.0f0 ) ( 1.0f0 -1.0f0 -1.0f0 )
      ( 0.0f0 1.0f0 ) ( 1.0f0  1.0f0 -1.0f0 )
      ( 1.0f0 1.0f0 ) ( 1.0f0  1.0f0  1.0f0 )
      ( 1.0f0 0.0f0 ) ( 1.0f0 -1.0f0  1.0f0 )

      (-1f0 0f0 0f0)
      ( 1.0f0 0.0f0 ) ( -1.0f0 -1.0f0 -1.0f0 )
      ( 0.0f0 0.0f0 ) ( -1.0f0 -1.0f0  1.0f0 )
      ( 0.0f0 1.0f0 ) ( -1.0f0  1.0f0  1.0f0 )
      ( 1.0f0 1.0f0 ) ( -1.0f0  1.0f0 -1.0f0 )))

(defun draw-boat ()
  #||
  (sgum:with-single-float-values (mat-spec 0.0f0 0.2f0 0.0f0 1f0)
    (gl:material-fv gl:+front+ gl:+specular+ mat-spec))
  (sgum:with-single-float-values (mat-shin 20f0)
    (gl:material-fv gl:+front+ gl:+shininess+ mat-shin))
  ||#
  (sgum:with-single-float-values (mat-amb-diff 0.1f0 0.1f0 0.1f0 1.0f0)
    (gl:material-fv gl:+front+ gl:+ambient-and-diffuse+ mat-amb-diff))
  (let ((ptr *quad*))
    (gl:begin gl:+quads+)
    (loop repeat 6 do
          (apply #'gl:normal-3f (first ptr))
          (setf ptr (rest ptr))
          (loop repeat 4 do
                ;;(apply #'gl:tex-coord-2f (first ptr))
                (apply #'gl:vertex-3f (second ptr))
                (setf ptr (cddr ptr))))
    (gl:end)))

(defun draw-cannon ()
  (let ((base 0.05d0)
        (top 0.05d0)
        (height 1.0d0))
    (sgum:with-single-float-values (mat-amb-diff 0.35f0 0.35f0 0.35f0 1.0f0)
      (gl:material-fv gl:+front+ gl:+ambient-and-diffuse+ mat-amb-diff))
    (glu:with-quadric (cyl)
      (glu:quadric-draw-style cyl glu:+fill+)
      (glu:quadric-normals cyl glu:+smooth+)
      (glu:cylinder cyl base top height 25 20))))


(defun draw-shot ()
  (sgum:with-single-float-values (mat-amb-diff 0.2f0 0.2f0 0.2f0 1.0f0)
    (gl:material-fv gl:+front+ gl:+ambient-and-diffuse+ mat-amb-diff))
  (glu:with-quadric (sphere)
    (glu:quadric-draw-style sphere glu:+fill+)
    (glu:quadric-normals sphere glu:+smooth+)
    (glu:sphere sphere 0.03d0 25 20)))

(let* ((size 60)
       (size-1 (1- size))
       (size/2 (truncate size 2))
       (segsize 0.2f0)
       (dampening 256)
       (current-array 0)
       (velocities (make-array (list 2 size size)
                               :element-type 'single-float
                               :initial-element 0f0))
       (array (make-array (list 2 size size) 
                          :element-type 'single-float
                          :initial-element 0f0))
       (prev-update 0)
       (update-interval 50)
       #+nil (unit-interval 10)
       (prev-draw 0)
       (prev-splash 0)
       (splash-interval 1000)
       (splash-depth 0.5f0))
  (declare (ignorable velocities))
  (defun init-water ()
    (setf (aref array current-array 20 28)
      0.5f0))
  (init-water)
  (defun update-water ()
    (declare (optimize (speed 3)))
    (let ((interval (- (sdl:get-ticks) prev-update)))
      (unless (>= interval update-interval)
        (return-from update-water nil))
      (loop for i from 1 below size-1 do
            (loop for j from 1 below size-1 do
                  (flet ((ref (dx dy)
                           (aref array current-array (+ i dx) (+ j dy))))
                    (let* ((t1 (+ (ref -1 0)
                                  (ref 1 0)
                                  (ref 0 -1)
                                  (ref 0 1)
                                  (ref -1 -1)
                                  (ref 1 -1)
                                  (ref -1 1)
                                  (ref 1 1)))
                           (t2 (- (/ t1 4)
                                  (aref array (- 1 current-array) i j)))
                           (new (- t2 (/ t2 dampening)))
                           #+nil
                           (old (aref array (- 1 current-array) i j)))
                      (setf (aref array (- 1 current-array) i j) new)))))
      
      (setf prev-update (sdl:get-ticks))
      (setf current-array (- 1 current-array)))
    
    (when (>= (- (sdl:get-ticks) prev-splash)
              splash-interval)
      (decf (aref array current-array 
                  (random size)
                  (random size))
            splash-depth)
      (setf prev-splash (sdl:get-ticks))))
  
  (defun draw-water ()
    (let (interval)
      (declare (ignorable interval))
      (when (zerop prev-draw)
        (setf prev-draw (sdl:get-ticks))
        (return-from draw-water nil))
      (setf interval (- (sdl:get-ticks)
                        prev-draw))
      (sgum:with-single-float-values (mat-amb-diff 0.0f0 0.3f0 0.6f0 1.0f0)
        (gl:material-fv gl:+front+ gl:+ambient-and-diffuse+ mat-amb-diff))
      (sgum:with-single-float-values (mat-shin 70f0)
        (gl:material-fv gl:+front+ gl:+shininess+ mat-shin))
      (gl:push-matrix)
      (gl:translate-f (* (- size/2) segsize) 0f0 0f0)
      (dotimes (i (1- size))
        (gl:push-matrix)
        (gl:translate-f 0f0 0f0 (* segsize (- i size/2)))
        (gl:begin gl:+triangle-strip+)
        (gl:normal-3f 0f0 1f0 0f0)
        (dotimes (j size)
          #+nil
          (when (zerop i)
            (incf (aref array current-array i j)
                  (* (aref velocities current-array i j)
                     (/ interval 500))))
          (gl:vertex-3f (* j segsize)
                        (aref array current-array i j)
                        0f0)
          #+nil
          (incf (aref array current-array (1+ i) j)
                  (* (aref velocities current-array (1+ i) j)
                     (/ interval 500)))
          (gl:vertex-3f (* j segsize)
                        (aref array current-array (1+ i) j)
                        segsize))
        (gl:end)
        (gl:pop-matrix))
      (gl:pop-matrix)
      (sgum:with-single-float-values (mat-shin 20f0)
        (gl:material-fv gl:+front+ gl:+shininess+ mat-shin)))))


(defun init-gl ()
  (gl:shade-model gl:+smooth+)
  (sdl:set-gl-attributes :red-size 4 :blue-size 4 :green-size 4
                         :doublebuffer 1 :depth-size 16)
  (gl:clear-color 0.0f0 0.0f0 0.0f0 0.0f0)
  (gl:clear-depth 1.0d0)
  (gl:enable gl:+depth-test+)
  (gl:depth-func gl:+lequal+)
  (gl:hint gl:+perspective-correction-hint+ gl:+nicest+)

  (gl:load-identity)

  (sgum:with-single-float-values (light-pos 1f0 1f0 1f0 1f0)
    (gl:light-fv gl:+light0+ gl:+position+ light-pos))
  (sgum:with-single-float-values (light-amb 0.8f0 0.7f0 0.5f0 1f0)
    (gl:light-fv gl:+light0+ gl:+ambient+ light-amb))
  (sgum:with-single-float-values (light-diff 1f0 0.8f0 1f0 1f0)
    (gl:light-fv gl:+light0+ gl:+diffuse+ light-diff))
  (sgum:with-single-float-values (light-spec 0.7f0 0.5f0 0f0 1f0)
    (gl:light-fv gl:+light0+ gl:+specular+ light-spec))
  
  (gl:enable gl:+lighting+)
  (gl:enable gl:+light0+)

  (gl:enable gl:+color-material+)
  (gl:color-material gl:+front+ gl:+specular+)
  (gl:enable gl:+fog+)
  (gl:hint gl:+fog-hint+ gl:+dont-care+)
  (gl:fog-f gl:+fog-start+ 1f0)
  (gl:fog-f gl:+fog-end+ 10f0)
  (gl:fog-f gl:+fog-density+ 0.30f0)
  t)

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

(defun update-gl (surface)
  (declare (ignorable surface))
  (gl:clear-color 0f0 0f0 0f0 0f0)
  (gl:clear (logior gl:+color-buffer-bit+
                    gl:+depth-buffer-bit+))
  (gl:load-identity)

  (gl:translate-f 0f0 -0.7f0 0.3f0)

  (progn
    (gl:push-matrix)
    (gl:rotate-f 190f0 1f0 0f0 0f0)
    (gl:translate-f 0f0 (- -0.1f0 0.05f0) 0f0)
    (gl:rotate-f 20f0 1f0 0f0 0f0)
    (gl:rotate-f 0f0 0f0 1f0 0f0)
    (gl:color-3f 0.35f0 0.35f0 0.35f0)
    (draw-cannon)
    (gl:pop-matrix))
  
  (progn
    (gl:push-matrix)
    (gl:translate-f 1f0 0f0 -5f0)
    (gl:color-3f 0f0 0f0 1f0)
    (gl:scale-f 0.2f0 0.1f0 0.2f0)
    (draw-boat)
    (gl:pop-matrix))

  (progn 
    (gl:push-matrix)
    (gl:translate-f 0f0 0.9f0 -1f0)
    (gl:color-3f 0.2f0 0.2f0 0.2f0)
    (draw-shot)
    (gl:pop-matrix))

  (progn
    (gl:push-matrix)
    (gl:color-3f 0f0 0.7f0 1f0)
    (update-water)
    (draw-water)
    (gl:pop-matrix))
  
  (sdl:gl-swap-buffers)
  t)

(defun resize (surface width height)
  (declare (ignorable surface))
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

(defun event-loop (surface update-fn resize-fn 
                   handle-keypress-fn bpp video-flags)
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
            (setf surface
              (sdl:set-video-mode width height bpp video-flags))
            (funcall resize-fn surface width height))
   (:idle ()
	  (progn (funcall update-fn surface)
                 (incf-frames)))))


(defun handle-keypress (key)
  key)

(defvar *frames* 0)
(defvar *start-time*)

(defun incf-frames ()
  (incf *frames*)
  (let* ((time (get-universal-time))
         (delta (- time *start-time*)))
    (when (>= delta 5)
      (format t "~&~A frames in ~A seconds = ~A FPS~%"
              *frames* delta (float (/ *frames* delta)))
      (setf *frames* 0
            *start-time* time))))

(defun start (&key (width 640) (height 480) (bpp 16) (video-flags (logior sdl:+opengl+ sdl:+resizable+ sdl:+gl-doublebuffer+ sdl:+hwpalette+)) (title "Cannon"))
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
    
    (unless (init-gl)
      (error "Failed to initialize GL"))
    
    (resize surface width height)
    
    (sdl:wm-set-caption title nil)
    
    (unwind-protect (event-loop surface 
                                'update-gl
                                'resize
                                'handle-keypress
                                bpp
                                video-flags)
      
      (sdl:quit))
    (values)))
