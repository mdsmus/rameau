(in-package #:nehe-tutorials)

(flet ((draw-sphere (size)
         (glu:with-quadric (sphere)
           (glu:quadric-draw-style sphere glu:+fill+)
           (glu:quadric-normals sphere glu:+smooth+)
           (glu:sphere sphere size 25 20))))

  (defun initgl-lighting ()
    (gl:clear-color 0f0 0f0 0f0 0f0)
    (gl:clear-depth 1d0)
    (gl:shade-model gl:+smooth+)
    (sgum:with-single-float-values (mat-spec 1f0 1f0 1f0 1f0)
      (gl:material-fv gl:+front+ gl:+specular+ mat-spec))
    (sgum:with-single-float-values (mat-shin 50f0)
      (gl:material-fv gl:+front+ gl:+shininess+ mat-shin))
    (sgum:with-single-float-values (light-pos 1f0 1f0 1f0 0f0)
      (gl:light-fv gl:+light0+ gl:+position+ light-pos))
    (gl:enable gl:+lighting+)
    (gl:enable gl:+light0+)
    (gl:enable gl:+depth-test+)
    t)

  (defun draw-gl-scene-lighting (surface)
    (declare (ignorable surface))
    (gl:clear (logior gl:+color-buffer-bit+
                      gl:+depth-buffer-bit+))
    (gl:load-identity)

    (glu:look-at 0d0 0d0 5d0 0d0 0d0 0d0 0d0 1d0 0d0)
    (sgum:with-single-float-values (light-pos 1f0 1f0 1f0 0f0)
      (gl:light-fv gl:+light0+ gl:+position+ light-pos))
    (draw-sphere 1d0)
    (sdl:gl-swap-buffers)
    t))
  
(register-tutorial :lighting
                   :init-gl-fn #'initgl-lighting
                   :event-loop-fn #'event-loop0
                   :update-fn #'draw-gl-scene-lighting)