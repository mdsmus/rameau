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
  (let ((file-name (cadadr (swank-backend:find-source-location (symbol-function function-name)))))
   (cl-ppcre:regex-replace *rameau-path*  file-name "")))

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

(defun parse-documentation (docstring)
  (when docstring
    (string-trim "[NOTEST]" docstring)))

(defun find-test-body (test-name test-file)
  (flet ((get-first-test (test-list)
           (second (third (first test-list)))))
    (get-first-test (remove-if-not #L(eql test-name (second !1)) test-file))))

(defun document-function-or-macro :private (symbol &key (type :function) used-by-p)
  (append (list :package-name (get-package-name symbol)
                :name symbol
                :type type
                :arglist (swank-backend:arglist symbol)
                :docstring (parse-documentation (documentation symbol 'function))
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
     (:html
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

(defun get-all-tests ()
  (mapcan #'read-file-as-sexp (directory (concat *rameau-path* "src/tests/*.lisp"))))

(defun htmlize-docstring (string)
  "Replace strings in the form of @foo{bar} and gerenate a div whose
class is foo and content is bar."
  (cl-ppcre:regex-replace-all "@(\\w+){([\\w-@%?!]+)}" string "<div class='\\1'>\\2</div>"))

(defun html-for-one-package (package)
  (with-open-file (file (format nil "~a/rameau-documentation/~(~a~).html" *rameau-path* package)
                        :direction :output :if-exists :supersede)
    (html-page file "Rameau API Documentation"
      (:h1 (str package))
      (:p1 (str (documentation (find-package package) t)))
      (iter (for plist in (create-documentation-sexp package))
            (with test-file = (get-all-tests))
            (for name = (getf plist :name))
            (for docstring = (getf plist :docstring))
            (for url = "http://bugs.genos.mus.br/repositories/entry/rameau/")
            (for filename = (getf plist :source-file))
            (for example = (find-test-body name test-file))
            (htm (:h2 (str name))
                 (:div :class "function-block"
                       (:div :class "function-arg-list"
                             ;;(getf plist :type)
                             (:p (:div :class "function-name" (fmt "~(~a~)" name))
                                 (iter (for arg in (getf plist :arglist))
                                       (if (member arg '(&optional &rest &key &body))
                                           (htm (:div :class "function-key" (str (stringify arg))))
                                           (htm (:div :class "function-arg" (str (stringify arg))))))))
                       (when docstring (htm
                                        (:br)
                                        (:p :class "docstring"
                                            (str (htmlize-docstring docstring))
                                            "Defined in " (htm (:a :href (concat url filename)
                                                                   (str (pathname-name filename)))))))
                       
                       (:p "uses" (str (getf plist :uses)))
                       (when example
                         (htm (:p :class "example-header" "Example: ")
                              (:div :class "example"
                                    (fmt "~s" (third example))
                                    (:br)
                                    (fmt "=> ~s" (second example)))))))))))

(defun create-documentation-for-all-packages ()
  (mapcar #'html-for-one-package *rameau-packages*))

(defun document (options)
  (declare (ignore options))
  (create-documentation-for-all-packages))

(register-command :name "document"
                  :action #'document
                  :documentation "Generate the documentation for rameau and save it in the rameau-documentation folder.")
