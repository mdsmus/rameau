(defpackage :rameau-doc
  (:import-from #:arnesi "AIF" "AWHEN" "IT" "LAST1" "ENABLE-SHARP-L-SYNTAX")
  (:import-from #:alexandria "SWITCH")
  (:use :rameau :cl :iterate :cl-utils :cl-who))

(in-package :rameau-doc)

(enable-sharp-l-syntax)

(defparameter *rameau-packages*
  '("RAMEAU" "EXPORT-SYMBOLS" "CL-UTILS" "CL-MUSIC" "CL-LILY" "RAMEAU-WEB"
    "RAMEAU-ALG-COMMANDS" "RAMEAU-ANALYSIS" "RAMEAU-DOC"
    "RAMEAU-MUSICOLOGY" "RAMEAU-STAT" "RAMEAU-WEB" "RAMEAU-HMM" "RAMEAU-NEURAL"
    "RAMEAU-KNN" "RAMEAU-TREE-ENARM" "RAMEAU-PARDO"))

(defun swank-get-source-location (function-name)
  (second (aget :location (first (swank-backend:find-definitions function-name)))))

(defun find-source-file-of-function (function-name)
  ;; according to CLHS the readtable is reset after reading or
  ;; compiling a file. For some reason it is not enought to call
  ;; enable-sharp-l-syntax on the top of this file, it has to be
  ;; called here.
  (enable-sharp-l-syntax)
  (awhen (swank-get-source-location function-name)
    (pathname-difference (translate-logical-pathname "rameau:") it)))

(defun function-uses (function-name)
  (handler-case (swank-backend:list-callees function-name)
    (serious-condition () (list function-name))
    (:no-error (expr) (mapcar #'first expr))))

(defun functions-used-by (function-name)
  (handler-case (swank-backend:list-callers function-name)
    (serious-condition () (list function-name))
    (:no-error (expr) (mapcar #'first expr))))

(defun get-package-name (symbol)
  (package-name (symbol-package symbol)))

(defun rameau-package-p (item)
  (flet ((get-package-name (el)
           (if (listp el)
               (unless (listp (second el))
                 (get-package-name (second el)))
               (get-package-name el))))
    (when (member (get-package-name item) *rameau-packages* :test #'equalp)
      t)))

(defun remove-functions-not-in-rameau (list)
  (mapcar #'(lambda (item) (if (listp item) (second item) item))
          (remove-if-not #'rameau-package-p list)))

(defun parse-documentation (docstring)
  "Remove extraneous tags from string @var{docstring}"
  (when docstring
    (cl-ppcre:regex-replace "\\[NOTEST\\]" docstring "")))

(defun parse-test (sexp)
  (flet ((parse-is-type (is-type)
           (switch ((stringify is-type) :test #'equal)
             ("is-false" nil)
             ("is-true" t)
             (t (error "Unknow is-type type ~a." is-type)))))
   (when (consp sexp)
     (destructuring-bind (is-type body) sexp
       (case (length body)
         (2 (list body (parse-is-type is-type)))
         (3 (list (third body)
                  (second body))))))))

(defun find-test-body (test-name test-file)
  "Find the body of a test names @var{test-name} in file @var{test-file}"
  (labels ((fiveam-predicate (item)
             "Use symbol-name because of package names."
             (member (symbol-name item)
                     '("IS" "IS-NOT" "IS-TRUE" "IS-FALSE")
                     :test #'equalp))
           (get-test (test-name test-file)
             (remove-if-not #L(equal test-name (second !1)) test-file))
           (get-first-test (test-list)
             (first (remove-if-not #'fiveam-predicate
                                   (nthcdr 2 (first test-list))
                                   :key #'first))))
    (let ((test (get-first-test (get-test test-name test-file))))
      (parse-test test))))

(defun document-function-or-macro (symbol &key (type :function)
                                   cross-func-ref-p)
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

(defun sorted-symbols (package)
  (sorted (iter (for symbol in-package package :external-only t) (collect symbol))
          #'string< :key #'stringify))

(defun create-documentation-sexp (package)
  (iter (for symbol in (sorted-symbols package))
        (when (fboundp symbol)
          (collect (if (macro-function symbol)
                       (document-function-or-macro symbol :type :macro)
                       (document-function-or-macro symbol :type :function))))))

(defun get-all-tests ()
  "Get all texts from rameau."
  (mapcan #'read-file-as-sexp (directory "rameau:src;tests;*.lisp")))

(defun pprint-to-string (object)
  (let ((s (make-string-output-stream))
        (*print-right-margin* 65)
        (*print-case* :downcase))
    (pprint object s)
    (subseq (get-output-stream-string s) 1)))

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

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defparameter *docstring-templates* nil)

  (defun single-template (name args body)
    (let ((arg (gensym))
          (str (gensym)))
      `(push (list ,(stringify name)
                   (lambda (,arg)
                     (destructuring-bind ,args (mapcar #'stringify ,arg)
                       (let ((,str ""))
                         (declare (ignore ,str))
                         (with-html-output-to-string (,str)
                           ,@body)))))
             *docstring-templates*)))

  (defmacro make-docstring-template (name (&rest args) &body body)
    "Define a dosctring template named @var{name} that expands to the
html code in @var{body}. These are expanded in
@function{rameau-doc}{htmlize-docstring}."
    (if (listp name)
        `(progn ,@(iter (for n in name) (collect (single-template n args body))))
        (single-template name args body))))

(make-docstring-template var (name)
  (:span :class "var" (str (escape-string name))))

(make-docstring-template link (name url)
  (:a :href url (str (escape-string name))))

(make-docstring-template rameau ()
  (:span :class "rameau" "rameau"))

(make-docstring-template file (name)
  (:a :href
      (str (concat "http://git.genos.mus.br/cgit.cgi?url=rameau/tree/src/"
                   (namestring name)
                   ".lisp"))
      (str name)))

(make-docstring-template (macro function) (package name)
  (:a :href
      (concat package ".html#" name)
      (str name)))

(make-docstring-template foo (bar)
  (str (concat "@&nbsp;foo{" bar "}")))

(make-docstring-template mono (text)
  (:span :class "mono" (str (escape-string text))))

(make-docstring-template code (text)
  (:pre :class "code" (str text)))

(defun apply-replacement (name args string)
  "Compute the correct replacement for template named @var{name} in @var{string}"
  (iter (for (command function) in *docstring-templates*)
        (when (string= command name)
          (return (funcall function args)))
        (finally (error "Template ~a not found in \"~a\".~%" name string))))

(defun all-arguments (arglist)
  (let (args)
    (cl-ppcre:do-register-groups (a) ("{([^}]*)}" arglist)
      (push a args))
    (reverse args)))

(let ((regex (cl-ppcre:create-scanner "@([a-z]+)(({([^}]*)})*)"))
      (pbreaks (cl-ppcre:create-scanner "\\n\\n")))
  (defun htmlize-docstring (string)
    "Replace strings in the form of @foo{bar} and expand it to a
user-defined template."
    (let ((string (format nil "<p>~a</p>"
                          (cl-ppcre:regex-replace-all pbreaks string "</p><p>"))))
      (iter (while (cl-ppcre:scan regex string))
            (cl-ppcre:register-groups-bind (name args) (regex string)
              (setf string (cl-ppcre:regex-replace regex
                                                   string
                                                   (apply-replacement name
                                                                      (all-arguments args)
                                                                      string)))))
      string)))

(defun make-doc-file (name)
  (make-pathname :directory
                 (logical-pathname-directory "rameau:rameau-documentation;")
                 :name (stringify name)
                 :type "html"))

(defun %html-string (symbol &optional uppcasep)
  "Convert a symbol to string in order to be used in the html
  documentation."
  (escape-string (funcall (if uppcasep
                              #'string-upcase
                              #'identity)
                          (stringify symbol))))

(defun html-for-one-package (package-name)
  "Generate the html documentation for a package. The argument
@var{package-name} is the symbol or keyword that names the package."
  (format t "Generating documentation for package ~a.~%" package-name)
  (with-output-file (file (make-doc-file package-name))
    (html-page file "Rameau API Documentation"
      (:h1 (str (%html-string package-name :upcase)))
      (:p1 (str (htmlize-docstring (documentation (find-package package-name) t))))
      (iter (for plist in (create-documentation-sexp package-name))
            (with test-file = (get-all-tests))
            (for name = (getf plist :name))
            (for docstring = (getf plist :docstring))
            (for url = "http://git.genos.mus.br/cgit.cgi?url=rameau/tree/")
            (for source-file = (getf plist :source-file))
            (for filename = (if (and source-file (not (equal source-file "")))
                                source-file
                                (make-pathname)))
            (for example = (find-test-body name test-file))
            (for uses = (getf plist :uses))
            (htm
             (:div :class "function-type"
                   (:h2 (fmt "[~a]" (getf plist :type))))
             (:div :class "function-name-header"
                   (:a :name (%html-string name)
                       (:h2 (str (%html-string name :upcase)))))
             (:div :class "function-block"
                   (:div :class "function-arg-list"
                         (:p (:span :class "function-name" (fmt "~(~a~)" name))
                             (iter (for arg in (getf plist :arglist))
                                   (if (member arg '(&optional &rest &key &body))
                                       (htm (:span :class "function-key"
                                                   (str (%html-string arg))))
                                       (htm (:span :class "function-arg"
                                                   (str (%html-string arg))))))))
                   (htm
                    (:br)
                    (:p :class "example-header" "Description:")
                    (:p :class "docstring"
                        (str (htmlize-docstring (escape-string (or docstring ""))))
                        "Defined in "
                        (htm (:a :href (concat url (namestring filename))
                                 (str (escape-string (pathname-name filename)))))))
                   (when uses
                     (htm (:p :class "example-header" "Uses:")
                          (:p :class "uses-body"
                              (fmt "~{~(~a~^, ~)~}" uses))))
                   (when (consp example)
                     (destructuring-bind (cmd result) example
                      (htm (:p :class "example-header" "Example:")
                           (:span :class "example"
                                  (str (pprint-to-string cmd))
                                  (:br)
                                  (str (concat "=> "
                                               (pprint-to-string result)))))))))
            (values)))))

(defun make-index-page (packages)
  (with-output-file (file (make-doc-file :index))
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

(defun show-help (command &key full)
  (format t "~:@(* ~a~)~%" (dashs->space (command-name command)))
  (when full
    (format t "    ~a~%" (command-documentation command))
    (iter (for (short long help) in (command-options command))
          (format t "~4T~4a--~25a ~a~%" short long (remove #\Newline help)))))

(defun help (options)
  "Display detailed help for one subcommand, specified with -c.
If not specified, list all subcommands and their descriptions."
  (aif (arg :command options)
       (show-help (get-command-by-name it) :full t)
       (mapcar #'show-help *commands*)))

(register-command :name "help"
                  :action #'help
                  :documentation "Show the help for a command."
                  :options '(("-c" "command" "The command to be helped.")))
