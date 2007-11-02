#+sbcl(declaim (sb-ext:muffle-conditions warning style-warning sb-ext:compiler-note))

#+cmu(setf ext::*complain-about-illegal-switches* nil)

(declaim (optimize (compilation-speed 0)
                   (debug 3)
                   (safety 3)
                   (space 1)
                   (speed 1)))

(asdf:oos 'asdf:load-op :rameau :verbose nil)

(use-package :rameau)

;;; As funções dependentes de implementação devem ficar aqui
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun rameau-args ()
  (let ((sbcl-args #+sbcl *posix-argv*)
        (cmu-args #+cmu extensions:*command-line-strings*)
        (clisp-args #+clisp *args*))
    (cond (sbcl-args (rest sbcl-args))
          (cmu-args (subseq cmu-args 3))
          (clisp-args clisp-args)
          )))

(defun rameau-path ()
  (format nil "~a" (or #+sbcl *default-pathname-defaults*
                       #+cmu (first (ext:search-list "default:"))
                       #+clisp (ext:default-directory))))

(defun rameau-profile ()
  #+sbcl(sb-profile:profile "RAMEAU")
  #+cmu(profile:profile-all :package "RAMEAU"))

(defun rameau-report ()
  #+sbcl(sb-profile:report)
  #+cmu(profile:report-time))

(defun rameau-quit ()
  #+clisp(ext:exit)
  #+sbcl(quit))

(shadow 'report)

(defun report ()
  "Report results from profiling. The results are approximately adjusted
for profiling overhead. The compensation may be rather inaccurate when
bignums are involved in runtime calculation, as in a very-long-running
Lisp process."
  (unless (boundp '*overhead*)
    (setf *overhead*
          (compute-overhead)))
  (let ((time-info-list ())
        (no-call-name-list ()))
    (dohash (name pinfo *profiled-fun-name->info*)
      (unless (eq (fdefinition name)
                  (profile-info-encapsulation-fun pinfo))
        (warn "Function ~S has been redefined, so times may be inaccurate.~@
               PROFILE it again to record calls to the new definition."
              name))
      (multiple-value-bind (calls ticks consing profile)
          (funcall (profile-info-read-stats-fun pinfo))
        (if (zerop calls)
            (push name no-call-name-list)
            (push (make-time-info :name name
                                  :calls calls
                                  :seconds (compensate-time calls
                                                            ticks
                                                            profile)
                                  :consing consing)
                  time-info-list))))

    (setf time-info-list
          (sort time-info-list
                #'>=
                :key #'time-info-seconds))
    (print-profile-table time-info-list)

    (values)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defparameter max-print-error 10
  "Quando o numero de arquivos que não são parseados é maior que essa
  constante, rameau mostra apenas o inicio da lista.")

(defparameter *help* '((todos
                        (("-h" "ajuda")
                         ("-f" "arquivos")
                         ("-p" "profile")
                         ("-d" "debug")
                         ("-v" "verbose")
                         ("-m n" "o número de testes errados para imprimir")))
                       (análise
                        (("-a" "gera análise harmônica (padrão)")
                         ("-g" "compara com gabarito")
                         ("-n" "mostra as notas de cada segmento" "-v")
                         ("-d" "mostra as durações de cada segmento" "-v")
                         ("-l" "mostra formato de gabarito como listas" "-v")
                         ("-e" "só mostra os testes que tem erro" "-v")
                         ("-c" "só mostra os testes corretos" "-v")
                         ("-i" "ignora (não imprime) corais sem gabaritos")))))

(defparameter *lily-dir-list* '(("corais" "literatura/bach-corais/")
                                ("kostka" "literatura/kostka-payne/")
                                ("sonatas" "literatura/beethoven-sonatas/")
                                ("exemplos" "exemplos/")
                                ("regressao" "regressao/")
                                ("lily" "regressao-lily/")))

(defparameter *dados* '((teste ("unidade" "regressao" "lily"))
                        (analise ("corais" "kostka" "sonatas" "exemplos"))))

(defun get-item (item lista &optional (test #'eql))
  (second (assoc item lista :test test)))

(defun split-word (word)
  (loop for char across word collect (char->symbol char)))

(defun char->symbol (char)
  (intern (string-upcase (string char))))

(defun split-opts (string)
  (mapcan (lambda (s) (split-word (delete #\- s)))
          (cl-ppcre:split #\Space string)))

(defun split-dados (dados)
  (cl-ppcre:split "," dados))

(defmacro with-profile (var &body body)
  `(progn
     (when (member 'p ,var)
       (rameau-profile))
     ,@body
     (when (member 'p ,var)
       (rameau-report))))

(defun next-flag (list)
  (loop for x in (rest list) do
       (if (equal #\- (aref x 0))
           (return x))))

(defun pos (list)
  (aif (position (next-flag list) list :test #'string=) it 0))

(defun arg->list (list)
  (when list
    (if (next-flag list)
        (let ((p (pos list)))
          (cons (subseq list 0 p)
                (arg->list (nthcdr p list))))
        (list list))))

(defun get-lone-flags (list)
  (exclude-repetition
   (mapcan (lambda (item) (split-opts (first item)))
           (remove-if-not (lambda (item) (= (length item) 1)) list))))

(defun get-flag-list (flag list)
  (rest (assoc flag list :test #'string=)))

(defun maptrace (lista-string)
  (eval (append '(trace) (mapcar #'string->symbol lista-string))))

(defun get-comandos ()
  (mapcar #'(lambda (item) (format nil "~(~a~)" (first item))) *dados*))

(defun print-condition (status file expr)
  (format t "[~a] ~a: ~a~%" status (pathname-name file) expr))

(defun print-ok/no-list (list)
  (destructuring-bind (ok no) list
    (let* ((s2 (length no))
           (no-string
            (cond ((= max-print-error 0) no)
                  ((> s2 max-print-error)
                   (format nil "~a ..." (subseq no 0 max-print-error)))
                  (t no))))
      (format t "  [OK]: ~a [NO]: ~a ~@[~a ~]~%" (length ok) s2 no-string))))

(defun print-gabarito (file gabarito algoritmo comparacao flags &key notas dur)
  (let ((*package* (find-package :rameau)))
    (progn
      (format t "~% * ~a~%" file)
      (format t "gabarito (~a): ~(~s~) ~%" (length gabarito) gabarito)
      (format t "   pardo (~a): ~(~s~) ~%" (length algoritmo) algoritmo)
      (when (member 'n flags) (format t "   notas: ~(~a~) ~%" notas))
      (when (member 'd flags) (format t "   dur: ~(~a~) ~%" dur))
      (format t "correto?: ~:[não~;sim~]~%" comparacao))))

(defun print-help-item (item)
  (format t "~%~(* [~a]~)~%" item)
  (dolist (line (get-item item *help*))
    (destructuring-bind (flag string &optional v) line
      (format t "  ~6a~a ~@[(implica em ~a)~]~%" flag string v))))
  
(defun print-help ()
  (format t "USO: rameau <ação> [dados] [opções]~%~%")
  (dolist (item *dados*)
    (format t "     ~10a~{~a~^,~}~%" (first item) (second item)))
  (print-help-item 'todos)
  (print-help-item 'análise)
  (rameau-quit))

(defun parse-verbose (files)
  (dolist (file files)
    (handler-case (parse-file file)
      (serious-condition (expr) (print-condition 'no file expr))
      (:no-error (&rest rest) (print-condition 'ok file rest)))))

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

(defun files-range (list)
  (loop for x from (parse-integer (first list)) to (parse-integer (second list))
     collect (cond ((< x 10)  (format nil "00~a" x))
                   ((< x 100) (format nil "0~a" x))
                   (t (format nil "~a" x)))))

(defun first-string (string list)
  (let ((tmp (loop for s in list do
                  (if (string= (subseq s 0 1) string)
                      (return s)))))
    (if tmp tmp string)))

(defun run-regressao (flags files)
  (if (member 'v flags)
      (parse-verbose files)
      (print-ok/no-list (parse-summary files))))

(defun run-unidade (flags files)
  (let ((string-result
         (with-output-to-string (string)
           (let ((*standard-output* string))
             (lisp-unit:run-all-tests :rameau)
             (format t "~%")))))    
    (if (member 'v flags)
        (write-line string-result)
        (write-line (subseq (last1 (cl-ppcre:split "\\n" string-result)) 34)))))

(defun run-analise-harmonica (files)
  (dolist (file files)
    (let ((resultado (with-system rameau:tempered
                       (gera-gabarito-pardo (parse-file file)))))
      (format t "~%  * ~a: [pardo] ~(~a~) ~%" (pathname-name file) resultado))))

(defun run-compara-gabarito (flags files)
  (let (ok no)
    (dolist (file files)
      (multiple-value-bind (algoritmo segmento)
          (with-system rameau:tempered (gera-gabarito-pardo (parse-file file)))
        (let* ((file-name (pathname-name file))
               (gabarito (processa-gabarito (tira-extensao file)))
               (notas (with-system rameau:tempered (mapcar #'lista-notas segmento)))
               (comparacao (with-system rameau:tempered
                             (compara-gabarito-pardo algoritmo gabarito)))
               (duracoes (mapcar (lambda (x y) (list y (evento-dur (first x))))
                                 segmento algoritmo)))
          (cond
            ((member 'e flags)
             (unless comparacao
               (push 'v flags)
               (print-gabarito file-name gabarito algoritmo comparacao
                               flags :dur duracoes :notas notas)))
            ((member 'c flags)
             (push 'v flags)
             (when comparacao
               (print-gabarito file-name gabarito algoritmo comparacao
                               flags :dur duracoes :notas notas)))
            ((and (not gabarito) (not (member 'i flags)))
             (format t "~&[ERRO] o gabarito de ~a não existe~%" file-name))
            ((or (member 'v flags) (member 'n flags) (member 'd flags))
             (push 'v flags)
             (print-gabarito file-name gabarito algoritmo comparacao
                             flags :dur duracoes :notas notas))
            (gabarito
             (if comparacao (push file-name ok) (push file-name no)))))))
    (unless (member 'v flags)
      (print-ok/no-list (list (reverse ok) (reverse no))))))

(defun run-analise (flags files)
  (when (and (member 'a flags) (member 'g flags))
    (write-line "As opções -a e -g não podem ser dadas ao mesmo tempo")
    (rameau-quit))
  (if (member 'g flags)
      (run-compara-gabarito flags files)
      (run-analise-harmonica files)))

(defun processa-files (item f &optional (ext ".ly"))
  (let* ((path (concat (rameau-path) (get-item item *lily-dir-list*  #'equal)))
         (file-name (format nil "~a" (first f)))
         (files (if (search ".." file-name)
                    (files-range (cl-ppcre:split "\\.\\." file-name))
                    f)))
    (if files
        (mapcar (lambda (file) (concat path file ext)) files)
        (mapcar (lambda (file) (format nil "~a" file)) (directory (concat path "*" ext))))))

(defmacro defcomando (nome dados flags files &body body)
  `(defun ,nome (,dados ,flags ,files)
     (let* ((dados-list (get-item ',nome *dados*))
            (comandos-lista (if (string= ,dados "all") dados-list (split-dados ,dados))))
       (with-profile ,flags
         (loop
            for i in comandos-lista
            for item = (first-string i dados-list) do
              (if (member item dados-list :test #'string=)
                  (progn
                    (format t "~%* ~(~a~): ~(~a~)~%" ',nome item)
                    ,@body)
                  (progn
                    (format t "~a não é um comando de ~(~a~).~%" item ',nome)
                    (format t "comandos possíveis são: all ~{~a ~}~%" dados-list))))))))

(defcomando teste dados flags files
    (if (string= item "unidade")
        (run-unidade flags (processa-files item files))
        (run-regressao flags (processa-files item files))))

(defcomando analise dados flags files
  (run-analise flags (processa-files item files)))

(defun main ()
  (let* ((args (rameau-args))
         (string (first args))
         (dados (second args))
         (comando (if string (first-string string (get-comandos))))
         (flags-list (if (> (length args) 2) (arg->list (subseq args 2))))
         (files (get-flag-list "-f" flags-list))
         (trace (get-flag-list "-t" flags-list))
         (max-error (first (get-flag-list "-m" flags-list)))
         (flags (if flags-list (get-lone-flags flags-list))))

    (maptrace trace)
    
    (when max-error (setf max-print-error (read-from-string max-error)))

    (when (member 'h flags) (print-help))
    
    (cond ((null comando) (print-help))
          ((equal comando "help") (print-help))
          ((equal comando "-h") (print-help))
          ((and comando (null dados))
           (if (string= comando "teste")
               (funcall (read-from-string comando) "all" flags files)
               (progn
                 (format t "comando ~a não reconhecido~%" comando)
                 (format t "você deve entrar um dos comandos: ~{~(~a~)~^ ~}~%" (get-comandos)))))
          ((member comando (get-comandos) :test #'string=)
           (funcall (read-from-string comando) dados flags files))
          (t (format t "comando ~a não reconhecido~%" comando)
             (format t "você deve entrar um dos comandos: ~{~(~a~)~^ ~}~%" (get-comandos)))))
  0)
