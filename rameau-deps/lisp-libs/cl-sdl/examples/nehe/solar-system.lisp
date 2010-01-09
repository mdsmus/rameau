(in-package #:nehe-tutorials)

(defvar *solar-system-sun*)
(defvar *solar-system-planet*)
(defvar *solar-system-satellite*)
(defparameter *xspeed-ss* 0f0)
(defparameter *yspeed-ss* 0f0)
(defparameter *z-ss* 10f0)

(declaim (inline sf))
(defun sf (x)
  (coerce x 'single-float))

(defun draw-solar-system-body (size)
  (glu:with-quadric (sphere)
    (glu:quadric-draw-style sphere glu:+fill+)
    (glu:quadric-normals sphere glu:+smooth+)
    (glu:sphere sphere size 25 20)))


(defun initgl-solar-system ()
  (setf *solar-system-sun* (gl:gen-lists 1))
  (setf *solar-system-planet* (gl:gen-lists 1))
  (setf *solar-system-satellite* (gl:gen-lists 1))
  (gl:new-list *solar-system-sun* gl:+compile+)
  (draw-solar-system-body 0.40d0)
  (gl:end-list)

  (gl:new-list *solar-system-planet* gl:+compile+)
  (draw-solar-system-body 0.20d0)
  (gl:end-list)

  (gl:new-list *solar-system-satellite* gl:+compile+)
  (draw-solar-system-body 0.10d0)
  (gl:end-list)
  
  (gl:shade-model gl:+smooth+)
  (gl:clear-color 0.0f0 0.0f0 0.0f0 0.0f0)
  (gl:clear-depth 1.0d0)
  (gl:enable gl:+depth-test+)
  (gl:depth-func gl:+lequal+)
  (gl:hint gl:+perspective-correction-hint+ gl:+nicest+)

  (sgum:with-single-float-values (mat-spec 0.5f0 0.5f0 0.3f0 1f0)
    (gl:material-fv gl:+front+ gl:+specular+ mat-spec))
  (sgum:with-single-float-values (mat-shin 30f0)
    (gl:material-fv gl:+front+ gl:+shininess+ mat-shin))
  (sgum:with-single-float-values (light-amb 0.2f0 0.2f0 0.2f0 1f0)
    (gl:light-fv gl:+light0+ gl:+ambient+ light-amb))
  (sgum:with-single-float-values (light-diff 1f0 1f0 1f0 1f0)
    (gl:light-fv gl:+light0+ gl:+diffuse+ light-diff))
  
  (gl:enable gl:+lighting+)
  (gl:enable gl:+light0+)

  (gl:enable gl:+color-material+)
  (gl:color-material gl:+front+ gl:+position+)
  
  t)

(flet ((init-body-data (array n &rest args)
         ;;tx ty tz cr cg cb ra rx ry rz r1 r2
         (loop for arg in args
               for i from 0 do
               (setf (aref array n i) arg))))
  (let* ((rot-vec (make-array 2 :element-type 'single-float
                              :initial-element 0f0))
         (num-bodies 5)
         (body-data (make-array `(,num-bodies 12)
                                :element-type 'single-float
                                :initial-element 0f0))
         (satellite-p (make-array num-bodies
                                  :element-type 'boolean
                                  :initial-element nil))
         (satellite-data (make-array `(,num-bodies 12)
                                     :element-type 'single-float
                                     :initial-element 0f0)))
    (init-body-data body-data 0
                    0f0 0f0 0f0
                    1f0 1f0 0f0
                    1f0 0f0 0f0 1f0
                    0f0
                    0f0)
    (init-body-data body-data 1
                    0f0 6.0f0 0f0
                    0.9f0 0.2f0 0.2f0
                    2f0 0f0 0f0 1f0
                    0f0
                    0f0)
    (init-body-data body-data 2
                    2.5f0 0f0 0f0
                    0.5f0 0f0 0.5f0
                    2f0 1f0 1f0 0f0
                    0f0
                    0f0)
    (init-body-data body-data 3
                    1.5f0 0f0 0f0
                    0.6f0 0.5f0 0.5f0
                    2f0 1f0 1f0 0f0
                    0f0
                    0f0)
    (init-body-data body-data 4
                    4f0 0f0 0f0
                    0f0 0.5f0 1f0
                    0.5f0 0f0 1f0 0f0
                    0f0
                    0f0)
    (init-body-data satellite-data 4
                    0.7f0 0f0 0f0
                    0.3f0 0.3f0 0.3f0
                    0.3f0 0f0 1f0 0f0
                    0f0
                    0f0)
    (setf (aref satellite-p 4) t)
    (defun draw-gl-scene-solar-system (surface)
      (declare (ignorable surface))
      (gl:clear (logior gl:+color-buffer-bit+
                        gl:+depth-buffer-bit+))
      
      (gl:load-identity)
      (glu:look-at 0d0 0d0 (coerce *z-ss* 'double-float)
                   0d0 0d0 0d0
                   0d0 1d0 0d0)
      (sgum:with-single-float-values (light-pos 0f0 0f0 0f0 1.0f0)
        (gl:light-fv gl:+light0+ gl:+position+ light-pos))
      (gl:rotate-f (aref rot-vec 0) 1f0 0f0 0f0)
      (gl:rotate-f (aref rot-vec 1) 0f0 1f0 0f0)

      (loop for i from 0 below num-bodies do
            (gl:push-matrix)


            (gl:rotate-f (aref body-data i 11)
                         0f0 0f0 1f0)
            
            (gl:translate-f (aref body-data i 0)
                            (aref body-data i 1)
                            (aref body-data i 2))
            
            
            (gl:push-matrix)
            (gl:rotate-f (aref body-data i 10)
                         (aref body-data i 7)
                         (aref body-data i 8)
                         (aref body-data i 9))
            
            
            (gl:color-3f (aref body-data i 3)
                         (aref body-data i 4)
                         (aref body-data i 5))
            
            (cond ((zerop i)
                   (sgum:with-single-float-values (emis 0.9f0 0.7f0 0.1f0 0f0)
                     (gl:material-fv gl:+front+ gl:+emission+ emis))
                   (gl:call-list *solar-system-sun*)
                   (sgum:with-single-float-values (emis 0.0f0 0.0f0 0.0f0 0f0)
                     (gl:material-fv gl:+front+ gl:+emission+ emis)))
                  (t
                   (gl:call-list *solar-system-planet*)))

            (gl:pop-matrix)
            (when (aref satellite-p i)
              (gl:rotate-f (aref satellite-data i 11)
                           0f0 0f0 1f0)
              (gl:translate-f (aref satellite-data i 0)
                              (aref satellite-data i 1)
                              (aref satellite-data i 2))
              (gl:rotate-f (aref satellite-data i 10)
                           (aref satellite-data i 7)
                           (aref satellite-data i 8)
                           (aref satellite-data i 9))
              (gl:color-3f (aref satellite-data i 3)
                           (aref satellite-data i 4)
                           (aref satellite-data i 5))
              (gl:call-list *solar-system-satellite*)
              (incf (aref satellite-data i 10)
                    (aref satellite-data i 6))
              (let ((dist (abs (+ (aref satellite-data i 0)
                                  (aref satellite-data i 1)
                                  (aref satellite-data i 2)))))
                (unless (zerop dist)
                  (incf (aref satellite-data i 11)
                        (sf (/ dist))))))
            
            (incf (aref body-data i 10)
                  (aref body-data i 6))
            (let ((dist (abs (+ (aref body-data i 0)
                                (aref body-data i 1)
                                (aref body-data i 2)))))
              (unless (zerop dist)
                (incf (aref body-data i 11)
                      (sf (/ dist)))))

            (gl:pop-matrix))

      (incf (aref rot-vec 0) *xspeed-ss*)
      (incf (aref rot-vec 1) *yspeed-ss*)
      (sdl:gl-swap-buffers)
      
      t)))

(defun handle-keypress-solar-system (key)
  (cond
    ((eql 275 key)                      ; right arrow
     (incf *yspeed-ss* 0.05f0))
    ((eql 273 key)                      ; up arrow
     (decf *xspeed-ss* 0.05f0))
    ((eql 276 key)                      ; left arrow
     (decf *yspeed-ss* 0.05f0))
    ((eql 274 key)                      ; down arrow
     (incf *xspeed-ss* 0.05f0))
    ((eql 281 key)                      ; pgdown
     (incf *z-ss* 0.2f0))
    ((eql 280 key)                      ; pgup
     (decf *z-ss* 0.2f0))))

(register-tutorial :solar-system
                   :init-gl-fn #'initgl-solar-system
                   :event-loop-fn #'event-loop0
                   :update-fn #'draw-gl-scene-solar-system
                   :handle-keypress-fn #'handle-keypress-solar-system)

