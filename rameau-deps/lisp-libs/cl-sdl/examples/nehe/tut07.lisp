(in-package #:nehe-tutorials)

(declaim (type cl:single-float *z7* *xspeed7* *yspeed7* *xrot7* *yrot7*))
(defparameter *z7* -5f0)
(defparameter *xspeed7* 0f0)
(defparameter *yspeed7* 0f0)
(defparameter *xrot7* 0f0)
(defparameter *yrot7* 0f0)

(defparameter *image7* (data-file "cl-sdl" "bmp"))

(sgum:def-foreign-type uint* (* gl:uint))
(defvar *texture7* (sgum:allocate-foreign-object gl:uint 3))
(declaim (type uint* *texture7*))

(defparameter *filter7* 0)
(defvar *light-ambient7*
  (sgum:allocate-foreign-object sgum:c-single-float 4))
(defvar *light-diffuse7*
  (sgum:allocate-foreign-object sgum:c-single-float 4))
(defvar *light-position7*
  (sgum:allocate-foreign-object sgum:c-single-float 4))

(defun init-float-array7 (array &rest values)
  (loop for v in values
        for i from 0 do
        (setf (sgum:deref-array array
                                (:array sgum:c-single-float)
                                i)
              v)))

(init-float-array7 *light-ambient7* 0.5f0 0.5f0 0.5f0 1.0f0)
(init-float-array7 *light-diffuse7* 1f0 1f0 1f0 1f0)
(init-float-array7 *light-position7* 0f0 0f0 2f0 1f0)

(defparameter *quad7*
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

(defun get-texture7 (i)
  (sgum:deref-array *texture7*
                    (:array gl:uint)
                    i))

(defun load-gl-textures7 ()
  (let ((tex-image (sdl:load-bmp *image7*)))
    (unwind-protect
         (progn
           (gl:gen-textures 3 *texture7*)
           ;; Texture 1
           (gl:bind-texture gl:+texture-2d+
                            (get-texture7 0))
           (gl:tex-image-2d gl:+texture-2d+ 0 3
                            (sdl:surface-w tex-image)
                            (sdl:surface-h tex-image)
                            0 gl:+bgr+
                            gl:+unsigned-byte+
                            (sdl:surface-pixels tex-image))
           (gl:tex-parameter-i gl:+texture-2d+
                               gl:+texture-min-filter+
                               gl:+nearest+)
           (gl:tex-parameter-i gl:+texture-2d+
                               gl:+texture-mag-filter+
                               gl:+nearest+)
           ;; Texture 2
           (gl:bind-texture gl:+texture-2d+
                            (get-texture7 1))
           (gl:tex-parameter-i gl:+texture-2d+
                               gl:+texture-min-filter+
                               gl:+linear+)
           (gl:tex-parameter-i gl:+texture-2d+
                               gl:+texture-mag-filter+
                               gl:+linear+)
           (gl:tex-image-2d gl:+texture-2d+ 0 3
                            (sdl:surface-w tex-image)
                            (sdl:surface-h tex-image)
                            0 gl:+bgr+
                            gl:+unsigned-byte+
                            (sdl:surface-pixels tex-image))
           ;; Texture 3
           (gl:bind-texture gl:+texture-2d+
                            (get-texture7 2))
           (gl:tex-parameter-i gl:+texture-2d+
                               gl:+texture-min-filter+
                               gl:+linear-mipmap-nearest+)
           (gl:tex-parameter-i gl:+texture-2d+
                               gl:+texture-mag-filter+
                               gl:+linear+)
           (glu:build-2d-mipmaps gl:+texture-2d+ 3
                                 (sdl:surface-w tex-image)
                                 (sdl:surface-h tex-image)
                                 gl:+bgr+
                                 gl:+unsigned-byte+
                                 (sdl:surface-pixels tex-image)))
      
      (sdl:free-surface tex-image))))

(defun initgl7 ()
  (load-gl-textures7)
  (gl:enable gl:+texture-2d+)
  (gl:shade-model gl:+smooth+)
  (gl:clear-color 0.0f0 0.0f0 0.0f0 0.0f0)
  (gl:clear-depth 1.0d0)
  (gl:enable gl:+depth-test+)
  (gl:depth-func gl:+lequal+)
  (gl:hint gl:+perspective-correction-hint+ gl:+nicest+)
  (gl:light-fv gl:+light1+ gl:+ambient+ *light-ambient7*)
  (gl:light-fv gl:+light1+ gl:+diffuse+ *light-diffuse7*)
  (gl:light-fv gl:+light1+ gl:+position+ *light-position7*)
  (gl:enable gl:+light1+)
  t)

(defun draw-quads7 (quads)
  (unwind-protect
       (let ((ptr quads))
         (gl:begin gl:+quads+)
         (loop repeat 6 do
               (apply #'gl:normal-3f (first ptr))
               (setf ptr (rest ptr))
               (loop repeat 4 do
                     (apply #'gl:tex-coord-2f (first ptr))
                     (apply #'gl:vertex-3f (second ptr))
                     (setf ptr (cddr ptr)))))
    (gl:end)))

(defun draw-gl-scene7 (surface)
  (declare (ignorable surface)
           (optimize (speed 3)))
  
  (gl:clear (logior gl:+color-buffer-bit+
                    gl:+depth-buffer-bit+))

  (gl:load-identity)

  (gl:translate-f 0f0 0f0 *z7*)
  (gl:rotate-f *xrot7* 1f0 0f0 1f0)
  (gl:rotate-f *yrot7* 0f0 1f0 0f0)
  (gl:bind-texture gl:+texture-2d+ (get-texture7 *filter7*))
  (draw-quads7 *quad7*)
  
  (sdl:gl-swap-buffers)

  (incf *xrot7* *xspeed7*)
  (incf *yrot7* *yspeed7*)
  t)

(defparameter *lighting-p7* nil)
(defun handle-keypress7 (key)
  (cond
    ((eql (char-code #\l) key)
     (if *lighting-p7*
         (gl:disable gl:+lighting+)
         (gl:enable gl:+lighting+))
     (setf *lighting-p7* (not *lighting-p7*)))
    ((eql (char-code #\f) key)
     (setf *filter7*
           (mod (1+ *filter7*) 3))
     (format t "~&Filter: ~A~%" *filter7*))
    ((eql 275 key) ; right arrow
     (incf *yspeed7* 0.01f0))
    ((eql 273 key) ; up arrow
     (decf *xspeed7* 0.01f0))
    ((eql 276 key) ; left arrow
     (decf *yspeed7* 0.01f0))
    ((eql 274 key) ; down arrow
     (incf *xspeed7* 0.01f0))
    ((eql 281 key) ; pgdown
     (incf *z7* 0.02f0))
    ((eql 280 key) ; pgup
     (decf *z7* 0.02f0))
    (t
     (format t "~&Unbound key code: ~A~%" key))))
  
(register-tutorial 7
                   :init-gl-fn #'initgl7
                   :event-loop-fn #'event-loop0
                   :update-fn #'draw-gl-scene7
                   :handle-keypress-fn #'handle-keypress7)

