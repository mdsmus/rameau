(declaim (sb-ext:muffle-conditions warning style-warning sb-ext:compiler-note))

(declaim (optimize (compilation-speed 0)
                   (debug 1)
                   (safety 1)
                   (space 3)
                   (speed 3)))

(asdf:oos 'asdf:load-op 'rameau :verbose nil)
(asdf:oos 'asdf:load-op 'getopt :verbose nil)

(use-package :rameau)

(defparameter *print-only-wrong* nil)
(defparameter *use-cifras* nil)

(defparameter *testes* '((corais "literatura/bach-corais/")
                         (kostka "literatura/kostka-payne/")
                         (sonatas "literatura/beethoven-sonatas/")
                         (exemplos "exemplos/")
                         (regressao "regressao/")
                         (lily "regressao-lily/")))

(defun print-gabarito (file gabarito algoritmo comparacao &optional notas)
  (progn
    (format t "~% * ~a~%" file)
    (format t "gabarito (tamanho: ~a): ~(~a~) ~%" (length gabarito) gabarito)
    (format t "   pardo (tamanho: ~a): ~(~a~) ~%" (length algoritmo) algoritmo)
    (when notas (format t "   notas: ~(~a~) ~%" notas))
    (format t "correto?: ~:[não~;sim~]~%" comparacao)))

(defun gera-gabarito (gabarito)
  (if *use-cifras*
      (mapcar #'acorde->cifra gabarito)
      gabarito))

(defun print-help ()
  (format t "uso: rameau-tests [opções] [arquivos]

* OPÇÕES
-p        gera gabaritos a partir de arquivos .pop
-t <nome> indica o nome do teste
-l        lista os testes disponíveis
-a        gera analise harmonica (sem comparar com gabarito)
-g        compara com gabarito (implica em -h)
-s        mostra as notas de cada segmento
-w        só mostra os testes que tem algum erro (implica em -v)
-c        mostra cifra dos acordes no lugar de listas
-v        verbose (mostra tudo)
-u        roda os testes de unidade
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

(defun print-compara-gabarito (files &optional verbose? print-notas?)
  (let (ok no)
    (dolist (file files)
      (let* ((algoritmo (gera-gabarito
                         (with-system rameau:tempered
                           (gera-gabarito-pardo (parse-file file)))))
             (gabarito (gera-gabarito (processa-gabarito
                                       (troca-extensao file ".gab"))))
             (comparacao (with-system rameau:tempered
                           (compara-gabarito-pardo algoritmo gabarito)))
             (notas (no-op (parse-file file)))
             (file-name (pathname-name file)))
        (cond
          (*print-only-wrong*
           (unless comparacao
             (print-gabarito file-name gabarito algoritmo comparacao)))
          ;; se o arquivo .gab não existir
          ((not gabarito)
           (format t "~&[ERRO] o gabarito de ~a não existe~%" (pathname-name file)))
          (print-notas?
           (print-gabarito file-name gabarito algoritmo comparacao notas))
          (verbose?
           (print-gabarito file-name gabarito algoritmo comparacao))
          (gabarito
           (if comparacao (push file-name ok) (push file-name no)))
          (t (error "não sei o que fazer!")))))
    (list (reverse ok) (reverse no))))
      
(defun print-analise-harmonica (files)
  (dolist (file files)
    (format t "~% * ~a~%" (pathname-name file))
    (format t "   pardo: ~(~a~) ~%" (gera-gabarito
                                     (with-system rameau:tempered
                                       (gera-gabarito-pardo (parse-file file)))))))

(defun parse-summary (files)
  (let (ok no)
    (dolist (file files)
      (handler-case (parse-file file)
        (serious-condition (expr) (push (pathname-name file) no))
        (:no-error (&rest rest) (push (pathname-name file) ok))))
    (list (reverse ok) (reverse no))))

(defun print-ok-no-list (list)
  (destructuring-bind (ok no) list
    (format t "[OK]: ~a [NO]: ~a ~@[~a ~]~%" (length ok) (length no) no)))

(defun parse-verbose (files)
  (dolist (file files)
    (handler-case (parse-file file)
    (serious-condition (expr) (format t "[NO] ~a: ~a~%" (pathname-name file) expr))
    (:no-error (&rest rest) (format t "[OK] ~a ~a~%" (pathname-name file) rest)))))
  
(defun handle-args ()
  "O script passa os argumentos na ordem: sbcl path comandos"
  (let ((command-args (rest *posix-argv*))
        (path (format nil "~a" *default-pathname-defaults*)))
    (append (list path)
            (multiple-value-list
             (getopt:getopt command-args
                            '(("-h" :none) ("-g" :none) ("-w" :none)
                              ("-v" :none) ("-h" :none) ("-l" :none)
                              ("-p" :none) ("-u" :none)
                              ("-c" :none) ("-s" :none) ("t" :required)))))))

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

(defun pop->cifra (path f)
  (let* ((full-path (concat path "literatura/bach-corais/"))
         (files (if f
                    (loop for file in f collect (concat full-path (add-pop-ext file)))
                    (loop for file in (directory (concat full-path "*.pop"))
                       collect (format nil "~a" file)))))
    (loop for file in files do
         (if (cl-fad:file-exists-p file)
             (progn
               (format t "... gerando gabarito ~a~%" (pathname-name file))
               (gera-gabarito-file file))
             (format t "arquivo ~a não existe~%" file)))))

(defun run-unit-tests ()
  (lisp-unit:run-all-tests :rameau)
  (format t "~%"))

(defmacro opt-cond (opts help-fn null-vars &body body)
  "Gera um cond para lidar com opções do programa. opts indica a
variável que guarda as opções, help-fn a função caso as variáveis em
null-vars sejam nulas (ou seja, o usuário não as especificou. body
deve obedecer ao formato (<opção> <função> <argumentos>). Se <opção>
for uma lista assume que é para concetar com 'and'."
  `(cond ((and ,@(mapcar (lambda (item) `(null ,item)) null-vars)) (,help-fn))
         ,@(mapcar (lambda (item)
                     (destructuring-bind (opt fn &rest args) item
                       (cond ((listp opt)
                              `((and ,@(mapcar (lambda (o) `(find ,o ,opts)) opt)) (,fn ,@args)))
                             ((eql opt t)
                              `(,opt (,fn ,@args)))
                              (t `((find ,opt ,opts) (,fn ,@args))))))
                   body)))

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

      (opt-cond opts print-help (type opts files)
        (#\h           print-help)
        (#\l           print-tests)
        (#\u           run-unit-tests)
        (#\a           print-analise-harmonica files)
        ((#\g #\v #\s) print-compara-gabarito files t t)
        ((#\g #\v)     print-compara-gabarito files t)
        ((#\v #\s)     print-compara-gabarito files nil t)
        (#\v           parse-verbose files)
        (#\g           print-ok-no-list (print-compara-gabarito files))
        (#\p           pop->cifra raw-path file-list)
        (t             print-ok-no-list (parse-summary files)))
  0)))
