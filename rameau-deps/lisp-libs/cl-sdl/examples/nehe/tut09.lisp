(in-package #:nehe-tutorials)

(defparameter *image9* (data-file "star" "bmp"))

(sgum:def-foreign-type uint* (* gl:uint))
(defvar *texture9* (sgum:allocate-foreign-object 'gl:uint))
(declaim (type uint* *texture9*))

(declaim (type fixnum *num-stars9*))
(defparameter *num-stars9* 50)

(declaim (type single-float *zoom9* *tilt9* *spin9*))
(defparameter *zoom9* -15f0)
(defparameter *tilt9* 90f0)
(defparameter *spin9* 0f0)

(declaim (type boolean *twinkle9*))
(defparameter *twinkle9* nil)

(defstruct star9
  (r 0 :type (unsigned-byte 8))
  (g 0 :type (unsigned-byte 8))
  (b 0 :type (unsigned-byte 8))
  (dist 0f0 :type cl:single-float)
  (angle 0f0 :type cl:single-float))


(declaim (type (simple-array star9) *stars9*))
(defparameter *stars9*
  (make-array *num-stars9*
              :element-type 'star9
              :initial-contents (loop repeat *num-stars9*
                                      collect (make-star9))))

(defun load-gl-textures9 ()
  (let ((tex-image (sdl:load-bmp *image9*)))
    (unwind-protect
         (progn
           (gl:gen-textures 1 *texture9*)
           (gl:bind-texture gl:+texture-2d+
                            (sgum:deref-array *texture9*
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

(defun initgl9 ()
  (load-gl-textures9)
  (gl:enable gl:+texture-2d+)
  (gl:shade-model gl:+smooth+)
  (gl:clear-color 0.0f0 0.0f0 0.0f0 0.0f0)
  (gl:clear-depth 1.0d0)
  (gl:hint gl:+perspective-correction-hint+ gl:+nicest+)
  (gl:blend-func gl:+src-alpha+ gl:+one+)
  (gl:enable gl:+blend+)
  (loop for star across *stars9*
        for i from 0 do
        (setf (star9-angle star) 0f0)
        (setf (star9-dist star) (* 5f0 (/ i *num-stars9*)))
        (setf (star9-r star) (random 256))
        (setf (star9-g star) (random 256))
        (setf (star9-b star) (random 256)))
  t)

(let ((spin (make-array 1
                        :element-type 'single-float
                        :initial-element 0f0)))
  ;; ah, the lengths one will go to avoid consing at all cost
  (declare (type (simple-array single-float) spin))
  (defun draw-gl-scene9 (surface)
    (declare (ignorable surface)
             (optimize (speed 3) (safety 0)))

    (gl:clear (logior gl:+color-buffer-bit+
                      gl:+depth-buffer-bit+))
    (gl:bind-texture gl:+texture-2d+
                     (sgum:deref-array *texture9*
                                       '(:array gl:uint)
                                       0))
    (loop for star across *stars9*
          for i of-type fixnum from 0 do
          (gl:load-identity)
          (gl:translate-f 0f0 0f0 *zoom9*)
          (gl:rotate-f *tilt9* 1f0 0f0 0f0)
          (gl:rotate-f (star9-angle star) 0f0 1f0 0f0)
          (gl:translate-f (star9-dist star) 0f0 0f0)
          (gl:rotate-f (- (star9-angle star)) 0f0 1f0 0f0)
          (gl:rotate-f (- *tilt9*) 1f0 0f0 0f0)      

          (when *twinkle9*
            (let ((other-star (aref *stars9* (- *num-stars9* i 1))))
              (gl:color-4ub (star9-r other-star)
                            (star9-g other-star)
                            (star9-b other-star)
                            255)
              (gl:begin gl:+quads+)
              (gl:tex-coord-2f 0f0 0f0)
              (gl:vertex-3f -1f0 -1f0 0f0)
              (gl:tex-coord-2f 1f0 0f0)
              (gl:vertex-3f 1f0 -1f0 0f0)
              (gl:tex-coord-2f 1f0 1f0)
              (gl:vertex-3f 1f0 1f0 0f0)
              (gl:tex-coord-2f 0f0 1f0)
              (gl:vertex-3f -1f0 1f0 0f0)
              (gl:end)))

          (gl:rotate-f (aref spin 0) 0f0 0f0 1f0)
          (gl:color-4ub (star9-r star)
                        (star9-b star)
                        (star9-g star)
                        255)
          (gl:begin gl:+quads+)
          (gl:tex-coord-2f 0f0 0f0)
          (gl:vertex-3f -1f0 -1f0 0f0)
          (gl:tex-coord-2f 1f0 0f0)
          (gl:vertex-3f 1f0 -1f0 0f0)
          (gl:tex-coord-2f 1f0 1f0)
          (gl:vertex-3f 1f0 1f0 0f0)
          (gl:tex-coord-2f 0f0 1f0)
          (gl:vertex-3f -1f0 1f0 0f0)
          (gl:end)
          (incf (aref spin 0) 0.01f0)

          (incf (star9-angle star) (/ (float i)
                                      (float *num-stars9*)))
          (decf (star9-dist star) 0.01f0)
          
          (when (< (star9-dist star) 0f0)
            (incf (star9-dist star) 5.0f0)
            (setf (star9-r star) (random 256))
            (setf (star9-g star) (random 256))
            (setf (star9-b star) (random 256))))
    
    (sdl:gl-swap-buffers)
    t))

(defun handle-keypress9 (key)
  (cond
    ((eql (char-code #\t) key)
     (setf *twinkle9* (not *twinkle9*)))
    ((eql 273 key) ; up arrow
     (decf *tilt9* 0.5f0))
    ((eql 274 key) ; down arrow
     (incf *tilt9* 0.5f0))
    ((eql 281 key) ; pgdown
     (incf *zoom9* 0.2f0))
    ((eql 280 key) ; pgup
     (decf *zoom9* 0.2f0))
    (t
     (format t "~&Unbound key code: ~A~%" key))))

(register-tutorial 9
                   :init-gl-fn #'initgl9
                   :event-loop-fn #'event-loop0
                   :update-fn #'draw-gl-scene9
                   :handle-keypress-fn #'handle-keypress9)

