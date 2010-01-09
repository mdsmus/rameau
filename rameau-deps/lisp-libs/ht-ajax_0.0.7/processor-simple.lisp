;;; -*- Mode: LISP; Syntax: COMMON-LISP; Base: 10 -*-
;;;
;;; Copyright (c) 2007, Ury Marshak
;;; The code comes with a BSD-style license, so you can basically do
;;; with it whatever you want. See the file LICENSE for details.
;;;

(in-package #:ht-ajax)

(declaim #.*optimization*)

;;


;;; This is loosely based on the CL-AJAX package by Richard Newman
;;; (http://www.cliki.net/cl-ajax, http://www.holygoat.co.uk/applications/cl-ajax/cl-ajax)
;;; but probably does not deserve the name "port of CL-AJAX for Hunchentoot",
;;; also in any case the code taken from CL-AJAX was heavily modified, so
;;; the bugs are probably mine



(defclass simple-ajax-processor (ajax-processor)
  ())


(defun prepare-js-simple-init-request ()
  "
function init_request() {
//  debug_alert(\"Initialising request...\");
  var r;
  if (window.XMLHttpRequest) { r = new XMLHttpRequest(); }
  else {
    try { r = new ActiveXObject(\"Msxml2.XMLHTTP\"); } catch (e) {
      try { r = new ActiveXObject(\"Microsoft.XMLHTTP\"); } catch (ee) {
        r = null;
      }}}
  if (!r) debug_alert(\"Browser couldn't make a connection object.\");
  return r;
}
")



(defun prepare-js-simple-ajax-preamble (server-uri) 
  "Output a string containing the call function."
  (format nil "

function ajax_call_uri(func, callback_spec, args) {
  var uri = '~A';
  var i;
  var response = null;
  var callbacks = ajax_parse_callbacks(callback_spec);

  if (uri.indexOf('?') == -1)
    uri = uri + '?';
  else
    uri = uri + '&';

  uri = uri + ajax_encode_args(func, args);

  var re = init_request();

  re.open('GET', uri, true);
  re.onreadystatechange = function() {
    if (re.readyState != 4) return;
    if (((re.status>=200) && (re.status<300)) || (re.status == 304)) {
      var data = re.responseText;
      ajax_call_maybe_evaluate_json(callbacks[0], 
                                    data, 
                                    re.getResponseHeader('Content-Type'));
    }
    else {
      if(callbacks[1]) {
          callbacks[1](re.status + ' ' + re.statusText);
      }
      else {
          debug_alert('Error for URI '+uri + ' ' + re.status + ' ' + re.statusText);
      }

    }
  }
  re.send(null);
  delete re;
}"
    server-uri))


(defmethod prepare-js-ajax-function ((processor simple-ajax-processor) fun-name js-fun-name
                                     &rest rest &key method &allow-other-keys)
  (declare (ignore processor))
  (unless (eq method :get)
    (error "SIMPLE-AJAX-PROCESSOR does not support methods other than GET"))
  (apply #'prepare-js-ajax-function-definitions "ajax_call_uri" fun-name js-fun-name rest))



;; (defun wrap-result-in-xml (result element-id)
;;   (no-cache)
;;   (format nil
;;           "<?xml version=\"1.0\" encoding=\"utf-8\" standalone=\"yes\"?>
;; <response>~A<result xmlns=\"http://www.w3.org/1999/xhtml\">~A</result></response>"
;;           (if element-id
;;               (concatenate 'string "<elem_id>" element-id "</elem_id>")
;;               "")
;;           result)
;;   )


;; (defmethod handle-request ((processor simple-ajax-processor))
;;   (let ((ajax-xml (string-to-js-boolean (parameter "ajax-xml")))
;;         (ajax-elem (parameter "ajax-elem")))
;;     (let ((result (call-next-method)))
;;       (if ajax-xml
;;           (progn
;;             (setf (content-type) "text/xml")
;;             (wrap-result-in-xml result ajax-elem))
;;           result)
;;       ))
;;   )


(defmethod %generate-includes ((processor simple-ajax-processor))
  "No includes for SIMPLE processor"
  ;;
  "")


(defmethod %generate-js-code ((processor simple-ajax-processor))
  (apply #'concatenate 'string
         (prepare-js-debug-function processor)
         (prepare-js-ajax-encode-args)
         (prepare-js-parse-callbacks)
         (prepare-js-ajax-is-json)
         (prepare-js-ajax-call-maybe-evaluate-json)
         (prepare-js-simple-ajax-preamble (maybe-rewrite-url-for-session
                                           (server-uri processor)))
         (prepare-js-simple-init-request)

         (loop
            for fun-name being the hash-keys
            in (exported-funcs processor)
            collect (apply #'prepare-js-ajax-function
                           processor
                           fun-name
                           (js-function-name processor fun-name)
                           (gethash fun-name (exported-funcs processor))))
         ))

