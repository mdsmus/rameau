(in-package #:nehe-tutorials)

(defparameter *rquad6* 0f0)
(defparameter *image6* (data-file "cl-sdl" "bmp"))
(defvar *texture6* (sgum:allocate-foreign-object 'gl:uint))


(defparameter *quad6*
  '(( 0.0f0 1.0f0 ) ( -1.0f0 -1.0f0 1.0f0 )
    ( 1.0f0 1.0f0 ) (  1.0f0 -1.0f0 1.0f0 )
    ( 1.0f0 0.0f0 ) (  1.0f0  1.0f0 1.0f0 )
    ( 0.0f0 0.0f0 ) ( -1.0f0  1.0f0 1.0f0 )

    ( 0.0f0 0.0f0 ) ( -1.0f0 -1.0f0 -1.0f0 )
    ( 0.0f0 1.0f0 ) ( -1.0f0  1.0f0 -1.0f0 )
    ( 1.0f0 1.0f0 ) (  1.0f0  1.0f0 -1.0f0 )
    ( 1.0f0 0.0f0 ) (  1.0f0 -1.0f0 -1.0f0 )

    ( 1.0f0 1.0f0 ) ( -1.0f0  1.0f0 -1.0f0 )
    ( 1.0f0 0.0f0 ) ( -1.0f0  1.0f0  1.0f0 )
    ( 0.0f0 0.0f0 ) (  1.0f0  1.0f0  1.0f0 )
    ( 0.0f0 1.0f0 ) (  1.0f0  1.0f0 -1.0f0 )

    ( 0.0f0 1.0f0 ) ( -1.0f0 -1.0f0 -1.0f0 )
    ( 1.0f0 1.0f0 ) (  1.0f0 -1.0f0 -1.0f0 )
    ( 1.0f0 0.0f0 ) (  1.0f0 -1.0f0  1.0f0 )
    ( 0.0f0 0.0f0 ) ( -1.0f0 -1.0f0  1.0f0 )

    ( 0.0f0 0.0f0 ) ( 1.0f0 -1.0f0 -1.0f0 )
    ( 0.0f0 1.0f0 ) ( 1.0f0  1.0f0 -1.0f0 )
    ( 1.0f0 1.0f0 ) ( 1.0f0  1.0f0  1.0f0 )
    ( 1.0f0 0.0f0 ) ( 1.0f0 -1.0f0  1.0f0 )

    ( 1.0f0 0.0f0 ) ( -1.0f0 -1.0f0 -1.0f0 )
    ( 0.0f0 0.0f0 ) ( -1.0f0 -1.0f0  1.0f0 )
    ( 0.0f0 1.0f0 ) ( -1.0f0  1.0f0  1.0f0 )
    ( 1.0f0 1.0f0 ) ( -1.0f0  1.0f0 -1.0f0 )))

(defun load-gl-textures6 ()
  (let ((tex-image (sdl:load-bmp *image6*)))
    (unwind-protect
         (progn
           (gl:gen-textures 1 *texture6*)
           (gl:bind-texture gl:+texture-2d+
                            (sgum:deref-array *texture6*
                                              '(:array gl:uint)
                                              0))
           (gl:tex-image-2d gl:+texture-2d+ 0 3
                            (sdl:surface-w tex-image)
                            (sdl:surface-h tex-image)
                            0 gl:+bgr+
                            gl:+unsigned-byte+
                            (sdl:surface-pixels tex-image))
           (gl:tex-parameter-i gl:+texture-2d+
                               gl:+texture-min-filter+
                               gl:+linear+)
           (gl:tex-parameter-i gl:+texture-2d+
                               gl:+texture-mag-filter+
                               gl:+linear+))
      (sdl:free-surface tex-image))))

(defun initgl6 ()
  (load-gl-textures6)
  (gl:enable gl:+texture-2d+)
  (gl:shade-model gl:+smooth+)
  (gl:clear-color 0.0f0 0.0f0 0.0f0 0.0f0)
  (gl:clear-depth 1.0d0)
  (gl:enable gl:+depth-test+)
  (gl:depth-func gl:+lequal+)
  (gl:hint gl:+perspective-correction-hint+ gl:+nicest+)
  t)

(defun draw-quads6 (quad)
  (gl:begin gl:+quads+)
  (loop for (tex vertex) on quad by #'cddr
        until (null vertex) do
        (apply #'gl:tex-coord-2f tex)
        (apply #'gl:vertex-3f vertex))
  (gl:end))
        
(defun draw-gl-scene6 (surface)
  (declare (ignorable surface))
  (gl:clear (logior gl:+color-buffer-bit+
                    gl:+depth-buffer-bit+))

  (gl:load-identity)

  (gl:translate-f 0f0 0f0 -5f0)
  (gl:rotate-f *rquad6* 1f0 1f0 1f0)
  
  (draw-quads6 *quad6*)
  
  (sdl:gl-swap-buffers)

  (decf *rquad6* 0.15f0)
  t)

(register-tutorial 6
                   :init-gl-fn #'initgl6
                   :event-loop-fn #'event-loop0
                   :update-fn #'draw-gl-scene6)

