(defpackage :rameau-main
  (:import-from #:arnesi "AIF" "AWHEN" "IT" "LAST1")
  (:use :rameau :cl :cl-ppcre :lisp-unit :iterate)
  (:export :main :check))

(in-package :rameau-main)

(defparameter *commands*
  '(("common-flags"
     (("-h" "help" "ajuda")
      ("-f" "files" "arquivos" list)
      ("-p" "profile" "profile" list)
      ("-a" "algorithms" "Usa <algoritmos> para fazer a análise" list)
      ("-d" "debug" "ativa código de depuração para os itens i" list)
      ("-v" "verbose" "verbose")
      ("-t" "trace" "mostra o trace de <funções>" list)
      ;;("-q" "quiet" "quiet")
      ("-m" "max-print-error" "Quando o numero de arquivos que não são
  parseados é maior que essa constante, rameau mostra apenas o start
  da lista.")))
    ("analysis"
     (("-u" "show-dur" "")
      ("-n" "show-notes" "")
      ("-i" "ignore" "ignora (não imprime) corais sem gabaritos")
      ("-c" "no-color" "don't use color in the answer")
      ("-s" "column-chord-size" "")
      ("" "column-number-size" "")
      ("" "column-notes-size" "")
      ("" "column-dur-size" "")
      ("" "column-separator" "")
      ("" "wrong-answer-color" "")))
    ("test"
     (("-u" "unit" "")
      ("-r" "regression" "")))
    ("check")
    ("gui"))
  "The star at the end indicates that the flag accepts multiple values.")

(defun parse-options (command list)
  "Parse the list of options to a structure."
  (loop for item in (sublist-of-args list) append
       (destructuring-bind (flag &rest value) item
         (list (cond ((long-flag? flag)
                      (%string->symbol (get-long-flag-name command flag) :keyword))
                     ((short-flag? flag)
                      (%string->symbol (get-short-flag-name command flag) :keyword)))
               (if value
                   (if (get-star-in-flag command flag)
                       value
                       (first value))
                   t)))))

(defun rameau-args ()
  (let ((sbcl-args #+sbcl sb-ext:*posix-argv*)
        (cmu-args #+cmu extensions:*command-line-strings*)
        (clisp-args #+clisp ext:*args*))
    (cond (sbcl-args (rest sbcl-args))
          (cmu-args (subseq cmu-args (1+ (position "cmurameau" cmu-args :test #'string=))))
          (clisp-args clisp-args))))

(defmacro with-profile (args &body body)
  `(progn
     (when (args-profile ,args)
       (rameau-profile))
     ,@body
     (when (args-profile ,args)
       (rameau-report))))

(defun maptrace (lista-string &optional (trace 'trace))
  (eval (append (list trace) (mapcar2 #'read-from-string #'string-upcase lista-string))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun print-answer (&key file sheet results dur notes)
  (mapcar #'(lambda (s r d n) (format t "~10a ~10a ~10a ~10a~%" s r d n))
          sheet (first results) dur notes))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defstruct analysis
  segments results answer-sheet file-name notes dur size-answer-sheet
  number-algorithms)

(defun analyse-files (options)
  (loop
     for file in (args-files options)
     for segments = (sonorities (parse-file file))
     collect
       (make-analysis
        :segments segments
        :results (mapcar #'(lambda (algo) (funcall (algorithm-classify algo) segments))
                         (args-algorithms options))
        :answer-sheet (new-parse-answer-sheet (pathname-name file) "chora") ;;==========================
        :file-name (pathname-name file)
        :number-algorithms (length (args-algorithms options))
        :notes (mapcar #'list-events segments)
        :dur (durations segments))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 (defun print-help ()
   (let ((*package* (find-package :rameau-main)))
     (print (get-commands-assoc))
     (rameau-quit)))

(defun print-warning (message)
  (format t "WARNING: ~a~%" message))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun print-condition (status file expr)
  (format t "[~a] ~a: ~a~%" status (pathname-name file) expr))

(defun print-ok/no-list (list)
  (destructuring-bind (ok no) list
    (let* ((s2 (length no))
           (no-string
            (cond ((= max-print-error 0) no)                  ((> s2 max-print-error)
                   (format nil "~a ..." (subseq no 0 max-print-error)))
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
  (if (args-verbose options)
      (parse-verbose (args-files options))
      (print-ok/no-list (parse-summary (args-files options)))))

(defun unit (options)
  (let ((string-result
         (with-output-to-string (string)
           (let ((*standard-output* string))
             (lisp-unit:run-all-tests :rameau)
             (format t "~%")))))    
    (if (args-verbose options)
        (write-line string-result)
        ;;(write-line (subseq (last1 (cl-ppcre:split "\\n" string-result)) 34))
        )))

(defun test (analysis options)
  (when (args-unit options) (unit options))
  (when (args-regression options) (test options)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun make-result-list (analysis)
  (apply #'mapcar #'list (analysis-results analysis)))

(defun analysis-terminal (analysis options)
  (let* ((number-algorithms (analysis-number-algorithms analysis))
         (size-line (hline-size number-algorithms options)))
    (print-line-term options "#" "notes" "dur" "answer")
    (iter (for algo in (args-algorithms options))
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

(defun analysis-terminal-no-answer (analysis options)
  (let* ((number-algorithms (analysis-number-algorithms analysis))
         (size-line (hline-size number-algorithms options 'no-answer)))
    (print-line-term options "#" "notes" "dur")
    (iter (for algo in (args-algorithms options))
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

(defun analysis (analysis options)
  (iter (for anal in analysis)
        (if (analysis-answer-sheet anal)
            (analysis-terminal anal options)
            (progn
              (print-warning (concat "the answer sheet for " (analysis-file-name anal) " doesn't exist"))
              (analysis-terminal-no-answer anal options)
              ))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun parse-file-name (exp)
  (unless (search ":" exp)
    (error "expression should be in the format <substring>:<expression>"))
  (let* ((tmp (cl-ppcre:split ":" exp))
         (substring (first tmp))
         (file-or-range (second tmp))
         (dir (search-music-dirs substring "music")))
    (mapcar (lambda (item) (concat dir item ".ly"))
            (cond ((search ".." file-or-range)
                   (files-range (cl-ppcre:split "\\.\\." file-or-range)))
                  ((search "," file-or-range)
                   (cl-ppcre:split "," file-or-range))
                  (t (search " " file-or-range)
                     (cl-ppcre:split " " file-or-range))))))

(defun parse-files (files)
  (loop for file in files append
       (if (search "/" file)
           (list file)
           (parse-file-name file))))

(defmacro set-user-opt (name value opt)
  `(unless (,name ,opt)
     (setf (,name ,opt) ,value)))
  
(defmacro set-user-opt-num (name value opt)
  `(unless (,name ,opt)
     (typecase ,value
       (nil (setf (,name ,opt) ,value))
       (string (setf (,name ,opt) (parse-integer ,value)))
       (number (setf (,name ,opt) ,value)))))
  
(defun create-args-struct (command-list command)
  ;; create a structure dynamically to accomodate different slots
  (eval `(defstruct args ,@(append '(name)
                                   (mapcar #'%string->symbol (get-command-slots command)))))
  (let* ((options
          (apply #'make-args
                 (append `(:name ,command)
                         (parse-options command
                                        (rest command-list)))))
         (files (parse-files (args-files options))))
    (setf (args-files options) files
          (args-algorithms options) (filter-algorithms (args-algorithms options)))
    (when (string= command "analysis")
      (set-user-opt-num args-max-print-error 10 options)
      (set-user-opt args-column-chord-size "7" options)
      (set-user-opt args-column-number-size "3" options)
      (set-user-opt args-column-notes-size "12" options)
      (set-user-opt args-column-dur-size "4" options)
      (set-user-opt args-column-separator "|" options)
      (set-user-opt args-wrong-answer-color "red" options))
    options))

(defun main (&optional args)
  "You can run main from the REPL with all arguments as a
  string: (main \"analysis chorales -v -f 001\")"
  (let* ((*package* (find-package :rameau-main))
         (rameau-args (rameau-args))
         (arguments (if rameau-args rameau-args (cl-ppcre:split " " args))))
    (loop
       for command-list in (split-command-list arguments)
       for command = (first command-list)
       for options = (create-args-struct command-list command)
       for analysis = (analyse-files options) do
         (aif (args-debug options)
              (mapcar2 #'rameau-debug #'string->symbol it)
              (rameau-undebug))
         
         (aif (args-trace options)
              (maptrace it)
              (maptrace it 'untrace))
         
         (with-profile options
           (funcall (%string->symbol command) analysis options))

       (dbg 'main "~a" options)
         ))
  #+clisp(ext:exit)
  0)
