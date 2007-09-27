(declaim (sb-ext:muffle-conditions warning style-warning sb-ext:compiler-note))

(defun asdf-all (packages)
  (dolist (package packages) (asdf:oos 'asdf:load-op package :verbose nil)))

(load "src/rameau.asd")

(asdf-all '(lexer yacc getopt cl-fad cl-ppcre rameau))

(use-package :rameau)

(defparameter *print-only-wrong* nil)
(defparameter *use-cifras* nil)

(defparameter *testes* '((corais "literatura/bach-corais/")
                         (kostka "literatura/kostka-payne/")
                         (sonatas "literatura/beethoven-sonatas/")
                         (exemplos "exemplos/")
                         (regressao "regressao/")
                         (lily "regressao-lily/")))


(defun add-lily-ext (file)
  (if (tem-ext? file) file (concat file ".ly")))

(defun tem-ext? (file)
  (find #\. file))
  

(defun print-gabarito (file gabarito algoritmo comparacao &optional notas)
  (progn
    (format t "~% * ~a~%" file)
    (format t "gabarito: ~(~a~) ~%" gabarito)
    (format t "   pardo: ~(~a~) ~%" algoritmo)
    (when notas (format t "   notas: ~(~a~) ~%" notas))
    (format t "correto?: ~:[não~;sim~]~%" comparacao)))

(defun gera-gabarito (gabarito)
  (if *use-cifras*
      (mapcar #'acorde->cifra gabarito)
      gabarito))

(defun tira-extensao (file)
  (subseq file 0 (position #\. file)))


(defun troca-extensao (file ext)
  (concat (tira-extensao file) ext))

(defun print-compara-gabarito (files &optional verbose? print-notas?)
  (let (ok no)
    (dolist (file files)
      (let* ((algoritmo (gera-gabarito
                         (with-system rameau:tempered
                           (gera-gabarito-pardo (parse-file file)))))
             (gabarito (gera-gabarito (processa-gabarito
                                       (troca-extensao file ".gab"))))
             (comparacao (compara-gabarito-pardo algoritmo gabarito))
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
  (let ((command-args (subseq *posix-argv* 2))
        (path (second *posix-argv*)))
    (append (list path)
            (multiple-value-list
             (getopt:getopt command-args
                            '(("-h" :none) ("-g" :none) ("-w" :none)
                              ("-v" :none) ("-h" :none) ("-l" :none)
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
        ((find #\l opts) (print-tests))
        ((find #\a opts) (print-analise-harmonica files))
        ((and (find #\g opts) (find #\v opts) (find #\s opts))
         (print-compara-gabarito files t t))
        ((and (find #\g opts) (find #\v opts))
         (print-compara-gabarito files t))
        ((find #\v opts) (parse-verbose files))
        ((find #\g opts) (print-ok-no-list (print-compara-gabarito files)))
        (t (print-ok-no-list (parse-summary files))))
      )))
