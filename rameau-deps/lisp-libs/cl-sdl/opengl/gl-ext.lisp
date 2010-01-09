;;;;
;;;; OpenGL bindings' extensions
;;;; ===========================
;;;;
;;;; written in 2002 by Timo Tossavainen (tt@cs.uta.fi)
;;;;
;;;; This file contains various lispifications of the OpenGL API
;;;; The raw OpenGL binding is in gl.lisp
;;;;

(in-package #:opengl)

;; Cross-platform vertex array support
;; TODO: Add support for multi-dimensional arrays
;;       Specify usage of Lisp arrays for implementations which support it


;; This is vertex-array code which should work on every implementation
;; that CL-SDL supports.
(defun convert-to-vertex-array (array type)
  (ecase type
    (:float
     (let ((c-array
            (sgum:allocate-foreign-object :float (length array))))
       (loop for value across array
             for i from 0 do
             (setf (deref-array c-array
                                (:array :float)
                                i)
                   value))
       c-array))))

(defun free-vertex-array (varray)
  (sgum:free-foreign-object varray))

(defun varef (varray type i)
  (ecase type
    (:float
     (sgum:deref-array varray (:array :float) i))))

(defun (setf varef) (value varray type i)
  (ecase type
    (:float
     (setf (sgum:deref-array varray (:array :float) i) value))))

(defmacro with-vertex-array-in-use ((name &optional array type) &body body)
  (if array
      `(let ((,name (convert-to-vertex-array ,array ,type)))
        (unwind-protect (progn ,@body)
          (free-vertex-array ,name)))
      `(progn ,@body)))

(export '(with-vertex-array-in-use
          convert-to-vertex-array
          free-vertex-array))

#+nil
(defmacro with-vertex-array (array-spec &body code)
  (labels
      ((expand-array-spec (code array-name
                                &key
                                (type nil)
                                (size nil)
                                (stride 0)
                                (offset 0))
         (let ((typespec
                (case type
                  ((cl:single-float gl:float)  'gl:+float+)
                  ((cl:double-float gl:double) 'gl:+double+)
                  ((cl:fixnum gl::int) 'gl:+int+)
                  ((gl:short) 'gl:+short+)
                  (otherwise
                   (error "Unknown OpenGL vertex array type: ~A" type)))))
           (if (integerp size)
               (progn (assert (<= 2 size 4))
                      `((gl:vertex-pointer ,size ,typespec
                         ,stride (aref-sap ,array-name
                                  ,offset))
                        ,@code))
               `((gl:vertex-pointer ,size ,typespec
                  ,stride (aref-sap ,array-name
                           ,offset)))))))
    `(system:without-gcing
      (gl:enable-client-state gl:+vertex-array+)
      ,@(apply #'expand-array-spec code array-spec)
      (gl:disable-client-state gl:+vertex-array+))))

;; TODO: general with-gl-arrays macro (even for interleaved arrays)
;; TODO: display list macro (gen-display-list <code>)
;; TODO: display list macro (gen-and-exec-display-list <code>)
