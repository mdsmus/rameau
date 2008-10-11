(in-package :rameau)
;;; As funções dependentes de implementação devem ficar aqui
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(enable-sharp-l-syntax)

(defclass rameau-algorithm ()
  ((name :accessor alg-name :initarg :name)
   (tempered? :accessor alg-tempered? :initarg :tempered?)
   (description :accessor alg-description :initarg :description)))

(defgeneric perform-analysis (segments options algorithm)
  (:documentation "Perform harmonic analysis"))

(defmethod perform-analysis (segments options (algorithm rameau-algorithm))
  (declare (ignore options algorithm))
  (error "Chord labeling not implemented for this algorithm.~%"))


(defgeneric functional-analysis (segments options algorithm)
  (:documentation "Perform functional harmonic analysis"))

(defmethod functional-analysis (segments options (algorithm rameau-algorithm))
  (declare (ignore options algorithm))
  (error "Functional analysis not implemented for this algorithm;~%"))

(defgeneric do-options (algorithm options)
  (:documentation "Process algorithm-specific options"))

(defmethod do-options ((algorithm rameau-algorithm) options))

(defparameter *algorithms* nil)

(defun add-algorithm (alg)
  "Register algorithm instance @var{alg} with @rameau."
  (push alg *algorithms*))

(defun filter-algorithms (algoritmos algs)
  "[NOTEST]

Filter @var{*algorithms*} so that only the ones specified in
@var{algoritmos} are returned.
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
  "Register functional algorithm @var{alg}."
  (push alg *functional-algorithms*))

(defun alg-file-name (alg)
  "The file name used to save an algorithm to disk."
  (make-pathname :name (alg-name alg)
                 :type "store"
                 :directory "algorithms"))

(defun load-alg (alg)
  "Load @var{alg} from disk, returning @var{alg} itself in case a failure happens."
  (handler-case (cl-store:restore (alg-file-name alg))
    (simple-error () alg)
    (error () alg)))

(defun save-alg (alg)
  "Save algorithm @var{alg} to disk."
  (cl-store:store alg (alg-file-name alg)))

(defun rameau-profile ()
  "[NOTEST]

Profile all functions in @var{Rameau}.
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
  "[NOTEST]

Report the results from a profile.
"
  #+sbcl(sb-profile:report)
  #+cmu(profile:report-time))

(defun rameau-quit ()
  "[NOTEST]

Exit @rameau.
"
  #+clisp(ext:exit)
  #+sbcl(sb-ext:quit))

;; Compile this by hand if running under slime: (defun rameau-quit () (error "Quit."))

(defun getenv (string)
  "[NOTEST]

Get environment variable @var{string} from the environment.
"
  #+sbcl(sb-ext:posix-getenv string)
  #+cmu(cdr (assoc (intern string :keyword) ext:*environment-list*))
  #+clisp(ext:getenv string))

(defun remove-comma-if-needed (text)
  "[NOTEST]

Remove the commas from @var{text} and replace them with dots in
case we a in a portuguese language environment. Needed for fann.
"
  (if (= 1 (count-subseq "pt" (getenv "LANG")))
      (substitute #\, #\. text)
      text))

(defun unicode-term (f)
  "[NOTEST]

Checks if terminal @var{f} supports unicode.
"
  (or (null f)
      (eq (stream-external-format f) nil)
      (eq (stream-external-format f) #+sbcl :utf-8 #-sbcl :default)))

(defun read-user-config ()
  "Read and load definitions from a user-set configuration file in
@file{~/.rameaurc}.[NOTEST]"
  (aif (cl-fad:file-exists-p (concat (getenv "HOME") "/.rameaurc"))
       (loop for (var value) in (read-file-as-sexp it) do (setf (symbol-value var) value))))

(read-user-config)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun files-range (list)
  "All files in the range specified in @var{list}."
  (loop for x from (parse-integer (first list)) to (parse-integer (second list))
        collect (cond ((< x 10)  (format nil "00~a" x))
                      ((< x 100) (format nil "0~a" x))
                      (t (format nil "~a" x)))))

(defun path-parse-answer-sheet (file)
  "Find and parse the answer sheet for file @var{file}, if exists."
  (let* ((full-file (cl-ppcre:regex-replace "music" file "answer-sheets"))
         (full-file (cl-ppcre:regex-replace "\\.ly" full-file ".pop")))
    (when (cl-fad:file-exists-p full-file)
      (read-chords (read-file-as-sexp full-file)))))

(defun path-parse-functional-answer-sheet (file)
  "Find and parse the answer sheet for file @var{file}, if exists."
  (let* ((full-file (cl-ppcre:regex-replace "music" file "answer-sheets"))
         (full-file (cl-ppcre:regex-replace "\\.ly" full-file ".fun")))
    (when (cl-fad:file-exists-p full-file)
      (get-fchords (file-string full-file)))))

(defparameter *training-data* nil)

(defun extract-feature-list (segmento diff)
  "Extract the feature list of a sonority givern its @var{diff}."
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

(defparameter *all-colors*
  (iter (for symbol in-package :cl-colors :external-only t) (when (equal #\+ (char (symbol-name symbol) 0)) (collect (symbol-value symbol)))))

(cl-colors:red (first *all-colors*))

(defun cairo-random-stroke-fill-colors ()
  "Random stroke and fill colors for use with cairo."
  (let* ((color (nth (random (length *all-colors*)) *all-colors*))
         (red (cl-colors:red color))
         (green (cl-colors:green color))
         (blue (cl-colors:blue color)))
    (cl-cairo2:set-source-rgb red green blue)
    (list red green blue)))

(defun cairo-brighten-source (red green blue)
  "Brighten slightly the colors used."
  (cl-cairo2:set-source-rgb (* 0.5 red) (* 0.5 green) (* 0.5 blue)))

(defun cairo-set-stroke-fill-colors (colors)
  "Set stroke and fill colors using cairo."
  (cl-cairo2:set-source-rgb (first colors) (second colors) (third colors)))

(defmacro safe-with-backtrace ((&key condition print-error-msg exit return) &body code)
  "Runs @var{code} with error protection, calling @var{print-error-msg} if there's
an error and doing a backtrace if running on sbcl and @var{condition} is true at runtime."
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
