(in-package :rameau-main)

(defparameter *commands*
  '(("common-flags"
     (("-h" "help" "ajuda")
      ("-f" "files" "arquivos" "*")
      ("-p" "profile" "profile" "*")
      ("-a" "algorithms" "Usa <algoritmos> para fazer a análise" "*")
      ("-d" "debug" "ativa código de depuração para os itens i")
      ("-v" "verbose" "verbose")
      ("-t" "trace" "mostra o trace de <funções>" "*")
      ("-q" "quiet" "quiet")
      ("-m" "test-number" "o número de testes errados para imprimir")
      ("-c" "no-color" "don't use color in the answer")
      ("-s" "column-chord-size" "")
      ("-z" "column-number-size" "")
      ("-y" "column-notes-size" "")
      ("-k" "column-dur-size" "")
      ))
    ("analysis"
     (("-u" "show-dur" "")
      ("-n" "show-notes" "")
      ("-i" "ignore" "ignora (não imprime) corais sem gabaritos")
      ("-e" "style" "seleciona estilo de impressão dos acordes errados (bold ou red)")))
    ("test")
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
        (clisp-args #+clisp *args*))
    (cond (sbcl-args (rest sbcl-args))
          (cmu-args (subseq cmu-args (1+ (position "cmurameau" cmu-args :test #'string=))))
          (clisp-args clisp-args)
          (t (error "algum problema com argumentos")))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun print-answer (&key file sheet results dur notes)
  (mapcar #'(lambda (s r d n) (format t "~10a ~10a ~10a ~10a~%" s r d n))
          sheet (first results) dur notes))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defstruct analysis
  segments results answer-sheet file-name notes dur size-answer-sheet number-algorithms)


(defun analyse-files (options)
  (loop
     for file in (args-files options)
     for segments = (sonorities (parse-file file))
     collect
       (make-analysis
        :segments segments
        :results (mapcar #'(lambda (algo) (funcall (algorithm-classify algo) segments))
                         (args-algorithms options))
        :answer-sheet (new-parse-answer-sheet (remove-ext file) "chora") ;;==========================
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

;; (command-let analysis
;;   ;;(when (/= size-gab (length i)) (print-warning "sizes don't match!"))
;;   (if (and (not answer-sheet) (not (args-ignore options)))
;;       (print-warning (concat "the answer sheet for " file-name " doesn't exist"))
;;       (print-answer :file file-name :sheet answer-sheet :results results :dur dur :notes notes)))

(defun print-color-terminal (result comparison options)
  (let ((column (concat "~" (args-column-chord-size options) "a"))
        (color (if comparison 21 31))
        (string "~a[0;~Dm"))
    (if (args-no-color options)
        (format t (concat column "|") result)
        (progn
          (format t (concat string column) (code-char #x1b) color result)
          (format t "~a[0m|" (code-char #x1b))))))

(defun inc-bool-list (bool-list num-list)
  (mapcar #'+ (mapcar #'(lambda (x) (if x 1 0)) bool-list) num-list))

(defun print-line-term (options number note dur answer)
  (format t (concat "~&~"
                    (args-column-number-size options)
                    "a~@[|~"
                    (args-column-notes-size options)
                    "a~]~@[|~"
                    (args-column-dur-size options)
                    "a~]|~"
                    (args-column-chord-size options)
                    "a|")
          number
          (when (args-show-notes options) note)
          (when (args-show-dur options) dur)
          answer))

(defun hline-size (number-algorithms options)
  (+ (* (parse-integer (args-column-chord-size options)) (1+ number-algorithms))
     (1+ number-algorithms)
     (1+ (parse-integer (args-column-number-size options)))
     (if (args-show-notes options)
         (1+ (parse-integer (args-column-notes-size options)))
         0)
     (if (args-show-dur options)
         (1+ (parse-integer (args-column-dur-size options)))
         0)))

(defun print-chord-column (options text)
  (format t (concat "~" (args-column-chord-size options) "a|") text))

(defun print-footer-term (text size-line number-algorithms options)
  (let ((footer-size (- size-line
                        (1+ (length text))
                        number-algorithms
                        (* number-algorithms (parse-integer (args-column-chord-size options))))))
    (format t (concat "~&" text (repeat-string footer-size " ") "|"))))

(defun print-hline-term (size)
  (format t "~&~a" (repeat-string size "-")))

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
          (for result in (apply #'mapcar #'list (analysis-results analysis)))
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
                 (print-chord-column options i))))))

(defun analysis (analysis options)
  (mapcar #'(lambda (anal) (analysis-terminal anal options)) analysis))

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
    (unless (args-column-chord-size options)
      (setf (args-column-chord-size options) "7"))
    (setf (args-column-number-size options) "3")
    (setf (args-column-notes-size options) "12")
    (setf (args-column-dur-size options) "4")
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
         (funcall (%string->symbol command) analysis options)
         ))
  0)
