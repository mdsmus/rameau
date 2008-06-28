;;; define package
(defpackage :rameau-options
  (:import-from #:arnesi "AIF" "AWHEN" "IT" "LAST1" "ENABLE-SHARP-L-SYNTAX")
  (:shadowing-import-from #:rameau-base #:defun #:defmacro #:defparameter #:defvar #:defstruct #:defclass)
  (:use :rameau :genoslib :cl :cl-ppcre :iterate)
  (:export :type-list :type-integer :*commands*  :parse-file-name))

(in-package :rameau-options)

(defparameter *commands*
  '(("common-flags"
     (("-h" "help" "ajuda")
      ("-f" "files" "arquivos" nil type-list)
      ("-p" "profile" "profile" nil type-list)
      ("-a" "algorithms" "Usa <algoritmos> para fazer a análise" nil type-list)
      ("-d" "debug" "ativa código de depuração para os itens i" nil type-list)
      ("-v" "verbose" "verbose")
      ("-t" "trace" "mostra o trace de <funções>" nil type-list)
      ("-o" "options" "send options to the algorithms" nil type-list)
      ("" "paper-width" "largura do papel" 7.1)
      ("" "paper-height" "altura do papel" 4.3)
      ;;("-q" "quiet" "quiet")
      ("-m" "max-print-error" "Quando o numero de arquivos que não são
  parseados é maior que essa constante, rameau mostra apenas o start
  da lista." 10)))
    ("analysis"
     (("" "dont-compare" "don't compare the results with the answer sheet")
      ("" "sonorities" "print total number of sonorities")
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
    ("cadences"
     (("-z" "cadence-number" "number of chords to consider" 4 type-integer)))
    ("jumps")
    ("ambitos")
    ("cruzamento")
    ("resolve-seventh")
    ("parallel-fifths")
    ("parallel-octaves")
    ("algorithms")
    ("print-segments"
     (("-i" "start" "segmento inicial" 0 type-integer)
      ("-z" "end" "segmendo final" 1000000 type-integer)))
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
  "The 'list' at the end indicates that the flag accepts multiple values.")

(defclass arguments-table ()
  ((arguments :accessor get-args :initform (make-hash-table :test #'eql))))

(defun arg (name options)
  (gethash name (get-args options)))

(defsetf arg (name options) (value)
  `(setf (gethash ,name (get-args ,options)) ,value))

(defun make-default-arguments ()
  (let* ((options (make-instance 'arguments-table))
         (neural-version "005")
         (neural-path (concat *rameau-path* "neural-nets/master-" neural-version "-"))
         (*package* (find-package :rameau-options)))
    (iter outer (for (k v) in *commands*)
          (iter (for (short long doc init list) in v)
                (for comando = (make-keyword long))
                (when (and comando init) (setf (arg comando options) init))))
    (setf (arg :context-value options)
          (* (+ 1 (arg :context-after options) (arg :context-before options))
             96))
    (setf (arg :context-fann options) (concat neural-path "context.fann"))
    (setf (arg :context-data options) (concat neural-path "context-train.data"))
    (setf (arg :e-chord-fann options) (concat neural-path "e-chord.fann"))
    (setf (arg :e-chord-data options) (concat neural-path "e-chord-train.data"))
    options))

(defun get-short-flag-name (command flag)
  (second (find-flag command flag)))

(defun get-long-flag-name (command flag)
  (second (find-flag-by-name command (subseq flag 2))))

(defun get-default-in-flag :private (command flag)
  (third (find-flag command flag)))

(defun get-type-by-flag (command flag)
  (fifth (find-flag command flag)))

(defun get-type-by-name (command name)
  (fifth (find-flag-by-name command name)))

(defun find-flag-by-name :private (command name)
  (or (find name (get-item "common-flags" *commands*) :key #'second :test #'string=)
      (find name (get-flag-assoc command) :key #'second :test #'string=)))

(defun find-flag :private (command flag)
  (or (find flag (get-item "common-flags" *commands*) :key #'first :test #'string=)
      (find flag (get-flag-assoc command) :key #'first :test #'string=)))

(defun long-flag? (flag)
  (when (cl-ppcre:scan "^--[a-zA-Z]+" flag)
    t))

(defun short-flag? (flag)
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


