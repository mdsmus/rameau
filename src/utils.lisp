
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

(defun count-subseq (sub seq &optional (start -1) (acumula 0))
  (let ((s (search sub seq :start2 (+ start 1))))
    (if (null s)
        acumula
        (count-subseq sub seq s (+ acumula 1)))))
        

(defun symbol->number (string string-list)
  "Essa função conta quantas ocorrências tem do caractere na lista de
mapeamento e retorna esse valor. Essa função é usada para contar
quantos acidentes ou oitavas uma nota tem."
  (destructuring-bind (flat sharp) string-list
    (cond ((search sharp string) (count-subseq sharp string))
          ((search flat string) (- (count-subseq flat string)))
          (t 0))))

(defun repeat-string (n string)
  "Repeat a string n times. EXAMPLE: (repeat-string 3 \"foo\") returns
  \"foofoofoo\"."
  (with-output-to-string (s)
    (loop for x from 1 to (abs n) do (format s string))))

(defun string->symbol (string)
  "Convert a string to a symbol."
  (intern (string-upcase string)))

(defun assoc-item (item alist)
  "Returns an item from a alist. "
  (second (assoc item alist)))

(defun max-predicado (predicado lista)
  "retorna o maior par de uma lista de pares"
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
  (let ((segmento (sort segmento #'compara-notas)))
      (mapcar (lambda (x)
                (print-note (code->note (evento-pitch x)) 'latin))
              segmento)))

(defun no-op (musica)
  (mapcar #'lista-notas (segmentos-minimos musica)))

(defun retorna-n-segmentos (musica n)
  (subseq musica 0 n))

(defun expande-multiplicacoes (gab)
  (when gab
    (let ((atual (first gab))
          (resto (rest gab)))
      (cons (if (eq '* (first atual))
                (second atual)
                atual)
            (expande-multiplicacoes resto)))))

(defun processa-gabarito (file)
  "Transforma um gabarito de texto em sexp."
  (let ((gabarito (when (cl-fad:file-exists-p file) 
                    (read-from-string
                     (format nil "(~a)" (file-string file))))))
    (expande-multiplicacoes gabarito)))
