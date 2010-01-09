;;; -*- lisp -*-

;; ASDF system definition for loading the rtm-lisp-api.

;; Usage:
;;   1. Load the asdf:
;;   (require 'asdf)

;;   2. Add rtm-lisp-api's path to asdf registry:
;;   (push #p"<path to rtm-lisp-api.asd>"
;;         asdf:*central-registry*)             

;;   3. Load the library:
;;   (asdf:operate 'asdf:load-op 'rtm-lisp-api)


(eval-when (:compile-toplevel :load-toplevel :execute)
  (unless (find-package :rtm-lisp-api.system)
    (defpackage :rtm-lisp-api.system
      (:nicknames :rtm.system)
      (:use :common-lisp :asdf))))

(in-package :rtm-lisp-api.system)

(defsystem :rtm-lisp-api
  :version "0.1"
  :depends-on (:drakma :cl-json)
  :author "Edgar Gonçalves"
  :components ((:static-file "rtm-lisp-api.asd")
	       (:module :src
			:components ((:file "packages")
				     (:file "rtm-lisp-api"
					    :depends-on ("packages"))
				     (:file "rtm-model"
					    :depends-on ("packages"
							 "rtm-lisp-api"))))))

#|
The MIT License

Copyright (c) 2008 Edgar Gonçalves

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
|#

