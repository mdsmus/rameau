(in-package #:nehe-tutorials)

(defun draw-gl-scene1 (surface)
  (declare (ignorable surface))
  (gl:clear-color 0f0 0f0 0f0 0f0)
  (gl:clear (logior gl:+color-buffer-bit+
                    gl:+depth-buffer-bit+))
  (gl:load-identity)
  (gl:translate-f -1.5f0 0.0f0 -6.0f0)

  (gl:begin gl:+triangles+)
  (gl:color-3f 1f0 1f0 1f0)
  (gl:vertex-3f 0f0 1f0 0f0)
  (gl:vertex-3f -1f0 -1f0 0f0)
  (gl:vertex-3f 1f0 -1f0 0f0)
  (gl:end)
  
  (gl:translate-f 3f0 0f0 0f0)

  (gl:begin gl:+quads+)
  (gl:vertex-3f -1f0 1f0 0f0)
  (gl:vertex-3f 1f0 1f0 0f0)
  (gl:vertex-3f 1f0 -1f0 0f0)
  (gl:vertex-3f -1f0 -1f0 0f0)
  (gl:end)
  (sdl:gl-swap-buffers)
  t)

(register-tutorial 1
                   :init-gl-fn #'initgl0
                   :event-loop-fn #'event-loop0
                   :update-fn #'draw-gl-scene1)

