(require 'cl-ppcre)

(defun file-string (path)
  "Sucks up an entire file from PATH into a freshly-allocated string,
      returning two values: the string and the number of bytes read."
  (with-open-file (s path #+sbcl :external-format #+sbcl :utf-8 )
    (let* ((len (file-length s))
           (data (make-string len :initial-element #\Space)))
      (values data (read-sequence data s)))))

(defun remove-test (list)
  "Remove test files from list of files."
  (remove-if (lambda (f) (search "test-" (pathname-name f))) list))

(defun get-symbols (file)
  "Return an alist with the functions or testes of a file."
  (with-open-file (s file)
    (list (intern (string-upcase (cl-ppcre:regex-replace-all "test-" (pathname-name file) "")))
          (mapcar #'intern
                  (mapcar (lambda (x) (cl-ppcre:regex-replace-all "(DEFINE-TEST|DEFUN|DEFMETHOD|DEFCACHED)[ ]+" x ""))
                          (cl-ppcre:all-matches-as-strings *regexp* (string-upcase (file-string s))))))))

(defparameter *regexp* "(DEFINE-TEST|DEFUN|DEFMETHOD|DEFCACHED)[ ]+[0-9a-zA-Z><\!\$%&\*\?/-]+")
(defparameter *tests* (mapcar #'get-symbols (directory "test-*.lisp")))
(defparameter *functions* (mapcar #'get-symbols (remove-test (directory "*.lisp"))))

(defun functions-without-tests ()
  (loop
     for (key list) in *functions*
     collect
       (list key
             (remove-if (lambda (item) (member item (second (assoc key *tests*))))
                        list))))

(defun orphan-tests ()
  (loop
     for (key list) in *tests*
     collect
       (list key
             (remove-if (lambda (item) (member item (second (assoc key *functions*))))
                        list))))

(defun check ()
  (format t "~%==========================================~%~%")
  (format t "~%as seguintes funções estão sem testes:~%~%")
  
  (loop
     for (key list) in (functions-without-tests)
     do
       (when list
         (format t "* ~(~a.lisp~) [~a]~%" key (length list))
         (format t "~{~(    ~a~%~)~}~%" list)))
  
  (format t "~%==========================================~%~%")
  (format t "~%os seguintes testes estão orfãos:~%~%")
  
  (loop
     for (key list) in (orphan-tests)
     do
       (when list
         (format t "* ~(~a.lisp~) [~a]~%" key (length list))
         (format t "~{~(    ~a~%~)~}~%" list))))

(check)