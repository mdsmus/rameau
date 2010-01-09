;;; -*- Mode: LISP; Syntax: COMMON-LISP; Base: 10 -*-
;;;
;;; Copyright (c) 2007, Ury Marshak
;;; The code comes with a BSD-style license, so you can basically do
;;; with it whatever you want. See the file LICENSE for details.
;;;

(in-package #:ht-ajax)

(declaim #.*optimization*)
;;


;;; This is the AJAX processor interfacing to the Dojo Toolkit
;;; ( http://dojotoolkit.org/ )


(defclass dojo-ajax-processor (library-ajax-processor)
  ())

(defmethod default-library-file-names ((processor dojo-ajax-processor))
  (declare (ignore processor))
  
  '("dojo.js"))

;;


(defun prepare-js-dojo-ajax-preamble (server-uri) 
  "Output a string containing the call function."
  (concatenate 'string
   "
dojo.require('dojo.io.*');

var ajax_server_uri = '" server-uri "';

function ajax_call_uri(func, callback_spec, args) {
  var uri = ajax_server_uri;
  var i;

  if (uri.indexOf('?') == -1)
    uri = uri + '?';
  else
    uri = uri + '&';

  uri = uri + ajax_encode_args(func, args);
  var callbacks = ajax_parse_callbacks(callback_spec);

  dojo.io.bind({ url: uri,
                 transport: 'XMLHTTPTransport',
                 load: function (type, data, evt) {
                     ajax_call_maybe_evaluate_json(callbacks[0], 
                                     data, 
                                     evt.getResponseHeader('Content-Type'));

                 },
                 error: function (type, errorObject) {
                   if(callbacks[1]) {
                     callbacks[1](dojo.errorToString(errorObject)); 
                   }
                   else {
                     debug_alert(dojo.errorToString(errorObject)); 
                   }
                 }
  });
}


function ajax_post_uri(func, callback_spec, args) {
  var params = ajax_encode_args(func, args);
  var callbacks = ajax_parse_callbacks(callback_spec);

  dojo.io.bind({ url: ajax_server_uri,
                 transport: 'XMLHTTPTransport',
                 method: 'POST',
                 load: function (type, data, evt) {
                     ajax_call_maybe_evaluate_json(callbacks[0], 
                                     data, 
                                     evt.getResponseHeader('Content-Type'));

                 },
                 error: function (type, errorObject) {
                   if(callbacks[1]) {
                     callbacks[1](dojo.errorToString(errorObject));
                   }
                   else {
                     debug_alert(dojo.errorToString(errorObject));
                   }
                 },
                 postContent: params
  });
}"))




(defmethod %generate-js-code ((processor dojo-ajax-processor))
  (concatenate 'string
               (apply #'concatenate 'string
                      (prepare-js-debug-function processor)
                      (prepare-js-ajax-encode-args)
                      (prepare-js-parse-callbacks)
                      (prepare-js-ajax-is-json)                      
                      (prepare-js-ajax-call-maybe-evaluate-json)
                      (prepare-js-dojo-ajax-preamble (maybe-rewrite-url-for-session
                                                      (server-uri processor)))


                      (loop
                         for fun-name being the hash-keys
                         in (exported-funcs processor)
                         collect (apply #'prepare-js-ajax-function
                                        processor
                                        fun-name
                                        (js-function-name processor fun-name)
                                        (gethash fun-name (exported-funcs processor))))
                      )))
