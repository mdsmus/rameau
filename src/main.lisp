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

;;;; Functions to deal with commands (flags and data)

(defun %string->symbol (string &optional (package (sb-int:sane-package)))
  (intern (string-upcase string) package))

(defun get-commands-assoc ()
  (remove "common-flags" (mapcar #'first *commands*)))

(defun get-command-slots (command)
  (mapcar #'second (append (get-common-flags) (get-flag-assoc command))))

(defun get-flag-assoc (item)
  "Works for commands only"
  (get-item 'flags (get-item item *commands*)))

(defun get-data-assoc (item)
  "Works for commands only"
  (get-item 'data (get-item item *commands*)))

(defun get-common-flags ()
  (get-item "common-flags" *commands*))

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

(defmacro command-let (name &body body)
  `(defun ,name (item options)
     (dolist (file (args-files options))
       (let* ((segments (sonorities (parse-file file)))
              (results (loop for a in (args-algorithms options) collect
                            (funcall (algorithm-classify a) segments)))
              (answer-sheet (parse-answer-sheet (remove-ext file) item))
              (file-name (pathname-name file))
              (notes (mapcar #'list-events segments))
              (dur (durations segments))
              (size-gab (length answer-sheet)))
         ,@body))))

(command-let analysis
  ;;(when (/= size-gab (length i)) (print-warning "sizes don't match!"))
  (if (and (not answer-sheet) (not (args-ignore options)))
      (print-warning (concat "the answer sheet for " file-name " doesn't exist"))
      (print-answer :file file-name :sheet answer-sheet :results results :dur dur :notes notes)))
      
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 (defun print-help ()
   (let ((*package* (find-package :rameau-main)))
     (print (get-commands-assoc))
     (rameau-quit)))

(defun print-warning (message)
  (format t "WARNING: ~a~%" message))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


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
       for data-assoc = (get-data-assoc command) do
         ;;; create a structure dynamically to accomodate different slots
         (eval `(defstruct args ,@(append '(name data)
                                          (mapcar #'%string->symbol (get-command-slots command)))))
         (let* ((options
                 (apply #'make-args
                        (append `(:name ,command :data ,(when data-assoc data))
                                (parse-options command
                                               (if data-assoc
                                                   (nthcdr 2 command-list)
                                                   (rest command-list))))))
                (files (parse-file-list (stringify data) (args-files options))))
           (setf (args-files options) files)
           (setf (args-algorithms options)
                 (filter-algorithms (args-algorithms options)))
           (funcall (%string->symbol command) (stringify data) options)
           )))
  0)
