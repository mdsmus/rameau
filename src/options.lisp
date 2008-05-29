;;; define package
(defpackage :rameau-options
  (:import-from #:arnesi "AIF" "AWHEN" "IT" "LAST1" "ENABLE-SHARP-L-SYNTAX")
  (:shadowing-import-from #:rameau-base #:defun #:defmacro #:defparameter #:defvar #:defstruct #:defclass)
  (:use :rameau :genoslib :cl :cl-ppcre :iterate)
  (:export :type-list :type-integer :*commands*))

(in-package :rameau-options)

;;; options
(eval-when (:compile-toplevel :load-toplevel)
  (defparameter *commands*
    '(("common-flags"
       (("-h" "help" "ajuda")
        ("-f" "files" "arquivos" nil type-list)
        ("-p" "profile" "profile" nil type-list)
        ("-a" "algorithms" "Usa <algoritmos> para fazer a análise" nil type-list)
        ("-d" "debug" "ativa código de depuração para os itens i" nil type-list)
        ("-v" "verbose" "verbose")
        ("-t" "trace" "mostra o trace de <funções>" nil type-list)
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
        ("-s" "score" "generate annotated scores as answer")
        ("-z" "column-chord-size" "" "7")
        ("" "column-number-size" "" "3")
        ("" "column-notes-size" "" "12")
        ("" "column-dur-size" "" "4")
        ("" "column-separator" "" "|")
        ("" "wrong-answer-color" "" "red")
	("" "lily" "roda lilypond")
	("" "gv" "roda gv")
	("" "png" "gera png")
	("-S" "view-score" "gera score, roda lily e gv")))
      ("cadences")
      ("jumps"
       (("-m" "max-number" "max number of jumps to be displayed" 30)))
      ("ambitos")
      ("cruzamento")
      ("resolve-seventh")
      ("parallel-fifths")
      ("parallel-octaves")
      ("train-neural"
       (("" "e-chord-data-set" "generate the data set for the network")
        ("" "e-chord-fann-file" "generate the reural network file")
        ("" "context-data-set" "generate the data set for the network")
        ("" "context-fann-file" "generate the reural network file")
        ("" "hidden-units" "" 22 type-integer)
        ("" "context-before" "" 1 type-integer)
        ("" "context-after" "" 1 type-integer)
        ("" "context-value" "" 96 type-integer)
        ("" "context-data" "" "")
        ("" "context-fann" "" "")
        ("" "e-chord-value" "" 96 type-integer)
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
                         (initially (export '(get-substring set-substring)))
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

(defun get-type-by-flag (command flag)
  (fifth (find-flag command flag)))

(defun get-type-by-name (command name)
  (fifth (find-flag-by-name command name)))

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
