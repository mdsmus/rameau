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

(defun check-block-file (file)
  "check for large chunks of code"
  (loop for block in (cl-ppcre:split "\\n\\n" (file-string file))
        for block-split = (split-sequence:split-sequence #\Newline block)
        for size = (length block-split) do
        (when (> size 35)
          (write-line "*************************************************************")
          (format t "~&~a: ~a~%      ~a~%" file size (subseq block-split 0 4)))))

(defun list-all-rameau-files ()
  (directory (merge-pathnames "*/*.lisp"
                              (translate-logical-pathname "rameau:src;"))))

(defun map! (fn list)
  (loop for item in list do (funcall fn item)))

(defun check-lines ()
  (map! #'check-lines-file (list-all-rameau-files)))

(defun check-blocks ()
  (map! #'check-block-file (list-all-rameau-files)))