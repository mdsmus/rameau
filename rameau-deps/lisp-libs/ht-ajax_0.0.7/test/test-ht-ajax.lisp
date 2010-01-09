;;; -*- Mode: LISP; Syntax: COMMON-LISP; Base: 10 -*-
;;;
;;; Copyright (c) 2007, Ury Marshak
;;; The code comes with a BSD-style license, so you can basically do
;;; with it whatever you want. See the file LICENSE for details.
;;;

(in-package #:ht-ajax-test)

(declaim (optimize (space 0) (speed 0) (safety 3) (debug 3)))


(defvar *this-file* (load-time-value
                     (or #.*compile-file-pathname* *load-pathname*)))

(defvar *this-dir* (make-pathname :host (pathname-host *this-file*)
                                  :device (pathname-device *this-file*)
                                  :directory (pathname-directory *this-file*)))


;; (defmacro debug-output (value)
;;   `(ignore-errors
;;     (swank::with-connection ((swank::default-connection)) (print ,value))))



;;
(defparameter +templates-root+ (namestring *this-dir*))

(defparameter +web-root-base+ "/hunchentoot/test")
(defparameter +web-root+ (concatenate 'string +web-root-base+ "/"))
(defparameter +static-web-root+ (concatenate 'string +web-root+ "static/"))

(defparameter +ajax-handler-url+ (concatenate 'string +web-root+ "ajax-hdlr"))

(defparameter +static-files-root+ (concatenate 'string +templates-root+ "../static/"))



;;
(defun expand-web-addr (short-addr)
  (concatenate 'string +web-root+ short-addr ))


(defun expand-template (templ-short-name &optional args)
  (let ((templ-full-name (merge-pathnames templ-short-name +templates-root+)))
    (with-output-to-string (*default-template-output*)
      (funcall #'fill-and-print-template templ-full-name args :external-format :utf-8))))


(defun expand-template-with-prologue (templ-short-name &optional args prologue)
  (let ((page (expand-template templ-short-name args)))
    (regex-replace "(?s)<body[^>]*>" page (list :match prologue))))

;;


(defparameter *ajax-processor* (ht-ajax:make-ajax-processor
                                :type :prototype
                                :server-uri +ajax-handler-url+
                                :js-file-uris "static/"
                                :js-debug nil
                                :js-compression t
                                :virtual-js-file t))


;;


(defun test ()
  (no-cache)
;;   (setf (content-type) "text/html; charset=utf-8")
;;   (setf (reply-external-format)  hunchentoot::+utf-8+)
  
  (expand-template-with-prologue "test-ajax.tmpl.html" '()
                                 (ht-ajax:generate-prologue *ajax-processor*)))


(let ((counter 0))
  (ht-ajax:defun-ajax get-counter () (*ajax-processor*)
    (concatenate 'string
                 "<span>" "counter: "
                 (princ-to-string (incf counter))
                 "</span>")))


(ht-ajax:defun-ajax testfunc (command) (*ajax-processor* :method :post)
  (prin1-to-string (handler-case (eval (read-from-string command nil))
                     (error (c) (format nil "~A" c)))))


(ht-ajax:defun-ajax testjson () (*ajax-processor* :method :get
                                                  :json t)
  "{\"p\":[1,2,3,5,7,11]}")


;;

(defun string-starts-with (string prefix)
  ;; (from Hunchentoot)
  (let ((mismatch (mismatch string prefix :test #'char=)))
    (or (null mismatch)
        (>= mismatch (length prefix)))))

;;
(defun page404 ()
  (no-cache)
  (setf (return-code *reply*) +http-not-found+)
  (throw 'handler-done nil))


(defparameter +urls-alist+ '(("test" . test)) )


(defun serve-static ()
  "Handle a request for a file under static/ directory"
  (let* ((script-name (script-name))
         (fname (subseq script-name (length +static-web-root+)))
         (fullname (concatenate 'string +static-files-root+ fname)))
    (handle-static-file fullname)))


(defun dispatch (request)
  (let ((script-name (script-name request)))
    (cond
      ((or (string-equal script-name +web-root-base+)
           (string-equal script-name +web-root+)) 'root-url) ; go to the start page
      ((string-starts-with script-name +ajax-handler-url+)          ; process AJAX requests
         (ht-ajax:get-handler *ajax-processor*))
      ((not (string-starts-with script-name +web-root+)) nil) ; do not handle this request
      ((string-starts-with script-name +static-web-root+) 'serve-static) ; serve static file
      
      (t                                ; normal processing
       (let* ((name (subseq script-name (length +web-root+)))
              (handler (assoc name +urls-alist+ :test #'string-equal)))

         (if handler
             (cdr handler)
             'page404))))))



(pushnew 'dispatch *dispatch-table* :test #'eq)
