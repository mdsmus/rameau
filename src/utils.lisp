(in-package #:rameau)


;; "Roubada" de src/code/pred.lisp da distribuição do SBCL e modificada
;; pra lidar direito com pacotes de símbolos
(defun rameau-equal (x y)
  #!+sb-doc
  "Return T if X and Y are EQL or if they are structured components whose
elements are EQUAL. Strings and bit-vectors are EQUAL if they are the same
length and have identical components. Other arrays must be EQ to be EQUAL."
  ;; Non-tail self-recursion implemented with a local auxiliary function
  ;; is a lot faster than doing it the straightforward way (at least
  ;; on x86oids) due to calling convention differences. -- JES, 2005-12-30
  (labels ((equal-aux (x y)
             (cond ((eql x y)
                    t)
                   ((consp x)
                    (and (consp y)
                         (equal-aux (car x) (car y))
                         (equal-aux (cdr x) (cdr y))))
                   ((symbolp x)
                    (and (symbolp y) (or (eq x y)
                                         (string= (symbol-name x) (symbol-name y)))))
                   ((stringp x)
                    (and (stringp y) (string= x y)))
                   ((pathnamep x)
                    (and (pathnamep y) (pathname= x y)))
                   ((bit-vector-p x)
                    (and (bit-vector-p y)
                         (bit-vector-= x y)))
                   (t nil))))
    ;; Use MAYBE-INLINE to get the inline expansion only once (instead
    ;; of 200 times with INLINE). -- JES, 2005-12-30
    (declare (maybe-inline equal-aux))
    (equal-aux x y)))

(defmacro equal-case (test-form &body cases)
  (let ((form (gensym)))
    `(let ((,form ,test-form))
       (cond
         ,@(mapcar
            (lambda (x)
              (destructuring-bind (value action) x
                (if (eq t value)
                    `(t ,action)
                    `((rameau-equal ,form ',value) ,action))))
            cases)))))



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
  
(defmacro aif (test-form then-form &optional else-form)
  "Macro anafófica que retorna o elemento no predicado ('it') se for
verdadeiro."
  (labels ((change-it-package (form)
             (subst 'it (find-symbol "IT" *package*) form)))
    `(let ((it ,test-form))
       (if it
           ,(change-it-package then-form)
           ,(change-it-package else-form)))))

(defmacro defcached (funcname args &body body)
  (let ((cache (gensym))
        (func (gensym))
        (params (gensym)))
    `(let ((,cache (make-hash-table :test #'equal)))
       (defun ,funcname (&rest ,params)
         (labels ((,func ,args ,@body))
           (aif (gethash ,params ,cache)
                it
                (setf (gethash ,params ,cache) (apply #',func ,params))))))))
           
(defun concat (&rest strings)
  "Concatenate a bunch of strings."
  (apply #'concatenate 'string strings))

(defun last1 (list)
  "Retuns the last element of a list."
  (first (last list)))

(defun sort-set (set)
  "Sort a set in crescent order. "
  (sort set #'<))

(defun exclude-repetition (set)
  "Exclude all repetitions from a set."
  (let ((novo-set ()))
    (loop for x in set unless (member x novo-set)
       do (push x novo-set))
    (nreverse novo-set)))

(defun pula (elemento lista)
  "Pula as ocorrências iniciais de elemento na lista"
  (if (rameau-equal elemento (first lista))
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

(defcached string->symbol (string)
  "Convert a string to a symbol."
  (intern (string-upcase string) :rameau))

(defcached stringify (symb)
  (format nil "~(~a~)" symb))

(defun destringify (coisa)
  (cond ((numberp coisa) coisa)
        ((stringp coisa) (read-from-string (string-upcase coisa)))
        (t coisa)))

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
  (let ((maior-valor (funcall predicado (first lista)))
        (lista-max nil))
    (dolist (par lista)
      (cond ((> (funcall predicado par) maior-valor)
             (setf maior-valor (funcall predicado par))
             (setf lista-max (list par)))
            ((= (funcall predicado par) maior-valor)
             (push par lista-max))))
    lista-max))

(defun octave-from-string (string)
  (+ 8 (symbol->number string '("," "'"))))

(defun compara-notas (x y)
  (let ((a (evento-octave x))
        (b (evento-octave y)))
    (if (= a b)
        (< (evento-pitch x) (evento-pitch y))
        (< (evento-octave x) (evento-octave y)))))

(defun lista-notas (segmento)
  (mapcar (lambda (x)
            (print-note (code->note (evento-pitch x)) 'latin))
          (sort segmento #'compara-notas)))

(defun no-op (musica)
  (mapcar #'lista-notas (segmentos-minimos musica)))

(defun retorna-n-segmentos (musica n)
  (subseq musica 0 n))

(defun repeat-list (n list)
  (if (> n 0)
      (cons list (repeat-list (- n 1) list))))

(defun expande-multiplicacoes (gab)
  (when gab
    (let ((atual (first gab))
          (resto (rest gab)))
      (if (and (listp atual) (eq '* (first atual)))
          (nconc
           (reduce #'append (repeat-list (second atual)
                                        (expande-multiplicacoes (rest (rest atual)))))
           (expande-multiplicacoes resto))
          (cons atual (expande-multiplicacoes resto))))))

(defun processa-gabarito-pop (file)
  (mapcar (lambda (x)
            (let ((cifra (pop2cifra x)))
              (if (stringp cifra)
                  (read-from-string (string-upcase cifra))
                  (converte-strings cifra))))
          (read-pop-file file)))

(defun processa-gabarito (file)
  "Transforma um gabarito de texto em sexp."
  (let* ((nome-gab (concat file ".gab"))
         (nome-pop (concat file ".pop"))
         (gabarito (cond ((cl-fad:file-exists-p nome-gab) 
                          (read-from-string (format nil "(~a)" (file-string nome-gab))))
                         ((cl-fad:file-exists-p nome-pop)
                          (processa-gabarito-pop nome-pop))
                         (t nil))))
    (expande-multiplicacoes gabarito)))
