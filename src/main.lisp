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
     (("-i" "ignore" "ignora (não imprime) corais sem gabaritos")
      ("-e" "style" "seleciona estilo de impressão dos acordes errados (bold ou red)")))
    ("test")
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


(defun analyse-files (options)
  (loop
     for file in (args-files options)
     for segments = (sonorities (parse-file file))
     collect
       (make-analysis
        :segments segments
        :results (mapcar #'(lambda (algo) (funcall (algorithm-classify algo) segments))
                         (args-algorithms options))
        :answer-sheet (parse-answer-sheet (remove-ext file) 'foo)
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

(defun analysis-terminal (analysis options)
  (iter (for note in (analysis-notes analysis))
        (for dur in (analysis-dur analysis))
        (for seg-number from 1)
        (for result in (apply #'mapcar #'list (analysis-results analysis)))
        (print result)
        ;;(print (apply #'compare-answer-sheet result))
        ;;(format t "~&~3a | ~12a | ~4a |" seg-number note dur)
        ;;(apply #'format t " ~7a | ~7a |" result)
        ))

(defmacro flatten (&rest list)

    (flatten ((a b c) (d e f)))
  
(defun analysis (analysis options)
  (mapcar #'(lambda (anal) (analysis-terminal anal options)) analysis))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun search-music-dirs (substring dir)
  (first (remove-if-not (lambda (item) (search substring item :test #'equalp))
                        (mapcar #'namestring
                                (directory (format nil "~a/~a/*"
                                                   dir
                                                   *default-pathname-defaults*))))))

(defun parse-answer-sheet (file item)
  (let* ((dir (search-music-dirs substring "")))
         (nome-pop (concat *rameau-path*
                           (get-item item *gabarito-dir-list*)
                           (add-pop-ext (pathname-name file)))))
    (when (cl-fad:file-exists-p nome-pop)
      (read-chords (read-file-as-sexp nome-pop)))))

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
         (funcall (%string->symbol command) analysis options)))
  0)
