#+(or sbcl ecl) (require 'asdf)

(defparameter *packages* '("cl-fad-0.6.0"
                           "cl-ppcre-1.3.2"
                           "lisp-unit"))

(defun main-path ()
  (format nil "~a" *default-pathname-defaults*))

(when *use-rameau-deps*
  (loop for p in *packages* do
       (push (concatenate 'string (main-path) "rameau-deps/" p "/") asdf:*central-registry*)))

(mapcar #'require '(cl-ppcre cl-fad))
(load "tools/read-notes.lisp")
(sb-ext:save-lisp-and-die "checa-notas" :executable t :toplevel #'read-notes:main)