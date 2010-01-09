(in-package #:nehe-tutorials)

(defparameter *rtri5* 0f0)
(defparameter *rquad5* 0f0)

(defparameter *tri5*
  '((1f0 0f0 0f0) (0f0 1f0 0f0)
    (0f0 1f0 0f0) (-1f0 -1f0 1f0)
    (0f0 0f0 1f0) (1f0 -1f0 1f0)

    (1f0 0f0 0f0) (0f0 1f0 0f0)
    (0f0 0f0 1f0) (1f0 -1f0 1f0)
    (0f0 1f0 0f0) (1f0 -1f0 -1f0)

    (1f0 0f0 0f0) (0f0 1f0 0f0)
    (0f0 1f0 0f0) (1f0 -1f0 -1f0)
    (0f0 0f0 1f0) (-1f0 -1f0 -1f0)

    (1f0 0f0 0f0) (0f0 1f0 0f0)
    (0f0 0f0 1f0) (-1f0 -1f0 -1f0)
    (0f0 1f0 0f0) (-1f0 -1f0 1f0)))

(defparameter *quad5*
  '((0.0f0 1.0f0 0.0f0)
    ( 1.0f0  1.0f0 -1.0f0)			
    (-1.0f0  1.0f0 -1.0f0)			
    (-1.0f0  1.0f0  1.0f0)			
    ( 1.0f0  1.0f0  1.0f0)	

    (1.0f0 0.5f0 0.0f0)
    ( 1.0f0 -1.0f0  1.0f0)
    (-1.0f0 -1.0f0  1.0f0)
    (-1.0f0 -1.0f0 -1.0f0)
    ( 1.0f0 -1.0f0 -1.0f0)

    (1.0f0 0.0f0 0.0f0)
    ( 1.0f0  1.0f0  1.0f0)
    (-1.0f0  1.0f0  1.0f0)
    (-1.0f0 -1.0f0  1.0f0)
    ( 1.0f0 -1.0f0  1.0f0)

    (1.0f0 1.0f0 0.0f0)
    ( 1.0f0 -1.0f0 -1.0f0)
    (-1.0f0 -1.0f0 -1.0f0)
    (-1.0f0  1.0f0 -1.0f0)
    ( 1.0f0  1.0f0 -1.0f0)

    (0.0f0 0.0f0 1.0f0)
    (-1.0f0  1.0f0  1.0f0)
    (-1.0f0  1.0f0 -1.0f0)
    (-1.0f0 -1.0f0 -1.0f0)
    (-1.0f0 -1.0f0  1.0f0)

    (1.0f0 0.0f0 1.0f0)
    ( 1.0f0  1.0f0 -1.0f0)
    ( 1.0f0  1.0f0  1.0f0)
    ( 1.0f0 -1.0f0  1.0f0)
    ( 1.0f0 -1.0f0 -1.0f0)))

(defun draw-triangles5 (tri)
  (gl:begin gl:+triangles+)
  (loop for (color-triple vertex-triple) on tri by #'cddr
        until (null vertex-triple) do
        (apply #'gl:color-3f color-triple)
        (apply #'gl:vertex-3f vertex-triple))
  (gl:end))

(defun 5cdr (x)
  (nthcdr 5 x))

(defun draw-quads5 (quad)
  (gl:begin gl:+quads+)
  (loop for (color-triple v1 v2 v3 v4) on quad by #'5cdr
        until (or (null v1) (null v2) (null v3) (null v4)) do
        (apply #'gl:color-3f color-triple)
        (apply #'gl:vertex-3f v1)
        (apply #'gl:vertex-3f v2)
        (apply #'gl:vertex-3f v3)
        (apply #'gl:vertex-3f v4))
  (gl:end))
        
(defun draw-gl-scene5 (surface)
  (declare (ignorable surface))
  ;(gl:clear-color 0f0 0f0 0f0 0f0)
  (gl:clear (logior gl:+color-buffer-bit+
                    gl:+depth-buffer-bit+))

  (gl:load-identity)
  (gl:translate-f -1.5f0 0.0f0 -6.0f0)
  (gl:rotate-f *rtri5* 0f0 1f0 0f0)

  (draw-triangles5 *tri5*)
  
  (gl:load-identity)
  (gl:translate-f 1.5f0 0f0 -6f0)
  (gl:rotate-f *rquad5* 1f0 1f0 1f0)
  (gl:color-3f 0.5f0 0.5f0 1.0f0)
  
  (draw-quads5 *quad5*)
  
  (sdl:gl-swap-buffers)

  (incf *rtri5* 0.2f0)
  (decf *rquad5* 0.15f0)
  t)

(register-tutorial 5
                   :init-gl-fn #'initgl0
                   :event-loop-fn #'event-loop0
                   :update-fn #'draw-gl-scene5)

