(in-package #:nehe-tutorials)

(defparameter *rtri-vertex-array* 0f0)
(defparameter *rquad-vertex-array* 0f0)

(defparameter *tri-vertex-array*
  (coerce '(1.0 0.0 0.0 0.0 1.0 0.0
            0.0 1.0 0.0 -1.0 -1.0 1.0
            0.0 0.0 1.0 1.0 -1.0 1.0
            0.0 1.0 0.0 1.0 -1.0 -1.0
            0.0 0.0 1.0 -1.0 -1.0 -1.0)
          '(vector single-float)))

(defparameter *tri-indices-vertex-array*
  (coerce '(0 1 2
            0 2 3
            0 3 4
            0 4 1)
          '(vector (unsigned-byte 8))))

(defparameter *quad-vertices-vertex-array*
  '((-1f0 1f0 1f0)
    (1f0 1f0 1f0)
    (1f0 -1f0 1f0)
    (-1f0 -1f0 1f0)
    (1f0 1f0 -1f0)
    (1f0 -1f0 -1f0)
    (-1f0 -1f0 -1f0)
    (-1f0 1f0 -1f0)))

;; A color cube!
(defparameter *quad-colors-vertex-array*
  '((0f0 1f0 1f0)
    (1f0 1f0 1f0)
    (1f0 0f0 1f0)
    (0f0 0f0 1f0)
    (1f0 1f0 0f0)
    (1f0 0f0 0f0)
    (0f0 0f0 0f0)
    (0f0 1f0 0f0)))

(defparameter *quad-indices-vertex-array*
  (coerce '(0 3 2 1
            1 2 5 4
            4 5 6 7
            0 7 6 3
            0 1 4 7
            2 3 6 5)
          '(vector (unsigned-byte 8))))

(defparameter *quad-vertex-array*
  (coerce (loop for color in *quad-colors-vertex-array*
                and vertex in *quad-vertices-vertex-array*
                append color
                append vertex)
          '(vector single-float)))
                
(defun draw-triangles-vertex-array ()
  (gl:with-vertex-array-in-use (va *tri-vertex-array* :float)
    (gl:interleaved-arrays gl:+c3f-v3f+ 0 va)
    (sgum:with-octet-vector (indices *tri-indices-vertex-array*)
      (gl:draw-elements gl:+triangles+
                        (length *tri-indices-vertex-array*)
                        gl:+unsigned-byte+
                        indices))))

(defun draw-quads-vertex-array (quad)
  (gl:with-vertex-array-in-use (va quad :float)
    (gl:interleaved-arrays gl:+c3f-v3f+ 0 va)
    (sgum:with-octet-vector (indices *quad-indices-vertex-array*)
      (gl:draw-elements gl:+quads+
                        (length *quad-indices-vertex-array*)
                        gl:+unsigned-byte+
                        indices))))
        
(defun draw-gl-scene-vertex-array (surface)
  (declare (ignorable surface))

  (gl:clear (logior gl:+color-buffer-bit+
                    gl:+depth-buffer-bit+))

  (gl:load-identity)
  (gl:translate-f -1.5f0 0.0f0 -6.0f0)
  (gl:rotate-f *rtri-vertex-array* 0f0 1f0 0f0)

  (draw-triangles-vertex-array)
  
  (gl:load-identity)
  (gl:translate-f 1.5f0 0f0 -6f0)
  (gl:rotate-f *rquad-vertex-array* 1f0 1f0 1f0)
  (gl:color-3f 0.5f0 0.5f0 1.0f0)
  
  (draw-quads-vertex-array *quad-vertex-array*)
  
  (sdl:gl-swap-buffers)

  (incf *rtri-vertex-array* 0.2f0)
  (decf *rquad-vertex-array* 0.15f0)
  t)

(defun initgl-vertex-array ()
  (gl:shade-model gl:+smooth+)

  (gl:clear-color 0.0f0 0.0f0 0.0f0 0.0f0)
  (gl:clear-depth 1.0d0)
  (gl:enable gl:+depth-test+)
  (gl:depth-func gl:+lequal+)
  (gl:hint gl:+perspective-correction-hint+ gl:+nicest+)
  (gl:enable-client-state gl:+vertex-array+)
  (gl:enable-client-state gl:+color-array+)
  
  t)

(register-tutorial :vertex-array
                   :init-gl-fn #'initgl-vertex-array
                   :event-loop-fn #'event-loop0
                   :update-fn #'draw-gl-scene-vertex-array)

