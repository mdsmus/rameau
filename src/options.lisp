(defpackage :rameau-options
  (:import-from #:arnesi "AIF" "AWHEN" "IT" "LAST1" "ENABLE-SHARP-L-SYNTAX")
  (:use :rameau :cl :cl-ppcre :iterate)
  (:export :*commands* :get-long-flag-name :get-short-flag-name :get-star-in-flag
           :get-substring :long-flag? :set-substring :short-flag? :arguments :make-args-class))

(in-package :rameau-options)

(eval-when (:compile-toplevel :load-toplevel)
  (defparameter *commands*
    '(("common-flags"
       (("-h" "help" "ajuda")
        ("-f" "files" "arquivos" nil list)
        ("-p" "profile" "profile" nil list)
        ("-a" "algorithms" "Usa <algoritmos> para fazer a análise" nil list)
        ("-d" "debug" "ativa código de depuração para os itens i" nil list)
        ("-v" "verbose" "verbose")
        ("-t" "trace" "mostra o trace de <funções>" nil list)
        ;;("-q" "quiet" "quiet")
        ("-m" "max-print-error" "Quando o numero de arquivos que não são
  parseados é maior que essa constante, rameau mostra apenas o start
  da lista." 10)))
      ("analysis"
       (("" "dont-compare" "don't compare the results with the answer sheet")
        ("-u" "show-dur" "")
        ("-n" "show-notes" "")
        ("-i" "ignore" "ignora (não imprime) corais sem gabaritos")
        ("-c" "no-color" "don't use color in the answer")
        ("-s" "column-chord-size" "" "7")
        ("" "column-number-size" "" "3")
        ("" "column-notes-size" "" "12")
        ("" "column-dur-size" "" "4")
        ("" "column-separator" "" "|")
        ("" "wrong-answer-color" "" "red")))
      ("train-neural"
       (("" "hidden-units" "" "" 22)
        ("" "context-data" "" "")
        ("" "context-fann" "" "")
        ("" "e-chord-data" "" "")
        ("" "e-chord-fann" "" "")))
      ("test"
       (("-u" "unit" "")
        ("-r" "regression" "")))
      ("check")
      ("gui"))
    "The 'list' at the end indicates that the flag accepts multiple values."))

(defun make-args-class ()
  (eval `(defclass arguments ()
           ,(append
             (list '(substring :writer set-substring :reader get-substring
                     :initarg :substring :initform nil))
             (iter outer (for (k v) in *commands*)
                   (iter (for (short long doc init list) in v)
                         (for writer = (intern (concat "SET-" (string-upcase long))))
                         (for reader = (intern (concat "GET-" (string-upcase long))))
                         (export (list writer reader))
                         (in outer (collect (list (intern (string-upcase long))
                                                  :writer writer
                                                  :reader reader
                                                  :initarg (intern (string-upcase long) :keyword)
                                                  :initform init)))))))))

(defun get-short-flag-name (command flag)
  (second (find-flag command flag)))

(defun get-long-flag-name (command flag)
  (second (find-flag-by-name command (subseq flag 2))))

(defun get-default-in-flag (command flag)
  (third (find-flag command flag)))

(defun get-star-in-flag (command flag)
  (fifth (find-flag command flag)))

(defun find-flag-by-name (command name)
  (or (find name (get-item "common-flags" *commands*) :key #'second :test #'string=)
      (find name (get-flag-assoc command) :key #'second :test #'string=)))

(defun find-flag (command flag)
  (or (find flag (get-item "common-flags" *commands*) :key #'first :test #'string=)
      (find flag (get-flag-assoc command) :key #'first :test #'string=)))

(defun long-flag? (flag)
  (when (cl-ppcre:scan "^--[a-zA-Z]+" flag)
    t))

(defun short-flag? (flag)
  (when (cl-ppcre:scan "^-[a-zA-Z]+" flag)
    t))

(defun get-common-flags ()
  (get-item "common-flags" *commands*))

(defun get-commands-assoc ()
  (remove "common-flags" (mapcar #'first *commands*)))
  
(defun get-command-slots (command)
  (mapcar #'second (get-flag-assoc command)))
  
(defun get-flag-assoc (item)
  "Works for commands only"
  (get-item item *commands*))

(make-args-class)
