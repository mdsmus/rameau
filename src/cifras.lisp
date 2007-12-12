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

(defstruct
    (chord
      (:print-function
       (lambda (struct stream depth)
         (declare (ignore depth))
         (format stream "~:(~a~a~)~@[~:(~a~)~]~@[~:((~a)~)~]~@[~:((~a)~)~]~@[~:((~a)~)~]~@[/~:(~a~)~]"
                 (chord-root struct)
                 (chord-mode struct)
                 (chord-7th struct)
                 (chord-9th struct)
                 (chord-11th struct)
                 (chord-13th struct)
                 (chord-bass struct)))))
  root 7th 9th 11th 13th bass inversion mode)
  
(defun parse-chord (chord)
  (let ((poplist (cl-ppcre:split "/" (stringify chord))))
    (cl-ppcre:register-groups-bind (root mode 7th 9th 11th 13th)
        ("([cdefgab]+[#b]?)(m|°|ø|!|\\+)?(7[\\+-]?)?\\.?(9[b\\#]?)?\\.?(11[b\\#]?)?\\.?(13[b\\#]?)?"
         (first poplist) :sharedp t)
      (make-chord :root root
                  :mode mode
                  :bass (second poplist)
                  :7th 7th
                  :9th 9th
                  :11th 11th
                  :13th 13th))))

(defun parse-item (chord)
  (typecase chord
    (list (case (first chord)
            (m! (make-melodic-note :notes (rest chord)))
            (t (mapcar #'parse-item chord))))
    (t (parse-chord chord))))

(defun read-chords (list)
  (mapcar #'parse-item (expand-chords list)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; testes

;;; (defun roda-all-pop ()
;;;   (loop for file in (directory "/home/kroger/src/rameau/corais/*.pop") do
;;;        (print (pops->gabs (read-file-as-sexp file)))))

;;; (read-file-as-sexp "/home/kroger/src/rameau/gabaritos/bach-corais/001.pop")
