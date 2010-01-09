;;; -*- Mode: LISP; Syntax: COMMON-LISP; Base: 10 -*-
;;;
;;; Copyright (c) 2007, Ury Marshak
;;; The code comes with a BSD-style license, so you can basically do
;;; with it whatever you want. See the file LICENSE for details.
;;;

(in-package #:ht-ajax)

(declaim #.*optimization*)

;;

(defclass ajax-processor ()
  ((exported-funcs :initform nil :accessor exported-funcs)
   (server-uri :initarg :server-uri :accessor server-uri)
   (hunchentoot-handler :accessor hunchentoot-handler)
   (cached-prologue :accessor cached-prologue :initform nil)
   (js-debug :accessor js-debug :initarg :js-debug :initform nil)
   (js-compression :accessor js-compression :initarg :js-compression :initform nil)
   (ajax-function-prefix :initarg :ajax-function-prefix
                         :accessor ajax-function-prefix :initform "ajax_")
   (default-content-type :initarg :default-content-type
     :accessor default-content-type :initform "text/plain; charset=\"utf-8\"")
   (default-reply-external-format :initarg :default-reply-external-format
     :accessor default-reply-external-format :initform hunchentoot::+utf-8+)
   (virtual-js-file :initarg :virtual-js-file
                    :accessor virtual-js-file :initform nil)
   (virtual-files :accessor virtual-files :initform nil))
  
  (:documentation "The class containing all ajax-related handling"))


(defmethod initialize-instance :after ((processor ajax-processor) &key)
  (setf (exported-funcs processor)  (make-hash-table :test 'equal))
  (unless (and (slot-boundp processor 'server-uri)
               (server-uri processor))
    (error "Initializing AJAX-PROCESSOR without SERVER-URI.")))


;;


(defgeneric handle-request (processor)
  (:documentation "Process the incoming request from hunchentoot"))


(defgeneric export-func (processor funcallable
                                   &key method name content-type allow-cache)
  (:documentation "Makes the function designated by FUNCALLABLE exported (available to call from js)
Parameters:
  METHOD - :get (default) or :post (:post is not supported under SIMPLE processor)
  NAME - export the function under a different name
  CONTENT-TYPE - Value of Content-Type header so set on the reply (default: text/plain)
  ALLOW-CACHE - (default nil) if true then HT-AJAX will not call NO-CACHE function and
                allow to control cache manually
  JSON - (default nil) if true, the function returns a JSON-encoded object that will
         be decoded on the client and passed to the callback
"))

(defgeneric unexport-func (processor symbol-or-name)
  (:documentation "Removes the previously exported function, should be called
with either the name (string) under which it was exported or the symbol
designating the function"))


(defmacro defun-ajax (name params (processor &rest export-args) &body body)
  "Macro, defining a function exported to AJAX
Example: (defun-ajax func1 (arg1 arg2) (*ajax-processor*)
   (do-stuff))"
  (let ((f (gensym)))
      `(let ((,f (defun ,name ,params ,@body)))
	 (if ,f (export-func ,processor ',name ,@export-args)))))


(defgeneric generate-prologue (processor &key use-cache)
  (:documentation "Generates the necessary HTML+JS to be included in the web page.
Provides caching if USE-CACHE is true (default)"))


(defgeneric %generate-includes (processor)
  (:documentation "Internal generic function to be implemented in specific 
ajax processor"))

(defgeneric %generate-js-code (processor)
  (:documentation "Internal generic function to be implemented in specific 
ajax processor"))


(defgeneric get-handler (processor)
  (:documentation "Get the hunchentoot handler for AJAX url. 
The url that was passed as the SERVER-URI parameter should be
dispatched to this handler."))


(defgeneric reset-prologue-cache (processor)
  (:documentation ""))


(defgeneric js-function-name (processor function-name)
  (:documentation ""))

(defgeneric prepare-js-ajax-function (processor fun-name js-fun-name
                                     &rest rest &key method &allow-other-keys)
  (:documentation ""))

;;; 

(defmethod export-func ((processor ajax-processor) funcallable
                        &key (method :get) name content-type allow-cache json)
  (let ((func-name (or name
                       (when (symbolp funcallable)
                         (symbol-name funcallable)))))
    (unless func-name
      (error "Name not provided for ~A" funcallable))
    
    (setf (gethash (string-upcase func-name) (exported-funcs processor))
          `(:funcallable ,funcallable
                         :method ,method
                         :content-type ,content-type
                         :allow-cache ,allow-cache
                         :json ,json))
    (reset-prologue-cache processor)
    (values)))


(defmethod unexport-func ((processor ajax-processor) symbol-or-name)
  (let ((func-name (or (when (symbolp symbol-or-name)
                         (symbol-name symbol-or-name))
                       symbol-or-name)))
    (unless (and func-name
                 (stringp func-name))
      (error "Invalid name ~S in UNEXPORT-FUNC" symbol-or-name))

    (remhash (string-upcase func-name) (exported-funcs processor))
    (reset-prologue-cache processor)
    (values)))



(defmethod handle-request ((processor ajax-processor))
  ;; See if it's a request for a virtual .JS file
  (let ((virtual-file-result (handle-virtual-file processor)))
    (when virtual-file-result
      (return-from handle-request virtual-file-result)))

  ;; Not a vitual file, process as a function call
  (let ((func-name (parameter "ajax-fun"))
        (num-args (parameter "ajax-num-args")))
    (unless (and func-name num-args)
      (error "Error in HANDLE-REQUEST: required parameters missing"))

    (let* ((args (loop for i from 0 below (parse-integer num-args)
                    for arg-name = (concatenate 'string "ajax-arg" (princ-to-string i))
                    for arg = (parameter arg-name)
                    collect arg))
           (funcallable-plist (gethash func-name (exported-funcs processor)))
           (funcallable (getf funcallable-plist :funcallable)))
      (unless funcallable
        (error "Error in HANDLE-REQUEST: no such function: ~A" func-name))

      (let ((content-type (getf funcallable-plist :content-type)))
        ;; Can't use the default parameter of getf since it may be present but null
        (setf (content-type) (or content-type
                                 (when (getf funcallable-plist :json) (json-content-type))
                                 (default-content-type processor))))
      (when (default-reply-external-format processor)
        (setf (reply-external-format) (default-reply-external-format processor)))
      (unless (getf funcallable-plist :allow-cache)
        (no-cache))

      (apply funcallable args))))


(defun handle-virtual-file (processor)
  (let* ((file-name (string-downcase (script-name)))
         (file-record (assoc file-name (virtual-files processor) :test 'equal)))
    (when file-record
      (let ((time (cddr file-record)))
        (handle-if-modified-since time) ; Does not return if the file was not modified
        
        (setf (content-type) "text/javascript")
        (setf (header-out "Last-Modified") (rfc-1123-date time))
        ;;(setf (header-out "Expires") (rfc-1123-date (+ time #.(* 60 60 2))))
        (cadr file-record)))))


(defun store-virtual-js-file (processor file-contents)
  "Makes a new unique name for a file, makes an alist of file name and a cons of 
contents and time, stores the alist in the processor's slot and returns the 
file name"
  (let ((file-name (string-downcase (concatenate 'string
                                                 (server-uri processor)
                                                 "/"
                                                 (symbol-name (gensym))
                                                 ".js"))))
    (setf (virtual-files processor) (list (cons file-name
                                                (cons file-contents (get-universal-time)))))
    file-name))


(defmethod get-handler ((processor ajax-processor))
  (if (slot-boundp processor 'hunchentoot-handler)
      (hunchentoot-handler processor)
      (setf (hunchentoot-handler processor) #'(lambda ()
                                                (handle-request processor)))))


(defun make-ajax-processor (&rest rest &key (type :simple) &allow-other-keys)
  "Creates an ajax-processor object. Parameters: 
   TYPE - selects the kind of ajax-processor to use (should be 
          one of:SIMPLE or :LOKRIS, :PROTOTYPE, :YUI or :DOJO) (required)
   SERVER-URI - url that the ajax function calls will use (required)
   JS-FILE-URIS - a list of URLs on your server of the .js files that the
                used library requires , such as lokris.js or prototype.js 
                (parameter required for all processors except :SIMPLE). If
                only one file needs to be included then instead of a list a single 
                string may be passed. Also if this parameter is a string that ends 
                in a forward slash ( #\/ ) then it is assumed to be a directory 
                and the default file names for the processor are appended to it.
   AJAX-FUNCTION-PREFIX - the string to be prepended to the generated js functions,
                (default prefix is \"ajax_\")
   JS-DEBUG - enable the Javascript debugging function debug_alert(). Overrides
              such parameters as JS-COMPRESSION and VIRTUAL-FILES
   JS-COMPRESSION - enable Javascript compression to minimize the download size
   VIRTUAL-JS-FILE - enable creation of virtual Javascript file instead of
                inline Javascript code that may be cached on the client to 
                minimize traffic
   "
  (let ((params (copy-seq rest)))
    (remf params :type)

    ;; make a class name depending on TYPE and create an instance
    (let* ((class-name (concatenate 'string (symbol-name type) "-ajax-processor"))
           (class-sym (intern (string-upcase class-name) #.*package*)))
      (apply #'make-instance class-sym params))))


(defmethod generate-prologue ((processor ajax-processor) &key (use-cache t))
  (let ((cached-prologue (cached-prologue processor)))
    (if (and cached-prologue use-cache)
        cached-prologue
        (let ((prologue (%generate-includes processor))
              (js-code (%generate-js-code processor)))
          
          (when (and (js-compression processor) (js-debug processor))
            (setf (js-compression processor) nil)
            (warn "JS-COMPRESSION conflicts with JS-DEBUG, JS-COMPRESSION disabled."))
          
          (when (js-compression processor)
            (setf js-code (jsmin js-code)))

          (when (and (virtual-js-file processor) (js-debug processor))
            (setf (virtual-js-file processor) nil)
            (warn "VIRTUAL-JS-FILE conflicts with JS-DEBUG, VIRTUAL-JS-FILE disabled."))

          (if (virtual-js-file processor)
              ;; Create a virtual file and use a link to it
              (let ((file-name (store-virtual-js-file processor js-code)))
                (setf prologue (concatenate 'string
                                            "<!-- HT-AJAX " +version+ "-->"
                                            prologue
                                            (prepare-js-file-include file-name))))
              ;; Not using virtual file, create inline <script> tag
              (setf prologue (concatenate 'string
                                          "<!-- HT-AJAX " +version+ "-->"
                                          prologue
                                          (wrap-js-in-script-tags js-code))))

          (setf (cached-prologue processor) prologue)))))



(defmethod reset-prologue-cache ((processor ajax-processor))
  (setf (cached-prologue processor) nil))


(defmethod js-function-name ((processor ajax-processor) function-name)
  (concatenate 'string
               (ajax-function-prefix processor)
               (string-downcase (make-safe-js-name function-name))))


(defun maybe-rewrite-url-for-session (url &key (cookie-name *session-cookie-name*)
                                      (value (hunchentoot::session-cookie-value)))
  "Modelled after (well, copied from) HUNCHENTOOT::MAYBE-REWRITE-URLS-FOR-SESSION.
Rewrites the URL such that the name/value pair
COOKIE-NAME/COOKIE-VALUE is inserted if the client hasn't sent a
cookie of the same name but only if *REWRITE-FOR-SESSION-URLS* is
true."
  (cond
    ((or (not *rewrite-for-session-urls*)
         (null value)
         (cookie-in cookie-name))
     url)
    (t
     (hunchentoot::add-cookie-value-to-url url
                                           :cookie-name cookie-name
                                           :value value))))


 ;;

(defclass library-ajax-processor (ajax-processor)
  ((js-file-uris :initarg :js-file-uris :accessor js-file-uris))
  (:documentation "The class representing a processor that uses an 
external Javascript library"))

(defgeneric default-library-file-names (library-ajax-processor)
  (:documentation "Returns the default filename for Javascript library to
be included in the HTML"))


(defmethod initialize-instance :after ((processor library-ajax-processor) &key)
  (unless (and (slot-boundp processor 'js-file-uris)
               (js-file-uris processor))
    (error "Initializing ~A without JS-FILE-URIS" (class-name (class-of processor))))
  (let ((file-uri (js-file-uris processor)))
    (when (and (stringp file-uri)
               (eql (char file-uri (1- (length file-uri))) #\/)) ; Just a path
      ;; Store default filenames for this processor
      (setf (js-file-uris processor)
            (mapcar #'(lambda (fname) (concatenate 'string
                                                   file-uri fname))
                    (default-library-file-names processor))))
    ;; If it's a string then wrap it in a list
    (when (stringp (js-file-uris processor))
      (setf (js-file-uris processor) (list (js-file-uris processor))))))


(defmethod %generate-includes ((processor library-ajax-processor))
  (apply #'concatenate 'string
         (mapcar #'prepare-js-file-include (js-file-uris processor))))


(defmethod prepare-js-ajax-function ((processor library-ajax-processor) fun-name js-fun-name
                                     &rest rest &key method &allow-other-keys)
  (declare (ignore processor))
  (let ((request-func (ecase method
                        (:get "ajax_call_uri")
                        (:post "ajax_post_uri"))))
    (apply #'prepare-js-ajax-function-definitions request-func fun-name js-fun-name rest)))
