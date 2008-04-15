(defpackage #:read-notes
  (:export #:main)
  (:use #:cl #:cl-ppcre #:cl-fad))

(in-package #:read-notes)

(defparameter *rameau-path* *default-pathname-defaults*)

(defun concat (&rest strings)
  (apply #'concatenate 'string strings))

(defun file-string (path)
  (cl-ppcre:regex-replace-all
   "\\n"
   (with-open-file (s path)
     (let* ((len (file-length s))
            (data (make-string len :initial-element #\Space)))
       (values data (read-sequence data s))))
   " "))

(defun get-block (name string)
  (let* ((s1 (search name string))
         (repeat (search "\\repeat" string :start2 s1))
         (s2 (search "}" string :start2 s1))
         (s3 (search "}" string :start2 (1+ s2))))
    (subseq string s1 (if repeat s3 s2))))

(defun parse-note (string)
  (register-groups-bind (note acc octave dur)
      ("(a|b|c|d|e|f|g)(is|es)?(['|,]*)?([0-9.\\*]*)?" string)
    (declare (ignore octave dur))
    (list note (if acc acc ""))))


(defun clean (string)
  (string-trim " "
               (cl-ppcre:regex-replace-all
                "[ ]+"
                (cl-ppcre:regex-replace-all
                 "~|%[0-9]+|}|{|(soprano|alto|tenor|bass) = |\\\\relative c[']+ |\\\\repeat volta 2 {|\\\\partial [0-9]+" string "")
                " ")))

(defun get-notes (name file)
  (let ((notes (cl-ppcre:split #\Space
                               (clean (get-block name (file-string file))))))
    (loop
       for note in notes
       for n = (parse-note note)
       when (consp n) collect n)))

(defun toca-nota (nota-list)
  (let ((nota (apply #'concatenate 'string nota-list)))
    (format t "~a " nota)
    (sb-ext:run-program "/usr/bin/play"
                        (list (concat "/home/kroger/src/rameau/samples/" nota ".wav")))))

(defun read-file-as-sexp (file)
  "Read file named \\texttt{file} as a single sexp"
  (read-from-string (format nil "(~a)" (file-string file))))

(defun read-user-config ()
  (let ((it (cl-fad:file-exists-p (concat (sb-ext:posix-getenv "HOME") "/.rameaurc"))))
    (if it
        (loop for (var value) in (read-file-as-sexp it) do (set var value)))))

(read-user-config)

(defun toca (voz coral &optional (de 0) ate)
  (let ((string"~a/literatura/bach-corais/~a.lyi"))
    (loop
       for nota in
         (subseq (get-notes voz (format nil string *rameau-path* coral))
                 de
                 ate)
       do (toca-nota nota))))
  
(defun main ()
  (if (< (length sb-ext:*posix-argv*) 3)
      (format t "USO: checa-notas <voz> <coral> [de] [ate]")
      (destructuring-bind (prog voz coral &optional de ate) sb-ext:*posix-argv*
        (declare (ignore prog))
        (toca voz
              coral
              (if de
                  (parse-integer de :junk-allowed t)
                  0)
              (when ate (parse-integer ate :junk-allowed t)))))
  0)
