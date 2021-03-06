(in-package :rameau)

(enable-sharp-l-syntax)

(defun rameau-args ()
  "The command-line arguments, minus the first one."
  #+sbcl (rest sb-ext:*posix-argv*)
  #+cmu (subseq cmu-args (1+ (position "cmurameau" extensions:*command-line-strings* :test #'string=)))
  #+clisp ext:*args*)

(defun maptrace :private (lista-string &optional (trace 'trace))
  (eval (append (list trace)
                (mapcar2 #'read-from-string #'string-upcase lista-string))))

;;; Print messages
(defun print-help :private ()
  (iter (for (key value) in (append *common-flags*
                                    (mapcar #'make-command-option-list *commands*)))
        (for documentation in (cons "" (mapcar #'command-documentation *commands*)))
        (format t "~%~:@(* ~a~)~%" (dashs->space key))
        (format t "    ~a~%" documentation)
        (iter (for (short long help) in value)
              (format t "~4T~4a--~25a ~a~%" short long (remove #\Newline help)))))

(defun print-warning :private (message)
  (format t "~&WARNING: ~a~%" message))

(defun print-fatal :private (message)
  (format t "~&FATAL: ~a~%" message))

(defun split-command-list :private (command-list)
  (let ((pos (position "and" command-list :test #'string=)))
    (if pos
        (append (list (subseq command-list 0 pos))
                (split-command-list (subseq command-list (1+ pos))))
        (list command-list))))

(defun parse-options :private (command list)
  "Parse the list of options to a structure."
  (loop for item in (sublist-of-args list #\-) collect
        (destructuring-bind (flag &rest value) item
          (list (make-keyword (get-flag-name command flag))
                (if value
                    (case (get-flag-type command flag)
                      (type-list value)
                      (type-integer (parse-integer (first value)))
                      (t (first value)))
                    t)))))

(defun parse-files :private (options)
  (iter (for file in (arg :files options))
        (appending (if (search ":" file)
                       (parse-file-name file options)
                       (if (cl-fad:file-exists-p file)
                           (list file)
                           (error "File ~a does not exist." file))))))

;; These variables are set in the makefile. Their definitions are only here
;; to stop rameau about from crashing in slime.

(defvar *rameau-version*)
(defvar *compilation-date*)
(defvar *user*)
(defvar *git-commit*)
(defvar *kernel-info*)
(defvar *libc-version*)

(defun print-about ()
  (macrolet ((get-info (info)
               `(when (boundp ',info)
                  ,info)))
    (format t
            "Rameau ~@[~a~] was compiled with ~@[~a~], version ~@[~a~], in ~@[~a~] by ~@[~a~],
  at least using commit ~@[~a~], on the system:~%  ~@[~a~],
  using libc version ~@[~a~]~%"
            (get-info cl-user::*rameau-version*)
            (lisp-implementation-type)
            (lisp-implementation-version)
            (get-info cl-user::*compilation-date*)
            (get-info cl-user::*user*)
            (get-info cl-user::*git-commit*)
            (get-info cl-user::*kernel-info*)
            (get-info cl-user::*libc-version*))
    (rameau-quit)))

(defun main (&optional args)
  "You can run main from the REPL with all arguments as a
  string: (main \"analysis chorales -v -f 001\")"
  (let* ((*package* (find-package :rameau))
         (rameau-args (rameau-args))
         (arguments (if args (cl-ppcre:split " " args) rameau-args)))
    (handler-case
        (safe-with-backtrace (:print-error-msg
                              (format t "Rameau could not operate.~%")
                              :exit t)
          (if arguments
              (iter (for command-list in (split-command-list arguments))
                    (for cmd = (first command-list))
                    (for command = (get-command-by-name cmd))
                    (when (string= cmd "-h")
                      (print-help)
                      (return))
                    (when  (string= cmd "-A")
                      (print-about)
                  (return))
                    (unless command
                      (print-fatal (concat cmd " is not a rameau command.~%"))
                      (return))
                    (for options = (make-default-arguments command))
                    (iter (for (key value) in (parse-options command
                                                             (rest command-list)))
                          (if key
                              (setf (arg key options) value)
                              (return-from main
                                (progn
                                  (format t "ERROR: command not found. Exiting.~%")
                                  1))))
                    (aif (arg :debug options)
                         (mapcar2 #'rameau-debug #'make-keyword it)
                         (rameau-undebug))
                    (when (arg :crazy-debug options)
                      (setf yacc::*warn-on-tokens* t
                            lexer::*warn-on-token* t))
                    (when (arg :profile options)
                      (rameau-profile))
                    (awhen (arg :trace options)
                  (maptrace it))
                    (when (arg :help options)
                      (print-help)
                      (return))
                    (when (arg :about options)
                      (print-about)
                      (return))
                    ;; parse file options
                    (setf (arg :files options) (parse-files options))
                    ;; parse algorithms options
                    (if (command-p command)
                        (funcall (command-action command) options)
                        (print-fatal (concat cmd " is not a rameau command.")))
                    (when (arg :profile options)
                  (rameau-report)))
              ;;(dbg 'main "~a" (print-slots options))
              (print-help)))
      #+clisp(ext:exit)
      (exit-rameau nil)
      (error nil)))0)
