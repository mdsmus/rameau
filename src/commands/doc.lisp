(defpackage :rameau-doc
  (:import-from #:arnesi "AIF" "AWHEN" "IT" "LAST1" "ENABLE-SHARP-L-SYNTAX")
  (:shadowing-import-from #:rameau-base #:defun #:defmacro #:defparameter #:defvar #:defstruct)
  (:use :rameau :cl :iterate :genoslib :cl-who))

(in-package :rameau-doc)

(enable-sharp-l-syntax)

(defparameter *rameau-packages*
;;; falta rameau e rameau-doc
  '("RAMEAU-BASE" "GENOSLIB" "RAMEAU-WEB"
    "RAMEAU-HMM"
    "RAMEAU-NEURAL" "RAMEAU-KNN" "RAMEAU-TREE-ENARM" "RAMEAU-PARDO"))

(defun find-source-file-of-function :private (function-name)
  ;; according to CLHS the readtable is reset after reading or
  ;; compiling a file. For some reason it is not enought to call
  ;; enable-sharp-l-syntax on the top of this file, it has to be
  ;; called here.
  (enable-sharp-l-syntax)
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

(defun document-function-or-macro :private (symbol &key (type :function) used-by-p)
  (append (list :package-name (get-package-name symbol)
                :name (stringify symbol)
                :type type
                :arglist (stringify `(,symbol ,@(swank-backend:arglist symbol)))
                :docstring (documentation symbol 'function)
                :source-file (find-source-file-of-function symbol))
          (when (eql type :function)
            (list :uses (remove-functions-not-in-rameau (function-uses symbol))
                  :used-by
                  (when used-by-p
                    (remove-functions-not-in-rameau (functions-used-by symbol)))))))

(defun create-documentation-sexp :private (package)
  (iter (for symbol in-package package :external-only t)
        (when (fboundp symbol)
          (collect (if (macro-function symbol)
                       (document-function-or-macro symbol :type :macro)
                       (document-function-or-macro symbol :type :function))))))

(defmacro html-page (stream title &body body)
  `(with-html-output (,stream nil :prologue t :indent t)
     (:html :xmlns :xmlns "http://www.w3.org/1999/xhtml"
            :xml\:lang "en" 
            :lang "en"
            (:head 
             (:meta :http-equiv "Content-Type" 
                    :content    "text/html;charset=utf-8")
             (:title ,title)
             (:link :rel "icon"
                  :type "image/gif"
                  :href "/favicon.ico")
             (:link :rel "stylesheet" :href "documentation.css"))
            (:body
             ,@body))))

(defun html-for-one-package (package)
  (with-open-file (file (concat *rameau-path* "/rameau-documentation/rameau.html")
                        :direction :output :if-exists :supersede)    
    (html-page file "Rameau API Documentation"
      (:h1 (str package))
      (:p1 (str (documentation (find-package package) t)))
      (iter (for plist in (create-documentation-sexp package))
            (htm (:h2 (str (getf plist :name)))
                 ;;(getf plist :type)
                 (:p "Syntax: " (str (getf plist :arglist)))
                 (:p (str (getf plist :docstring)))
                 (:p "defined in " (str (getf plist :source-file)))
                 (:p "uses" (str (getf plist :uses))))))))

(defun create-documentation-for-all-packages ()
  (mapcar #'create-documentation-sexp *rameau-packages*))

(defun document (options)
  (declare (ignore options))
  (create-documentation-for-all-packages))

(register-command :name "document"
                  :action #'document
                  :documentation "Generate the documentation for rameau and save it in the rameau-documentation folder.")
