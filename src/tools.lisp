(in-package :rameau)

;;; As funções dependentes de implementação devem ficar aqui
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defparameter *ignore-algorithms-files* nil
  "Use non-nil value to not load the algorithm files. (useful for
debugging)")

(defparameter *rameau-path*
  (format nil "~a" (or #+sbcl *default-pathname-defaults*
		       #+cmu (first (ext:search-list "default:"))
		       #+clisp (ext:default-directory))))
  
(defun rameau-profile ()
  #+sbcl(progn
         (setf sb-profile::*print-functions-not-called* nil)
         (sb-profile:profile "RAMEAU")
         (sb-profile:profile "RAMEAU-PARDO")
         (sb-profile:profile "RAMEAU-KNN")
         (sb-profile:profile "GENOSLIB"))
  #+cmu (progn
          (profile:profile-all :package "RAMEAU")
          (profile:profile-all :package "RAMEAU-PARDO")
          (profile:profile-all :package "RAMEAU-KNN")
          (profile:profile-all :package "GENOSLIB")))

(defun rameau-report ()
  #+sbcl(sb-profile:report)
  #+cmu(profile:report-time))

(defun rameau-quit ()
  #+clisp(ext:exit)
  #+sbcl(sb-ext:quit))

(defun getenv (string)
  #+sbcl(sb-ext:posix-getenv string)
  #+cmu(cdr (assoc (intern string :keyword) ext:*environment-list*))
  #+clisp(ext:getenv string))

(defun remove-comma-if-needed (text)
  (if (= 1 (count-subseq "pt" (getenv "LANG")))
      (substitute #\, #\. text)
      text))
  
(defun unicode-term (f)
  (or (null f)
      (eq (stream-external-format f) nil)
      (eq (stream-external-format f) #+sbcl :utf-8 #-sbcl :default)))

(defun read-user-config ()
  (aif (cl-fad:file-exists-p (concat (getenv "HOME") "/.rameaurc"))
       (loop for (var value) in (read-file-as-sexp it) do (setf (symbol-value var) value))))

(read-user-config)

(do-not-test getenv remove-comma-if-needed unicode-term
             read-user-config rameau-args rameau-profile rameau-report
             rameau-quit)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *lily-dir-list*
  '(("chorales" "corais/")
    ("kostka" "literatura/kostka-payne/")
    ("sonatas" "literatura/beethoven-sonatas/")
    ("exemplos" "exemplos/")
    ("regressao" "regressao/")
    ("lily" "regressao-lily/")
    ("corais-include" "literatura/bach-corais/")
    ("exemplos-include" "literatura/exemplos/")))

(defparameter *gabarito-dir-list*
  '(("chorales" "answer-sheets/chorales-bach/")
    ("exemplos" "answer-sheets/examples/")))

(defun files-range (list)
  (loop for x from (parse-integer (first list)) to (parse-integer (second list))
     collect (cond ((< x 10)  (format nil "00~a" x))
                   ((< x 100) (format nil "0~a" x))
                   (t (format nil "~a" x)))))

(defun first-string (string list)
  (let ((tmp (loop for s in list do
                  (if (string= (subseq s 0 1) string)
                      (return s)))))
    (if tmp tmp string)))

(defun parse-answer-sheet (file item)
  "Parse the answer sheet for song \\texttt{file}."
  (let* ((*package* (find-package :rameau))
         (nome-pop (concat *rameau-path*
                           (get-item item *gabarito-dir-list*)
                           (add-pop-ext (pathname-name file)))))
    (when (cl-fad:file-exists-p nome-pop)
      (read-chords (read-file-as-sexp nome-pop)))))

(defun search-music-dirs (substring dir)
  (first (remove-if-not (lambda (item) (search substring item :test #'equalp))
                        (mapcar #'namestring
                                (directory (format nil "~a/~a/*"
                                                   *default-pathname-defaults*
                                                   dir))))))

(defun new-parse-answer-sheet (file substring)
  (let* ((dir (search-music-dirs "chora" "answer-sheets"))
         (full-file (concat dir (add-pop-ext file))))
    (when (cl-fad:file-exists-p full-file)
      (read-chords (read-file-as-sexp full-file)))))

(defun parse-file-list (item f &optional (ext ".ly"))
  "Parse file list \\texttt{f} into a list of filenames."
  (let* ((path (concat *rameau-path* (get-item item *lily-dir-list*)))
         (file-name (format nil "~a" (first f)))
         (files (if (search ".." file-name)
                    (files-range (cl-ppcre:split "\\.\\." file-name))
                    f)))
    (if files
        (mapcar (lambda (file) (concat path file ext)) files)
        (remove-if #'(lambda (x) (search "coral" x))
                   (mapcar (lambda (file) (format nil "~a" file))
                           (directory (concat path "*" ext)))))))

(do-not-test parse-file-list parse-answer-sheet)

(defparameter *training-data*
  (nconc (loop for f in (parse-file-list "chorales" '("001..6"))
            for g = (parse-answer-sheet f "chorales")
            collect (list (sonorities (parse-file f)) g))
         (loop for f in (mapcan (lambda (x) (parse-file-list "exemplos" (list x)))
                                '("11..13" "23..28"))
            for g = (parse-answer-sheet f "exemplos")
            collect (list (sonorities (parse-file f)) g))))

(defun extract-feature-list (segmento diff)
  "Extract the feature list of a sonority givern its \\texttt{diff}."
  (let ((segmento (mapcar2 (lambda (x) (module (- x diff))) #'event-pitch segmento))
        (n (length segmento))
        (feature-list (repeat-list (get-module) 0)))
    (loop for nota in segmento
       do (incf (nth nota feature-list) (/ 1 n)))
    feature-list))

(defun extract-diff (segmento)
  "Extract the diff of a sonority."
  (let ((segmento (sorted segmento #'event-<)))
    (event-pitch (first segmento))))

