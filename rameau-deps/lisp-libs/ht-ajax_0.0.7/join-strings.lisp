;;; -*- Mode: LISP; Syntax: COMMON-LISP; Base: 10 -*-

(in-package #:ht-ajax)

;; Written by Riastradh ( http://mumble.net/~campbell/blog.txt )
;; posted at http://paste.lisp.org/display/35412
;; and placed in the public domain

(defun join-strings (string-list separator)
  (if (null string-list)
      ""
      (let* ((separator-length (length separator))
             (total-length
              (reduce (lambda (left-length right-length)
                        (+ left-length separator-length right-length))
                      string-list
                      :key #'length))
             (result (make-string total-length)))
        (replace result (car string-list))
        (let ((offset (length (car string-list))))
          (dolist (string (cdr string-list))
            (replace result separator :start1 offset)
            (replace result string :start1 (+ offset separator-length))
            (incf offset (+ separator-length (length string)))))
        result)))
