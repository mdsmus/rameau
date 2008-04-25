(in-package :rameau-main)

(defparameter *commands*
  '(("common-flags"
     (("-h" "help" "ajuda")
      ("-f" "files" "arquivos")
      ("-p" "profile" "profile")
      ("-a" "algorithms" "Usa <algoritmos> para fazer a análise")
      ("-d" "debug" "ativa código de depuração para os itens i")
      ("-v" "verbose" "verbose")
      ("-t" "trace" "mostra o trace de <funções>")
      ("-q" "quiet" "quiet")
      ("-m" "test-number" "o número de testes errados para imprimir")))
    ("analysis"
     ((data ("chorales" "kostka" "sonatas" "examples"))
      (flags (("-i" "ignore" "ignora (não imprime) corais sem gabaritos")
              ("-e" "style" "seleciona estilo de impressão dos acordes errados (bold ou red)")))))
    ("test"
     ((data (unit regression lily))))
    ("check")
    ("gui")))

(defun parse-options (command list)
  "Parse the list of options to a structure."
  (loop for item in (sublist-of-args list) append
       (destructuring-bind (flag &rest value) item
         (list (cond ((long-flag? flag)
                      (%string->symbol (get-long-flag-name command flag) :keyword))
                     ((short-flag? flag)
                      (%string->symbol (get-short-flag-name command flag) :keyword)))
               (if value value t)))))

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
  segments results answer-sheet file-name notes dur size-answer-sheet)


(defun analyse-files (data options)
    (loop
       for file in (args-files options)
       for segments = (sonorities (parse-file file))
       collect
         (make-analysis
          :segments segments
          :results (mapcar #'(lambda (algo) (funcall (algorithm-classify algo) segments))
                           (args-algorithms options))
          :answer-sheet (parse-answer-sheet (remove-ext file) data)
          :file-name (pathname-name file)
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
      

(defun analysis (analysis options)
  (print (mapcar #'analysis-dur analysis)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun search-music-dirs (substring)
  (first (remove-if-not (lambda (item) (search substring item :test #'equalp))
                        (mapcar #'namestring
                                (directory (format nil "~a/literatura/*"
                                                   *default-pathname-defaults*))))))

(defun parse-file-name (exp)
  (unless (search ":" exp)
    (error "expression should be in the format <substring>:<expression>"))
  (let* ((tmp (cl-ppcre:split ":" exp))
         (substring (first tmp))
         (file-or-range (second tmp))
         (dir (search-music-dirs substring)))
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
  
(defun create-args-struct (command-list command data-assoc data)
  ;; create a structure dynamically to accomodate different slots
  (eval `(defstruct args ,@(append '(name data)
                                   (mapcar #'%string->symbol (get-command-slots command)))))
  (let* ((options
          (apply #'make-args
                 (append `(:name ,command :data ,(when data-assoc data))
                         (parse-options command
                                        (if data-assoc
                                            (nthcdr 2 command-list)
                                            (rest command-list))))))
         (files (parse-files (args-files options))))
    (setf (args-files options) files
          (args-algorithms options) (filter-algorithms (args-algorithms options)))
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
       for data = (second command-list)
       for data-assoc = (get-data-assoc command)
       for options = (create-args-struct command-list command data-assoc data)
       for analysis = (analyse-files data options) do
         (funcall (%string->symbol command) analysis options)))
  0)
