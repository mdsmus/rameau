(defpackage :rameau-doc
  (:import-from #:arnesi "AIF" "AWHEN" "IT" "LAST1" "ENABLE-SHARP-L-SYNTAX")
  (:shadowing-import-from #:rameau-base #:defun #:defmacro #:defparameter #:defvar #:defstruct)
  (:use :rameau :cl :iterate :genoslib))

(in-package :rameau-doc)

(defparameter *rameau-packages*
  ;;; falta rameau e rameau-doc
  '("RAMEAU-OPTIONS" "RAMEAU-BASE" "GENOSLIB" "RAMEAU-WEB"
    "RAMEAU-MAIN" "RAMEAU-TERMINAL" "RAMEAU-LILY" "RAMEAU-HMM"
    "RAMEAU-NEURAL" "RAMEAU-KNN" "RAMEAU-TREE-ENARM" "RAMEAU-PARDO"))

(defun find-source-file-of-function :private (function-name)
  (pathname-name (cadadr (swank-backend:find-source-location (symbol-function function-name)))))

(defun function-uses :private (function-name)
  (handler-case (swank-backend:list-callees function-name)
    (serious-condition () (list function-name))
    (:no-error (expr) (mapcar #'first expr))))

(defun functions-used-by :private (function-name)
  (handler-case (swank-backend:list-callers function-name)
    (serious-condition () (list function-name))
    (:no-error (expr) (mapcar #'first expr))))

(defun get-package-name :private (symbol)
  (package-name (symbol-package symbol)))

(defun rameau-package-p :private (item)
  (flet ((get-package-name (el)
           (if (listp el)
               (unless (listp (second el))
                 (get-package-name (second el)))
               (get-package-name el))))
    (when (member (get-package-name item) *rameau-packages* :test #'equalp)
      t)))

(defun remove-functions-not-in-rameau :private (list)
  (mapcar #'(lambda (item) (if (listp item) (second item) item))
          (remove-if-not #'rameau-package-p list)))

(defun document-function-or-macro :private (symbol &optional (type :function))
  (list (get-package-name symbol)
        (stringify symbol)
        type
        (stringify (swank-backend:arglist symbol))
        (documentation symbol 'function)
        (find-source-file-of-function symbol)
        (when (eql type :function)
          (remove-functions-not-in-rameau (function-uses symbol))
          ;;(remove-functions-not-in-rameau (functions-used-by symbol))
          )))

(defun create-documentation-sexp :private (package)
  (iter (for symbol in-package package :external-only t)
        (when (fboundp symbol)
          (collect (if (macro-function symbol)
                       (document-function-or-macro symbol :macro)
                       (document-function-or-macro symbol :function))))))

(defun create-documentation-for-all-packages ()
  (mapcar #'create-documentation-sexp *rameau-packages*))

(defcommand document (options &rest ignore)
  nil
  (declare (ignore ignore options))
  (create-documentation-for-all-packages))

