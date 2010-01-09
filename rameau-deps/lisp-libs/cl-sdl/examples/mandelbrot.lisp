(declaim (optimize (speed 3) (debug 0) (safety 0)))
(defconstant +squared-limit+ 4.0f0)

(defun mandelbrot (width height max-iterations &key (real-limits
						     '(-2.25f0 0.75f0))
		   (imag-limits '(-1.25f0 1.25f0)) &aux (surface nil))
  (declare (type (unsigned-byte 16) width height max-iterations))
  (sdl:init (logior sdl:+init-noparachute+ sdl:+init-video+))
  (setf surface (sdl:set-video-mode width height 16 sdl:+doublebuf+))

  (labels ((norm-squared (z)
             (declare (type (complex single-float) z))
             (let ((real-part (realpart z))
                   (imag-part (imagpart z)))
               (declare (single-float real-part imag-part))
               (the single-float
                 (+ (expt real-part 2)
                    (expt imag-part 2)))))
           (iterate-point (z max-iter)
             (declare (type (complex single-float) z)
                      (fixnum max-iter))
             (let ((zn z))
               (declare (type (complex single-float) zn))
               (loop for iter of-type fixnum from 0 below max-iter
                     until (>= (norm-squared zn)
                               +squared-limit+)
                     do (setf zn (+ (expt zn 2) z))
                     finally (return iter #+nil (- max-iter iter))))))
    
    (let* ((real-min (first real-limits))
           (real-max (second real-limits))
           (imag-min (first imag-limits))
           (imag-max (second imag-limits))
           (real-step (/ (- real-max real-min) width))
           (imag-step (/ (- imag-max imag-min) height))
           (z (complex real-min imag-min))
           (result (make-array (* width height)
                               :element-type '(unsigned-byte 8))))
      (declare (single-float real-min real-max imag-min imag-max
                             real-step imag-step)
               (type (complex single-float) z))
      (dotimes (x width)
        (declare (fixnum x))
        (dotimes (y height)
          (declare (fixnum y))
          (let ((count (iterate-point z max-iterations)))
            (setf (aref result
                        (+ x (the fixnum (* width y))))
                  (the (unsigned-byte 8)
                    (min 255 count))))
          (incf z (complex 0f0 imag-step)))
        (setf z (complex (+ (realpart z) real-step)
                         imag-min))
        (format t "~&Column ~D finished~%" x))
      (format t "~&~A~%" (aref result #.(+ 425 (* 640 240))))

      (sdl:lock-surface surface)
      (unwind-protect
           (loop for x of-type (unsigned-byte 16) from 0 below width do
                 (loop for y of-type (unsigned-byte 16) from 0 below height do
                       (sdl:draw-pixel surface x y 100 100
                                       (aref result
                                             (+ x (the (unsigned-byte 32)
                                                    (* y width)))))))
        (progn (sdl:unlock-surface surface)
               (sdl:flip surface))))))






#||
#+nil
                      (iterate-recursive (zn iter)
                        (declare (type (complex single-float) zn)
                                 (fixnum iter))
                        (cond ((or (>= (norm-squared zn)
                                       +squared-limit+)
                                   (zerop iter))
                               (- max-iter iter))
                              (t (iterate-recursive (+ (expt zn 2) z)
                                                    (1- iter)))))
#+nil
               (iterate-recursive z max-iter)

||#
