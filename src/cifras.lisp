(in-package #:rameau)

;;; (defun qual-intervalo-no-baixo? (inversao)
;;;   "Retorna a nota (i.e. 1, 3, 5, 7, mas sem qualidade) do acorde que
;;; está no baixo de acordo com a inversão."
;;;   (first (find inversao *inversions-pop* :key #'second)))

;;; ;; TODO: lidar com 7m 7M, 5+, etc
;;; (defun get-intervalo-inversao-pop (modo inversao)
;;;   (code->interval (list (qual-intervalo-no-baixo? inversao)
;;;                         (case inversao
;;;                           (1 modo)
;;;                           (2 'just)
;;;                           (3 'min)
;;;                           (t (error "não conheço essa inversão"))))))
;;; ;;; 1 minor
;;; ;;; 1 major
;;; ;;; 2 just
;;; ;;; 2 dim
;;; ;;; 2 aug
;;; ;;; 3 min
;;; ;;; 3 maj
;;; ;;; 3 dim

;;; (defun get-inversao-pop (tonica modo inversao)
;;;   (unless (= inversao 0)
;;;     (print-note (code->note (+ (note->code tonica)
;;;                                (get-intervalo-inversao-pop modo inversao)))
;;;                 'latin)))

;;; (defun acorde->cifra (acorde)
;;;   (cond ((equal (first acorde) 'm!) "m!")
;;;         ((listp (first acorde)) (acorde->cifra (first acorde)))
;;;         (t (destructuring-bind (tonica &optional modo inv acresc &rest resto) acorde
;;;              (declare (ignore resto))
;;;              (let ((fundamental (lily->latin (stringify tonica)))
;;;                    (acrescimos (cond ((and (null acresc) (eql inv 7)) 7)
;;;                                      (t acresc)))
;;;                    (inversao (cond ((and (null acresc) (eql inv 7)) 0)
;;;                                    ((null inv) 0)
;;;                                    (t inv))))
;;;                (format nil "~@(~a~)~@[~a~]~@[/~@(~a~)~]"
;;;                        (case modo
;;;                          (maj (format nil "~a" fundamental))
;;;                          (min (format nil "~am" fundamental))
;;;                          (dim (if (eq '7- acrescimos)
;;;                                   (format nil "~a°" fundamental)
;;;                                   (format nil "~aø" fundamental)))
;;;                          (aug (format nil "~a+" fundamental)))
;;;                        (if (eq modo 'dim)
;;;                            ""
;;;                            acrescimos)
;;;                        (get-inversao-pop fundamental modo inversao)))))))

;;; ;;; (defun multiplica-cifra (cifra)
;;; ;;;   (list (list '* (second cifra) (cifra->acorde (first cifra)))))

;;; ;;; (defun expande-cifra-sexta-aumentada (cifra)
;;; ;;;   (list (substitute (second cifra) "maj" (cifra->acorde (first cifra)) :test #'equal)))

;;; (defparameter *inversions-pop* '(1 3 5 7))

;;; (defun %chord-interval-code (root bass)
;;;   "Retorna o interval-code do intervalo entre o bass e a root
;;; do acorde. Expects root and bass to be a string."
;;;   (interval->code (interval (note->code bass)
;;;                             (note->code root))))

;;; (defun chord-inversion (root bass)
;;;   "Return the inversion number of the chord with root and bass (both
;;; as strings). If bass is nil the chord is suposed to be in root
;;; position."
;;;   (if bass
;;;       (aif (first (%chord-interval-code root bass))
;;;            (position it *inversions-pop*)
;;;            (error "don't know inversion ~a" it))
;;;       0))

;;; (defun parse-seventh (mode 7th)
;;;   (cond ((and (string= mode "°") (string= 7th "7"))
;;;          81)
;;;         ((string= 7th "7") 82)
;;;         ((string= 7th "7m") 83)
;;;         (t 7th)))
  
;;; (defun parse-extensions (mode extensions)
;;;   (when extensions
;;;     (let ((ext-list (cl-ppcre:split "\\." extensions)))
;;;       (aif (cl-ppcre:scan-to-strings "7(m|-)?" (first ext-list))
;;;            (parse-seventh mode it)
;;;            ;;; BUG: deve usar mapcar
;;;            (cl-ppcre:scan-to-strings "(9|11|13)(b|\\#)?" (rest ext-list)))
;;;       )))

;;; (defun get-mode (abrev)
;;;   (case (string->symbol abrev)
;;;     (m "min")
;;;     (° "dim")
;;;     (ø "dim")
;;;     (+ "aug")
;;;     (! "inc")
;;;     (t "maj")))

;;; (defun %parse-pop (pop)
;;;   "Essa espera que cifra seja uma string em minúscula."
;;;   (let ((poplist (cl-ppcre:split "/" pop)))
;;;     (cl-ppcre:register-groups-bind (root mode extensions)
;;;         ("([cdefgab]+[#b]?)(m|°|ø|!|\\+)?([0-9\\.mb#]+)?" (first poplist) :sharedp t)
;;;       (remove-if #'null (list (latin->lily root)
;;;                               (get-mode mode)
;;;                               (chord-inversion root (second poplist))
;;;                               (parse-extensions mode extensions))))))

;;; (defun %parse-6+ (list)
;;;   ;; e.g. 6 aumentada
;;;   list)

;;; (defun parse-pop (pop)
;;;   "Converte uma cifra simbolica para lista no formato de gabarito."
;;;   (let ((pop-string (stringify pop))
;;;         (parse-table '(("\\*" %parse-multiplication)
;;;                        ("-" %parse-6+))))
;;;     (aif (loop
;;;             for item in parse-table
;;;             for regex = (cl-ppcre:split (first item) pop-string)
;;;             when (rest regex) do
;;;               (return (funcall (second item) (first regex) (second regex))))
;;;          it
;;;          (%parse-pop pop-string))))

;;; (defun parse-melodic-notes (pop)
;;;   (append '(m!) (mapcar #'latin->lily (rest pop))))

;;; (defun parse-annotation (pop)
;;;   (format nil "(~{~a ~}~s)" (parse-pop (second pop)) (third pop)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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

(defun parse-multiplication (chord)
  (if (listp chord)
      (if (eql (first chord) '*)
          (append (subseq chord 0 2)
                  (mapcar #'parse-multiplication (subseq chord 2)))
          chord)
      (let* ((chord-string (stringify chord))
             (pos (position #\* chord-string)))
        (if pos
            (list '*
                  (parse-integer (subseq chord-string (1+ pos)))
                  (string->symbol (subseq chord-string 0 pos)))
            chord))))

(defun expand-multiplications (gab)
  (when gab
    (let ((atual (first gab))
          (resto (rest gab)))
      (if (and (listp atual) (eq '* (first atual)))
          (nconc
           (reduce #'append (repeat-list (second atual)
                                        (expand-multiplications (rest (rest atual)))))
           (expand-multiplications resto))
          (cons atual (expand-multiplications resto))))))

(defun expand-chords (list)
  (expand-multiplications (mapcar #'parse-multiplication list)))

(defstruct (melodic-note
             (:print-function
              (lambda (struct stream depth)
                (declare (ignore struct depth))
                (format stream "--"))))
  notes)

(defstruct (chord
             (:print-function
              (lambda (struct stream depth)
                (declare (ignore depth))
                (format stream "~:(~a~)~@[~:(~a~)~]~@[/~:(~a~)~]"
                        (chord-root struct)
                        (chord-seventh struct)
                        (chord-bass struct)))))
  root seventh bass inversion mode)

;;;;;;;;;;;;;;

;;; (defun parse-seventh (mode 7th)
;;;   (cond ((and (string= mode "°") (string= 7th "7"))
;;;          81)
;;;         ((string= 7th "7") 82)
;;;         ((string= 7th "7m") 83)
;;;         (t 7th)))
  
;;; (defun parse-extensions (mode extensions)
;;;   (when extensions
;;;     (let ((ext-list (cl-ppcre:split "\\." extensions)))
;;;       (aif (cl-ppcre:scan-to-strings "7(m|-)?" (first ext-list))
;;;            (parse-seventh mode it)
;;;            ;;; BUG: deve usar mapcar
;;;            (cl-ppcre:scan-to-strings "(9|11|13)(b|\\#)?" (rest ext-list)))
;;;       )))

;;; (defun get-mode (abrev)
;;;   (case (string->symbol abrev)
;;;     (m "min")
;;;     (° "dim")
;;;     (ø "dim")
;;;     (+ "aug")
;;;     (! "inc")
;;;     (t "maj")))

(defun parse-chord (chord)
  (let ((poplist (cl-ppcre:split "/" (stringify chord))))
    (cl-ppcre:register-groups-bind (root mode extensions)
        ("([cdefgab]+[#b]?)(m|°|ø|!|\\+)?([0-9\\.mb#]+)?" (first poplist) :sharedp t)
      (make-chord :root root
                  :mode mode
                  :bass (second poplist)
                  :seventh extensions))))

(defun parse-item (chord)
  (typecase chord
    (list (case (first chord)
            (m! (make-melodic-note :notes (rest chord)))
            (t (mapcar #'parse-item chord))))
    (t (parse-chord chord))))

(defun read-chords (list)
  (mapcar #'parse-item (expand-chords list)))

;;; (defun expand-chord (pop)
;;;   (typecase pop
;;;     (list (case (first pop)
;;;             (an! (parse-annotation pop))
;;;             (m!  (parse-melodic-notes pop))
;;;             (*   (parse-repetition pop))
;;;             (t   (mapcar #'pop->gab pop)))) ; parse-pop era processa-cifra
;;;     (t (parse-pop pop))))




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; testes

;;; (defun roda-all-pop ()
;;;   (loop for file in (directory "/home/kroger/src/rameau/corais/*.pop") do
;;;        (print (pops->gabs (read-file-as-sexp file)))))

;;; (read-file-as-sexp "/home/kroger/src/rameau/gabaritos/bach-corais/001.pop")
