(in-package #:nehe-tutorials)

(declaim (type cl:single-float *z8* *xspeed8* *yspeed8* *xrot8* *yrot8*))
(defparameter *z8* -5f0)
(defparameter *xspeed8* 0f0)
(defparameter *yspeed8* 0f0)
(defparameter *xrot8* 0f0)
(defparameter *yrot8* 0f0)
(defparameter *blend-p8* nil)

(defparameter *image8* (data-file "cl-sdl" "bmp"))

(sgum:def-foreign-type uint* (* gl:uint))
(defvar *texture8* (sgum:allocate-foreign-object gl:uint 3))
(declaim (type uint* *texture8*))

(defparameter *filter8* 0)
(defvar *light-ambient8*
  (sgum:allocate-foreign-object sgum:c-single-float 4))
(defvar *light-diffuse8*
  (sgum:allocate-foreign-object sgum:c-single-float 4))
(defvar *light-position8*
  (sgum:allocate-foreign-object sgum:c-single-float 4))

(defun init-float-array8 (array &rest values)
  (loop for v in values
        for i from 0 do
        (setf (sgum:deref-array array
                                (:array sgum:c-single-float)
                                i)
              v)))

(init-float-array8 *light-ambient8* 0.5f0 0.5f0 0.5f0 1.0f0)
(init-float-array8 *light-diffuse8* 1f0 1f0 1f0 1f0)
(init-float-array8 *light-position8* 0f0 0f0 2f0 1f0)

(defparameter *quad8*
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

(declaim (inline get-texture8))
(defun get-texture8 (i)
  (declare (optimize (speed 3)))
  (sgum:deref-array *texture8*
                    (:array gl:uint)
                    i))

(defun load-gl-textures8 ()
  (let ((tex-image (sdl:load-bmp *image8*)))
    (unwind-protect
         (progn
           (gl:gen-textures 3 *texture8*)
           ;; Texture 1
           (gl:bind-texture gl:+texture-2d+
                            (get-texture8 0))
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
                            (get-texture8 1))
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
                            (get-texture8 2))
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

(defun initgl8 ()
  (load-gl-textures8)
  (gl:enable gl:+texture-2d+)
  (gl:shade-model gl:+smooth+)
  (gl:clear-color 0.0f0 0.0f0 0.0f0 0.0f0)
  (gl:clear-depth 1.0d0)
  (gl:enable gl:+depth-test+)
  (gl:depth-func gl:+lequal+)
  (gl:hint gl:+perspective-correction-hint+ gl:+nicest+)
  (gl:color-4f 1f0 1f0 1f0 0.5f0)
  (gl:blend-func gl:+src-alpha+ gl:+one+)
  (gl:light-fv gl:+light1+ gl:+ambient+ *light-ambient8*)
  (gl:light-fv gl:+light1+ gl:+diffuse+ *light-diffuse8*)
  (gl:light-fv gl:+light1+ gl:+position+ *light-position8*)
  (gl:enable gl:+light1+)
  t)

(defun draw-quads8 (quads)
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

(defun draw-gl-scene8 (surface)
  (declare (ignorable surface)
           (optimize (speed 3)))
  
  (gl:clear (logior gl:+color-buffer-bit+
                    gl:+depth-buffer-bit+))

  (gl:load-identity)

  (gl:translate-f 0f0 0f0 *z8*)
  (gl:rotate-f *xrot8* 1f0 0f0 1f0)
  (gl:rotate-f *yrot8* 0f0 1f0 0f0)
  (gl:bind-texture gl:+texture-2d+ (get-texture8 *filter8*))
  (draw-quads8 *quad8*)
  
  (sdl:gl-swap-buffers)

  (incf *xrot8* *xspeed8*)
  (incf *yrot8* *yspeed8*)
  t)

(defparameter *lighting-p8* nil)
(defun handle-keypress8 (key)
  (cond
    ((eql (char-code #\l) key)
     (if *lighting-p8*
         (gl:disable gl:+lighting+)
         (gl:enable gl:+lighting+))
     (setf *lighting-p8* (not *lighting-p8*)))
    ((eql (char-code #\f) key)
     (setf *filter8*
           (mod (1+ *filter8*) 3))
     (format t "~&Filter: ~A~%" *filter8*))
    ((eql (char-code #\b) key)
     (setf *blend-p8* (not *blend-p8*))
     (cond (*blend-p8*
            (gl:enable gl:+blend+)
            (gl:disable gl:+depth-test+))
           (t
            (gl:disable gl:+blend+)
            (gl:enable gl:+depth-test+))))
    ((eql 275 key) ; right arrow
     (incf *yspeed8* 0.01f0))
    ((eql 273 key) ; up arrow
     (decf *xspeed8* 0.01f0))
    ((eql 276 key) ; left arrow
     (decf *yspeed8* 0.01f0))
    ((eql 274 key) ; down arrow
     (incf *xspeed8* 0.01f0))
    ((eql 281 key) ; pgdown
     (incf *z8* 0.02f0))
    ((eql 280 key) ; pgup
     (decf *z8* 0.02f0))
    (t
     (format t "~&Unbound key code: ~A~%" key))))
  
(register-tutorial 8
                   :init-gl-fn #'initgl8
                   :event-loop-fn #'event-loop0
                   :update-fn #'draw-gl-scene8
                   :handle-keypress-fn #'handle-keypress8)

