(in-package :rameau-main)

(eval-when (:compile-toplevel :load-toplevel)
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
       (("" "dont-compare" "don't compare the results with the answer sheet")
        ("-u" "show-dur" "")
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
    "The 'list' at the end indicates that the flag accepts multiple values."))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmacro make-args-class ()
  `(defclass arguments ()
     ,(iter (for item in (mapcan #'get-command-slots (get-commands-assoc)))
            (collect (list (%string->symbol item)
                           :writer (%string->symbol (concat "SET-" (string-upcase item)))
                           :reader (%string->symbol (concat "GET-" (string-upcase item)))
                           :initarg (%string->symbol item :keyword)
                           :initform nil)))))
  
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
     do (print file)
     collect
       (make-analysis
        :segments segments
        :results (mapcar #'(lambda (algo) (funcall (algorithm-classify algo) segments))
                         (get-algorithms options))
        :answer-sheet (new-parse-answer-sheet (pathname-name file) "chora") ;;==========================
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
        ;;(write-line (subseq (last1 (cl-ppcre:split "\\n" string-result)) 34))
        )))

(defun test (analysis options)
  (declare (ignorable analysis))
  (when (get-unit options) (unit options))
  (when (get-regression options) (test analysis options)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun make-result-list (analysis)
  (apply #'mapcar #'list (analysis-results analysis)))

(defun analysis-terminal (analysis options)
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

(defun analysis-terminal-no-answer (analysis options)
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

(defun analysis (analysis options)
  (iter (for anal in analysis)
        (cond ((get-dont-compare options) (analysis-terminal-no-answer anal options))
              ((analysis-answer-sheet anal) (analysis-terminal anal options))
              (t (print-warning (concat "the answer sheet for "
                                        (analysis-file-name anal)
                                        " doesn't exist"))
                 (analysis-terminal-no-answer anal options)))))

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

(defun print-slots (obj)
  (iter (for slot in (sb-mop:class-slots (class-of obj)))
        ;;; FIXME that's f*cking ugly, why sb-mop:slot-definition-readers dont work?
        (for s = (intern (concat "GET-" (symbol-name (sb-mop:slot-definition-name slot)))))
        (format t "~a: ~a~%" s (funcall s obj))))

(defun main (&optional args)
  "You can run main from the REPL with all arguments as a
  string: (main \"analysis chorales -v -f 001\")"

  ;;; corrigir isso
  (make-args-class)

  (let* ((*package* (find-package :rameau-main))
         (rameau-args (rameau-args))
         (arguments (if rameau-args rameau-args (cl-ppcre:split " " args)))
         (options (make-instance 'arguments)))
    ;; default values
    (set-max-print-error 10 options)
    (set-column-chord-size "7" options)
    (set-column-number-size "3" options)
    (set-column-notes-size "12" options)
    (set-column-dur-size "4" options)
    (set-column-separator "|" options)
    (set-wrong-answer-color "red" options)

    (if arguments
        (iter (for command-list in (split-command-list arguments))
              (for command = (first command-list))
              (iter (for (key value) in (parse-options command (rest command-list)))
                    (funcall key value options))
              (set-files (parse-files (get-files options)) options)
              (set-algorithms (filter-algorithms (get-algorithms options)) options)
              (for analysis = (analyse-files options))
              ;; FIXME debug is not working
              (aif (get-debug options)
                   (mapcar2 #'rameau-debug #'string->symbol it)
                   (rameau-undebug))
              (aif (get-trace options)
                   (maptrace it)
                   (maptrace it 'untrace))
              (with-profile options
                (funcall (%string->symbol command) analysis options))
              (dbg 'main "~a" (print-slots options)))
        (print-help)))
  #+clisp(ext:exit)
  0)
