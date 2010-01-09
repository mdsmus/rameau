;;;;
;;;; Miscellaneous utilities
;;;; =======================
;;;;
;;;; written in 2002 by Timo Tossavainen (tt@cs.uta.fi)
;;;;

(in-package #:sdl)

(defun clamp (v l u)
  (min (max v l) u))

(defun delta-clamp (v d l u)
  (let ((sum (+ v d)))
    (cond ((< sum l)
           (- d (- sum l)))
          ((> sum u)
           (- d (- sum u)))
          (t d))))

(export '(clamp delta-clamp))

(defmacro with-gensyms (symbol-bind-list &body code)
  "Binds symbols in symbol-bind-list to gensyms"
  `(let ,(cl:mapcar #'(lambda (x) `(,x (cl:gensym))) symbol-bind-list)
     ,@code))

;;;
;;; CMU Common Lisp -specific utils
;;; ===============================
;;;
;;; aref-sap is useful for passing lisp arrays to C functions
;;; remember to use (system:without-gcing ...) when using it.
;;; 

#+nil
(declaim (ftype  (function ((or #+signed-array (array (signed-byte 8))
				#+signed-array (array (signed-byte 16))
				#+signed-array (array (signed-byte 32))
				(array (unsigned-byte 8))
				(array (unsigned-byte 16))
				(array (unsigned-byte 32))
				(array single-float)
				(array double-float))
			    fixnum)
			   system:system-area-pointer)
		 aref-sap)
	 (inline aref-sap))
#+nil
;; TODO: handle multidimensional arrays => make it into a macro
(defun aref-sap (array offset)
  "Return the physical address of where the actual data of an array at offset is stored.

ARRAY must be a specialized array type in CMU Lisp.  This means ARRAY
must be an array of one of the following types:

                  double-float
                  single-float
                  (unsigned-byte 32)
                  (unsigned-byte 16)
                  (unsigned-byte  8)
                  (signed-byte 32)
                  (signed-byte 16)
                  (signed-byte  8)
"
  (declare (type (or #+signed-array (array (signed-byte 8))
                     #+signed-array (array (signed-byte 16))
                     #+signed-array (array (signed-byte 32))
                     (array (unsigned-byte 8))
		     (array (unsigned-byte 16))
                     (array (unsigned-byte 32))
                     (array single-float)
                     (array double-float))
                 array)
	   (fixnum offset)	   
           (optimize (speed 3) (safety 0))
           (ext:optimize-interface (safety 3)))
  ;; with-array-data will get us to the actual data.  However, because
  ;; the array could have been displaced, we need to know where the
  ;; data starts.
  (lisp::with-array-data ((data array)
                          (start)
                          (end))
    (declare (ignore end))
    ;; DATA is a specialized simple-array.  Memory is laid out like this:
    ;;
    ;;   byte offset    Value
    ;;        0         type code (should be 70 for double-float vector)
    ;;        4         4 * number of elements in vector
    ;;        8         1st element of vector 
    ;;      ...         ...
    ;;
    (let ((addr (+ 8 (logandc1 7 (kernel:get-lisp-obj-address data))))
          (type-size (let ((type (array-element-type data)))
                       (cond ((or (equal type '(signed-byte 8))
                                  (equal type '(unsigned-byte 8)))
                              1)
                             ((or (equal type '(signed-byte 16))
                                  (equal type '(unsigned-byte 16)))
                              2)
                             ((or (equal type '(signed-byte 32))
                                  (equal type '(unsigned-byte 32)))
                              4)
                             ((equal type 'single-float)
                              4)
                             ((equal type 'double-float)
                              8)
                             (t
                              (error "Unknown specialized array element type"))
))))
      (declare (type (unsigned-byte 32) addr)
               (optimize (speed 3) (safety 0) (ext:inhibit-warnings 3)))
      (system:int-sap (the (unsigned-byte 32)
                        (+ addr (* type-size (+ start offset))))))))


