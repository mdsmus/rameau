;;; define package
(in-package :rameau)

(enable-sharp-l-syntax)

(defparameter *commands*
  '(("common-flags"
     (("-h" "help" "ajuda")
      ("-f" "files" "arquivos" nil type-list)
      ("-p" "profile" "profile" nil type-list)
      ("-a" "algorithms" "Usa <algoritmos> para fazer a análise" nil type-list)
      ("-d" "debug" "ativa código de depuração para os itens i" nil type-list)
      ("-v" "verbose" "verbose")
      ("-A" "about" "print rameau info")
      ("-y" "crazy-debug" "dump megabytes of debug info from the lexer and parser.")
      ("-t" "trace" "mostra o trace de <funções>" nil type-list)
      ("-o" "options" "send options to the algorithms" nil type-list)
      ("" "paper-width" "largura do papel" 7.1)
      ("" "paper-height" "altura do papel" 4.3)
      ;;("-q" "quiet" "quiet")
      ("-m" "max-print-error" "Quando o numero de arquivos que não são
  parseados é maior que essa constante, rameau mostra apenas o start
  da lista." 10))))
  "The 'list' at the end indicates that the flag accepts multiple values.")

(defclass arguments-table ()
  ((arguments :accessor get-args :initform (make-hash-table :test #'eql))))

(defun arg (name options)
  "Get option named \\texttt{name} from \\texttt{options}."
  (gethash name (get-args options)))

(defsetf arg (name options) (value)
  `(setf (gethash ,name (get-args ,options)) ,value))

(defun make-default-arguments ()
  "Make default arguments for \\texttt{rameau}."
  (let* ((options (make-instance 'arguments-table)))
    (iter outer (for (k v) in *commands*)
          (iter (for (short long doc init list) in v)
                (for comando = (make-keyword long))
                (when (and comando init) (setf (arg comando options) init))))
    options))

(defun get-short-flag-name (command flag)
  "Return \\texttt{flag}'s short name."
  (second (find-flag command flag)))

(defun get-long-flag-name (command flag)
  "Return \\texttt{flag}'s long name."
  (second (find-flag-by-name command (subseq flag 2))))

(defun get-default-in-flag :private (command flag)
  (third (find-flag command flag)))

(defun get-type-by-flag (command flag)
  "Return the argument type of \\texttt{command}."
  (fifth (find-flag command flag)))

(defun get-type-by-name (command name)
  "Return the type of \\texttt{command} by its name."
  (fifth (find-flag-by-name command name)))

(defun find-flag-by-name :private (command name)
  (or (find name (get-item "common-flags" *commands*) :key #'second :test #'string=)
      (find name (get-flag-assoc command) :key #'second :test #'string=)))

(defun find-flag :private (command flag)
  (or (find flag (get-item "common-flags" *commands*) :key #'first :test #'string=)
      (find flag (get-flag-assoc command) :key #'first :test #'string=)))

(defun long-flag? (flag)
  "True when \\texttt{flag} is a long flag."
  (when (cl-ppcre:scan "^--[a-zA-Z]+" flag)
    t))

(defun short-flag? (flag)
  "True when \\texttt{flag} is a short flag."
  (when (cl-ppcre:scan "^-[a-zA-Z]+" flag)
    t))

(defun get-common-flags :private ()
  (get-item "common-flags" *commands*))

(defun get-commands-assoc :private ()
  (remove "common-flags" (mapcar #'first *commands*)))

(defun get-command-slots :private (command)
  (mapcar #'second (get-flag-assoc command)))

(defun get-flag-assoc :private (item)
  "Works for commands only"
  (get-item item *commands*))

(defun parse-file-name (exp options)
  "Parse a file name \\texttt{exp} with the options in \\texttt{options}."
  (unless (search ":" exp)
    (error "expression should be in the format <substring>:<expression>"))
  (let* ((tmp (cl-ppcre:split ":" exp))
         (substring (first tmp))
         (file-or-range (second tmp))
         (dir (search-music-dirs substring "music")))
    (setf (arg :substring options) substring)
    (mapcar (lambda (item) (concat dir item ".ly"))
            (cond ((search ".." file-or-range)
                   (files-range (cl-ppcre:split "\\.\\." file-or-range)))
                  ((search "," file-or-range)
                   (cl-ppcre:split "," file-or-range))
                  (t (search " " file-or-range)
                     (cl-ppcre:split " " file-or-range))))))

(defun process-option-list (options)
  (iter (for op in options)
        (aif (search "=" op)
             (collect (list (make-keyword (subseq op 0 it)) (read-from-string (subseq op (1+ it) (length op)))))
             (collect (list (make-keyword op) t)))))



(defparameter *command-names* nil)
(defparameter *command-functions* nil)
(defparameter *command-documentations* nil)

(defmacro defcommand (name (&rest args) command-line-args documentation &body body)
  "Wrapper to defun. Store the name of the command in *commands-names."
  `(progn
     (push (string-downcase (symbol-name ',name)) *command-names*)
     (push ,documentation *command-documentations*)
     (setf *commands* (append *commands* (list (list (stringify ',name) ',command-line-args))))
     (push (lambda ,args ,@body) *command-functions*)))

(defun make-int (value)
  "Coerce value into an integer."
  (if (integerp value)
      value
      (parse-integer value)))