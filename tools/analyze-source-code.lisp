(defun file-string (path)
  (with-open-file (s path #+sbcl :external-format #+sbcl :utf-8 )
    (let* ((len (file-length s))
           (data (make-string len :initial-element #\Space)))
      (values data (read-sequence data s)))))

(defun read-file-as-sexp (file &optional (case :upcase))
  (let ((*readtable* (copy-readtable *readtable*)))
    (setf (readtable-case *readtable*) case)
    (read-from-string (format nil "(~a)" (file-string file)))))

(defun check-lines-file (file)
  (format t "~&********************************************************************")
  (format t "~&~a~%" file)
  (loop for line in (split-sequence:split-sequence #\Newline (file-string file))
        for x from 1
        for size = (length line)
        do
        (cond ((>= size 90)
               (format t "~&~3a ~a*: ~a~%" x size line))
              ((> size 80)
               (format t "~&~3a ~a: ~a~%" x size line)))))

(defun list-all-rameau-files ()
  (directory (merge-pathnames "*/*.lisp"
                              (translate-logical-pathname "rameau:src;"))))

(defun check-all-rameau-files ()
  (loop for item in (list-all-rameau-files)
        do (check-lines-file item) ))
