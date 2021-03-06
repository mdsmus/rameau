(in-package :rameau)

(enable-sharp-l-syntax)

(defclass rameau-algorithm ()
  ((name :accessor alg-name :initarg :name)
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

(defvar *algorithms* nil)

(defgeneric you-ok-p (algorithm)
  (:documentation "True if the algorithm is ok and good to go."))

(defmethod you-ok-p ((algorithm rameau-algorithm)) t)

(defun add-algorithm (alg)
  "Register algorithm instance @var{alg} with @rameau."
  (pushnew alg *algorithms*))

(defun get-algorithm-opt (algorithm-type chord functional)
 (case algorithm-type
   (:chord-names chord)
   (:roman-analysis functional)
   (t (error "Algorithmn type ~a is unknown." algorithm-type))))

(defun load-algorithms (algorithms algorithm-type)
  "Make sure the algorithms are ok and load them."
  (let ((algs (get-algorithm-opt algorithm-type
                                 *algorithms*
                                 *functional-algorithms*)))
   (remove-if-not #'you-ok-p (mapcar #'load-alg (filter-algorithms algorithms algs)))))

(defun filter-algorithms (algoritmos algs)
  "Filter @var{*algorithms*} so that only the ones specified in
@var{algoritmos} are returned.[NOTEST]"
  (if algoritmos
      (remove-duplicates
       (iter (for alg in algoritmos)
             (appending (iter (for i in algs)
                              (when (> (count-subseq alg
                                                     (string-downcase (alg-name i)))
                                       0)
                                (collect i))))))
      algs))

(defvar *functional-algorithms* nil)

(defun add-falgorithm (alg)
  "Register functional algorithm @var{alg}."
  (pushnew alg *functional-algorithms*))

(defun alg-file-name (alg)
  "The file name used to save an algorithm to disk."
  (make-pathname :name (alg-name alg)
                 :type "store"
                 :directory (logical-pathname-directory "rameau:algorithms;")))

(defun load-alg (alg)
  "Load @var{alg} from disk, returning @var{alg} itself in case a failure happens."
  (handler-case (cl-store:restore (alg-file-name alg))
    (simple-error () alg)
    (error () alg)))

(defun save-alg (alg)
  "Save algorithm @var{alg} to disk."
  (cl-store:store alg (alg-file-name alg)))

(defun rameau-profile ()
  "Profile all functions in @var{Rameau}. [NOTEST]"
  #+sbcl(progn
          (setf sb-profile::*print-functions-not-called* nil)
          (sb-profile:profile "MUSICOLOGY-COMMANDS")
          (sb-profile:profile "RAMEAU")
          (sb-profile:profile "RAMEAU-ALG-COMMANDS")
          (sb-profile:profile "RAMEAU-ANALYSIS")
          (sb-profile:profile "RAMEAU-DOC")
          (sb-profile:profile "RAMEAU-FHMM")
          (sb-profile:profile "RAMEAU-HMM")
          (sb-profile:profile "RAMEAU-KNN")
          (sb-profile:profile "RAMEAU-MUSICOLOGY")
          (sb-profile:profile "RAMEAU-NEURAL")
          (sb-profile:profile "RAMEAU-NOISY")
          (sb-profile:profile "RAMEAU-PARDO")
          (sb-profile:profile "RAMEAU-SETUP")
          (sb-profile:profile "RAMEAU-STAT")
          (sb-profile:profile "RAMEAU-TREE-ENARM")
          (sb-profile:profile "RAMEAU-WEB"))
#+cmu (progn
          (profile:profile-all :package "RAMEAU")
          (profile:profile-all :package "RAMEAU-PARDO")
          (profile:profile-all :package "RAMEAU-KNN")
          (profile:profile-all :package "GENOSLIB")))

(defun rameau-report ()
  "Report the results from a profile.[NOTEST]"
  #+sbcl(sb-profile:report)
  #+cmu(profile:report-time))

(define-condition exit-rameau () ())

(defun rameau-quit ()
  "Exit @rameau.[NOTEST]"
  (error (make-condition 'exit-rameau)))

(defun getenv (string)
  "Get environment variable @var{string} from the environment.[NOTEST]"
  #+sbcl(sb-ext:posix-getenv string)
  #+cmu(cdr (assoc (intern string :keyword) ext:*environment-list*))
  #+clisp(ext:getenv string))

(defun remove-comma-if-needed (text)
  "Remove the commas from @var{text} and replace them with dots in
case we a in a portuguese language environment. Needed for
fann.[NOTEST]"
  (if (= 1 (count-subseq "pt" (getenv "LANG")))
      (substitute #\, #\. text)
      text))

(defun unicode-term (f)
  "Checks if terminal @var{f} supports unicode.[NOTEST]"
  (or (null f)
      (eq (stream-external-format f) nil)
      (eq (stream-external-format f) #+sbcl :utf-8 #-sbcl :default)))

(defun files-range (list)
  "All files in the range specified in @var{list}."
  (loop for x from (parse-integer (first list)) to (parse-integer (second list))
        collect (cond ((< x 10)  (format nil "00~a" x))
                      ((< x 100) (format nil "0~a" x))
                      (t (format nil "~a" x)))))

(defun path-parse-answer-sheet (file)
  "Find and parse the answer sheet for a given lilypond @var{file}, if
exists."
  (awhen (cl-fad:file-exists-p
          (pathname-replace-directory file
                                      "rameau:music;"
                                      "rameau:answer-sheets;"
                                      "pop"))
    (read-chords (read-file-as-sexp it))))

(defun path-parse-functional-answer-sheet (file)
  "Find and parse the answer sheet for file @var{file}, if exists."
  (awhen (cl-fad:file-exists-p
          (pathname-replace-directory file
                                      "rameau:music;"
                                      "rameau:answer-sheets;"
                                      "fun"))
    (get-fchords (file-string it))))

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
  (iter (for symbol in-package :cl-colors :external-only t)
        (when (equal #\+ (char (symbol-name symbol) 0))
          (collect (symbol-value symbol)))))

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
  (apply #'cl-cairo2:set-source-rgb colors))

(defun rameau-log-file-name :private ()
  (make-pathname :name (format nil "rameau-~a" (get-universal-time))
                 :type "log"
                 :directory "/tmp"))

(defmacro safe-with-backtrace ((&key print-error-msg exit return)
                               &body code)
  "Runs @var{code} with error protection, calling
@var{print-error-msg} if there's an error and doing a backtrace if
running on sbcl and @var{condition} is true at runtime."
  (let ((err (gensym)))
    `(handler-bind ((error (lambda (,err)
                             ,print-error-msg
                             (format t "Error: ~a~%" ,err)
                             (let ((name (rameau-log-file-name)))
                               (with-output-file (f name)
                                 #+sbcl (sb-debug:backtrace most-positive-fixnum f))
                               (format t "For more detailed information see ~a~%"
                                       name))
                             (when ,exit
                               (rameau-quit))
                             ,return)))
       ,@code)))

