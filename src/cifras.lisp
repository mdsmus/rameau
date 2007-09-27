(in-package #:rameau)

(defun parse-acrescimos (cifra)
  ;; por enquanto só funciona com acordes simples, como Cm7
  (when cifra
    (parse-integer (first (cl-ppcre:split "\\." cifra)))))

(defun get-modo (abrev)
  (case (string->symbol abrev)
    (m 'min)
    (o 'dim)
    (+ 'aug)
    (t 'maj)))

(defun parse-fundamental (fundamental)
  (when fundamental
    (string->symbol (latin->lily fundamental))))

(defun %chord-interval-code (fundamental baixo)
  "Retorna uma lista com o intervalo tonal entre o baixo e a
fundamental do acorde."
  (interval->code (interval (note->code baixo)
                            (note->code fundamental))))

(defparameter *inversoes-pop* '((1 0) (3 1) (5 2) (7 3)))

(defun qual-inversao? (fundamental baixo)
  (if baixo
      (let ((intervalo (first (%chord-interval-code fundamental baixo))))
        (if intervalo
            (second (find intervalo *inversoes-pop* :key #'first))
            (error "não conheço inversão")))
      0))

(defun qual-intervalo-no-baixo? (inversao)
  (first (find inversao *inversoes-pop* :key #'second)))

;; (cifra->acorde 'Cm7.9b.13/Eb)
;; (cifra->acorde 'C#m7/G#)

(defun cifra->acorde (cifra)
  (let ((cifra-list (cl-ppcre:split "/" (symbol->string cifra))))
    (cl-ppcre:register-groups-bind (fundamental modo acrescimos)
        ("([cdefgab]+[#b]?)(m|o)?([0-9.Mb\\+]+)?" (first cifra-list) :sharedp t)
      (remove-if #'null (list (parse-fundamental fundamental)
                              (get-modo modo)
                              (parse-acrescimos acrescimos)
                              (qual-inversao? fundamental (second cifra-list)))))))

;; TODO: lidar com 7m 7M, 5+, etc
(defun get-intervalo-inversao-pop (modo inversao)
  (code->interval (list (qual-intervalo-no-baixo? inversao)
                        (case inversao
                          (1 modo)
                          (2 'just)
                          (3 'min)))))

(defun get-inversao-pop (tonica modo inversao)
  (unless (= inversao 0)
    (print-note (code->note (+ (note->code tonica)
                               (get-intervalo-inversao-pop modo inversao)))
                'latin)))
  
(defun acorde->cifra (acorde)
  (destructuring-bind (tonica modo inversao &optional acrescimos &rest resto) acorde
    (declare (ignore resto))
    (let ((fundamental (lily->latin  (symbol->string tonica))))
      (format nil "~a~@[~a~]~@[/~:(~a~)~]"
              (case modo
                (maj (format nil "~a" fundamental))
                (min (format nil "~am" fundamental))
                (dim (format nil "~ao" fundamental))
                (aug (format nil "~a+" fundamental)))
              acrescimos
              (get-inversao-pop fundamental modo inversao)))))

(defun read-pop-file (file)
  (read-from-string (format nil "(~a)" (file-string file))))

(defun 7+ (gabarito)
  (append gabarito (list 7)))

(defun extract-cifra (cifra-string pos)
  (cifra->acorde (string->symbol (subseq cifra-string 0 pos))))

(defun expande-cifra-setima (cifra)
  (let* ((cifra-string (symbol->string cifra))
         (pos (search "--7" cifra-string)))
    (when pos
      (let ((cifra1 (extract-cifra cifra-string pos)))
        (list '* 2 (list cifra1 (7+ cifra1)))))))

(defun expand-mel (stream char)
  (declare (ignore char))
  `(:mel ,@(read-delimited-list #\] stream t)))

(set-macro-character #\[ #'expand-mel)
(set-macro-character #\] (get-macro-character #\)))

(defun gera-gabarito-file (file)
  (with-open-file (f (concat file ".gab") :direction :output :if-exists :supersede)
    (loop for cifra in (read-pop-file (concat file ".pop")) do
         (if (listp cifra)
             cifra
             (let ((expande-cifra (expande-cifra-setima cifra)))
               (if expande-cifra
                   (format f "~(~a~)~%" expande-cifra)
                   (format f "~(~a~)~%" (cifra->acorde cifra))))))))

;;(gera-gabarito-file "/home/kroger/doc/pesquisa/analise-harmonica/literatura/bach-corais/001")
