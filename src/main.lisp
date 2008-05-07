(defpackage :rameau-main
  (:import-from #:arnesi "AIF" "AWHEN" "IT" "LAST1" "ENABLE-SHARP-L-SYNTAX")
  (:use :rameau :cl :cl-ppcre :lisp-unit :iterate :rameau-options :rameau-terminal)
  (:export :main :check))

(in-package :rameau-main)

(enable-sharp-l-syntax)

(defparameter *command-names* nil)

(defmacro defcommand (name (&rest args) &body body)
  "Wrapper to defun. Store the name of the command in *commands-names."
  `(progn
     (push (string-downcase (symbol-name ',name)) *command-names*)
     (defun ,name ,args
     ,@body)))

(defun %string->symbol (string &optional (package #+sbcl(sb-int:sane-package) #-sbcl *package*))
  (intern (string-upcase string) package))

(defun parse-options (command list)
  "Parse the list of options to a structure."
  (loop for item in (sublist-of-args list) collect
       (destructuring-bind (flag &rest value) item
         (list (cond ((long-flag? flag)
                      (%string->symbol (concat "SET-" (get-long-flag-name command flag))))
                     ((short-flag? flag)
                      (%string->symbol (concat "SET-" (get-short-flag-name command flag)))))
               (if value
                   (if (get-star-in-flag command flag)
                       value
                       (first value))
                   t)))))

(defun rameau-args ()
  #+sbcl (rest sb-ext:*posix-argv*)
  #+cmu (subseq cmu-args (1+ (position "cmurameau" extensions:*command-line-strings* :test #'string=)))
  #+clisp ext:*args*)

(defmacro with-profile (args &body body)
  `(progn
     (when (get-profile ,args)
       (rameau-profile))
     ,@body
     (when (get-profile ,args)
       (rameau-report))))

(defun maptrace (lista-string &optional (trace 'trace))
  (eval (append (list trace) (mapcar2 #'read-from-string #'string-upcase lista-string))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defstruct analysis
  segments results answer-sheet file-name notes dur size-answer-sheet
  number-algorithms)

(defun analyse-files (options)
  (loop
     for file in (get-files options)
     for segments = (sonorities (parse-file file))
     collect
       (make-analysis
        :segments segments
        :results (mapcar #L(funcall (algorithm-classify !1) segments options)
                         (get-algorithms options))
        :answer-sheet (new-parse-answer-sheet (pathname-name file) (get-substring options))
        :file-name (pathname-name file)
        :number-algorithms (length (get-algorithms options))
        :notes (mapcar #'list-events segments)
        :dur (durations segments))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 (defun print-help ()
   (iter (for (key value) in *commands*)
      (format t "~%~:@(* ~a~)~%" (substitute #\Space #\- key :test #'equal))
      (iter (for (short long help) in value)
            (format t "~4T~4a--~25a ~a~%" short long (remove #\Newline help))))
   (rameau-quit))

(defun print-warning (message)
  (format t "WARNING: ~a~%" message))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun print-condition (status file expr)
  (format t "[~a] ~a: ~a~%" status (pathname-name file) expr))

(defun print-ok/no-list (list options)
  (destructuring-bind (ok no) list
    (let* ((s2 (length no))
           (no-string
            (cond ((zerop (get-max-print-error options)) no)
                  ((> s2 (get-max-print-error options))
                   (format nil "~a ..." (subseq no 0 (get-max-print-error options))))
                  (t no))))
      (format t "  [OK]: ~a [NO]: ~a ~@[~a ~]~%" (length ok) s2 no-string))))

(defun parse-verbose (files)
  (dolist (file files)
    (handler-case (parse-file file)
      (serious-condition (expr) (print-condition 'no file expr))
      (:no-error (&rest rest) (print-condition 'ok file rest)))))

(defun parse-summary (files)
  (let (ok no)
    (dolist (file files)
      (handler-case (parse-file file)
        (serious-condition (expr)
          (declare (ignore expr))
          (push (pathname-name file) no))
        (:no-error (&rest rest)
          (declare (ignore rest))
          (push (pathname-name file) ok))))
    (list (reverse ok) (reverse no))))

(defun regression (options)
  (if (get-verbose options)
      (parse-verbose (get-files options))
      (print-ok/no-list (parse-summary (get-files options)) options)))

(defun unit (options)
  (let ((string-result
         (with-output-to-string (string)
           (let ((*standard-output* string))
             (lisp-unit:run-all-tests :rameau)
             (format t "~%")))))    
    (if (get-verbose options)
        (write-line string-result)
        (write-line (subseq (last1 (cl-ppcre:split "\\n" string-result)) 34)))))

(defcommand test (options analysis)
  (declare (ignorable analysis))
  (when (get-unit options) (unit options))
  (when (get-regression options) (regression options)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun make-result-list (analysis)
  (apply #'mapcar #'list (analysis-results analysis)))

(defun analysis-terminal (options analysis)
  (let* ((number-algorithms (analysis-number-algorithms analysis))
         (size-line (hline-size number-algorithms options)))
    (print-line-term options "#" "notes" "dur" "answer")
    (iter (for algo in (get-algorithms options))
          (print-chord-column options (algorithm-name algo)))
    (print-hline-term size-line)
    (iter (with right-answer-list = (make-list number-algorithms :initial-element 0))
          (for note in (analysis-notes analysis))
          (for dur in (analysis-dur analysis))
          (for seg-number from 1)
          (for answer in (analysis-answer-sheet analysis))
          (for result in (make-result-list analysis))
          (for comparison = (mapcar (lambda (x) (compare-answer-sheet answer x)) result))
          (setf right-answer-list (inc-bool-list comparison right-answer-list))
          (print-line-term options seg-number note dur answer)
          (iter (for res in result)
                (for comp in comparison)
                (print-color-terminal res comp options))
          (finally
           (print-hline-term size-line)
           (print-footer-term "CORRECT(%)" size-line number-algorithms options)
           (iter (for i in (mapcar (lambda (x) (% x seg-number)) right-answer-list))
                 (print-chord-column options (format nil "~,2f" i)))))))

(defun analysis-terminal-no-answer (options analysis)
  (let* ((number-algorithms (analysis-number-algorithms analysis))
         (size-line (hline-size number-algorithms options 'no-answer)))
    (print-line-term options "#" "notes" "dur")
    (iter (for algo in (get-algorithms options))
          (print-chord-column options (algorithm-name algo)))
    (print-hline-term size-line)
    (iter (for note in (analysis-notes analysis))
          (for dur in (analysis-dur analysis))
          (for seg-number from 1)
          (for result in (make-result-list analysis))
          (print-line-term options seg-number note dur)
          (iter (for res in result)
                (print-chord-column options res))
          (finally
           (print-hline-term size-line)))))

(defcommand analysis (options analysis)
  (iter (for anal in analysis)
        (cond ((get-dont-compare options) (analysis-terminal-no-answer options anal))
              ((analysis-answer-sheet anal) (analysis-terminal options anal))
              (t (print-warning (concat "the answer sheet for "
                                        (analysis-file-name anal)
                                        " doesn't exist"))
                 (analysis-terminal-no-answer anal options)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defcommand train-neural (options &rest ignore)
  (declare (ignore ignore))
  (rameau-neural::generate-e-chord-net options 'force)
  (rameau-neural::generate-context-net options 'force))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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

(defun parse-file-name (exp options)
  (unless (search ":" exp)
    (error "expression should be in the format <substring>:<expression>"))
  (let* ((tmp (cl-ppcre:split ":" exp))
         (substring (first tmp))
         (file-or-range (second tmp))
         (dir (search-music-dirs substring "music")))
    (set-substring substring options)
    (mapcar (lambda (item) (concat dir item ".ly"))
            (cond ((search ".." file-or-range)
                   (files-range (cl-ppcre:split "\\.\\." file-or-range)))
                  ((search "," file-or-range)
                   (cl-ppcre:split "," file-or-range))
                  (t (search " " file-or-range)
                     (cl-ppcre:split " " file-or-range))))))

(defun parse-files (options)
  (loop for file in (get-files options) append
       (if (search "/" file)
           (list file)
           (parse-file-name file options))))

(defun print-slots (obj)
  (iter (for slot in (sb-mop:class-slots (class-of obj)))
        ;;; FIXME that's f*cking ugly, why sb-mop:slot-definition-readers dont work?
        (for s = (intern (concat "GET-" (symbol-name (sb-mop:slot-definition-name slot)))))
        (format t "~a: ~a~%" s (funcall s obj))))

(defun main (&optional args)
  "You can run main from the REPL with all arguments as a
  string: (main \"analysis chorales -v -f 001\")"

  (let* ((*package* (find-package :rameau-main))
         (rameau-args (rameau-args))
         (arguments (if rameau-args rameau-args (cl-ppcre:split " " args)))
         (options (make-instance 'arguments))
         (neural-path (concat *rameau-path* "neural-nets/" "master-0005-")))

    (set-context-fann (concat neural-path "context-net.fann") options)
    (set-context-data (concat neural-path "context-net-train.data") options)
    (set-e-chord-fann (concat neural-path "e-chord-net.fann") options)
    (set-e-chord-data (concat neural-path "e-chord-net-train.data") options)
    (set-hidden-units 22 options)
    (set-max-print-error 10 options)
    (set-column-chord-size "7" options)
    (set-column-number-size "3" options)
    (set-column-notes-size "12" options)
    (set-column-dur-size "4" options)
    (set-column-separator "|" options)
    (set-wrong-answer-color "red" options)

    (if arguments
        (iter (for command-list in (split-command-list arguments))
              (for cmd = (first command-list))
              (for command = (search-string-in-list cmd *command-names*))
              (iter (for (key value) in (parse-options command (rest command-list)))
                    (funcall key value options))
              (set-files (parse-files options) options)
              (set-algorithms (filter-algorithms (get-algorithms options)) options)
              (for analysis = (analyse-files options))
              ;; FIXME debug is not working
              ;;; BUG: register-algorithm nao esta rodando na hora de carregar slime
              ;;; nem make-args macro
              (aif (get-debug options)
                   (mapcar2 #'rameau-debug #'string->symbol it)
                   (rameau-undebug))
              (aif (get-trace options)
                   (maptrace it)
                   (maptrace it 'untrace))
              (with-profile options
                (funcall (%string->symbol command) options analysis))
              ;;(dbg 'main "~a" (print-slots options))
              )
        (print-help)))
  #+clisp(ext:exit)
  0)
