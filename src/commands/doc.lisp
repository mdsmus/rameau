(defpackage :rameau-doc
  (:import-from #:arnesi "AIF" "AWHEN" "IT" "LAST1" "ENABLE-SHARP-L-SYNTAX")
  (:shadowing-import-from #:rameau-base #:defun #:defmacro #:defparameter #:defvar #:defstruct)
  (:use :rameau :cl :iterate :genoslib :cl-who))

(in-package :rameau-doc)

(enable-sharp-l-syntax)

(defparameter *rameau-packages*
  ;; falta rameau e rameau-doc
  '("RAMEAU" "RAMEAU-BASE" "GENOSLIB" "CL-LILY" "RAMEAU-WEB" "RAMEAU-ALG-COMMANDS"
    "RAMEAU-ANALYSIS" "RAMEAU-CADENCES" "RAMEAU-DOC" "RAMEAU-MUSICOLOGY"
    "RAMEAU-STAT" "RAMEAU-WEB" "RAMEAU-HMM" "RAMEAU-NEURAL" "RAMEAU-KNN"
    "RAMEAU-TREE-ENARM" "RAMEAU-PARDO"))

(defun swank-get-source-location :private (function-name)
  (second (aget :location (first (swank-backend:find-definitions function-name)))))

(defun find-source-file-of-function :private (function-name)
  ;; according to CLHS the readtable is reset after reading or
  ;; compiling a file. For some reason it is not enought to call
  ;; enable-sharp-l-syntax on the top of this file, it has to be
  ;; called here.
  (enable-sharp-l-syntax)
  (let ((file-name (swank-get-source-location function-name)))
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
  "Remove extraneous tags from string @var{docstring}"
  (when docstring
    (cl-ppcre:regex-replace "\\[NOTEST\\]" docstring "")))

(defun find-test-body (test-name test-file)
  "Find the body of a test names @var{test-name} in file @var{test-file}"
  (flet ((get-first-test (test-list)
           (second (third (first test-list)))))
    (get-first-test (remove-if-not #L(eql test-name (second !1)) test-file))))

(defun document-function-or-macro :private (symbol &key (type :function) cross-func-ref-p)
  (append (list :package-name (get-package-name symbol)
                :name symbol
                :type type
                :arglist (swank-backend:arglist symbol)
                :docstring (parse-documentation (documentation symbol 'function))
                :source-file (find-source-file-of-function symbol))
          (when (and cross-func-ref-p (eql type :function))
            (list :uses
                  (remove-functions-not-in-rameau (function-uses symbol))
                  :used-by
                  (remove-functions-not-in-rameau (functions-used-by symbol))))))

(defun create-documentation-sexp :private (package)
  (iter (for symbol in-package package :external-only t)
        (when (fboundp symbol)
          (collect (if (macro-function symbol)
                       (document-function-or-macro symbol :type :macro)
                       (document-function-or-macro symbol :type :function))))))

(defun get-all-tests ()
  "Get all texts from rameau."
  (mapcan #'read-file-as-sexp (directory (concat *rameau-path* "src/tests/*.lisp"))))

;;; HTML

(defmacro html-page (stream title &body body)
  "Standard rameau documentation page markup."
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
             (:div :class "main"
                   ,@body)))))

(defun htmlize-docstring (string)
  "Replace strings in the form of @foo{bar} and gerenate a span whose
class is foo and content is bar."
  (let* ((str1 (cl-ppcre:regex-replace-all "@link{([\\w+ ]+)}{([\\w-@%?!/:.]+)}" string "<a href='\\2'>\\1</a>"))
         (str2 (cl-ppcre:regex-replace-all "@rameau" str1 "<span class='rameau'>rameau</span>")))
    (cl-ppcre:regex-replace-all "@(\\w+){([\\w-@%?!:\\*.~/]+)}" str2 "<span class='\\1'>\\2</span>")))

(defun html-for-one-package (package)
  "Generate documentation for package @var{package}"
  (format t "Generating documentation for package ~a.~%" package)
  (with-open-file (file (format nil "~a/rameau-documentation/~(~a~).html" *rameau-path* package)
                        :direction :output :if-exists :supersede)
    (html-page file "Rameau API Documentation"
      (:h1 (str (escape-string (string-upcase (stringify package)))))
      (:p1 (str (htmlize-docstring (documentation (find-package package) t))))
      (iter (for plist in (create-documentation-sexp package))
            (with test-file = (get-all-tests))
            (for name = (getf plist :name))
            (for docstring = (getf plist :docstring))
            ;;(for url = "http://bugs.genos.mus.br/repositories/entry/rameau/")
            (for url = "http://git.genos.mus.br/cgit.cgi?url=rameau/tree/")
            (for filename = (or (getf plist :source-file) ""))
            (for example = (find-test-body name test-file))
            (for uses = (getf plist :uses))
            (htm
             (:div :class "function-type"
                   (:h2 (fmt "[~a]" (getf plist :type))))
             (:div :class "function-name-header"
                   (:h2 (str (escape-string (string-upcase (stringify name))))))
             (:div :class "function-block"
                   (:div :class "function-arg-list"
                         (:p (:span :class "function-name" (fmt "~(~a~)" name))
                             (iter (for arg in (getf plist :arglist))
                                   (if (member arg '(&optional &rest &key &body))
                                       (htm (:span :class "function-key" (str (escape-string (stringify arg)))))
                                       (htm (:span :class "function-arg" (str (escape-string (stringify arg)))))))))
                   (htm
                    (:br)
                    (:p :class "example-header" "Description:")
                    (:p :class "docstring"
                        (str (escape-string (htmlize-docstring (or docstring ""))))
                        "Defined in " (htm (:a :href (concat url filename)
                                               (str (escape-string (pathname-name filename)))))))
                   (when uses
                     (htm (:p :class "example-header" "Uses:")
                          (:p :class "uses-body"
                              (fmt "~{~(~a~^, ~)~}" uses))))
                   (when example
                     (htm (:p :class "example-header" "Example:")
                          (:span :class "example"
                                 (fmt "~(~s~)" (third example))
                                 (:br)
                                 (fmt "=> ~(~s~)" (second example)))))))))))

(defun make-index-page (packages)
  (with-open-file (file (format nil "~a/rameau-documentation/index.html" *rameau-path*)
                        :direction :output :if-exists :supersede)
    (html-page file "Rameau API Documentation"
      (:h1 "Rameau")
      (:p1 "A system for automatic harmonic analysis")
      (:h2 "Packages:")
      (:ul 
       (iter (for package in packages)
             (htm (:li (:a :href (format nil "~(~a~).html" package)
                           (fmt "~a" (string-capitalize package)))
                       (:p (str
                            (htmlize-docstring
                             (documentation (find-package package) t)))))))))))

;;; Basic command
(defun document (options)
  "Document rameau."
  (declare (ignore options))
  (make-index-page *rameau-packages*)
  (mapcar #'html-for-one-package *rameau-packages*))

(register-command :name "document"
                  :action #'document
                  :documentation "Generate the documentation for
                  rameau and save it in the rameau-documentation
                  folder.")
