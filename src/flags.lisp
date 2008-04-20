(defpackage :rameau-main
  (:use :rameau :cl :cl-ppcre :lisp-unit :ltk)
  (:export :main :check))

(in-package :rameau-main)

(defun split-command-list (command-list)
  (let ((pos (position "and" command-list :test #'string=)))
    (if pos
        (append (list (subseq command-list 0 pos))
                (split-command-list (subseq command-list (1+ pos))))
        (list command-list))))

(defun sublist-of-args (list)
  "Separate the arguments in a list in sublist of arguments."
  (labels ((next-flag (list)
             (loop for x in (rest list) do
                  (if (and (< 0 (length x)) (equal #\- (aref x 0)))
                      (return x))))
           (pos (list)
             (let ((pos (position (next-flag list) list :test #'string=)))
               (if pos pos 0))))
    (when list
      (if (next-flag list)
          (let ((p (pos list)))
            (cons (subseq list 0 p)
                  (sublist-of-args (nthcdr p list))))
          (list list)))))

(defun get-short-flag-name (flag)
  (second (find-flag flag)))

(defun get-long-flag-name (flag)
  (second (find-flag-by-name (intern (string-upcase (subseq flag 2))))))

(defun find-flag-by-name (name)
  (find name (assoc-item 'common-flags *commands*) :key #'second))

(defun find-flag (flag)
  (find flag (assoc-item 'common-flags *commands*) :key #'first :test #'string=))

(defun long-flag? (flag)
  (when (cl-ppcre:scan "^--[a-zA-Z]+" flag)
    t))

(defun short-flag? (flag)
  (when (cl-ppcre:scan "^-[a-zA-Z]+" flag)
    t))
