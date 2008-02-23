(defpackage :genoslib
  (:use #:rameau-base #:cl #:it.bese.arnesi))

(in-package :genoslib)

(register-and-export-symbols '(
                               dbg
                               dbg-indent
                               rameau-debug
                               rameau-undebug
                               add-lily-ext
                               add-pop-ext
                               assoc-item
                               avanca-todos
                               char->symbol
                               concat
                               converte-strings
                               copy
                               count-subseq
                               defcached
                               destringify
                               file-string
                               get-item
                               max-predicado
                               no-op
			       mapcar2
                               octave-from-string
                               pula
                               read-file-as-sexp
                               repeat-list
                               retorna-n-segmentos
                               safe-retorna-n-elementos
                               smallest
                               split-word
                               split-opts
                               split-dados
                               sorted
                               sort-set
                               stringify
                               string->symbol
                               symbol->number
                               repeat-copy
                               repeat-string
                               tem-ext?
                               tira-extensao
                               troca-extensao
                               unzip
                               ))


(defun stringify (symb)
  (let ((*package* (find-package :rameau)))
    (format nil "~(~a~)" symb)))


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
                      nill
                      (set-difference *dbg-ids* ids))))


(defun add-lily-ext (file)
  (if (tem-ext? file) file (concat file ".ly")))

(defun add-pop-ext (file)
  (if (tem-ext? file) file (concat file ".pop")))

(defun tem-ext? (file)
  (find #\. file))

(defun tira-extensao (file)
  (subseq file 0 (position #\. file)))

(defun troca-extensao (file ext)
  (if (tem-ext? file) (concat (tira-extensao file) ext) file))

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
  (sort set #'<))

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

(defun no-op (musica)
  (mapcar #'lista-notas (segmentos-minimos musica)))

(defun retorna-n-segmentos (musica n)
  (subseq musica 0 n))

(defun safe-retorna-n-elementos (lista n)
  (loop for i from 0 to (1- n) collect
       (nth i lista)))

(defun repeat-list (n list)
  (if (> n 0)
      (cons list (repeat-list (- n 1) list))))

(defgeneric copy (obj)
  (:documentation "Copia um objeto"))

(defmethod copy ((obj list))
  (mapcar #'copy obj))

(defmethod copy (obj)
  obj)

(defun repeat-copy (n list)
  (if (> n 0)
      (cons (copy list) (repeat-copy (- n 1) list))))

(defun read-file-as-sexp (file)
  (read-from-string (format nil "(~a)" (file-string file))))

(defun unzip (lista)
  (let (lista1
        lista2)
    (loop for el in lista
       nconc (list (first el)) into lista1
       nconc (list (second el)) into lista2
       finally (return (values lista1 lista2)))))

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

(defun sorted (lista key)
  (sort (copy-list lista) key))

(defun mapcar2 (fn1 fn2 list)
  "Faz a mapcar do mapcar de uma lista"
  (mapcar fn1 (mapcar fn2 list)))
