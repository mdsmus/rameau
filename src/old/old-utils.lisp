(defparameter *notes-names* '(#\a #\b #\c #\d #\e #\f #\g #\s #\r #\R))
(defparameter *tonal* '(69 83 0 14 28 41 55 nil nil))
(defparameter *tempered* '(9 11 0 2 4 5 7 nil nil))

(defparameter *quarta-tonal* 41)

(defparameter *interval-names* '(tonic diminished-second second minor-third major-third fourth
                                 diminished-fifth fifth minor-sixth major-sixth diminished-seventh
                                 minor-seventh major-seventh))

(defparameter *tonal-intervals* '(0 13 14 27 28 41 54 55 56 68 69 81 82 83))

(defparameter *tempered-intervals* '(0 1 2 3 4 5 6 7 8 9 9 10 11))


#|
;;; o que está abaixo vai embora
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun number-of-accidentals (note)
  (symbol->number note '(("is" #\i) ("es" #\e))))

(defun note-number (note codification)
  (nth (position note *notes-names*) codification))

;;; FIXME
(defun number->note (note &optional (codification *tonal*))
  (nth (position note codification) *notes-names*))

|#

(defun defchord (chord &optional (codification *tonal-intervals*))
  (cons (first chord) (mapcar (lambda (x)
                                (interval-number x codification))
                              (second chord))))

(defmacro defchords (templates &body chords)
  `(defparameter ,templates '(,@(mapcar #'defchord chords))))


(defun octave-from-string (string)
  (+ 8 (symbol->number string '(("'" #\') ("," #\,)))))

(defun read-pop-file (file)
  (read-from-string (format nil "(~a)" (file-string file))))

(defun gera-gabarito-file (file)
  (with-open-file (f (concat file ".gab") :direction :output :if-exists :supersede)
    (loop for c in (read-pop-file (concat file ".pop")) do
       ;; ignora o que está entre parenteses
         (unless (listp c)
           (format f "~(~a~)~%" (cifra->acorde c))))))

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
              (get-inversao-pop2 modo inversao)))))



(defun no-op (musica)
  (mapcar #'lista-notas (segmentos-minimos musica)))

;;(no-op (parse-file "/home/top/programas/analise-harmonica/exemplos/001.ly"))

(defun numero-nota (n)
  (intern (string-upcase (nth n *notas*))))

(defun retorna-n-segmentos (musica)
  (subseq musica 0 n))

;; poor-man's version
(defun no-op2 (file)
  (mapcar (lambda (segmento)
            (mapcar #'(lambda (x)
                        (numero-nota (mod (evento-pitch x) 12)))
                    segmento))
          (segmentos-minimos (parse-file file))))

;;(no-op2 "/home/top/programas/analise-harmonica/exemplos/001.ly")

(defun note-from-string (nota &optional (codification *tonal*))
  (let* ((nota (string-downcase nota))
         (number (note-number (char nota 0) codification)))
    (if number
     (mod (+ (number-of-accidentals nota)
             number)
          96)
     nil)))

(defun interval-number (interval codification)
  (nth (position interval *interval-names*) codification))
