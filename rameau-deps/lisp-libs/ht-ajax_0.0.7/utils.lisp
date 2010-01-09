;;; -*- Mode: LISP; Syntax: COMMON-LISP; Base: 10 -*-
;;;
;;; Copyright (c) 2007, Ury Marshak
;;; The code comes with a BSD-style license, so you can basically do
;;; with it whatever you want. See the file LICENSE for details.
;;;

(in-package #:ht-ajax)

(declaim #.*optimization*)


;;
;; Common functions
;;

(defun make-safe-js-name (function-name)
  "Primitive function to try to turn rich lisp names into suitable
 for Javascript"
  (loop for c across "-<>"
     do (setf function-name (substitute #\_ c function-name))
     finally (return function-name)))


(defun prepare-js-debug-function (processor)
  "Output the debugging function."
  (concatenate 'string "
function debug_alert(text) {"
               (when (js-debug processor)
                   "  alert(\"HT-AJAX: \" + text);" )
               "}
"))


;; (defun js-string-to-boolean (str)
;;   (when str
;;     (not (or (string= str "")
;;              (string= str "null")
;;              (string= str "false")
;;              (string= str "0"))
;;          )))



;; (defun entity-escape (s)
;;   (setf s (regex-replace-all "(?s)&" s "&amp;"))
;;   (setf s (regex-replace-all "(?s)<" s "&lt;"))
;;   (setf s (regex-replace-all "(?s)>" s "&gt;"))
;;   )



(defun prepare-js-collect-varargs-to-array (num-standard-args &optional (array-name "args"))
  (let ((start_args (symbol-name (gensym)))
        (end_args (symbol-name (gensym)))
        (i (symbol-name (gensym))))
    (concatenate 'string
                 "
  var " start_args " = " (princ-to-string num-standard-args) ";
  var " end_args " = arguments.length;

  var " array-name " = new Array();
  var " i " = " start_args ";
  for (var " i "=" start_args "; " i " < " end_args "; ++" i ")
    " array-name ".push(arguments[" i "]);
"    )))


(defun prepare-js-ajax-encode-args ()
  ;;
  "
function ajax_encode_args(func, args) {
  var res = 'ajax-fun=' + encodeURIComponent(func);
  var i;
  if (args)
    for (i = 0; i < args.length; ++i) {
      res = res + '&ajax-arg' + i + '=' + encodeURIComponent(args[i]);
    }
  res = res + '&ajax-num-args=' + args.length;

  res = res + '&ajax-xml=false';

  return res;
}
")


(defun wrap-js-in-script-tags (js)
  (concatenate 'string
               "
<script type=\"text/javascript\">
//<![CDATA[
"
               js
               "
//]]>
</script>
" ))



(defun prepare-js-file-include (js-file-uri)
  (concatenate 'string
          "<script src=\"" js-file-uri "\" type=\"text/javascript\"></script>"))


(defun prepare-js-parse-callbacks ()
  "Create a Javascript function that receives a specification for
  callbacks and returns an array of two functions, the first is the
  success callback and the second is the error callback. The callback
  specification may be: 
    Function. It is assumed to be the success callback, the error callback
        is assumed to be null
    Array. Returned as is, i.e. it should be [success_callback, error_callback]
    Object. If the object has a success property it is used as success callback.
        The error property if present becomes the error callback."
  ;;
  "
function ajax_parse_callbacks(obj) {
  if (typeof obj === 'function') {
    return [obj, null];
  }
  if (typeof obj === 'object' && typeof obj.length === 'number') {
    // array
    return obj;
  }
  var error_callback = null;
  var success_callback = null;
  if (obj.error !== undefined) {
    error_callback = obj.error;
  }
  if (obj.success !== undefined) {
    success_callback = obj.success;
  }
  
  return [success_callback, error_callback];
}
")


(defun json-content-type ()
  "Official IANA http://www.iana.org/assignments/media-types/application/"
  ;;
  "application/json")


(defun prepare-js-ajax-is-json ()
  (concatenate 'string
               "
function ajax_trim_CR(s) {
  if (s.charCodeAt(s.length-1)==13) {
    s = s.substring(0,s.length-1)
  }
  return s;
}

function ajax_is_json(content_type) {
  content_type = ajax_trim_CR(content_type); // YUI under IE needs this
  return (content_type == '" (json-content-type) "');
}
"))


(defun prepare-js-ajax-call-maybe-evaluate-json ()
  (concatenate 'string
               "
function ajax_call_maybe_evaluate_json(callback, data, content_type) {
  if (ajax_is_json(content_type)) {
    try {
      data = eval('(' + data + ')');
    } 
    catch (e) {
      debug_alert(e.message);
    }
  }
  callback(data);
}
"))


(defun prepare-js-ajax-function-definitions(request-func fun-name js-fun-name &key method &allow-other-keys)
  "Output a string containing the appropriate Javascript for accessing fun-name
   on server-uri."
  (concatenate 'string
               "
function " js-fun-name "_callback(callback)
 {
" (prepare-js-collect-varargs-to-array 1 "args") "
  " request-func "('" fun-name "', callback, args);
}
"
               "
function " js-fun-name "_set_element(elem_id)
 {
" (prepare-js-collect-varargs-to-array 1 "args") "

  var elem = document.getElementById(elem_id);
  if (!elem) {
    debug_alert('!elem');
  }

  " request-func "('" fun-name "', function(res) {elem.innerHTML=res;} , args);
}
"))


