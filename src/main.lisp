(defpackage :rameau-main
  (:use :rameau :cl :cl-ppcre :lisp-unit :ltk)
  (:export :main :check))

(in-package :rameau-main)

(defparameter *dados*
  '((teste ("unidade" "regressao" "lily"))
    (analise ("corais" "kostka" "sonatas" "exemplos"))
    (partitura ("corais" "exemplos"))
    (tamanhos ("corais" "exemplos"))
    (enarmonia ("corais"))
    (check nil)
    (gui)
    (erros ("corais" "exemplos"))
    (acertos ("corais" "exemplos"))
    (resultados ("corais" "exemplos"))
    (tipos ("corais" "exemplos"))
    (dados ("corais" "exemplos"))))

(defparameter *help*
  '((todos
     (("-h" "ajuda" help)
      ("-f" "arquivos" files)
      ("-p" "profile" profile)
      ("-a <algoritmos>" "Usa <algoritmos> para fazer a análise" algorithms)
      ("-d i" "ativa código de depuração para os itens i" debug)
      ("-v" "verbose" verbose)
      ("-t <funções>" "mostra o trace de <funções>" trace)
      ("-q" "quiet" quiet)
      ("-m n" "o número de testes errados para imprimir" wrong-number)))
    (análise
     (("-i" "ignora (não imprime) corais sem gabaritos" no-sheet)
      ("-v" "mostra notas dos segmentos" verbose)))
    (partitura
     (("-e <estilo>" "seleciona estilo de impressão dos acordes errados (bold ou red)" style)))))

;;; cria estrucura a partir de help
(defmacro make-struct (name list)
  (let ((slots (remove-duplicates
                (loop for item in (mapcar #'first (symbol-value list))
                   append (mapcar #'third (second (assoc item (symbol-value list))))))))
    `(defstruct ,name (slots ',slots) ,@slots)))

(make-struct options *help*)

(defparameter *options* (make-options))

(defun main ()
  (let* ((args (rameau-args))
;;;          (string (first args))
;;;          (dados (second args))
;;;          (comando (if string (first-string string (get-comandos))))
;;;          (flags-list (if (> (length args) 2) (arg->list (subseq args 2))))
;;;          (files (get-flag-list "-f" flags-list))
;;;          (trace (get-flag-list "-t" flags-list))
;;;          (algoritmos (get-flag-list "-a" flags-list))
;;;          (regexps (get-flag-list "-r" flags-list))
;;;          (debug (get-flag-list "-d" flags-list))
;;;          (max-error (first (get-flag-list "-m" flags-list)))
;;;          (flags (if flags-list (get-lone-flags flags-list))))
         )
    (print args)))