(defpackage :genoslib
  (:use #:rameau-base #:cl #:it.bese.arnesi))

(in-package :genoslib)

(register-and-export-symbols '(
                               add-lily-ext
                               add-pop-ext
                               agrupa
                               assoc-item
                               avanca-todos
                               clip
                               char->symbol
                               coloca-contexto
                               concat
                               converte-strings
                               count-subseq
                               defcached
                               destringify
                               dbg
                               dbg-indent
                               file-string
                               get-item
                               insert
                               mapcar2
                               max-predicado
                               octave-from-string
                               pula
                               rameau-debug
                               rameau-undebug
                               read-file-as-sexp
                               repeat-string
                               repeat-list
                               safe-retorna-n-elementos
                               smallest
                               split-word
                               split-opts
                               split-dados
                               sorted
                               sort-set
                               stringify
                               string-member
                               string->symbol
                               symbol->number
                               has-ext?
                               tira-extensao
                               troca-extensao
                               unzip
                               ))


(defun stringify (obj)
  "Convert <obj> to a string according to predefined conventions."
  (let ((*package* (find-package :rameau)))
    (format nil "~(~a~)" obj)))

(defun clip (size list)
  "Clip <list> to size <size>."
  (remove-if #'null (safe-retorna-n-elementos list size)))

(defun insert (element list &key (less #'<) (key #'identity))
  "Insert <element> into <list> in a sorted position."
  (if list
      (let ((fe (funcall key element))
            (fl (funcall key (first list))))
        (if (funcall less fe fl)
            (cons element list)
            (cons (first list) (insert element (rest list) :key key :less less))))
      (list element)))


;;; Norvig's functions for debugging in PAIP, p. 124

(defvar *dbg-ids* nil "identifiers used by dbg")
(setf *debug-io* *error-output*)

(defun dbg (id format-string &rest args)
  "Print debugging info if (DEBUG ID) has been specified."
  (when (member id *dbg-ids* :test #'string=)
    (fresh-line *debug-io*)
    (apply #'format *debug-io* (concat " => DEBUG: " format-string) args)
    (force-output *debug-io*)))

(defun dbg-indent (id indent format-string &rest args)
  "Print indented debugging info if (DEBUG ID) has been specified."
  (when (member id *dbg-ids*)
    (fresh-line *debug-io*)
    (dotimes (i indent) (princ " " *debug-io*))
    (apply #'format *debug-io* (concat " => DEBUG: " format-string) args)))

(defun rameau-debug (&rest ids)
  "Start dbg output on the given ids."
  (setf *dbg-ids* (union ids *dbg-ids*)))

(defun rameau-undebug (&rest ids)
  "Stop dbg on the ids. With no ids, stop dbg altogether."
  (setf *dbg-ids* (if (null ids)
                      nil
                      (set-difference *dbg-ids* ids))))

(do-not-test dbg rameau-debug rameau-undebug dbg-indent)

(defun add-lily-ext (file)
  "Add a .ly extension to filename <file> if nonexistent."
  (if (has-ext? file) file (concat file ".ly")))

(defun add-pop-ext (file)
  "Add a .pop extension to filename <file> if nonexistent."  
  (if (has-ext? file) file (concat file ".pop")))

(defun has-ext? (file)
  "Heuristic check to see whether filename <file> has an extension."
  (find #\. file))

(defun tira-extensao (file)
  (subseq file 0 (position #\. file)))

(defun troca-extensao (file ext)
  (if (has-ext? file) (concat (tira-extensao file) ext) file))

(defmacro defcached (funcname args &body body)
  (labels ((varnames (symbols)
             (cons 'list
                   (loop for s in symbols unless (and (symbolp s)
                                                      (eql #\&  (aref (symbol-name s) 0)))
                      collect (if (atom s) s (first s))))))
    (let ((cache (gensym)))
      `(let ((,cache (make-hash-table :test #'equal)))
         (defun ,funcname ,args
           (aif (gethash ,(varnames args) ,cache)
                it
                (setf (gethash ,(varnames args) ,cache) (progn ,@body))))))))

(defun concat (&rest strings)
  "Concatenate a bunch of strings."
  (apply #'concatenate 'string strings))

(defun sort-set (set)
  "Sort a set in crescent order. "
  (sorted set #'<))

(defun pula (elemento lista)
  "Pula as ocorrências iniciais de elemento na lista"
  (if (equal elemento (first lista))
      (pula elemento (rest lista))
      lista))

(defun count-subseq (sub seq &optional (start -1) (acumula 0))
  (let ((s (search sub seq :start2 (+ start 1))))
    (if s
        (count-subseq sub seq s (+ acumula 1))
        acumula)))

(defun symbol->number (string string-list)
  "Essa função conta quantas ocorrências tem do caractere na lista de
mapeamento e retorna esse valor. Essa função é usada para contar
quantos acidentes ou oitavas uma nota tem."
  (destructuring-bind (flat sharp) string-list
    (cond ((search sharp string) (count-subseq sharp string))
          ((search flat string) (- (count-subseq flat string)))
          (t 0))))

(defun smallest (lista &optional (teste #'identity))
  (when lista
    (reduce #'min lista :key teste)))

(defun repeat-string (n string)
  "Repeat a string n times. EXAMPLE: (repeat-string 3 \"foo\") returns
  \"foofoofoo\"."
  (with-output-to-string (s)
    (dotimes (i (abs n)) (format s string))))

(defun avanca-todos (lista)
  "Substitui todos os elementos de uma lista pelos seus cdrs."
  (mapcar #'cdr lista))

(defcached string->symbol (string)
  "Convert a string to a symbol."
  (let ((*package* (find-package :rameau)))
    (intern (string-upcase string) :rameau)))


(defun destringify (coisa)
  (let ((*package* (find-package :rameau)))
    (cond ((numberp coisa) coisa)
          ((stringp coisa) (read-from-string (string-upcase coisa)))
          (t coisa))))

(defun converte-strings (coisas)
  (when coisas
    (let ((atual (first coisas))
          (resto (rest coisas)))
      (cons (if (listp atual)
                (converte-strings atual)
                (destringify atual))
            (converte-strings resto)))))

(defun assoc-item (item alist)
  "Returns an item from a alist. "
  (second (assoc item alist)))

(defun max-predicado (predicado lista)
  (when lista
    (let ((maior-valor (funcall predicado (first lista)))
          (lista-max nil))
      (dolist (par lista)
        (cond ((> (funcall predicado par) maior-valor)
               (setf maior-valor (funcall predicado par))
               (setf lista-max (list par)))
              ((= (funcall predicado par) maior-valor)
               (push par lista-max))))
      lista-max)))

(defun octave-from-string (string)
  (+ 8 (symbol->number string '("," "'"))))

(defun file-string (path)
  "Sucks up an entire file from PATH into a freshly-allocated string,
      returning two values: the string and the number of bytes read."
  (with-open-file (s path #+sbcl :external-format #+sbcl :utf-8 )
    (let* ((len (file-length s))
           (data (make-string len :initial-element #\Space))
           (*package* (find-package :rameau)))
      (values data (read-sequence data s)))))

(do-not-test file-string)

(defun safe-retorna-n-elementos (lista n)
  (loop for i from 0 to (1- n) collect
       (nth i lista)))

(defun repeat-list (n list)
  (if (> n 0)
      (cons list (repeat-list (- n 1) list))))

(defun read-file-as-sexp (file)
  (read-from-string (format nil "(~a)" (file-string file))))

(do-not-test read-file-as-sexp)

(defun unzip (lista)
  (loop for el in lista
     nconc (list (first el)) into lista1
     nconc (list (second el)) into lista2
     finally (return (values lista1 lista2))))

(defun get-item (item lista &optional (test #'eql))
  "Pega um item em uma lista de associação."
  (second (assoc item lista :test test)))

(defun char->symbol (char)
  "Retorna o símbolo representado pelo caractere char.
Exemplo: (char->symbol #\a) => A"
  (intern (string-upcase (string char)) :rameau))

(defun split-word (word)
  "Retorna uma lista de símbolos para cada letra da palavra 'word'.
Exemplo: (split-word \"foo\") => (F O O)"
  (loop for char across word collect (char->symbol char)))

(defun split-opts (string)
  (mapcan (lambda (s) (split-word (delete #\- s)))
          (cl-ppcre:split #\Space string)))

(defun split-dados (dados)
  (cl-ppcre:split "," dados))

(defun sorted (lista ord &key (key #'identity))
  (sort (copy-list lista) ord :key key))

(defun mapcar2 (fn1 fn2 list)
  "Faz a mapcar do mapcar de uma lista"
  (mapcar (lambda (x) (funcall fn1 (funcall fn2 x))) list))

(defun agrupa (lista n)
  "Agrupa os elementos da lista em grupos de n em n, repetindo"
  (when lista
    (cons (safe-retorna-n-elementos lista n) (agrupa (rest lista) n))))

(defun coloca-contexto (segmentos antes depois)
  (butlast (agrupa (append (repeat-list antes nil) segmentos) (+ 1 antes depois)) (max 0 (1- depois))))

(defun string-member (item list)
  (member (stringify item) list :test #'equal :key #'stringify))

