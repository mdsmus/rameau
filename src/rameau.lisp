(in-package :rameau)
;;; As funções dependentes de implementação devem ficar aqui
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(enable-sharp-l-syntax)

(defparameter *rameau-path*
  (format nil "~a" (or #+sbcl *default-pathname-defaults*
                       #+cmu (first (ext:search-list "default:"))
                       #+clisp (ext:default-directory))))


(defclass rameau-algorithm ()
  ((name :accessor alg-name :initarg :name)
   (tempered? :accessor alg-tempered? :initarg :tempered?)
   (description :accessor alg-description :initarg :description)))

(defgeneric perform-analysis (segments options algorithm)
  (:documentation "Perform harmonic analysis"))

(defmethod perform-analysis (segments options (algorithm rameau-algorithm))
  (declare (ignore options algorithm))
  (mapcar #L(make-chord :root (print-event-note (first !1))) segments))


(defgeneric functional-analysis (segments options algorithm)
  (:documentation "Perform functional harmonic analysis"))

(defmethod functional-analysis (segments options (algorithm rameau-algorithm))
  (declare (ignore options algorithm))
  (mapcar #L(make-fchord :function 1 :center (event-pitch (first !1)) :key-mode :major) segments))

(defgeneric do-options (algorithm options)
  (:documentation "Process algorithm-specific options"))

(defmethod do-options ((algorithm rameau-algorithm) options))

(defparameter *algorithms* nil)

(defun add-algorithm (alg)
  "Register algorithm instance \\texttt{alg} with \\texttt{rameau}."
  (push alg *algorithms*))

(defun filter-algorithms (algoritmos algs)
  "[DONTCHECK]

Filter \\texttt{*algorithms*} so that only the ones specified in
\\texttt{algoritmos} are returned.
"
  (if algoritmos
      (remove-duplicates
       (loop for alg in algoritmos
             append (loop for i in algs
                          when (> (count-subseq alg (string-downcase (alg-name i))) 0)
                          collect i)))
      algs))

(defparameter *functional-algorithms* nil)

(defun add-falgorithm (alg)
  (push alg *functional-algorithms*))

(defun alg-file-name (alg)
  "The file name used to save an algorithm to disk."
  (concat *rameau-path* "/algorithms/" (alg-name alg) ".store"))

(defun load-alg (alg)
  "Load \\texttt{alg} from disk, returning \\texttt{alg} itself in case a failure happens."
  (handler-case (cl-store:restore (alg-file-name alg))
    (simple-error () alg)
    (error () alg)))

(defun save-alg (alg)
  "Save algorithm \\texttt{alg} to disk."
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
  "[DONTCHECK]

Profile all functions in \\texttt{Rameau}.
"
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
  "[DONTCHECK]

Report the results from a profile.
"
  #+sbcl(sb-profile:report)
  #+cmu(profile:report-time))

(defun rameau-quit ()
  "[DONTCHECK]

Exit \\texttt{rameau}.
"
  #+clisp(ext:exit)
  #+sbcl(sb-ext:quit))

(defun getenv (string)
  "[DONTCHECK]

Get environment variable \\texttt{string} from the environment.
"
  #+sbcl(sb-ext:posix-getenv string)
  #+cmu(cdr (assoc (intern string :keyword) ext:*environment-list*))
  #+clisp(ext:getenv string))

(defun remove-comma-if-needed (text)
  "[DONTCHECK]

Remove the commas from \\texttt{text} and replace them with dots in
case we a in a portuguese language environment. Needed for fann.
"
  (if (= 1 (count-subseq "pt" (getenv "LANG")))
      (substitute #\, #\. text)
      text))

(defun unicode-term (f)
  "[DONTCHECK]

Checks if terminal \\texttt{f} supports unicode.
"
  (or (null f)
      (eq (stream-external-format f) nil)
      (eq (stream-external-format f) #+sbcl :utf-8 #-sbcl :default)))

(defun read-user-config ()
  "[DONTCHECK]

Read and load definitions from a user-set configuration file in \\texttt{~/.rameaurc}.
"
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

(defun files-range (list)
  "All files in the range specified in \\texttt{list}."
  (loop for x from (parse-integer (first list)) to (parse-integer (second list))
        collect (cond ((< x 10)  (format nil "00~a" x))
                      ((< x 100) (format nil "0~a" x))
                      (t (format nil "~a" x)))))

(defun search-music-dirs (substring dir)
  "Search for a directory in \\texttt{dir} with \\texttt{substring} in
  its name." 
  (search-string-in-list substring
                         (mapcar #'namestring
                                 (directory (format nil "~a/~a/*/"
                                                    *rameau-path*
                                                    dir)))))

(defun new-parse-answer-sheet (file substring)
  "Find and parse the answer sheet for file \\texttt{file}, if exists."
  (let* ((dir (search-music-dirs substring "answer-sheets"))
         (full-file (concat dir (add-pop-ext file))))
    (when (cl-fad:file-exists-p full-file)
      (read-chords (read-file-as-sexp full-file)))))

(defun path-parse-answer-sheet (file)
  "Find and parse the answer sheet for file \\texttt{file}, if exists."
  (let* ((full-file (cl-ppcre:regex-replace "music" file "answer-sheets"))
         (full-file (cl-ppcre:regex-replace "\\.ly" full-file ".pop")))
    (when (cl-fad:file-exists-p full-file)
      (read-chords (read-file-as-sexp full-file)))))

(defun path-parse-functional-answer-sheet (file)
  "Find and parse the answer sheet for file \\texttt{file}, if exists."
  (let* ((full-file (cl-ppcre:regex-replace "music" file "answer-sheets"))
         (full-file (cl-ppcre:regex-replace "\\.ly" full-file ".fun")))
    (when (cl-fad:file-exists-p full-file)
      (get-fchords (file-string full-file)))))

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

(defparameter *training-data* nil)

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

(defun random-color ()
  (min 0.5 (random 1.0)))

(defun random-stroke-fill-colors ()
  (let* ((red (rameau::random-color))
         (green (rameau::random-color))
         (blue (rameau::random-color))
         (redfill (max 1 (* 1.5 red)))
         (greenfill (max 1 (* 1.5 green)))
         (bluefill (max 1 (* 1.5 blue))))
    (vecto:set-rgb-stroke red green blue)
    (vecto:set-rgb-fill redfill greenfill bluefill)
    (list red green blue redfill greenfill bluefill)))

(defun cairo-random-stroke-fill-colors ()
  (let* ((red (rameau::random-color))
         (green (rameau::random-color))
         (blue (rameau::random-color)))
    (cl-cairo2:set-source-rgb red green blue)
    (list red green blue)))

(defun cairo-brighten-source (red green blue)
  (cl-cairo2:set-source-rgb (* 0.5 red) (* 0.5 green) (* 0.5 blue)))

(defun set-stroke-fill-colors (colors)
  (vecto:set-rgb-stroke (first colors) (second colors) (third colors))
  (vecto:set-rgb-fill (fourth colors) (fifth colors) (third colors)))

(defun cairo-set-stroke-fill-colors (colors)
  (cl-cairo2:set-source-rgb (first colors) (second colors) (third colors)))

(defun remove-inversions (chord-string)
  (cl-ppcre:regex-replace-all "/.*" chord-string ""))

(defmacro safe-with-backtrace ((&key condition print-error-msg exit return) &body code)
  "Runs \\texttt{code} with error protection, calling \\texttt{print-error-msg} if there's
an error and doing a backtrace if running on sbcl and \\texttt{condition} is true at runtime."
  (let ((err (gensym)))
    `(handler-bind ((error (lambda (,err)
                             ,print-error-msg
                             (format t "Error: ~a~%" ,err)
                             (when ,condition
                               #+sbcl (sb-debug:backtrace))
                             (when ,exit
                               (rameau-quit))
                             ,return)))
       ,@code)))

