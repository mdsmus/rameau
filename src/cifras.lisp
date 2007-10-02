(in-package #:rameau)

(defun parse-acrescimos (modo acrescimos)
  ;; por enquanto só funciona com acordes simples, como Cm7
  (when acrescimos
    (let* ((set (first (cl-ppcre:split "\\." acrescimos)))
           (setima (cond ((string= "~" modo) set)
                         ((string= "o" modo) (concat set "-"))
                         (t set))))
      (if (= (length setima) 1)
          setima
          (substitute #\+ #\m setima)))))

(defun get-modo (abrev)
  (case (string->symbol abrev)
    (m "min")
    (o "dim")
    (~ "dim")
    (+ "aug")
    (t "maj")))

(defun parse-fundamental (fundamental)
  (when fundamental
    (latin->lily fundamental)))

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

;; (cifra->acorde "Cm7.9b.13/Eb")
;; (cifra->acorde "C#M7/G#")
;; (cifra->acorde "C7M")

(defun cifra->acorde (cifra)
  (let ((cifra-list (cl-ppcre:split "/" cifra)))
    (cl-ppcre:register-groups-bind (fundamental modo acrescimos)
        ("([cdefgab]+[#b]?)(m|o|~|\\+)?([0-9\\.mb\\+]+)?" (first cifra-list) :sharedp t)
      (remove-if #'null (list (parse-fundamental fundamental)
                              (get-modo modo)
                              (qual-inversao? fundamental (second cifra-list))
                              (parse-acrescimos modo acrescimos))))))

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
                'lily)))
  
(defun acorde->cifra (acorde)
  (destructuring-bind (tonica modo inversao &optional acrescimos &rest resto) acorde
    (declare (ignore resto))
    (let ((fundamental (stringify tonica)))
      (format nil "~a~@[~a~]~@[/~:(~a~)~]"
              (case modo
                (maj (format nil "~a" fundamental))
                (min (format nil "~am" fundamental))
                (dim (format nil "~ao" fundamental))
                (aug (format nil "~a+" fundamental)))
              acrescimos
              (get-inversao-pop fundamental modo inversao)))))

(defun expand-mel (stream char)
  (declare (ignore char))
  `(:mel ,@(read-delimited-list #\] stream t)))

(set-macro-character #\[ #'expand-mel)
(set-macro-character #\] (get-macro-character #\)))

(defun nota-melodica? (lista)
  (when (eql (first lista) :mel) t))

(defun anotacao (lista)
  (append (processa-cifra (first lista))
          (list (second lista))))

(defun expande-cifra-setima (cifra)
  (let* ((cifra1 (cifra->acorde (first cifra)))
         (modo (second cifra1))
         (setima (parse-acrescimos modo (second cifra))))
    (list '* 2 (list cifra1 (append cifra1 (list setima))))))

(defun setima-no-baixo (acorde setima)
  (destructuring-bind (fund modo inversao &rest resto) acorde
    (declare (ignore inversao))
    (remove-if #'null (list fund modo 3 (parse-acrescimos modo setima) resto))))

(defun expande-cifra-setima-baixo (cifra)
  (let ((cifra1 (cifra->acorde (first cifra)))
        (setima (second cifra)))
    (format nil "~a~%~a" cifra1 (setima-no-baixo cifra1 setima))))

(defun multiplica-cifra (cifra)
  (list '* (second cifra) (cifra->acorde (first cifra))))

(defun processa-cifra (cifra)
  (let* ((cifra-string (stringify cifra))
         (cifra7 (cl-ppcre:split "--" cifra-string))
         (cifra7b (cl-ppcre:split "__" cifra-string))
         (cifra* (cl-ppcre:split "\\*" cifra-string)))
    (cond ((> (length cifra7) 1) (expande-cifra-setima cifra7))
          ((> (length cifra7b) 1) (expande-cifra-setima-baixo cifra7b))
          ((> (length cifra*) 1) (multiplica-cifra cifra*))
          (t (cifra->acorde cifra-string)))))

(defun print-mel (pop)
  (destructuring-bind (s &rest notas) pop
    (declare (ignore s))
    (format nil "(:mel ~{~(~a~)~^ ~})" (mapcar #'latin->lily notas))))

(defun pop2cifra (pop)
  (if (listp pop)
      (if (nota-melodica? pop)
          (print-mel pop)
          (anotacao pop))
      (processa-cifra pop)))

(defun read-pop-file (file)
  (read-from-string (format nil "(~a)" (file-string file))))

(defun gera-gabarito-file (file)
  (with-open-file (f (troca-extensao file ".gab") :direction :output :if-exists :supersede)
    (format f "~{~(~a~)~%~}" (mapcar #'pop2cifra (read-pop-file file)))))

;;(gera-gabarito-file "/home/kroger/doc/pesquisa/analise-harmonica/literatura/bach-corais/001.pop")
;;(gera-gabarito-file "/home/kroger/doc/pesquisa/analise-harmonica/literatura/bach-corais/002.pop")
;;(gera-gabarito-file "/home/kroger/doc/pesquisa/analise-harmonica/literatura/bach-corais/003.pop")
;;(gera-gabarito-file "/home/kroger/doc/pesquisa/analise-harmonica/literatura/bach-corais/004.pop")
