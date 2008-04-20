(in-package :rameau-main)

(defparameter *commands*
  '((common-flags
     (("-h" help "ajuda")
      ("-f" files "arquivos")
      ("-p" profile "profile")
      ("-a" algorithms "Usa <algoritmos> para fazer a análise")
      ("-d" debug "ativa código de depuração para os itens i")
      ("-v" verbose "verbose")
      ("-t" trace "mostra o trace de <funções>")
      ("-q" quiet "quiet")
      ("-m" test-number "o número de testes errados para imprimir")))
    (analysis
     ((data (chorales kostka sonatas examples))
      (flags (("-i" no-sheet "ignora (não imprime) corais sem gabaritos")
              ("-e" style "seleciona estilo de impressão dos acordes errados (bold ou red)")))))
    (test
     ((data (unit regression lily))))
    (check)
    (gui)))

;;;; Functions to deal with commands (flags and data)

(defun %assoc-item (item alist)
  (second (assoc item alist)))

(defun get-commands-assoc ()
  (remove 'common-flags (mapcar #'first *commands*)))

(defun get-command-slots (command)
  (mapcar #'second (append (get-common-flags) (get-flag-assoc command))))

(defun get-flag-assoc (item)
  "Works for commands only"
  (%assoc-item 'flags (%assoc-item item *commands*)))

(defun get-data-assoc (item)
  "Works for commands only"
  (%assoc-item 'data (%assoc-item item *commands*)))

(defun get-common-flags ()
  (%assoc-item 'common-flags *commands*))

(defun make-structs ()
  (loop for name in (get-commands-assoc) do
       (eval `(defstruct ,name ,@(get-command-slots name)))))

;;; make structures for each item in *commands*

(defstruct command
  name data options)

(defun %string->symbol (string &optional (package (sb-int:sane-package)))
  (intern (string-upcase string) package))

(defun parse-options (command list)
  "Parse the list of options to a structure."
  (apply (intern (concat "MAKE-" (symbol-name command)))
         (loop for (flag value) in (sublist-of-args list) append
              (list (cond ((long-flag? flag)
                           (%string->symbol (get-long-flag-name flag) :keyword))
                          ((short-flag? flag)
                           (%string->symbol (get-short-flag-name flag) :keyword)))
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

 (defun print-help ()
   (let ((*package* (find-package :rameau-main)))
     (print (get-commands-assoc))
     (rameau-quit)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defun main ()
  (let ((*package* (find-package :rameau-main)))
    (make-structs)
    (loop
       for command-list in (split-command-list (rameau-args))
       for command = (%string->symbol (first command-list))
       for data = (%string->symbol (second command-list))
       for data-assoc = (get-data-assoc command) do
         (cond ((null command) (print-help))
               (t (defparameter *options*
                    (make-command :name command
                                  :data (when data-assoc data)
                                  :options (parse-options command
                                                          (if data-assoc
                                                              (nthcdr 2 command-list)
                                                              (rest command-list))))))))
    (print *options*))
  0)
