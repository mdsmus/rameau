;;;; -*- Mode: Lisp -*-
;;;; Author: Matthew Danish <mrd@debian.org>
;;;; UFFI-ize the existing macros

(defpackage #:sdl-gl-uffi-macros
  (:use #:common-lisp)
  (:import-from #:uffi
                #:find-foreign-library
                #:load-foreign-library
                #:free-foreign-object)
  (:nicknames #:sgum)
  (:export #:*current-module*
           #:*library-paths*
           #:*library-types*
	   #:*drive-letters*
           #:in-module
           #:def-library-properties
           #:load-defined-foreign-library
	   #:find/load-foreign-library
           #:def-foreign-constant
           #:def-foreign-struct
           #:def-foreign-type
           #:def-foreign-union
           #:def-foreign-routine
           #:slot
           #:slot-ptr
           #:address-of
           #:with-foreign-objects
           #:deref-pointer
           #:deref-array
           #:cast-pointer
           #:null-pointer-p
           #:+null-pointer+
           #:find-foreign-library
           #:load-foreign-library
           #:allocate-foreign-object
           #:free-foreign-object
           #:def-foreign-struct-accessor
           #:def-foreign-struct-accessors           
           #:with-unicode-string
           #:check-types
           #:maybe-null->nil)
  (:documentation "UFFI macros for the binding definitions"))

(in-package #:sdl-gl-uffi-macros)

#+(or windows microsoft)
#.(prog () (pushnew :win32 *features*))

(defparameter *current-module* "sdl")

(defparameter *build-directory-path*
  (let ((file (or *load-truename* *compile-file-truename*)))
    (when file
      (merge-pathnames
       (make-pathname :directory '(:relative "build"))
       (make-pathname :directory (butlast (pathname-directory file)))))))

(defparameter *c-directory-path*
  (let ((file (or *load-truename* *compile-file-truename*)))
    (when file
      (merge-pathnames
       (make-pathname :directory '(:relative "c"))
       (make-pathname :directory (butlast (pathname-directory file)))))))

(defparameter *library-paths*
  #+unix `("/lib/" "/usr/lib/" "/usr/lib/cl-sdl/" "/usr/local/lib/" 
	   "/usr/X11R6/lib/"
  	   "/usr/local/cl-sdl/" "/opt/cl-sdl/" ,*build-directory-path*
           ,*c-directory-path* "./build/" "./")
  #+win32 `("C:\\windows\\system32\\" "C:\\windows\\" "C:\\winnt\\"
	    "C:\\winnt\\system32\\" "C:\\CL-SDL\\" "C:\\CL-SDL\\CURRENT\\"
            "C:\\windows\\system\\" "C:\\winnt\\system\\"
            ,*build-directory-path* ,*c-directory-path* ".\\"))

(defparameter *drive-letters*
  #+unix '()
  #+win32 '("C" "D" "E"))

(defparameter *library-types*
  #+(and unix (not darwin)) '("so")
  #+win32 '("dll")
  #+darwin '("dylib"))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defconstant +null-pointer+ ;; better check this out
      #+(or cmu sbcl lispworks openmcl) nil
      #+allegro 0)
  (defparameter *type-table*
    '((char :char)
      (unsigned-char :unsigned-char)
      (byte :byte)
      (unsigned-byte :unsigned-byte)
      (short :short)
      (unsigned-short :unsigned-short)
      (int :int)
      (unsigned-int :unsigned-int)
      (long :long)
      (unsigned-long :unsigned-long)
      (float :float)
      (single-float :float)
      (c-single-float :float)
      (double-float :double)
      (c-double-float :double)
      (double :double)
      (c-string :cstring)
      (t :void)
      (void :void)
      ((* t) :pointer-void)
      ((* void) :pointer-void)
      (* *)
      (sfloat :float)
      (dfloat :double)
      (ubyte8 :unsigned-char)
      (sbyte8 :char)
      (ubyte16 :unsigned-short)
      (sbyte16 :short)
      (ubyte32 :unsigned-long)
      (sbyte32 :unsigned-long)
      ((unsigned-byte 8) :unsigned-byte)
      ((unsigned-byte 16) :unsigned-short)
      ((unsigned-byte 32) :unsigned-long)
      ((signed-byte 8) :byte)
      ((signed-byte 16) :short)
      ((signed-byte 32) :long)))

  (defun map-typename (type-name)
    (let ((real-name (second (assoc type-name *type-table* :test #'equal))))
      (if real-name
          real-name
          (if (consp type-name)
              (mapcar #'map-typename type-name)
              type-name)))))

(defun module-name (module)
  (etypecase module
    (string module)
    (symbol (string-downcase (symbol-name module)))))

(defmacro in-module (module)
  `(setf *current-module* (module-name ',module)))

(defun find/load-foreign-library (names module)
  (let ((module (module-name module))
        (lib (uffi:find-foreign-library names
					*library-paths*
					:types *library-types*
					:drive-letters *drive-letters*)))
    (in-module module)
    (if lib
        (uffi:load-foreign-library lib :module module)
        (error "Cannot find one of ~S" names))))

(defmacro def-library-properties (name lib-names &key (depends-on nil) (module nil))
  `(progn
    (setf
     (get ',name 'library-names) ',lib-names
     (get ',name 'library-dependencies) ',depends-on
     (get ',name 'module) (module-name ',module))))

(defun load-defined-foreign-library (name)
  (unless (get name 'loaded-p)
    (loop for dep in (get name 'library-dependencies) do
          (load-defined-foreign-library dep))
    (when (get name 'library-names)
      (find/load-foreign-library (get name 'library-names)
                                 (get name 'module)))
    (setf (get name 'loaded-p) t)))

;; Work-arounds for UFFI bugs (for now)

(defmacro deref-pointer (ptr type)
  "Returns a object pointed"
  (let ((type (map-typename type)))
    #+(or cmu sbcl lispworks scl) (declare (ignore type))
    #+(or cmu scl)  `(alien:deref ,ptr)
    #+sbcl  `(sb-alien:deref ,ptr)
    #+lispworks `(fli:dereference ,ptr)
    #+allegro `(ff:fslot-value-typed ',(uffi::convert-from-uffi-type type :deref) :c ,ptr)
    #+mcl `(ccl:pref ,ptr ,(uffi::convert-from-uffi-type type :deref))))


(defmacro deref-array (obj type i)
  "Returns a field from a row"
  (let ((type (map-typename type)))
    #+(or lispworks cmu sbcl scl) (declare (ignore type))
    #+(or cmu scl)  `(alien:deref ,obj ,i)
    #+sbcl  `(sb-alien:deref ,obj ,i)
    #+lispworks `(fli:dereference ,obj :index ,i)
    #+allegro `(ff:fslot-value-typed ',(uffi::convert-from-uffi-type type :type) :c ,obj ,i)
    #+mcl
    (let* ((array-type (uffi::array-type type))
           (local-type (uffi::convert-from-uffi-type array-type :allocation))
           (accessor (first (macroexpand `(ccl:pref obj ,local-type)))))
      `(,accessor 
        ,obj
        (* (the fixnum ,i) ,(uffi::size-of-foreign-type local-type))))
    #+nil (warn "deref-array probably broken")
    #+nil
    (let* ((accessor (first (macroexpand `(ccl:pref obj ,type)))))
      `(,accessor 
        ,obj
        (* (the fixnum ,i)
         (uffi::size-of-foreign-type
          (uffi::convert-from-uffi-type (uffi::array-type ,type) :allocation)))))))

(defmacro allocate-foreign-object (type &optional (size :unspecified))
  "Allocates an instance of TYPE. If size is specified, then allocate
an array of TYPE with size SIZE. The TYPE parameter is evaluated."
  (let ((type (map-typename type)))
    (if (eq size :unspecified)
        (progn
          #+(or cmu scl)
          `(alien:make-alien ,(uffi::convert-from-uffi-type type :allocation))
          #+sbcl
          `(sb-alien:make-alien ,(uffi::convert-from-uffi-type type :allocation))
          #+lispworks
          `(fli:allocate-foreign-object :type ',(uffi::convert-from-uffi-type type :allocate))
          #+allegro
          `(ff:allocate-fobject ',(uffi::convert-from-uffi-type type :allocate) :c)
          #+mcl
          `(uffi::new-ptr ,(uffi::size-of-foreign-type (uffi::convert-from-uffi-type type :allocation)))
          )
        (progn
          #+(or cmu scl)
          `(alien:make-alien ,(uffi::convert-from-uffi-type type :allocation) ,size)
          #+sbcl
          `(sb-alien:make-alien ,(uffi::convert-from-uffi-type type :allocation) ,size)
          #+lispworks
          `(fli:allocate-foreign-object :type ',(uffi::convert-from-uffi-type type :allocate) :nelems ,size)
          #+allegro
          `(ff:allocate-fobject (list :array ',(uffi::convert-from-uffi-type type :allocate) ,size) :c)
          #+mcl
          `(uffi::new-ptr (* ,size ,(uffi::size-of-foreign-type (uffi::convert-from-uffi-type type :allocation))))
          ))))

(defmacro def-foreign-constant (name val)
  `(progn (defconstant ,name ,val)
    (export ',name)))

(defmacro def-foreign-type (type spec)
  (let ((real-spec (map-typename spec)))
    `(progn
      (uffi:def-foreign-type ,type ,real-spec)
      (uffi:def-type ,type ,real-spec)
      (export '(,type)))))

(defmacro def-foreign-struct (type &body spec)
  (flet ((special-map-typename (x)
           (if (equal x (list '* type))
               :pointer-self
               (map-typename x))))
    `(progn (uffi:def-struct ,type
                ,@(loop for (name slot-type) in spec
                        collect `(,name ,(special-map-typename slot-type))))
      (export ',type))))

(defmacro def-foreign-union (type &body spec)
  `(progn (uffi:def-union ,type
              ,@(loop for (name slot-type) in spec
                      collect `(,name ,(map-typename slot-type))))
    (export ',type)))

(defmacro def-cstring-wrapper (name (real-name ret-type &rest cstring-args) &rest args)
  (let ((cstring-arg-pairs
         (mapcar #'(lambda (x)
                     (list x x))
                 cstring-args)))
    `(defun ,name ,args
      (uffi:with-cstrings (,@cstring-arg-pairs)
        ,(if (eq ret-type :cstring)
             `(uffi:convert-from-cstring
               (,real-name ,@args))
             `(,real-name ,@args))))))

(defmacro def-foreign-routine ((c-name lisp-name &key module) ret-type &rest args)
  (let* ((module (if module module *current-module*))
         (names (list c-name lisp-name))
         (real-args (loop for (name slot-type) in args
                          collect `(,name ,(map-typename slot-type))))
         (arg-types (mapcar #'second real-args))
         (cstrings (mapcar #'first
                           (remove :cstring
                                   real-args
                                   :test-not #'eql
                                   :key #'second)))
         (real-ret-type (map-typename ret-type)))
    (if (and (null cstrings) (not (eq :cstring real-ret-type)))
        `(progn
          ;(declaim (ftype (function ,arg-types ,real-ret-type)))
          (uffi:def-function ,names
                    ,real-args
                  :returning ,real-ret-type
                  :module ,(module-name module))
          (export '(,(second names))))
        (let ((real-names
               (list (first names)
                     (intern (symbol-name
                              (gensym (symbol-name (second names))))))))
          `(progn (uffi:def-function ,real-names
                      ,real-args
                    :returning ,real-ret-type
                    :module ,(module-name module))
            (def-cstring-wrapper ,(second names)
                (,(second real-names) ,real-ret-type ,@cstrings)
              ,@(mapcar #'first real-args))
            (export '(,(second names))))))))


#+nil
(defmacro cast-pointer (ptr new-type)
  #+(or cmu scl) `(alien:cast ,ptr
                ,(uffi::convert-from-uffi-type
                  (map-typename new-type)
                  :type))
  #+sbcl `(sb-alien:cast ,ptr
           ,(uffi::convert-from-uffi-type
             (map-typename new-type)
             :type))
  #-(or scl sbcl cmu) ptr)

(defmacro slot (obj type slot)
  `(uffi:get-slot-value ,obj ',(map-typename type) ',slot))

(defmacro slot-ptr (obj type slot)
  `(uffi:get-slot-pointer ,obj ',(map-typename type) ',slot))

(defmacro address-of (obj)
  `(uffi:pointer-address ,obj))

(defmacro with-foreign-objects (vars &body body)
  (flet ((convert (var-spec)
           (list (first var-spec)
                 (list 'quote (map-typename (second var-spec))))))
    `(uffi:with-foreign-object ,(convert (first vars))
      ,@(if (null (rest vars))
            body
            `((with-foreign-objects ,(rest vars)
                ,@body))))))

#+nil
(defmacro deref-pointer (ptr type)
  `(uffi:deref-pointer ,ptr ',(map-typename type)))

#+nil
(defmacro deref-array (ptr type index)
  `(uffi:deref-array ,ptr ',(map-typename type) ,index))

#+nil
(defmacro allocate-foreign-object (type &optional (size :unspecified))
  `(uffi:allocate-foreign-object ',type ,size))

(defmacro null-pointer-p (ptr)
  `(uffi:null-pointer-p ,ptr))

(defmacro def-foreign-struct-accessor ((struct-name) slot)
  (let ((accessor-name (intern (format nil "~A-~A" struct-name slot)))
        (var (gensym "VAR"))
        (val (gensym "VAL")))
    #-cmu
    `(progn
      (declaim (inline ,accessor-name (setf ,accessor-name)))
      (defun ,accessor-name (,var)
        (slot ,var ,struct-name ,slot))
      (defun (setf ,accessor-name) (,val ,var)
        (setf (slot ,var ,struct-name ,slot)
              ,val))
      (export '(,accessor-name)))
    #+cmu
    `(progn
      (declaim (inline ,accessor-name (setf ,accessor-name)))
      (let* ((type (alien::parse-alien-type ',struct-name))
             (field (alien::slot-or-lose type ',slot))
             (field-offset (alien::alien-record-field-offset field))
             (field-type (alien::alien-record-field-type field))
             (extractor-backend (alien::compute-extract-lambda field-type))
             (depositor-backend (alien::compute-deposit-lambda field-type))
             (extractor-frontend (lambda (alien)
                                   (funcall extractor-backend
                                            (alien::alien-value-sap alien)
                                            field-offset
                                            nil)))
             (depositor-frontend (lambda (value alien)
                                   (funcall depositor-backend
                                            (alien::alien-value-sap alien)
                                            field-offset
                                            nil
                                            value))))
        (setq extractor-backend
              (compile nil (coerce extractor-backend 'function))
              depositor-backend
              (compile nil (coerce depositor-backend 'function)))
        (setf (fdefinition ',accessor-name) extractor-frontend)
        (setf (fdefinition '(setf ,accessor-name)) depositor-frontend)
        (export ',accessor-name)))))

(defmacro def-foreign-struct-accessors ((struct-name) &rest slots)
  `(progn
    ,@(loop for slot in slots collect
            `(def-foreign-struct-accessor (,struct-name) ,slot))))

(defmacro def-handy-conversion (name cl-type c-type)
  (let ((conv-name (intern (format nil "~A-~A-~A"
                                   'convert name 'vector)))
        (with-vec-name (intern (format nil "~A-~A-~A"
                                       'with name 'vector)))
        (with-val-name (intern (format nil "~A-~A-~A"
                                       'with name 'values)))
        (arg1-name (gensym))
        (arg2-name (gensym))
        (arg3-name (gensym))
        (arg4-name (gensym)))
    `(progn
      (defun ,conv-name (,arg1-name)
        (declare (type (simple-array ,cl-type (*)) ,arg1-name))
        (let ((,arg2-name (allocate-foreign-object
                           ,c-type
                           (length ,arg1-name))))
          (loop for ,arg3-name across ,arg1-name
                for ,arg4-name from 0 do
                (setf (deref-array ,arg2-name
                                   (:array ,c-type)
                                   ,arg4-name)
                      ,arg3-name))
          ,arg2-name))
      (defmacro ,with-vec-name ((,arg1-name ,arg2-name) &body ,arg3-name)
        `(let ((,,arg1-name (,',conv-name ,,arg2-name)))
          (unwind-protect
               (progn ,@,arg3-name)
            (free-foreign-object ,,arg1-name))))
      (defmacro ,with-val-name ((,arg1-name &rest ,arg2-name) &body ,arg3-name)
        `(let ((,,arg1-name (convert-single-float-vector
                             (make-array ,(length ,arg2-name)
                                         :element-type ',',cl-type
                                         :initial-contents (list ,@,arg2-name)))))
          (unwind-protect
               (progn ,@,arg3-name)
            (free-foreign-object ,,arg1-name))))
      (export '(,conv-name ,with-vec-name ,with-val-name)))))

(def-handy-conversion single-float single-float sfloat)
(def-handy-conversion double-float double-float dfloat)
(def-handy-conversion octet (unsigned-byte 8) ubyte8)
(def-handy-conversion ubyte8 (unsigned-byte 8) ubyte8)
(def-handy-conversion sbyte8 (signed-byte 8) sbyte8)
(def-handy-conversion ubyte16 (unsigned-byte 16) ubyte16)
(def-handy-conversion sbyte16 (signed-byte 16) sbyte16)
(def-handy-conversion ubyte32 (unsigned-byte 32) ubyte32)
(def-handy-conversion sbyte32 (signed-byte 32) sbyte32)

(defmacro with-unicode-string ((var text) &body body)
  ;; Currently, a UNICODE string is expected to be a
  ;; (simple-array (unsigned-byte 16) (*))
  `(with-ubyte16-vector (,var ,text)
    ,@body))

;; TODO:
;; proper type conversion

;; NOTES:
;; LispWorks offers only define-foreign-funcallable, which expands
;; to use a system-specific call ``CALL-WIN32-PROC'' for example.

(defun %reverse-flatten-and-quote-args (args)
  (loop for (name type) in args
        collect `',(uffi::convert-from-uffi-type (map-typename type)
                                                 :type)
        collect name))

(defun %reverse-and-flatten-args (args)
  (loop for (name type) in args
        collect (uffi::convert-from-uffi-type (map-typename type)
                                              :type)
        collect name))

#+nil
(defmacro def-foreign-funcallable (name ret-type (&rest args))
  #+lispworks `(fli:define-foreign-funcallable ,name ,args :result-type ,ret-type)
  #+(or cmu sbcl allegro openmcl)
  (let ((fptr (gensym "FPTR"))
        (ret-type (uffi::convert-from-uffi-type
                   (map-typename ret-type) :type))
        (arg-names (mapcar #'first args))
        #+(or cmu sbcl)
        (arg-types (mapcar #'(lambda (x)
                               (uffi::convert-from-uffi-type
                                (map-typename (second x))
                                :type))
                           args))
        #+allegro
        (rev-flattened-args-q
         (%reverse-flatten-and-quote-args args))
        #+openmcl
        (rev-flattened-args
         (%reverse-and-flatten-args args)))
    `(defun ,name (,fptr ,@arg-names)
      #+cmu (alien:alien-funcall (alien:cast ,fptr
                                  (alien:function ,ret-type ,@arg-types))
             ,@arg-names)
      #+sbcl (sb-alien:alien-funcall (sb-alien:cast ,fptr
                                      (sb-alien:function ,ret-type
                                                         ,@arg-types))
              ,@arg-names)
      #+allegro (system::ff-funcall ,fptr ,@rev-flattened-args-q ',ret-type)
      #+openmcl (ccl:ff-call ,fptr ,@rev-flattened-args ,ret-type))))
             
  

#+nil
(defmacro foreign-funcall-v (address ret-type &rest args)
  #+cmu `(alien:alien-funcall ,address ,@(every-even-argument args))
  #+sbcl `(sb-alien:alien-funcall ,address ,@(every-even-argument args))
  #+allegro `(system::ff-funcall ,address ,@args ,ret-type)
  #+openmcl `(ccl::%ff-call ,address ,@(transpose-types-and-values args) ,ret-type)
  )

(def-foreign-type c-single-float :float)
(def-foreign-type c-double-float :double)
;(export '(c-single-float c-double-float))

(defmacro check-types (&rest args)
  (let ((type (first (last args))))
    `(progn ,@(loop for var in (butlast args) collecting
                    `(check-type ,var ,type)))))

(declaim (inline maybe-null->nil))
(defun maybe-null->nil (desc)
  (unless (null-pointer-p desc) desc))

(dolist (type-mapping *type-table*)
  (let ((sym-or-cons (first type-mapping)))
    (if (consp sym-or-cons)
        (export (remove-if-not #'symbolp sym-or-cons))
        (export `(,sym-or-cons)))))
