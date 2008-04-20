(defpackage :rameau-main
  (:use :rameau :cl :cl-ppcre :lisp-unit :ltk)
  (:export :main :check))

(in-package :rameau-main)

(defparameter *data*
  '((:test unit regression lily)
    (:analysis chorales kostka sonatas examples)
    (:check)
    (:gui)))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defparameter *help*
    '((common
       (("-h" "--help" help "ajuda")
        ("-f" "--files " files "arquivos")
        ("-p" "--profile" profile "profile")
        ("-a" "--algorithm" algorithms "Usa <algoritmos> para fazer a análise")
        ("-d" "--debug" debug "ativa código de depuração para os itens i")
        ("-v" "--verbose" verbose "verbose")
        ("-t" "--trace" trace "mostra o trace de <funções>")
        ("-q" "--quiet" quiet "quiet")
        ("-m" "--test-number" test-number "o número de testes errados para imprimir")))
      (analysis
       (("-i" "" no-sheet "ignora (não imprime) corais sem gabaritos")
        ("-e" "--style" style "seleciona estilo de impressão dos acordes errados (bold ou red)"))))))

(defmacro make-struct (name &optional class)
  (let ((slots (remove-duplicates (mapcar #'third (second (assoc name *help*))))))
    `(defstruct ,(list* name (if class `((:include ,class))))
       ;;(slots ',slots)
       ,@slots)))

(make-struct common)
(make-struct analysis common)

(defun split-command-list (command-list)
  (let ((pos (position "and" command-list :test #'string=)))
    (if pos
        (append (list (subseq command-list 0 pos))
                (split-command-list (subseq command-list (1+ pos))))
        (list command-list))))

(defstruct command
  name data options)
           
(defun main ()
  (let ((args '("analysis" "chorales" "--score" "simple" "-f" "001" "and" "test" "unit" "--verbose" "and" "check")))
    (loop
       for command-list in (split-command-list args)
       for size = (length command-list) do
         (if (= size 1)
             (print (make-command :name (string->symbol (first command-list))))
             (print (make-command :name (string->symbol (first command-list))
                                  :data (string->symbol (second command-list))
                                  :options (subseq command-list 2)))))
    
    0
    ))

(main)
