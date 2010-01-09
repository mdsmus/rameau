(in-package #:nehe-tutorials)

(defvar *torus*)

(declaim (inline sf))
(defun sf (x)
  (coerce x 'single-float))

(defun draw-torus (numc numt)
  (let ((twopi (sf (* 2 pi)))
        (x 0f0) (y 0f0) (z 0f0) (s 0f0) (tee 0f0))
    (declare (type single-float x y z s tee twopi))
    (dotimes (i numc)
      (gl:begin gl:+quad-strip+)
      (dotimes (j (1+ numt))
        (loop for k from 1 downto 0 do
              (setf s (sf (+ (mod (+ i k) numc) 0.5f0))
                    tee (sf (mod j numt))
                    x (sf (1+ (* 0.1f0
                                 (cos (* s (/ twopi numc)))
                                 (cos (* tee (/ twopi numt))))))
                    y (sf (1+ (* 0.1f0
                                 (cos (* s (/ twopi numc)))
                                 (sin (* tee (/ twopi numt))))))
                    z (sf (* 0.1f0 (sin (* s (/ twopi numc))))))
              (gl:vertex-3f (1- x) (1- y) z)))
      (gl:end))))


(defun initgl-torus ()
  (setf *torus* (gl:gen-lists 1))
  (gl:new-list *torus* gl:+compile+)
  (draw-torus 8 25)
  (gl:end-list)
  
  (gl:shade-model gl:+smooth+)
  (gl:clear-color 0.0f0 0.0f0 0.0f0 0.0f0)
  (gl:clear-depth 1.0d0)
  (gl:enable gl:+depth-test+)
  (gl:depth-func gl:+lequal+)
  (gl:hint gl:+perspective-correction-hint+ gl:+nicest+)
  t)

(flet ((init-torus-data (array n &rest args)
         ;;tx ty tz cr cg cb ra rx ry rz r
         (loop for arg in args
               for i from 0 do
               (setf (aref array n i) arg))))
  
  (let* ((num-toruses 4)
         (torus-data (make-array `(,num-toruses 11)
                                 :element-type 'single-float
                                 :initial-element 0f0)))
    (init-torus-data torus-data 0 0f0 0.5f0 -2f0
                     0f0 1f0 1f0
                     1f0 1f0 0f0 0f0 0f0)
    (init-torus-data torus-data 1
                     0f0 -0.20f0 -1f0
                     0f0 0f0 1f0
                     2f0 1f0 1f0 0f0 0f0)
    (init-torus-data torus-data 2
                     0.20f0 0f0 -1f0
                     1f0 1f0 0f0
                     2f0 1f0 1f0 0f0 0f0)
    (init-torus-data torus-data 3
                     -0.20f0 0f0 -1f0
                     1f0 0f0 0f0
                     2f0 1f0 1f0 0f0 0f0)
  
    (defun draw-gl-scene-torus (surface)
      (declare (ignorable surface))
      (gl:clear (logior gl:+color-buffer-bit+
                        gl:+depth-buffer-bit+))

      (loop for i from 0 below num-toruses do
            
            (gl:load-identity)
            
            (gl:translate-f (aref torus-data i 0)
                            (aref torus-data i 1)
                            (aref torus-data i 2))
            
            
            (gl:rotate-f (aref torus-data i 10)
                         (aref torus-data i 7)
                         (aref torus-data i 8)
                         (aref torus-data i 9))
            
            (gl:color-3f (aref torus-data i 3)
                         (aref torus-data i 4)
                         (aref torus-data i 5))
            
            (gl:call-list *torus*)

            (incf (aref torus-data i 10)
                  (aref torus-data i 6)))
      
      (sdl:gl-swap-buffers)
      
      t)))

(register-tutorial :torus
                   :init-gl-fn #'initgl-torus
                   :event-loop-fn #'event-loop0
                   :update-fn #'draw-gl-scene-torus)

