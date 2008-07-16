(in-package :rameau)

;;; As funções dependentes de implementação devem ficar aqui
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(enable-sharp-l-syntax)

(defparameter *rameau-path*
  (format nil "~a" (or #+sbcl *default-pathname-defaults*
		       #+cmu (first (ext:search-list "default:"))
		       #+clisp (ext:default-directory))))

(defun alg-file-name (alg)
  (concat *rameau-path* "/algorithms/" (alg-name alg) ".store"))

(defun load-alg (alg)
  (let (done)
    (handler-case (cl-store:restore (alg-file-name alg))
      (simple-error () alg)
      (error () alg))))

(defun save-alg (alg)
  (cl-store:store alg (alg-file-name alg)))

(defun rameau-args ()
  "[DONTCHECK]"
  (let ((sbcl-args #+sbcl sb-ext:*posix-argv*)
        (cmu-args #+cmu extensions:*command-line-strings*)
        (clisp-args #+clisp *args*))
    (cond (sbcl-args (rest sbcl-args))
          (cmu-args (subseq cmu-args (1+ (position "cmurameau" cmu-args :test #'string=))))
          (clisp-args clisp-args)
          (t (error "algum problema com argumentos")))))

(defun rameau-profile ()
  "[DONTCHECK]"
  #+sbcl(progn
         (setf sb-profile::*print-functions-not-called* nil)
         (sb-profile:profile "RAMEAU")
         (sb-profile:profile "RAMEAU-PARDO")
				 (sb-profile:profile "RAMEAU-KNN")
         (sb-profile:profile "RAMEAU-HMM")
				 (sb-profile:profile "RAMEAU-NEURAL")
         (sb-profile:profile "RAMEAU-TREE-ENARM")
         (sb-profile:profile "RAMEAU-MAIN")
         (sb-profile:profile "GENOSLIB")
         )
  #+cmu (progn
          (profile:profile-all :package "RAMEAU")
          (profile:profile-all :package "RAMEAU-PARDO")
          (profile:profile-all :package "RAMEAU-KNN")
          (profile:profile-all :package "GENOSLIB")))

(defun rameau-report ()
  "[DONTCHECK]"
  #+sbcl(sb-profile:report)
  #+cmu(profile:report-time))

(defun rameau-quit ()
  "[DONTCHECK]"
  #+clisp(ext:exit)
  #+sbcl(sb-ext:quit))

(defun getenv (string)
  "[DONTCHECK]"
  #+sbcl(sb-ext:posix-getenv string)
  #+cmu(cdr (assoc (intern string :keyword) ext:*environment-list*))
  #+clisp(ext:getenv string))

(defun rameau-get-font-path (font)
  (let ((result))
   (cl-fad:walk-directory #+linux "/usr/share/fonts/"
			  #+windows "c:/windows/fonts/"
			  (lambda (path) (push path result))
			  :test (lambda (path) (search font (file-namestring path))))

   (first result)))

(defun remove-comma-if-needed (text)
  "[DONTCHECK]"
  (if (= 1 (count-subseq "pt" (getenv "LANG")))
      (substitute #\, #\. text)
      text))
  
(defun unicode-term (f)
  "[DONTCHECK]"
  (or (null f)
      (eq (stream-external-format f) nil)
      (eq (stream-external-format f) #+sbcl :utf-8 #-sbcl :default)))

(defun read-user-config ()
  "[DONTCHECK]"
  (aif (cl-fad:file-exists-p (concat (getenv "HOME") "/.rameaurc"))
       (loop for (var value) in (read-file-as-sexp it) do (setf (symbol-value var) value))))

(read-user-config)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defparameter *lily-dir-list*
  '(("chorales" "music/chorales-bach/")
    ("kostka" "music/kostka-payne/")
    ("exemplos" "music/examples/")
    ("regression" "regression/")
    ("lily" "regression-lily/")))

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
  "Parse the answer sheet for song \\texttt{file}. [DONTCHECK]"
  (let* ((*package* (find-package :rameau))
         (nome-pop (concat *rameau-path*
                           (get-item item *gabarito-dir-list*)
                           (add-pop-ext (pathname-name file)))))
    (when (cl-fad:file-exists-p nome-pop)
      (read-chords (read-file-as-sexp nome-pop)))))

(defun search-string-in-list (substring list)
  "Search for string in a list using a substring."
  (first (remove-if-not #L(search substring !1 :test #'equalp) list)))

(defun search-music-dirs (substring dir)
  (search-string-in-list substring
                         (mapcar #'namestring
                                (directory (format nil "~a/~a/*/"
                                                   *rameau-path*
                                                   dir)))))

(defun new-parse-answer-sheet (file substring)
  (let* ((dir (search-music-dirs substring "answer-sheets"))
         (full-file (concat dir (add-pop-ext file))))
    (when (cl-fad:file-exists-p full-file)
      (read-chords (read-file-as-sexp full-file)))))

(defun parse-file-list (item f &optional (ext ".ly"))
  "Parse file list \\texttt{f} into a list of filenames. [DONTCHECK]"
  (let* ((path (concat *rameau-path* (get-item item *lily-dir-list*  #'equal)))
         (file-name (format nil "~a" (first f)))
         (files (if (search ".." file-name)
                    (files-range (cl-ppcre:split "\\.\\." file-name))
                    f)))
    (if files
        (mapcar (lambda (file) (concat path file ext)) files)
        (remove-if #'(lambda (x) (search "coral" x))
                   (mapcar (lambda (file) (format nil "~a" file))
                           (directory (concat path "*" ext)))))))

(defparameter *training-data*
  (nconc (loop for f in (parse-file-list "chorales" '("001..10"))
            for g = (parse-answer-sheet f "chorales")
            collect (list (sonorities (parse-file f)) g))
         (loop for f in (parse-file-list "chorales" '("012"))
            for g = (parse-answer-sheet f "chorales")
            collect (list (sonorities (parse-file f)) g))
         (loop for f in (parse-file-list "chorales" '("014"))
            for g = (parse-answer-sheet f "chorales")
            collect (list (sonorities (parse-file f)) g))
         (loop for f in (parse-file-list "chorales" '("017..33"))
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


(defstruct analysis
  segments results answer-sheet file-name notes dur size-answer-sheet
  number-algorithms ast full-path algorithms title)
