(in-package :rameau)

(defparameter *rameau-packages*
  '("RAMEAU-OPTIONS" "RAMEAU-BASE" "GENOSLIB" "RAMEAU-WEB"
    "RAMEAU-MAIN" "RAMEAU-TERMINAL" "RAMEAU-LILY" "RAMEAU-HMM"
    "RAMEAU-NEURAL" "RAMEAU-KNN" "RAMEAU-TREE-ENARM" "RAMEAU-PARDO"))

(defun find-source-file-of-function :private (function-name)
  (pathname-name (cadadr (swank-backend:find-source-location (symbol-function function-name)))))

(defun function-uses :private (function-name)
  (handler-case (swank-backend:list-callees function-name)
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
          (remove-functions-not-in-rameau (function-uses symbol)))))

(defun create-documentation-sexp :private (package)
  (iter (for symbol in-package package :external-only t)
        (when (fboundp symbol)
          (collect (if (macro-function symbol)
                       (document-function-or-macro symbol :macro)
                       (document-function-or-macro symbol :function))))))


(defun creat-documentation-for-all-packages ()
  (mapcar #'create-documentation-sexp *rameau-packages*))
