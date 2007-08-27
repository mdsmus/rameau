(defparameter *notes-names* '(#\a #\b #\c #\d #\e #\f #\g #\s #\r #\R))
(defparameter *tonal* '(69 83 0 14 28 41 55 nil nil))
(defparameter *tempered* '(9 11 0 2 4 5 7 nil nil))

(defparameter *quarta-tonal* 41)

(defstruct evento
  (pitch)
  (octave)
  (dur)
  (inicio))

(defun symbol->number (string mapping-list)
  "Usa uma lista para mapear strings e caracteres. Essa função conta
quantas ocorrências tem do caractere na lista de mapeamento e retorna
esse valor. Essa função é usada para contar quantos acidentes ou
oitavas uma nota tem."
  (destructuring-bind ((s1 ch1) (s2 ch2)) mapping-list
    (cond ((search s1 string) (count ch1 string))
          ((search s2 string) (- (count ch2 string)))
          (t 0))))

(defun number-of-accidentals (note)
  (symbol->number note '(("is" #\i) ("es" #\e))))

(defun note-number (note codification)
  (nth (position note *notes-names*) codification))

;;; FIXME
(defun number->note (note &optional (codification *tonal*))
  (nth (position note codification) *notes-names*))

(defun note-from-string (nota &optional (codification *tonal*))
  (let ((number (note-number (char nota 0) codification)))
    (if number
     (mod (+ (number-of-accidentals nota)
             number)
          96)
     nil)))

(defun octave-from-string (string)
  (+ 8 (symbol->number string '(("'" #\') ("," #\,)))))

(defun gabarito->sexp (file)
  "Transforma um gabarito de texto em sexp."
  (when (cl-fad:file-exists-p file) 
    (read-from-string (format nil "(~a)" (file-string file)))))

(defparameter *inversoes* '((3 (5 6 6/4))
                            (7 (7 6/5 4/3 4/2))))

(defun get-inversao (key)
  (second (assoc (if key key 3) *inversoes*)))

(defparameter *acordes* '((maj (0 4 7 11))
                          (min (0 3 7 10))))

(defun get-inversao-pop (modo inversao)
  ;;(nth inversao (second (assoc modo *acordes*)))
  (let ((resultado (nth inversao '(0 3 5 7))))
    (if (/= resultado 0) resultado nil)))

(defun convert-accidents (tonica)
  (let ((string (string-downcase (symbol-name tonica))))
    (cond ((search "is" string) (cl-ppcre:regex-replace "is" string "#"))
          ((search "es" string) (cl-ppcre:regex-replace "es" string "b"))
          (t tonica))))

(defun acorde->cifra (acorde)
  (destructuring-bind (tonica modo inversao &optional acrescimos &rest resto) acorde
    (let ((fundamental (convert-accidents tonica)))
      (format nil "~a~@[~a~]~@[/~aa~]"
              (case modo
                ('maj (format nil "~a" fundamental))
                ('min (format nil "~am" fundamental))
                ('dim (format nil "~ao" fundamental))
                ('aug (format nil "~a+" fundamental)))
              acrescimos
              (get-inversao-pop modo inversao)))))

(defun concat (&rest args)
  (apply #'concatenate 'string args))

(defun tira-extensao (file)
  (subseq file 0 (position #\. file)))

(defun add-lily-ext (file)
  (if (tem-ext? file) file (concat file ".ly")))

(defun tem-ext? (file)
  (find #\. file))
  
(defun troca-extensao (file ext)
  (concat (tira-extensao file) ext))

