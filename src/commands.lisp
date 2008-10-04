;;; define package
(in-package :rameau)

(enable-sharp-l-syntax)

(defparameter *common-flags*
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
  da lista." 10)))))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defun get-all-flags (command)
    (append (second (first *common-flags*))
            (command-options command))))

(defmacro get-flag (slot command flag)
  `(iter (for (short long description start-value type) in (get-all-flags ,command))
         (when (or (equalp short ,flag)
                   (equalp long ,flag))
           (return ,slot))))

(defun get-flag-name (command flag)
  (get-flag long command flag))

(defun get-flag-type (command flag)
  (get-flag type command flag))

(defclass arguments-table ()
  ((arguments :accessor get-args :initform (make-hash-table :test #'eql))))

(defun arg (name options)
  "Get option named \\texttt{name} from \\texttt{options}."
  (gethash name (get-args options)))

(defsetf arg (name options) (value)
  `(setf (gethash ,name (get-args ,options)) ,value))

(defun make-default-arguments (command)
  "Make default arguments for \\texttt{rameau}."
  (let ((options (make-instance 'arguments-table)))
    (iter (for (short long doc init list) in (get-all-flags command))
          (for cmd = (make-keyword long))
          (when (and cmd init)
            (setf (arg cmd options) init)))
    options))

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
             (collect (list (make-keyword (subseq op 0 it))
                            (read-from-string (subseq op (1+ it) (length op)))))
             (collect (list (make-keyword op) t)))))

(defparameter *commands* nil)

(defstruct command
  name documentation options action)

(defun register-command (&key name options documentation action)
  (unless name
    (error "Registering a command without a name. This is definitely not a wise thing to do.~%"))
  (unless action
    (error "A command must do something. Please refrain from registering actionless commands.~%"))
  (push (make-command :name name
                      :options options
                      :documentation documentation
                      :action action)
        *commands*))

(defun get-command-by-name (name)
  (search-string-in-list name *commands* :key #'command-name))

(defun print-all-options (options)
  (format nil "~s~%" (iter (for (k v) in-hashtable (get-args options)) (collect (list k v)))))

(defun make-command-option-list (command)
  (list (command-name command)
        (command-options command)))
