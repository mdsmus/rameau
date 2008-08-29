(defpackage :rameau-base
  (:documentation "Macros to replace the standard \\texttt{def*} macros with
equivalents that export symbols by default.")
  (:shadow :defun :defmacro :defparameter :defvar :defstruct :defclass :defgeneric)
  (:use #:cl))

(in-package :rameau-base)

(cl:defun %parse-defmethod (cdr-of-form)
  ;; copied from sbcl
  (declare (list cdr-of-form))
  (let ((name (pop cdr-of-form))
        (qualifiers ())
        (spec-ll ()))
    (loop (if (and (car cdr-of-form) (atom (car cdr-of-form)))
              (push (pop cdr-of-form) qualifiers)
              (return (setq qualifiers (nreverse qualifiers)))))
    (setq spec-ll (pop cdr-of-form))
    (values name qualifiers spec-ll cdr-of-form)))

(cl:defmacro defun (&rest args)
  (multiple-value-bind (name private lambda-list body)
      (%parse-defmethod args)
    (if private
        `(cl:defun ,name ,lambda-list ,@body)
        `(progn
           (export ',name)
           (cl:defun ,name ,lambda-list ,@body)))))

(cl:defmacro defmacro (&rest args)
  (multiple-value-bind (name private lambda-list body)
      (%parse-defmethod args)
    (if private
        `(cl:defmacro ,name ,lambda-list ,@body)
        `(progn
           (export ',name)
           (cl:defmacro ,name ,lambda-list ,@body)))))

(cl:defmacro defparameter (&rest args)
  (if (eql (first args) :private)
      `(cl:defparameter ,@(rest args))
      `(progn
         (export ',(first args))
         (cl:defparameter ,@args))))

(cl:defmacro defvar (&rest args)
  (if (eql (first args) :private)
      `(cl:defvar ,@(rest args))
      `(progn
         (export ',(first args))
         (cl:defvar ,@args))))

(cl:defmacro defclass (&rest args)
  (if (eql (first args) :private)
      `(cl:defclass ,@(rest args))
      `(progn
         (export ',(first args))
         (cl:defclass ,@args))))

(cl:defmacro defgeneric (&rest args)
  (if (eql (first args) :private)
      `(cl:defgeneric ,@(rest args))
      `(progn
         (export ',(first args))
         (cl:defgeneric ,@args))))

(cl:defmacro defstruct (&rest args)
  ;;; limitado: nao aceita nome diferente para funcoes acessoras que
  ;;; <nome>-<slot>
  ;;; TODO: deixar o intern aqui dentro mais robusto
  (if (eql (first args) :private)
      `(cl:defstruct ,@(rest args))
      (let ((name (if (listp (first args))
                      (first (first args))
                      (first args))))
        `(progn
           (export ',(intern (concatenate 'string (symbol-name name) "-P")))
           (export ',(intern (concatenate 'string "MAKE-" (symbol-name name))))
           (export ',(loop for slot in (rest args) collect
                           (intern (concatenate 'string
                                                (symbol-name name)
                                                "-"
                                                (symbol-name (if (listp slot)
                                                                 (first slot)
                                                                 slot))))))
           (cl:defstruct ,@args)))))
