(in-package #:nehe-tutorials)

(defparameter *points11*
  (make-array '(45 45 3)
              :element-type 'single-float
              :initial-element 0f0))

(defparameter *image11* (data-file "cl-sdl" "bmp"))

(sgum:def-foreign-type uint* (* gl:uint))

(defvar *texture11* (sgum:allocate-foreign-object 'gl:uint))
(declaim (type uint* *texture11*))

(defun load-gl-textures11 ()
  (let ((tex-image (sdl:load-bmp *image11*)))
    (unwind-protect
         (progn
           (gl:gen-textures 1 *texture11*)
           (gl:bind-texture gl:+texture-2d+
                            (sgum:deref-array *texture11*
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

(defun initgl11 ()
  (load-gl-textures11)
  (gl:enable gl:+texture-2d+)
  (gl:shade-model gl:+smooth+)
  (gl:clear-color 0.0f0 0.0f0 0.0f0 0.0f0)
  (gl:clear-depth 1.0d0)
  (gl:enable gl:+depth-test+)
  (gl:depth-func gl:+lequal+)
  (gl:hint gl:+perspective-correction-hint+ gl:+nicest+)
  ;;(gl:polygon-mode gl:+back+ gl:+fill+)
  ;;(gl:polygon-mode gl:+front+ gl:+line+)
  (let ((p *points11*))
    (dotimes (x 45)
      (dotimes (y 45)
        (setf (aref p x y 0)
              (- (/ x 5f0) 4.5f0))
        (setf (aref p x y 1)
              (- (/ y 5f0) 4.5f0))
        (setf (aref p x y 2)
              (coerce (sin (* (/ (* (/ x 5f0)
                                    40f0)
                                 360f0)
                              pi
                              2f0))
                      'single-float)))))
  t)

        
(let ((wiggle-count 0)
      (ftmps (make-array 4 :element-type 'single-float :initial-element 0f0)))
  (declare (type (integer 0 10) wiggle-count)
           (type (simple-array single-float) ftmps))
  (defun draw-gl-scene11 (surface)
    (declare (ignorable surface)
             (optimize (speed 3)))
    (let ((p *points11*))
      (declare (type (array single-float (45 45 3)) p))
      (gl:clear (logior gl:+color-buffer-bit+
                        gl:+depth-buffer-bit+))
    
      (gl:load-identity)

      (gl:rotate-f 180f0 1f0 0f0 0f0)
      (gl:translate-f 0f0 0f0 12f0)
      
      ;;(gl:rotate-f *xrot11* 1f0 1f0 1f0)
      (gl:bind-texture gl:+texture-2d+
                       (sgum:deref-array *texture11*
                                         '(:array gl:uint)
                                         0))
      (gl:begin gl:+quads+)
      (dotimes (x 44)
        (dotimes (y 44)
          (setf (aref ftmps 0) (/ x 44f0)
                (aref ftmps 1) (/ y 44f0)
                (aref ftmps 2) (/ (1+ x) 44f0)
                (aref ftmps 3) (/ (1+ y) 44f0))
          (gl:tex-coord-2f (aref ftmps 0) (aref ftmps 1))
          (gl:vertex-3f (aref p x y 0)
                        (aref p x y 1)
                        (aref p x y 2))

          (gl:tex-coord-2f (aref ftmps 0) (aref ftmps 3))
          (gl:vertex-3f (aref p x (1+ y) 0)
                        (aref p x (1+ y) 1)
                        (aref p x (1+ y) 2))

          (gl:tex-coord-2f (aref ftmps 2) (aref ftmps 3))
          (gl:vertex-3f (aref p (1+ x) (1+ y) 0)
                        (aref p (1+ x) (1+ y) 1)
                        (aref p (1+ x) (1+ y) 2))

          (gl:tex-coord-2f (aref ftmps 2) (aref ftmps 1))
          (gl:vertex-3f (aref p (1+ x) y 0)
                        (aref p (1+ x) y 1)
                        (aref p (1+ x) y 2))))

      (gl:end)
    
      (sdl:gl-swap-buffers)
    
      (when (>= wiggle-count 2)
        (dotimes (y 45)
          (let ((hold (aref p 0 y 2)))
            (dotimes (x 44)
              (setf (aref p x y 2)
                    (aref p (1+ x) y 2)))
            (setf (aref p 44 y 2) hold)))
        (setf wiggle-count 0))
      (incf wiggle-count)
      t)))

(register-tutorial 11
                   :init-gl-fn #'initgl11
                   :event-loop-fn #'event-loop0
                   :update-fn #'draw-gl-scene11)

