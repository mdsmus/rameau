#+sbcl(declaim (sb-ext:muffle-conditions warning style-warning sb-ext:compiler-note))

#+cmu(setf ext::*complain-about-illegal-switches* nil)

(declaim (optimize (compilation-speed 0)
                   (debug 3)
                   (safety 3)
                   (space 1)
                   (speed 1)))

(asdf:oos 'asdf:load-op :rameau :verbose nil)
(asdf:oos 'asdf:load-op :getopt :verbose nil)

(use-package :rameau)

(defparameter *print-only-wrong* nil)
(defparameter *use-cifras* nil)
(defparameter *debug* nil)

(defparameter *testes* '((corais "literatura/bach-corais/")
                         (kostka "literatura/kostka-payne/")
                         (sonatas "literatura/beethoven-sonatas/")
                         (exemplos "exemplos/")
                         (regressao "regressao/")
                         (lily "regressao-lily/")))

;;; As funções dependentes de implementação devem ficar aqui
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun get-args ()
  (let ((sbcl-args #+sbcl *posix-argv*)
        (cmu-args #+cmu extensions:*command-line-strings*)
        (clisp-args #+clisp *args*))
    (cond (sbcl-args (rest sbcl-args))
          (cmu-args (subseq cmu-args 3))
          (clisp-args clisp-args)
          )))

(defun get-path ()
  (format nil "~a" (or #+sbcl *default-pathname-defaults*
                       #+cmu (first (ext:search-list "default:"))
                       #+clisp (ext:default-directory))))

(defun rameau-profile ()
  #+sbcl(sb-profile:profile "RAMEAU")
  #+cmu(profile:profile-all :package "RAMEAU")
  )

(defun rameau-report ()
  #+sbcl(sb-profile:report)
  #+cmu(profile:report-time)
  )

(defun rameau-quit ()
  #+clisp(ext:exit)
  )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun print-gabarito (file gabarito algoritmo comparacao &optional notas)
  (let ((*package* (find-package :rameau)))
    (progn
      (format t "~% * ~a~%" file)
      (format t "gabarito (tamanho: ~a): ~(~s~) ~%" (length gabarito) (gera-gabarito gabarito))
      (format t "   pardo (tamanho: ~a): ~(~s~) ~%" (length algoritmo) (gera-gabarito algoritmo))
      (when notas (format t "   notas: ~(~s~) ~%" notas))
      (format t "correto?: ~:[não~;sim~]~%" comparacao))))

(defun gera-gabarito (gabarito)
  (if *use-cifras*
      (mapcar (lambda (x) (string->symbol (acorde->cifra x))) gabarito)
      gabarito))

(defun print-help ()
  (format t "uso: rameau [opções] [arquivos]

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
-m        profiler (mede a execução do código)
-u        roda os testes de unidade
-d        debug (experimental)
-h        help

* EXEMPLOS
roda todas as regressões:
  rameau -t r

roda os corais 031 e 371:
  rameau -t c 031 371

roda todos os exemplos, faz comparação das analises harmonicas com
gabarito, e mostra resultado em cifras:
  rameau -t e -vcg
"))

(defun print-compara-gabarito (files &optional verbose? print-notas?)
  (let (ok no)
    (dolist (file files)
      (multiple-value-bind (algoritmo segmento)
          (with-system rameau:tempered (gera-gabarito-pardo (parse-file file)))
        (let* ((gabarito (processa-gabarito
                          (tira-extensao file)))
               (comparacao (with-system rameau:tempered
                             (compara-gabarito-pardo algoritmo gabarito)))
               (notas (mapcar #'lista-notas segmento))
               (file-name (pathname-name file))
               (duracoes (mapcar (lambda (x y)
                                   (cons (evento-dur (first x))
                                        y))
                                 segmento algoritmo)))

          (when *debug* (format t "gabarito:~s~%pardo:~s~%" gabarito algoritmo))

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
            (t (error "não sei o que fazer!"))))))
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
        (serious-condition (expr)
          (declare (ignore expr))
          (push (pathname-name file) no))
        (:no-error (&rest rest)
          (declare (ignore rest))
          (push (pathname-name file) ok))))
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
  (append (list (get-path))
          (multiple-value-list
           (getopt:getopt (get-args)
                          '(("-h" :none) ("-g" :none) ("-w" :none)
                            ("-v" :none) ("-h" :none) ("-l" :none)
                            ("-p" :none) ("-u" :none) ("-d" :none)
                            ("-c" :none) ("-s" :none) ("t" :required))))))

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

(defun symbol->char (symbol)
  (char-downcase (coerce symbol 'character)))

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
                              `((and ,@(mapcar (lambda (o) `(find ,(symbol->char o) ,opts)) opt)) (,fn ,@args)))
                             ((eql opt t)
                              `(,opt (,fn ,@args)))
                              (t `((find ,(symbol->char opt) ,opts) (,fn ,@args))))))
                   body)))

(defmacro when-set-opt-true (opts &body body)
  "Atribui o valor de verdadeiro para cada uma das variáveis em body
se o caractere em body for encontrado em opts."
  `(progn
     ,@(mapcar (lambda (item) `(when (find ,(symbol->char (first item)) opts) (setf ,@(rest item) t))) body)))

(defmacro with-profile (var &body body)
  `(progn
     (when (find #\m ,var)
       (rameau-profile))
     ,@body
     (when (find #\m ,var)
       (rameau-report))))
  
(defun main ()
  (destructuring-bind (raw-path (&rest file-list) opts-value raw-opts) (handle-args)
    (let* ((type (get-opt-value "t" opts-value))
           (path (concat raw-path "/"))
           (opts (apply #'append (mapcar (lambda (c) (coerce c 'list)) raw-opts)))
           (files (make-list-of-files path type file-list)))

      ;;(print (list raw-path file-list opts-value raw-opts))
      
      (when-set-opt-true opts
        (w         *print-only-wrong*)
        (c         *use-cifras*)
        (d         *debug*))
      
      (with-profile opts
        (opt-cond opts print-help (type opts files)
          (h       print-help)
          (l       print-tests)
          (u       run-unit-tests)
          (a       print-analise-harmonica files)
          ((g v s) print-compara-gabarito files t t)
          ((g v)   print-compara-gabarito files t)
          ((v s)   print-compara-gabarito files nil t)
          (v       parse-verbose files)
          (g       print-ok-no-list (print-compara-gabarito files))
          (p       pop->cifra raw-path file-list)
          (t       print-ok-no-list (parse-summary files))))

      (rameau-quit)
      0)))
