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

(defun get-commands-assoc ()
  (remove 'common-flags (mapcar #'first *commands*)))

(defun get-command-slots (command)
  (mapcar #'second (append (get-common-flags) (get-flag-assoc command))))

(defun get-flag-assoc (item)
  "Works for commands only"
  (assoc-item 'flags (assoc-item item *commands*)))

(defun get-data-assoc (item)
  "Works for commands only"
  (assoc-item 'data (assoc-item item *commands*)))

(defun get-common-flags ()
  (assoc-item 'common-flags *commands*))

(defun make-structs ()
  (loop for name in (get-commands-assoc) do
       (eval `(defstruct ,name ,@(get-command-slots name)))))

;;; make structures for each item in *commands*

(make-structs)

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
                           (%string->symbol (get-short-flag-name flag) :keyword))
                          (t (error "wrong option ~a" flag)))
                    (if value value t)))))

(defun main ()
  (let ((args '("analysis" "chorales" "--profile" "--verbose" "-f" "001" "and" "test" "unit" "-v" "and" "check" "-v")))
    (loop
       for command-list in (split-command-list args)
       for command = (%string->symbol (first command-list))
       for data = (%string->symbol (second command-list))
       for data-assoc = (get-data-assoc command) do
       (defparameter *options*
         (make-command :name command
                       :data (when data-assoc data)
                       :options (parse-options command
                                               (if data-assoc
                                                   (nthcdr 2 command-list)
                                                   (rest command-list)))))))
  0)

(main)
