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
    (° "dim")
    (ø "half-dim")
    (+ "aug")
    (! "inc")
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

(defun cifra->acorde (cifra)
  (let ((cifra-list (cl-ppcre:split "/" cifra)))
    (cl-ppcre:register-groups-bind (fundamental modo acrescimos)
        ("([cdefgab]+[#b]?)(m|°|ø|!|\\+)?([0-9\\.mb\\+]+)?" (first cifra-list) :sharedp t)
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
                'latin)))

(defun acorde->cifra (acorde)
  (cond ((equal (first acorde) 'm!) "m!")
        ((listp (first acorde)) (acorde->cifra (first acorde)))
        (t (destructuring-bind (tonica &optional modo inv acresc &rest resto) acorde
             (declare (ignore resto))
             (let ((fundamental (lily->latin (stringify tonica)))
                   (acrescimos (cond ((and (null acresc) (eql inv 7)) 7)
                                     (t acresc)))
                   (inversao (cond ((and (null acresc) (eql inv 7)) 0)
                                   ((null inv) 0)
                                   (t inv))))
               (format nil "~@(~a~)~@[~a~]~@[/~@(~a~)~]"
                       (case modo
                         (maj (format nil "~a" fundamental))
                         (min (format nil "~am" fundamental))
                         (dim (format nil "~a°" fundamental))
                         (half-dim (format nil "~aø" fundamental))
                         (aug (format nil "~a+" fundamental)))
                       acrescimos
                       (get-inversao-pop fundamental modo inversao)))))))

(defun expand-mel (stream char)
  (declare (ignore char))
  (let ((*package* (find-package :rameau)))
    `(m! ,@(read-delimited-list #\] stream t))))

(defun expand-repeat (stream char)
  (declare (ignore char))
  (let ((*package* (find-package :rameau)))
    `(* 1 ,@(read-delimited-list #\} stream t))))

(set-macro-character #\[ #'expand-mel)
(set-macro-character #\] (get-macro-character #\)))

(set-macro-character #\{ #'expand-repeat)
(set-macro-character #\} (get-macro-character #\)))

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

(defun expande-cifra-super-setima-baixo (cifra)
  (let ((cifra1 (cifra->acorde (first cifra)))
        (setima (second cifra)))
    (list '* 2 (list cifra1 (setima-no-baixo cifra1 setima)))))

(defun expande-cifra-super-setima (cifra)
  (let ((acorde (cifra->acorde (first cifra))))
    (format nil "~a~%~a" acorde (append acorde (list (second cifra))))))

(defun multiplica-cifra (cifra)
  (list '* (second cifra) (cifra->acorde (first cifra))))

(defun expande-cifra-sexta-aumentada (cifra)
  (substitute (second cifra) "maj" (cifra->acorde (first cifra)) :test #'equal))

(defun processa-cifra (cifra)
  (let* ((cifra-string (stringify cifra))
         (cifra7 (cl-ppcre:split "--" cifra-string))
         (cifra7s (cl-ppcre:split "==" cifra-string))
         (cifra7b (cl-ppcre:split "__" cifra-string))
         (cifra7sb (cl-ppcre:split "_-" cifra-string))
         (cifra* (cl-ppcre:split "\\*" cifra-string))
         (cifra6+ (when (cl-ppcre:scan "it|al|fr" cifra-string)
                    (cl-ppcre:split "-" cifra-string))))
    (cond ((rest cifra7)   (expande-cifra-setima cifra7))
          ((rest cifra7s)  (expande-cifra-super-setima cifra7s))
          ((rest cifra7b)  (expande-cifra-setima-baixo cifra7b))
          ((rest cifra7sb) (expande-cifra-super-setima-baixo cifra7sb))
          ((rest cifra*)   (multiplica-cifra cifra*))
          ((rest cifra6+)  (expande-cifra-sexta-aumentada cifra6+))
          (t (cifra->acorde cifra-string)))))

(defun print-mel (pop)
  (destructuring-bind (s &rest notas) pop
    (declare (ignore s))
    (format nil "(m! ~{~(~a~)~^ ~})" (mapcar #'latin->lily notas))))

(defun print-repeat (pop)
  (destructuring-bind (s valor &rest cifras) pop
    (format nil "(~a ~a~%~{~( ~a~%~)~})" s valor (mapcar #'pop2cifra cifras))))

(defun print-annotate (lista)
  (destructuring-bind (s nota anotacao) lista
    (declare (ignore s))
    (format nil "(~{~a ~}~s)" (processa-cifra nota) anotacao)))

(defun pop2cifra (pop)
  (cond ((listp pop)
         (case (first pop)
           (an! (print-annotate pop))
           (m! (print-mel pop))
           (*  (print-repeat pop))
           (t  (mapcar #'pop2cifra pop))))
        ((stringp pop) (format nil "; ~a" pop))
        (t (processa-cifra pop))))

(defun read-pop-file (file)
  (let ((*package* (find-package :rameau)))
    (read-from-string (format nil "(~a)" (file-string file)))))

(defun gera-gabarito-file (file)
  (with-open-file (f (troca-extensao file ".gab") :direction :output :if-exists :supersede)
    (format f "~{~(~a~)~%~}" (mapcar #'pop2cifra (read-pop-file file)))))
