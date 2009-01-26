(defpackage :music-data
  (:import-from #:arnesi "AIF" "AWHEN" "IT" "LAST1" "ENABLE-SHARP-L-SYNTAX")
  (:use :rameau :cl-utils :cl-music :cl :iterate :cl-lily :rameau-musicology)
  (:documentation "The computational musicology commands for @rameau"))

(in-package :music-data)

(defun choral-size (options)
  (iter (for file in (arg :files options))
        (format t "~a: ~a~%"
                file
                (length (sonorities (parse-file file)
                                    (arg :start options)
                                    (arg :end options))))))

(register-command :name "choral-size"
                  :action #'choral-size
                  :documentation ""
                  :options nil)

(enable-sharp-l-syntax)
