(in-package #:nehe-tutorials)

(defparameter *rtri4* 0f0)
(defparameter *rquad4* 0f0)

(defun draw-gl-scene4 (surface)
  (declare (ignorable surface))
  (gl:clear-color 0f0 0f0 0f0 0f0)
  (gl:clear (logior gl:+color-buffer-bit+
                    gl:+depth-buffer-bit+))
  (gl:load-identity)
  (gl:translate-f -1.5f0 0.0f0 -6.0f0)
  (gl:rotate-f *rtri4* 0f0 1f0 0f0)

  (gl:begin gl:+triangles+)

  (gl:color-3f 1f0 0f0 0f0)
  (gl:vertex-3f 0f0 1f0 0f0)

  (gl:color-3f 0f0 1f0 0f0)
  (gl:vertex-3f -1f0 -1f0 0f0)

  (gl:color-3f 0f0 0f0 1f0)
  (gl:vertex-3f 1f0 -1f0 0f0)

  (gl:end)

  (gl:load-identity)
  (gl:translate-f 1.5f0 0f0 -6f0)
  (gl:rotate-f *rquad4* 1f0 0f0 0f0)
  
  (gl:begin gl:+quads+)
  (gl:color-3f 0.5f0 0.5f0 1.0f0)
  (gl:vertex-3f -1f0 1f0 0f0)
  (gl:vertex-3f 1f0 1f0 0f0)
  (gl:vertex-3f 1f0 -1f0 0f0)
  (gl:vertex-3f -1f0 -1f0 0f0)
  (gl:end)
  
  (sdl:gl-swap-buffers)

  (incf *rtri4* 0.2f0)
  (decf *rquad4* 0.15f0)
  t)

(register-tutorial 4
                   :init-gl-fn #'initgl0
                   :event-loop-fn #'event-loop0
                   :update-fn #'draw-gl-scene4)

