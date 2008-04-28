(defpackage :rameau-main
  (:use :rameau :cl :cl-ppcre :lisp-unit :ltk :iterate)
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

(defun get-short-flag-name (command flag)
  (second (find-flag command flag)))

(defun get-long-flag-name (command flag)
  (second (find-flag-by-name command (subseq flag 2))))

(defun get-star-in-flag (command flag)
  (fourth (find-flag command flag)))

(defun find-flag-by-name (command name)
  (or (find name (get-item "common-flags" *commands*) :key #'second :test #'string=)
      (find name (get-flag-assoc command) :key #'second :test #'string=)))

(defun find-flag (command flag)
  (or (find flag (get-item "common-flags" *commands*) :key #'first :test #'string=)
      (find flag (get-flag-assoc command) :key #'first :test #'string=)))

(defun long-flag? (flag)
  (when (cl-ppcre:scan "^--[a-zA-Z]+" flag)
    t))

(defun short-flag? (flag)
  (when (cl-ppcre:scan "^-[a-zA-Z]+" flag)
    t))

(defun %string->symbol (string &optional (package (sb-int:sane-package)))
  (intern (string-upcase string) package))

(defun get-commands-assoc ()
  (remove "common-flags" (mapcar #'first *commands*)))

(defun get-command-slots (command)
  (mapcar #'second (append (get-common-flags) (get-flag-assoc command))))

(defun get-common-flags ()
  (get-item "common-flags" *commands*))

(defun get-flag-assoc (item)
  "Works for commands only"
  (get-item item *commands*))
