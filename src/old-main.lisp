(defpackage :rameau-main
  (:import-from #:arnesi "AIF" "AWHEN" "IT" "LAST1")
  (:use :rameau :cl :cl-ppcre :lisp-unit :iterate)
  (:export :main :check))

(in-package :rameau-main)

(defparameter *commands*
  '(("common-flags"
     (("-h" "help" "ajuda")
      ("-f" "files" "arquivos" list)
      ("-p" "profile" "profile" list)
      ("-a" "algorithms" "Usa <algoritmos> para fazer a análise" list)
      ("-d" "debug" "ativa código de depuração para os itens i" list)
      ("-v" "verbose" "verbose")
      ("-t" "trace" "mostra o trace de <funções>" list)
      ;;("-q" "quiet" "quiet")
      ("-m" "max-print-error" "Quando o numero de arquivos que não são
  parseados é maior que essa constante, rameau mostra apenas o start
  da lista.")))
    ("analysis"
     (("-u" "show-dur" "")
      ("-n" "show-notes" "")
      ("-i" "ignore" "ignora (não imprime) corais sem gabaritos")
      ("-c" "no-color" "don't use color in the answer")
      ("-s" "column-chord-size" "")
      ("" "column-number-size" "")
      ("" "column-notes-size" "")
      ("" "column-dur-size" "")
      ("" "column-separator" "")
      ("" "wrong-answer-color" "")))
    ("test"
     (("-u" "unit" "")
      ("-r" "regression" "")))
    ("check")
    ("gui"))
  "The star at the end indicates that the flag accepts multiple values.")

(defun parse-options (command list)
  "Parse the list of options to a structure."
  (loop for item in (sublist-of-args list) append
       (destructuring-bind (flag &rest value) item
         (list (cond ((long-flag? flag)
                      (%string->symbol (get-long-flag-name command flag) :keyword))
                     ((short-flag? flag)
                      (%string->symbol (get-short-flag-name command flag) :keyword)))
               (if value
                   (if (get-star-in-flag command flag)
                       value
                       (first value))
                   t)))))

(defun rameau-args ()
  (let ((sbcl-args #+sbcl sb-ext:*posix-argv*)
        (cmu-args #+cmu extensions:*command-line-strings*)
        (clisp-args #+clisp ext:*args*))
    (cond (sbcl-args (rest sbcl-args))
          (cmu-args (subseq cmu-args (1+ (position "cmurameau" cmu-args :test #'string=))))
          (clisp-args clisp-args))))

(defmacro with-profile (args &body body)
  `(progn
     (when (args-profile ,args)
       (rameau-profile))
     ,@body
     (when (args-profile ,args)
       (rameau-report))))

(defun maptrace (lista-string &optional (trace 'trace))
  (eval (append (list trace) (mapcar2 #'read-from-string #'string-upcase lista-string))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun print-answer (&key file sheet results dur notes)
  (mapcar #'(lambda (s r d n) (format t "~10a ~10a ~10a ~10a~%" s r d n))
          sheet (first results) dur notes))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defstruct analysis
  segments results answer-sheet file-name notes dur size-answer-sheet
  number-algorithms)

(defun analyse-files (options)
  (loop
     for file in (args-files options)
     for segments = (sonorities (parse-file file))
     collect
       (make-analysis
        :segments segments
        :results (mapcar #'(lambda (algo) (funcall (algorithm-classify algo) segments))
                         (args-algorithms options))
        :answer-sheet (new-parse-answer-sheet (pathname-name file) "chora") ;;==========================
        :file-name (pathname-name file)
        :number-algorithms (length (args-algorithms options))
        :notes (mapcar #'list-events segments)
        :dur (durations segments))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 (defun print-help ()
   (let ((*package* (find-package :rameau-main)))
     (print (get-commands-assoc))
     (rameau-quit)))

(defun print-warning (message)
  (format t "WARNING: ~a~%" message))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun print-condition (status file expr)
  (format t "[~a] ~a: ~a~%" status (pathname-name file) expr))

(defun print-ok/no-list (list)
  (destructuring-bind (ok no) list
    (let* ((s2 (length no))
           (no-string
            (cond ((= max-print-error 0) no)                  ((> s2 max-print-error)
                   (format nil "~a ..." (subseq no 0 max-print-error)))
                  (t no))))
      (format t "  [OK]: ~a [NO]: ~a ~@[~a ~]~%" (length ok) s2 no-string))))

(defun parse-verbose (files)
  (dolist (file files)
    (handler-case (parse-file file)
      (serious-condition (expr) (print-condition 'no file expr))
      (:no-error (&rest rest) (print-condition 'ok file rest)))))

(defun run-algorithm (algorithm answer sheet)
  (compare-answer-sheet answer sheet (algorithm-tempered? algorithm)))

(defun percent (x total)
  (unless (= 0 total)
    (/ (* x 100.0) total)))

(defmacro with-profile (var &body body)
  `(progn
     (when (member 'p ,var)
       (rameau-profile))
     ,@body
     (when (member 'p ,var)
       (rameau-report))))

(defun frac->dur-lily (dur)
  "Converte de fração para duração em lilypond. É muito simples, não
lida com quiáltera nem mais que 1 ponto, felizmente não tem mais de 1
ponto nos corais de bach."
  (let ((numer (numerator (abs dur)))
        (denom (denominator (abs dur))))
    (cond ((= numer 1) (format nil "~a" denom))
          ((= numer 3) (format nil "~a." (/ denom 2)))
          (t (error "duracao invalida")))))

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

(defun regression (options)
  (if (args-verbose options)
      (parse-verbose (args-files options))
      (print-ok/no-list (parse-summary (args-files options)))))

(defun print-duracoes (segmento)
  (values (loop for s = segmento then (rest s)
            unless s return res
            collect (frac->dur-lily (event-dur (first (first s)))) into res
            unless (= 0 (intervalo (first s) (second s)))
            collect (frac->dur-lily (intervalo (first s) (second s))) into res)
          (when (< 0 (event-start (first (first segmento))))
            (let ((n (frac->dur-lily (abs (event-start (first (first segmento)))))))
              (if (listp n)
                  n
                  (list n))))))

(defun print-score (stream lyric)
  (format stream "\\score {
  <<
    \\new Staff {
      <<
        \\global
        \\new Voice = \"soprano\" { \\voiceOne \\soprano }
        \\new Voice = \"alto\" { \\voiceTwo \\alto }
      >>
    }
    \\new Staff {
      <<
        \\global
        \\clef \"bass\"
        \\new Devnull= \"nowhere\" \\texto
        \\new Voice = \"tenor\" {\\voiceOne \\tenor }
        \\new Voice = \"baixo\" { \\voiceTwo \\baixo \\bar \"|.\"}
      >>
    }
   ~a
  >>

  \\layout {
    \\context {
      \\Lyrics
      \\override LyricSpace #'minimum-distance = #1.0
      \\override LyricText #'font-size = #-1
      \\override LyricText #'font-family = #'roman
    }
  }
  \\midi {}
}~%~%" lyric))

(defun print-lyric (name)
  (format nil "\\new Lyrics \\lyricsto \"nowhere\" \\~a~%" (remove #\- name)))

(defmacro with-print-cifra ((stream name) &body body)
  `(progn
     (format ,stream "~a = \\lyricmode {~%  \\set stanza = \"~:(~a~):\"~%"
             (remove #\- ,name)
             (substitute #\Space #\- ,name))
     ,@body
     (format ,stream "~%}~%~%")))

(defun print-lily (file item gabarito resultados flags notas)
  "[DONTCHECK]"
  (declare (ignore flags))
  (let* ((*package* (find-package :rameau))
         (path (concat *rameau-path*
                       (get-item (concat item "-include") *lily-dir-list*  #'equal)))
         (file-name (pathname-name file))
         (dir (get-item item *lily-dir-list* #'equal))
         (out-file (format nil "~a/~a/~a-~a.ly" *rameau-path* dir (item-singular item) file-name)))
    (with-open-file (stream out-file :direction :output :if-exists :supersede)
      (format stream "~a~%" (file-string (concat path file-name ".lyi")))
      (multiple-value-bind (durs first-rest) (print-duracoes notas)
        (if first-rest
            (format stream "texto = {~{s~a ~} ~{c~a ~}}~%~%" first-rest durs)
            (format stream "texto = {~{c~a ~}}~%~%" durs)))
      (when gabarito
        (with-print-cifra (stream "Answer")
          (loop for i in gabarito
             for s = notas then (rest s)
             unless s return it
             do (format stream "\"~a\" ~%" i)
             unless (= 0 (intervalo (first s) (second s)))
             do (format stream "\" \" "))))
      (loop for a in *algorithms*
         for r in resultados do
           (with-print-cifra (stream (algorithm-name a))
             (loop
                for alg-lista = r then (rest alg-lista)
                for gab-lista = gabarito then (rest gab-lista)
                for s = notas then (rest s)
                for res = (first alg-lista) then (first alg-lista)
                for gab = (first gab-lista) then (first gab-lista)
                unless s return 0
                unless alg-lista return 0
                if (run-algorithm a res gab) do
                  (format stream "\"~a\" " (if res res " "))
                else do
                  (format stream
                          ;;"\\markup{\\roman \\italic \\bold \"~a\"}"
                          "\\markup{\\bold \\with-color #(x11-color 'red) \"~a\"}"
                          (if res res " "))
                unless (= 0 (intervalo (first s) (second s))) do
                  (format stream "\" \""))))
      (with-print-cifra (stream "sonority")
        (loop for x from 1
           for s = notas then (rest s)
           unless s return 0
           do (format stream "\"~a\" " x)
           unless (= 0 (intervalo (first s) (second s)))
           do (format stream "\" \" ")))
      (print-score stream (reduce #'concat
                                  (append
                                   (list (print-lyric "sonority"))
                                   (loop for a in *algorithms* collect
                                        (print-lyric (algorithm-name a)))
                                   (list
                                    (when gabarito
                                      (print-lyric "Answer")))))))))

(defun print-gabarito (arquivo gabarito resultados flags &key notas dur)
  (let ((*package* (find-package :rameau))
        (size-gab (length gabarito)))
    (format t "~a:~%" arquivo)
    (print-gab-columns "#" "notas" "gab" "dur" flags)
    (loop
       for a in *algorithms*
       do (print-res-alg (subseq (algorithm-name a) 0 (min 5 (length (algorithm-name a)))) "ok?" flags))
    (format t "~%")
    (write-line (repeat-string 87 "-"))
    (let ((counts (repeat-list (length *algorithms*) 0)))
      (loop
         for n in notas
         for d in dur
         for numero-seg from 0
         for gab-lista = gabarito then (cdr gab-lista)
         for gab = (car gab-lista) then (car gab-lista)
         for res = resultados then (advance-all res)
         do
           (print-gab-columns (1+ numero-seg) n gab d flags)
           (loop
              for a in *algorithms*
              for i from 0
              for r in res
              for alg = (first r) then (first r)
              for certo? = (run-algorithm a alg gab)
              then (run-algorithm a alg gab)
              do (print-res-alg alg certo? flags)
              when certo? do (incf (nth i counts)))
           (format t "~%"))
      (format t "~% correto:~%")
      (let ((l (loop
                  for i in counts
                  for a in *algorithms*
                  collect (list (algorithm-name a) (percent i size-gab)))))
        (loop for (name value) in (sort l #'> :key #'second) do
             (format t "  ~(~15a~) ~,2f%~%" name value))))))


(defun gera-dados (item gabarito resultados flags)
  (declare (ignore flags))
  (let ((*package* (find-package :rameau))
        (size-gab (length gabarito))
        (corretos (repeat-list (length *algorithms*) 0))
        (total 0))
    (let ((counts (repeat-list (length *algorithms*) 0)))
      (loop
         for numero-seg from 0 to (1- size-gab)
         for gab-lista = gabarito then (cdr gab-lista)
         for gab = (car gab-lista) then (car gab-lista)
         for res = resultados then (advance-all res)
         do
           (incf total)
           (loop
              for a in *algorithms*
              for i from 0
              for r in res
              for alg = (first r) then (first r)
              for certo? = (run-algorithm a alg gab)
              then (run-algorithm a alg gab)
              when certo? do (incf (nth i counts)) (incf (nth i corretos))))
      (let ((l (loop
                  for i in counts
                  for a in *algorithms*
                  collect (list (algorithm-name a) (percent i size-gab) i))))
        (loop for (name perc correct) in (sort l #'> :key #'second) do
             (format t "~a  ~(~15a~) ~5a ~5a ~,2f%~%" item name correct (- size-gab correct) perc)))
      (values total corretos (loop for i in counts collect (percent i size-gab))))))

(defun gera-erros (item notas gabarito resultados flags regab reres erros?)
  (declare (ignore flags))
  (let ((*package* (find-package :rameau))
        (size-gab (length gabarito)))
    (loop
       for numero-seg from 0 to (1- size-gab)
       for gab-lista = gabarito then (cdr gab-lista)
       for gab = (car gab-lista) then (car gab-lista)
       for res = resultados then (advance-all res)
       for s in notas
       do
         (loop
            for a in *algorithms*
            for i from 0
            for r in res
            for alg = (first r) then (first r)
            for certo? = (run-algorithm a alg gab)
            do (if (or (and certo? (not erros?))
                       (and erros? (not certo?)))
                   (when (and
                          (cl-ppcre:scan regab (format nil "~a" gab))
                          (cl-ppcre:scan reres (format nil "~a" alg)))
                     (format t "~a| ~20a| ~4a| ~14a| ~12a| ~4a~%"
                             item
                             (algorithm-name a)
                             numero-seg
                             s
                             gab
                             alg)))))))

(defun gera-resultados (item notas gabarito resultados flags regab reres)
  (declare (ignore flags))
  (let ((*package* (find-package :rameau))
        (size-gab (length gabarito)))
    (loop
       for numero-seg from 0 to (1- size-gab)
       for gab-lista = gabarito then (cdr gab-lista)
       for gab = (car gab-lista) then (car gab-lista)
       for res = resultados then (advance-all res)
       for s in notas
       do
         (loop
            for a in *algorithms*
            for i from 0
            for r in res
            for alg = (first r) then (first r)
            do (when (and
                      (cl-ppcre:scan regab (format nil "~a" gab))
                      (cl-ppcre:scan reres (format nil "~a" alg)))
                 (format t "~a| ~20a| ~4a| ~14a| ~12a| ~4a~%"
                         item
                         (algorithm-name a)
                         numero-seg
                         s
                         gab
                         alg))))))

(defun print-help-item (item)
  (format t "~%~(* [~a]~)~%" item)
  (dolist (line (get-item item *help*))
    (destructuring-bind (flag string &optional v) line
      (format t "  ~6a~a ~@[(implica em ~a)~]~%" flag string v))))
  
(defun print-help ()
  (format t "USO: rameau <ação> [dados] [opções]~%~%")
  (dolist (item *dados*)
    (format t "     ~13a~{~a~^,~}~%" (first item) (second item)))
  (dolist (item (mapcar #'first *help*))
    (print-help-item item))
  (rameau-quit))

(defun run-regressao (flags files)
  (if (member 'v flags)
      (parse-verbose files)
      (print-ok/no-list (parse-summary files))))

(defun run-unidade (flags files)
  (declare (ignore files))
  (let ((string-result
         (with-output-to-string (string)
           (let ((*standard-output* string))
             (lisp-unit:run-all-tests :rameau)
             (format t "~%")))))    
    (if (args-verbose options)
        (write-line string-result)
        (write-line (subseq (last1 (cl-ppcre:split "\\n" string-result)) 34)))))


(defun run-compara-gabarito (flags files item)
  (dolist (file files)
    (let* ((musica (parse-file file))
           (segmentos (sonorities musica))
           (resultados (loop for a in *algorithms* collect
                            (funcall (algorithm-classify a) segmentos)))
           (gabarito (parse-answer-sheet (remove-ext file) item))
           (file-name (pathname-name file))
           (notas (mapcar #'list-events segmentos))
           (duracoes (durations segmentos)))
      (format t "tamanhos:~%  gabarito: ~a~%" (length gabarito))
      (loop for i in resultados
         for a in *algorithms*
         do (format t "  ~a: ~a~%" (algorithm-name a) (length i)))
      (cond
        ((and (not gabarito) (not (member 'rameau::i flags)))
         (format t "~&[ERRO] o gabarito de ~a não existe~%" file-name))
        (t
         (print-gabarito file-name gabarito resultados
                         flags :dur duracoes :notas notas))))))

(defun run-gera-dados (flags files item)
  (format t "Coral Algoritmo Corretos Incorretos Percentual~%")
  (let ((corretos (repeat-list (length *algorithms*) 0))
        (total 0)
        (processados 0)
        (media-x (repeat-list (length *algorithms*) 0.0))
        (media-x² (repeat-list (length *algorithms*) 0.0)))
    (dolist (file files)
      (let* ((musica (parse-file file))
             (segmentos (sonorities musica))
             (gabarito (parse-answer-sheet (remove-ext file) item))
             (resultados (when gabarito
                           (loop for a in *algorithms* collect
                                (funcall (algorithm-classify a) segmentos))))
             (file-name (pathname-name file))
             (notas (mapcar #'list-events segmentos))
             (duracoes (durations segmentos)))
        (when (or gabarito (member 'i flags))
           (multiple-value-bind (total1 corretos1 percentuais)
               (gera-dados file-name gabarito resultados flags)
             (incf total total1)
             (incf processados)
             (loop for i from 0 to (1- (length percentuais))
                do
                  (incf (nth i media-x) (nth i percentuais))
                  (incf (nth i media-x²) (* (nth i percentuais) (nth i percentuais))))
             (loop for i from 0 to (1- (length corretos))
                do (incf (nth i corretos) (nth i corretos1)))))))
    (let ((l (loop
                for i in corretos
                for a in *algorithms*
                for mx in media-x
                for mx² in media-x²
                collect (list (algorithm-name a)
                              i
                              (- total i)
                              (percent i total)
                              (or (= 0 processados) (/ mx processados))
                              (or (= 0 processados)
                                  (sqrt (- (/ mx² processados)
                                           (* (/ mx processados)
                                              (/ mx processados)))))))))
      (loop for r in (sort l #'> :key #'second)
         do (apply #'format t "Total ~(~15a~):  ~5a ~5a ~,2f% (~,2f +- ~,2f)~%" r)))))

(defun run-gera-erros (flags files item regexps &optional erros?)
  (format t "Coral Algoritmo Segmento Resultado_esperado Resultado_obtido~%")
  (dolist (file files)
    (let* ((musica (parse-file file))
           (segmentos (sonorities musica))
           (gabarito (parse-answer-sheet (remove-ext file) item))
           (resultados (when gabarito
                         (loop for a in *algorithms* collect
                              (funcall (algorithm-classify a) segmentos))))
           (file-name (pathname-name file))
           (notas (mapcar #'list-events segmentos)))
      (cond
        ((< 2 (length regexps)) (format t "São duas as expressoes regulares"))
        ((and (not gabarito) (not (member 'i flags))))
        (t
         (gera-erros file-name
                     notas
                     gabarito
                     resultados
                     flags
                     (or (first regexps) "")
                     (or (second regexps) "")
                     erros?))))))

(defun run-gera-resultados (flags files item regexps)
  (format t "Algoritmos:~%")
  (loop for a in *algorithms* do (format t "- ~a~%" (algorithm-name a)))
  (format t "Coral Algoritmo Segmento Resultado_esperado Resultado_obtido~%")
  (dolist (file files)
    (let* ((musica (parse-file file))
           (segmentos (sonorities musica))
           (gabarito (parse-answer-sheet (remove-ext file) item))
           (resultados (when gabarito
                         (loop for a in *algorithms* collect
                              (funcall (algorithm-classify a) segmentos))))
           (file-name (pathname-name file))
           (notas (mapcar #'list-events segmentos)))
      (cond
        ((< 2 (length regexps)) (format t "São duas as expressoes regulares"))
          ((and (not gabarito) (not (member 'i flags))))
          (t
           (gera-resultados file-name
                            notas
                            gabarito
                            resultados
                            flags
                            (or (first regexps) "")
                            (or (second regexps) "")))))))

(defun nome-original (arquivo)
  (subseq arquivo (1+ (position #\/ arquivo :from-end t))))

(defun run-compara-tamanhos (flags files item)
  (format t "~a:~%" item)
  (let ((errados 0))
    (dolist (file files)
      (let* ((musica (parse-file file))
             (segmentos (sonorities musica))
             (gabarito (parse-answer-sheet (remove-ext file) item))
             (size-gab (length gabarito))
             (size-seg (length segmentos)))
        (unless (or (= size-gab 0) (= size-gab size-seg))
          (format t " ~a errado (gabarito: ~a, mas ~a segmentos)~%"
                  (remove-ext file)
                  size-gab
                  size-seg)
          (incf errados))))
    (if (= 0 errados)
      (format t "Todos corretos.~%")
      (format t "~a errados.~%" errados))))

(defun run-testes (flags files item)
  (if (string= item "unidade")
      (run-unidade flags (parse-file-list item files))
      (run-regressao flags (parse-file-list item files))))

(defun pitch-list (list)
  (sorted (remove-duplicates (mapcar #'event-pitch list)) #'<))

(defun run-enarmonia (flags files item)
  (declare (ignore flags))
  (format t "~a:~%" item)
  (dolist (file files)
    (let ((segmento (sonorities (parse-file file)))
	  (*package* (find-package :rameau)))
      (loop
	 for x in (mapcar2 #'set-intervals #'pitch-list segmento)
	 for nota in (mapcar #'pitch-list segmento)
	 for s in segmento
	 for n from 1
	 for list = (mapcar #'interval->code x)
	 for aug = (find 'aug list :key #'second)
	 for dim = (find 'dim list :key #'second) do
	   (when aug
	     (when (and (/= (first aug) 4)
			(not (equal (sorted list #'< :key #'first)
				    '((2 AUG) (3 MIN) (3 MIN) (3 MIN))))
			(not (equal (sorted list #'< :key #'first)
				    '((2 AUG) (3 MIN) (5 DIM))))
			(not (equal (sorted list #'< :key #'first)
				    '((3 MIN) (5 DIM)))))
	       (format t "~4a ~4a: ~{~(~a ~)~} ~13a~%"
		       (pathname-name file) n aug (list-events s))))
	   (when dim
	     (when (and (/= (first dim) 5)
			(not (equal (sorted list #'< :key #'first)
				    '((3 MAJ) (3 MAJ) (4 DIM)))))
	       (format t "~4a ~4a: ~{~(~a ~)~} ~13a~%"
		       (pathname-name file) n dim (list-events s))))
	   ))))

(defun run-partitura (flags files item)
  (when (member 'v flags) (format t "gerando "))
  (dolist (file files)
    (when (member 'v flags) (format t "~a " (pathname-name file)))
    (let* ((gabarito (parse-answer-sheet (remove-ext file) item))
           (segmento (sonorities (parse-file file)))
           (resultados (loop for a in *algorithms* collect
                            (funcall (algorithm-classify a) segmento))))
      (print-lily file item gabarito resultados flags segmento))))

(defun remove-test (list)
  "Remove test files from list of files."
  (remove-if (lambda (f) (search "test-" (pathname-name f))) list))

(defun get-functions (string &optional test)
  "Return an alist with the functions or testes of a file."
  (let* ((regexp-def "(DEFINE-TEST|DEFUN|DEFCACHED|DEFMACRO|DEFGENERIC)[ ]+")
         (regexp-name "[0-9a-zA-Z><\!\$%&\*\?/-]+")
         (regexp (concat regexp-def regexp-name))
         (files-orig (directory (concat *rameau-path* string)))
         (files (if test files-orig (remove-test files-orig))))
    (loop for file in files collect
         (with-open-file (s file)
           (list (intern (string-upcase (regex-replace-all "test-" (pathname-name file) "")))
                 (mapcar #'intern
                         (mapcar (lambda (x) (regex-replace-all regexp-def x ""))
                                 (all-matches-as-strings regexp (string-upcase (file-string s))))))))))

(defun dont-check-p (symbol)
  (search "[DONTCHECK]" (documentation symbol 'function)))
  
(defun check-for (a b)
  (loop
     for (key list) in a
     collect (list key (remove-if #'(lambda (item)
                                      (or (dont-check-p item)
                                          (string-member item (second (assoc key b)))))
                                  list))))



(defun print-check (alist text)
  (format t "~%~a:~%~%" text)
  (loop
     for (key list) in alist
     do
       (when list
         (format t "* ~(~a.lisp~) [~a]~%" key (length list))
         (format t "~{~(    ~a~%~)~}~%" list))))

(defun run-check (&rest ignore)
  (declare (ignore ignore))
  (let ((tests (get-functions "src/test-*.lisp" 'test))
        (functions (get-functions "src/*.lisp")))
    (print-check (check-for functions tests) "as seguintes funções estão sem testes")
    (print-check (check-for tests functions) "os seguintes testes estão orfãos")))

(defmacro defcommand (nome fn &rest args)
  `(defun ,nome (dados flags files regexps)
     (declare (ignorable regexps))
     (let* ((dados-list (get-item ',nome *dados*))
            (comandos-lista (if (string= dados "all") dados-list (split-dados dados))))
       (with-profile flags
         (or (and comandos-lista
                  (loop
                     for i in comandos-lista
                     for item = (first-string i dados-list) do
                       (format t "comando-lista: ~a~%" comandos-lista)
                       (if (member item dados-list :test #'string=)
                           (progn
                             (,fn flags (parse-file-list item files) item ,@args))
                           (progn
                             (format t "~a não é um comando de ~(~a~).~%" item ',nome)
                             (format t "comandos possíveis são: all ~{~a ~}~%" dados-list))))))))))


(defcommand teste run-testes)
(defcommand acertos run-gera-erros regexps nil)
(defcommand analise run-compara-gabarito)
(defcommand dados run-gera-dados)
(defcommand enarmonia run-enarmonia)
(defcommand erros run-gera-erros regexps t)
(defcommand partitura run-partitura)
(defcommand resultados run-gera-resultados regexps)
(defcommand tamanhos run-compara-tamanhos)
(defcommand check run-check)

(defun main ()
  (let* ((args (rameau-args))
         (string (first args))
         (dados (second args))
         (comando (if string (first-string string (get-comandos))))
         (flags-list (if (> (length args) 2) (arg->list (subseq args 2))))
         (files (get-flag-list "-f" flags-list))
         (trace (get-flag-list "-t" flags-list))
         (algoritmos (get-flag-list "-a" flags-list))
         (regexps (get-flag-list "-r" flags-list))
         (debug (get-flag-list "-d" flags-list))
         (max-error (first (get-flag-list "-m" flags-list)))
         (flags (if flags-list (get-lone-flags flags-list))))
    (when debug
      (loop for item in debug do
           (rameau-debug (intern (string-upcase item) :rameau))))
    (when trace (maptrace trace))
    (when max-error (setf max-print-error (read-from-string max-error)))
    (when (member 'h flags) (print-help))
    (when algoritmos
      (setf *algorithms* (filter-algorithms algoritmos)))
    (cond ((null comando) (print-help))
          ((equal comando "help") (print-help))
          ((equal comando "-h") (print-help))
          ((and (null dados) (string= comando "teste"))
           (teste "all" flags files regexps))
          ((and comando (null dados))
           (if (member comando (get-comandos) :test #'string=)
               (format t "as opções de ~a são: ~{~a ~} ~%"
                       comando
                       (get-item (intern (string-upcase comando) :rameau-main) *dados*))
               (progn
                 (format t "comando ~a não reconhecido~%" comando)
                 (format t "você deve entrar um dos comandos: ~{~(~a~)~^ ~}~%"
                         (get-comandos)))))
          ((member comando (get-comandos) :test #'string=)
           (funcall (symbol-function (intern (string-upcase comando) :rameau-main))
                    dados
                    flags
                    files
                    regexps))
          (t (format t "comando ~a não reconhecido~%" comando)
             (format t "você deve entrar um dos comandos: ~{~(~a~)~^ ~}~%"
                     (get-comandos)))))
  0)
