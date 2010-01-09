(in-package #:nehe-tutorials)

(declaim (type cl:single-float *z16* *xspeed16* *yspeed16* *xrot16* *yrot16*))
(defparameter *z16* -5f0)
(defparameter *xspeed16* 0f0)
(defparameter *yspeed16* 0f0)
(defparameter *xrot16* 0f0)
(defparameter *yrot16* 0f0)
(defparameter *blend-p16* nil)
(defparameter *fogfilter16* 0)
(defparameter *fogmode16* (vector gl:+exp+ gl:+exp2+ gl:+linear+))

(defvar *fogcolor16*
  (sgum:allocate-foreign-object 'sgum:c-single-float 4))

(defparameter *image16* (data-file "cl-sdl" "bmp"))

(sgum:def-foreign-type uint* (* gl:uint))
(defvar *texture16* (sgum:allocate-foreign-object gl:uint 3))
(declaim (type uint* *texture16*))

(defparameter *filter16* 0)
(defvar *light-ambient16*
  (sgum:allocate-foreign-object sgum:c-single-float 4))
(defvar *light-diffuse16*
  (sgum:allocate-foreign-object sgum:c-single-float 4))
(defvar *light-position16*
  (sgum:allocate-foreign-object sgum:c-single-float 4))

(defun init-float-array16 (array &rest values)
  (loop for v in values
        for i from 0 do
        (setf (sgum:deref-array array
                                (:array sgum:c-single-float)
                                i)
              v)))

(init-float-array16 *light-ambient16* 0.5f0 0.5f0 0.5f0 1.0f0)
(init-float-array16 *light-diffuse16* 1f0 1f0 1f0 1f0)
(init-float-array16 *light-position16* 0f0 0f0 2f0 1f0)

(init-float-array16 *fogcolor16* 0.5f0 0.5f0 0.5f0 1f0)


(defparameter *quad16*
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

(declaim (inline get-texture16))
(defun get-texture16 (i)
  (declare (optimize (speed 3)))
  (sgum:deref-array *texture16*
                    (:array gl:uint)
                    i))

(defun load-gl-textures16 ()
  (let ((tex-image (sdl:load-bmp *image16*)))
    (unwind-protect
         (progn
           (gl:gen-textures 3 *texture16*)
           ;; Texture 1
           (gl:bind-texture gl:+texture-2d+
                            (get-texture16 0))
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
                            (get-texture16 1))
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
                            (get-texture16 2))
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

(defun initgl16 ()
  (load-gl-textures16)
  (gl:enable gl:+texture-2d+)
  (gl:shade-model gl:+smooth+)
  (gl:clear-color 0.5f0 0.5f0 0.5f0 1.0f0)
  (gl:clear-depth 1.0d0)
  (gl:enable gl:+depth-test+)
  (gl:depth-func gl:+lequal+)
  (gl:hint gl:+perspective-correction-hint+ gl:+nicest+)
  (gl:color-4f 1f0 1f0 1f0 0.5f0)
  (gl:blend-func gl:+src-alpha+ gl:+one+)
  (gl:light-fv gl:+light1+ gl:+ambient+ *light-ambient16*)
  (gl:light-fv gl:+light1+ gl:+diffuse+ *light-diffuse16*)
  (gl:light-fv gl:+light1+ gl:+position+ *light-position16*)
  (gl:enable gl:+light1+)
  (gl:fog-i gl:+fog-mode+ (aref *fogmode16* *fogfilter16*))
  (gl:fog-fv gl:+fog-color+ *fogcolor16*)
  (gl:fog-f gl:+fog-density+ 0.35f0)
  (gl:hint gl:+fog-hint+ gl:+dont-care+)
  (gl:fog-f gl:+fog-start+ 1f0)
  (gl:fog-f gl:+fog-end+ 5f0)
  (gl:enable gl:+fog+)
  t)

(defun draw-quads16 (quads)
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

(defun draw-gl-scene16 (surface)
  (declare (ignorable surface)
           (optimize (speed 3)))
  
  (gl:clear (logior gl:+color-buffer-bit+
                    gl:+depth-buffer-bit+))

  (gl:load-identity)

  (gl:translate-f 0f0 0f0 *z16*)
  (gl:rotate-f *xrot16* 1f0 0f0 1f0)
  (gl:rotate-f *yrot16* 0f0 1f0 0f0)
  (gl:bind-texture gl:+texture-2d+ (get-texture16 *filter16*))
  (draw-quads16 *quad16*)
  
  (sdl:gl-swap-buffers)

  (incf *xrot16* *xspeed16*)
  (incf *yrot16* *yspeed16*)
  t)

(defparameter *lighting-p16* nil)
(defun handle-keypress16 (key)
  (cond
    ((eql (char-code #\l) key)
     (if *lighting-p16*
         (gl:disable gl:+lighting+)
         (gl:enable gl:+lighting+))
     (setf *lighting-p16* (not *lighting-p16*)))
    ((eql (char-code #\f) key)
     (setf *filter16*
           (mod (1+ *filter16*) 3))
     (format t "~&Filter: ~A~%" *filter16*))
    ((eql (char-code #\b) key)
     (setf *blend-p16* (not *blend-p16*))
     (cond (*blend-p16*
            (gl:enable gl:+blend+)
            (gl:disable gl:+depth-test+))
           (t
            (gl:disable gl:+blend+)
            (gl:enable gl:+depth-test+))))
    ((eql (char-code #\g) key)
     (setf *fogfilter16* (mod (1+ *fogfilter16*) 3))
     (gl:fog-i gl:+fog-mode+ (aref *fogmode16* *fogfilter16*))
     (format t "~&Fog: ~A~%" *fogfilter16*))
    ((eql 275 key) ; right arrow
     (incf *yspeed16* 0.01f0))
    ((eql 273 key) ; up arrow
     (decf *xspeed16* 0.01f0))
    ((eql 276 key) ; left arrow
     (decf *yspeed16* 0.01f0))
    ((eql 274 key) ; down arrow
     (incf *xspeed16* 0.01f0))
    ((eql 281 key) ; pgdown
     (incf *z16* 0.02f0))
    ((eql 280 key) ; pgup
     (decf *z16* 0.02f0))
    (t
     (format t "~&Unbound key code: ~A~%" key))))
  
(register-tutorial 16
                   :init-gl-fn #'initgl16
                   :event-loop-fn #'event-loop0
                   :update-fn #'draw-gl-scene16
                   :handle-keypress-fn #'handle-keypress16)

