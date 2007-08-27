(declaim (sb-ext:muffle-conditions warning style-warning sb-ext:compiler-note))

(defun asdf-all (packages)
  (dolist (package packages) (asdf:oos 'asdf:load-op package :verbose nil)))

(asdf-all '(lexer yacc getopt cl-fad cl-ppcre))

(defparameter *print-only-wrong* nil)
(defparameter *use-cifras* nil)

(defparameter *testes* '((corais "literatura/bach-corais/")
                         (kostka "literatura/kostka-payne/")
                         (sonatas "literatura/beethoven-sonatas/")
                         (exemplos "exemplos/")
                         (regressao "regressao/")
                         (lily "regressao-lily/")))

(defun load-all (files)
  (loop for file in files do (load (format nil "src/~(~a~).lisp" file))))

(load-all '(utils lisp-unit formato parser segmento pardo))

(defun print-gabarito (file gabarito algoritmo comparacao)
  (progn
    (format t "~% * ~a~%" file)
    (format t "gabarito: ~(~a~) ~%" gabarito)
    (format t "   pardo: ~(~a~) ~%" algoritmo)
    (format t "correto?: ~:[não~;sim~]~%" comparacao)))

(defun gera-gabarito (gabarito)
  (if *use-cifras*
      (mapcar #'acorde->cifra gabarito)
      gabarito))

(defun print-compara-gabarito (files &optional verbose)
  (let (ok no)
    (dolist (file files)
      (let* ((algoritmo (gera-gabarito (gera-gabarito-pardo (parse-file file))))
             (gabarito (gera-gabarito (gabarito->sexp (troca-extensao file ".gab"))))
             (comparacao (equal algoritmo gabarito))
             (file-name (pathname-name file)))
        (cond
          (*print-only-wrong*
           (unless comparacao
             (print-gabarito file-name gabarito algoritmo comparacao)))
          ;; se o arquivo .gab não existir
          ((not gabarito)
           (format t "~&[ERRO] o gabarito de ~a não existe~%" (pathname-name file)))
          (verbose
           (print-gabarito file-name gabarito algoritmo comparacao))
          (gabarito
           (if comparacao (push file-name ok) (push file-name no)))
          (t (error "não sei o que fazer!")))))
    (list (reverse ok) (reverse no))))
      
(defun print-analise-harmonica (files)
  (dolist (file files)
    (format t "~% * ~a~%" (pathname-name file))
    (format t "   pardo: ~(~a~) ~%" (gera-gabarito (gera-gabarito-pardo (parse-file file))))))

(defun parse-summary (files)
  (let (ok no)
    (dolist (file files)
      (handler-case (parse-file file)
        (serious-condition (expr) (push (pathname-name file) no))
        (:no-error (&rest rest) (push (pathname-name file) ok))))
    (list (reverse ok) (reverse no))))

(defun print-ok-no-list (list)
  (destructuring-bind (ok no) list
    (format t "[OK]: ~a [NO]: ~a ~@[~a ~]" (length ok) (length no) no)))

(defun parse-verbose (files)
  (dolist (file files)
    (handler-case (parse-file file)
    (serious-condition (expr) (format t "[NO] ~a: ~a~%" (pathname-name file) expr))
    (:no-error (&rest rest) (format t "[OK] ~a ~a~%" (pathname-name file) rest)))))
  
(defun handle-args ()
  "O script passa os argumentos na ordem: sbcl path comandos"
  (let ((command-args (subseq *posix-argv* 2))
        (path (second *posix-argv*)))
    (append (list path)
            (multiple-value-list
             (getopt:getopt command-args
                            '(("-h" :none) ("-g" :none) ("-w" :none) ("-v" :none)
                              ("-h" :none) ("-l" :none) ("-c" :none) ("t" :required)))))))

(defun get-opt-value (key alist)
  (when alist (char (cdr (assoc key alist :test #'string=)) 0)))

(defun get-test (key)
  (second (assoc key *testes*)))

(defun print-tests ()
  (format t "~%os testes disponíveis são:~%  (t)odos ~{~(~a ~)~}"
          (mapcar #'parenteses-na-primeira-letra (mapcar #'first *testes*))))

(defun parenteses-na-primeira-letra (letra)
  (let ((palavra (format nil "~(~a~)" letra)))
    (format nil "(~a)~a" (subseq palavra 0 1) (subseq palavra 1))))

(defun print-help ()
  (format t "uso: rameau-tests [opções] [arquivos]

* OPÇÕES
-t <nome> indica o nome do teste
-l        lista os testes disponíveis
-a        gera analise harmonica (sem comparar com gabarito)
-g        compara com gabarito (implica em -h)
-w        só mostra os testes que tem algum erro (implica em -v)
-c        mostra cifra dos acordes no lugar de listas
-v        verbose (mostra tudo)
-h        help

* EXEMPLOS
roda todas as regressões:
  rameau-tests -t r

roda os corais 031 e 371:
  rameau-tests -t c 031 371

roda todos os exemplos, faz comparação das analises harmonicas com
gabarito, e mostra resultado em cifras:
  rameau-tests -t e -vcg
"))

(defun return-path (code)
  (case code
    (#\c (get-test 'corais))
    (#\e (get-test 'exemplos))
    (#\s (get-test 'sonatas))
    (#\k (get-test 'kostka))
    (#\l (get-test 'lily))
    (#\r (get-test 'regressao))))

(defun make-list-of-files (path type flist)
  (if flist
      (loop for f in flist collect (concat path (return-path type) (add-lily-ext f)))
      (loop for f in (directory (concat path (return-path type) "*.ly")) collect (format nil "~a" f))))

(defun main ()
  (destructuring-bind (raw-path (&rest file-list) opts-value raw-opts) (handle-args)
    (let* ((type (get-opt-value "t" opts-value))
           (path (concat raw-path "/"))
           (opts (apply #'append (mapcar (lambda (c) (coerce c 'list)) raw-opts)))
           (files (make-list-of-files path type file-list)))
      (when (find #\w opts)
        (setf *print-only-wrong* t)
        (push #\v opts))
      (when (find #\c opts)
        (setf *use-cifras* t))
      (cond
        ((and (null type) (null opts) (null files)) (print-help))
        ((find #\l opts) (print-tests))
        ((find #\h opts) (print-help))
        ((find #\a opts) (print-analise-harmonica files))
        ((and (find #\g opts) (find #\v opts))
         (print-compara-gabarito files t))
        ((find #\v opts) (parse-verbose files))
        ((find #\g opts) (print-ok-no-list (print-compara-gabarito files)))
        (t (print-ok-no-list (parse-summary files))))
      )))
