(declaim (sb-ext:muffle-conditions warning style-warning sb-ext:compiler-note))

(asdf:oos 'asdf:load-op 'lexer :verbose nil)
(asdf:oos 'asdf:load-op 'yacc :verbose nil)
(asdf:oos 'asdf:load-op 'getopt :verbose nil)

(defparameter *muffle-conflicts* t)

(defparameter *testes* '((corais "literatura/bach-corais/")
                         (kostka "literatura/kostka-payne/")
                         (sonatas "literatura/beethoven-sonatas/")
                         (exemplos "exemplos/")
                         (regressao "regressao/")
                         (lily "regressao-lily/")))

(defun concat (&rest args)
  (apply #'concatenate 'string args))

(defun load-all (files)
  (loop for file in files do (load (format nil "src/~(~a~)" file))))

(load-all '(lisp-unit formato parser segmento pardo))

(defun tira-extensao (file)
  (subseq file 0 (position #\. file)))

(defun add-lily-ext (file)
  (if (tem-ext? file)
      file
      (concatenate 'string file ".ly")))

(defun tem-ext? (file)
  (find #\. file))
  
(defun troca-extensao (file ext)
  (concatenate 'string (tira-extensao file) ext))

(defun print-compara-gabarito (files &optional verbose)
  (let (ok no)
    (dolist (file files)
      (let* ((algoritmo (gera-gabarito-pardo (parse-file file)))
             ;;; TODO lidar com .gab inexistente
             (gabarito (gabarito->sexp (troca-extensao (format nil "~a" file) ".gab")))
             (comparacao (equal algoritmo gabarito))
             (file-name (pathname-name file)))
        (if verbose
            (progn
              (format t "~% * ~a~%" file-name)
              (format t "gabarito: ~(~a~) ~%" gabarito)
              (format t "   pardo: ~(~a~) ~%" algoritmo)
              (format t "correto?: ~:[não~;sim~]~%" comparacao))
            (if comparacao
                (push file-name ok)
                (push file-name no)))))
    (list (reverse ok) (reverse no))))
      
(defun print-analise-harmonica (files)
  (dolist (file files)
    (format t "~% * ~a~%" (pathname-name file))
    (format t "   pardo: ~(~a~) ~%" (gera-gabarito-pardo (parse-file file)))))

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

(defun parse-only (file &optional verbose?)
  (handler-case (parse-file file)
    (serious-condition (expr) (format t "[NO] ~a: ~a~%" (pathname-name file) expr))
    ;;(:no-error (&rest rest) (format t "[OK] ~a ~a~%" (pathname-name file) rest))
    (:no-error (&rest rest) (format t "[OK] ~a~%" (pathname-name file)))
    ))
  
(defun test-all (arquivos &optional (print-only-if-incorrect? nil))
  (dolist (f arquivos)
    (handler-case (print-gabarito-pardo f print-only-if-incorrect?)
      (serious-condition (expr) (format t "~%=> ERRO em ~a~%" (pathname-name f))))))

(defun test-one (f)
  (handler-case (print-gabarito-pardo f)
    (serious-condition (expr) (format t "~%=> ERRO em ~a~%~a~%" (pathname-name f) expr))))

(defun handle-args ()
  "O script passa os argumentos na ordem: sbcl path comandos"
  (let ((command-args (subseq *posix-argv* 2))
        (path (second *posix-argv*)))
    (append (list path)
            (multiple-value-list
             (getopt:getopt command-args
                            '(("-p" :none) ("-h" :none) ("-g" :none)
                              ("-o" :none) ("-w" :none) ("-v" :none)
                              ("-h" :none) ("-l" :none) ("t" :required)))))))

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
-w        só mostra erros
-v        verbose (mostra tudo)
-h        help

* EXEMPLOS
roda todas as regressoes
  rameau-tests -t r

roda os corais 031 e 371
  rameau-tests -t c 031 371"))

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
      (directory (concat path (return-path type) "*.ly"))))

(defun main ()
  (destructuring-bind (raw-path (&rest file-list) opts-value raw-opts) (handle-args)
    (let* ((type (get-opt-value "t" opts-value))
           (path (concat raw-path "/"))
           (opts (mapcar #'(lambda (x) (char x 0)) raw-opts))
           (files (make-list-of-files path type file-list))
           )
      (cond
        ;; TODO lidar com combinacao de verbose e quiet
        ((and (null type) (null opts) (null files)) (print-help))
        ((find #\l opts) (print-tests))
        ((find #\h opts) (print-help))
        ((find #\a opts) (print-analise-harmonica files))
        ((and (find #\g opts) (find #\v opts)) (print-compara-gabarito files t))
        ((find #\v opts) (parse-verbose files))
        ((find #\g opts) (print-ok-no-list (print-compara-gabarito files)))
        ((find #\w opts) ())
        (t (print-ok-no-list (parse-summary files))))
      )))
