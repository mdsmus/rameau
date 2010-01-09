(in-package #:nehe-tutorials)

(declaim (type cl:single-float *z10* *xspeed10* *yspeed10* *xrot10* *yrot10*))
(defparameter *zpos10* 5f0)
(defparameter *xpos10* 0f0)
(defparameter *ypos10* 0f0)
(defparameter *yrot10* 0f0)
(defparameter *blend-p10* nil)
(defparameter *pi/180* (/ pi 180f0))
(defparameter *walkbiasangle10* 0f0)
(defparameter *walkbias10* 0f0)
(defparameter *lookupdown10* 0f0)

(defparameter *worldfile10* (data-file "tut10" "world"))
(defparameter *image10* (data-file "cl-sdl" "bmp"))

(sgum:def-foreign-type uint* (* gl:uint))
(defvar *texture10* (sgum:allocate-foreign-object gl:uint 3))
(declaim (type uint* *texture10*))

(defparameter *filter10* 0)
(defvar *light-ambient10*
  (sgum:allocate-foreign-object sgum:c-single-float 4))
(defvar *light-diffuse10*
  (sgum:allocate-foreign-object sgum:c-single-float 4))
(defvar *light-position10*
  (sgum:allocate-foreign-object sgum:c-single-float 4))

(defun init-float-array10 (array &rest values)
  (loop for v in values
        for i from 0 do
        (setf (sgum:deref-array array
                                (:array sgum:c-single-float)
                                i)
              v)))

(init-float-array10 *light-ambient10* 0.5f0 0.5f0 0.5f0 1.0f0)
(init-float-array10 *light-diffuse10* 1f0 1f0 1f0 1f0)
(init-float-array10 *light-position10* 0f0 0f0 2f0 1f0)

(defstruct (vertex10
             (:constructor make-vertex10 (x y z u v)))
  (x 0f0 :type single-float)
  (y 0f0 :type single-float)
  (z 0f0 :type single-float)
  (u 0f0 :type single-float)
  (v 0f0 :type single-float))

(defstruct triangle10
  (vertices (make-array 3 :element-type 'vertex10)
            :type (simple-array vertex10)))

(defstruct sector10
  (num-triangles 0 :type integer)
  triangles)

(defparameter *sector10* (make-sector10))

(declaim (inline get-texture10))
(defun get-texture10 (i)
  (declare (optimize (speed 3)))
  (sgum:deref-array *texture10*
                    (:array gl:uint)
                    i))

(defun safer-read (stream)
  (let ((*read-eval* nil))
    (read stream nil nil)))

(defun setup-world10 ()
  (with-open-file (stream *worldfile10*
                          :direction :input)
    (let* ((vertices
            (loop for vertex = (safer-read stream)
                  while vertex
                  collect vertex))
           (polys
            (loop for (v1 v2 v3) on vertices by #'cdddr
                  until (null v3) collect
                  (let ((tri (make-triangle10)))
                    (setf (triangle10-vertices tri)
                          (make-array 3 :element-type 'vertex10
                                      :initial-contents
                                      (list (apply #'make-vertex10
                                                   v1)
                                            (apply #'make-vertex10
                                                   v2)
                                            (apply #'make-vertex10
                                                   v3))))
                    tri)))
           (polys-v (coerce polys 'vector)))
      (setf (sector10-num-triangles *sector10*) (length polys-v))
      (setf (sector10-triangles *sector10*) polys-v))))

(defun load-gl-textures10 ()
  (let ((tex-image (sdl:load-bmp *image10*)))
    (unwind-protect
         (progn
           (gl:gen-textures 3 *texture10*)
           ;; Texture 1
           (gl:bind-texture gl:+texture-2d+
                            (get-texture10 0))
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
                            (get-texture10 1))
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
                            (get-texture10 2))
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

(defun initgl10 ()
  (load-gl-textures10)
  (setup-world10)
  (gl:enable gl:+texture-2d+)
  (gl:shade-model gl:+smooth+)
  (gl:clear-color 0.0f0 0.0f0 0.0f0 0.0f0)
  (gl:clear-depth 1.0d0)
  (gl:enable gl:+depth-test+)
  (gl:depth-func gl:+lequal+)
  (gl:hint gl:+perspective-correction-hint+ gl:+nicest+)
  (gl:color-4f 1f0 1f0 1f0 0.5f0)
  (gl:blend-func gl:+src-alpha+ gl:+one+)
  (gl:light-fv gl:+light1+ gl:+ambient+ *light-ambient10*)
  (gl:light-fv gl:+light1+ gl:+diffuse+ *light-diffuse10*)
  (gl:light-fv gl:+light1+ gl:+position+ *light-position10*)
  (gl:enable gl:+light1+)
  t)

(defun draw-quads10 (quads)
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

(defun draw-gl-scene10 (surface)
  (declare (ignorable surface)
           (optimize (speed 3)))
  (let ((sceneroty (- 360f0 *yrot10*))
        (xtrans (coerce (- *xpos10*) 'single-float))
        (ytrans (coerce (- 0 *walkbias10* 0.25f0) 'single-float))
        (ztrans (coerce (- *zpos10*) 'single-float)))
    (gl:clear (logior gl:+color-buffer-bit+
                      gl:+depth-buffer-bit+))

    (gl:load-identity)


    (gl:rotate-f *lookupdown10* 1f0 0f0 0f0)
    (gl:rotate-f sceneroty 0f0 1f0 0f0)
    (gl:translate-f xtrans ytrans ztrans)

    (gl:bind-texture gl:+texture-2d+ (get-texture10 *filter10*))

    (loop for tri across (sector10-triangles *sector10*) do
          (gl:begin gl:+triangles+)
          (gl:normal-3f 0f0 0f0 1f0)
          (loop for v across (triangle10-vertices tri) do
                (gl:tex-coord-2f (vertex10-u v)
                                 (vertex10-v v))
                (gl:vertex-3f (vertex10-x v)
                              (vertex10-y v)
                              (vertex10-z v)))
          (gl:end))
  
  
    (sdl:gl-swap-buffers)

    t))

(defparameter *lighting-p10* nil)
(defun handle-keypress10 (key)
  (cond
    ((eql (char-code #\l) key)
     (if *lighting-p10*
         (gl:disable gl:+lighting+)
         (gl:enable gl:+lighting+))
     (setf *lighting-p10* (not *lighting-p10*)))
    ((eql (char-code #\f) key)
     (setf *filter10*
           (mod (1+ *filter10*) 3))
     (format t "~&Filter: ~A~%" *filter10*))
    ((eql (char-code #\b) key)
     (setf *blend-p10* (not *blend-p10*))
     (cond (*blend-p10*
            (gl:enable gl:+blend+)
            (gl:disable gl:+depth-test+))
           (t
            (gl:disable gl:+blend+)
            (gl:enable gl:+depth-test+))))
    ((eql 275 key) ; right arrow
     (decf *yrot10* 1.5f0))
    ((eql 273 key) ; up arrow
     (decf *xpos10* (* (sin (* *yrot10* *pi/180*)) 0.05f0))
     (decf *zpos10* (* (cos (* *yrot10* *pi/180*)) 0.05f0))
     (if (>= *walkbiasangle10* 359.0f0)
         (setf *walkbiasangle10* 0f0)
         (incf *walkbiasangle10* 10f0))
     (setf *walkbias10* (/ (sin (* *walkbiasangle10* *pi/180*))
                           20.0f0)))
    ((eql 276 key) ; left arrow
     (incf *yrot10* 1.5f0))
    ((eql 274 key) ; down arrow
     (incf *xpos10* (* (sin (* *yrot10* *pi/180*)) 0.05f0))
     (incf *zpos10* (* (cos (* *yrot10* *pi/180*)) 0.05f0))
     (if (<= *walkbiasangle10* 1f0)
         (setf *walkbiasangle10* 359f0)
         (decf *walkbiasangle10* 10f0))
     (setf *walkbias10* (/ (sin (* *walkbiasangle10* *pi/180*))
                           20.0f0)))
    (t
     (format t "~&Unbound key code: ~A~%" key))))
  
(register-tutorial 10
                   :init-gl-fn #'initgl10
                   :event-loop-fn #'event-loop0
                   :update-fn #'draw-gl-scene10
                   :handle-keypress-fn #'handle-keypress10)

