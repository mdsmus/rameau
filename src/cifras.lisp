(in-package #:rameau)

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
           (format stream "~:(~a~@[~a~]~)~@[~:(~a~)~]~@[~:((~a)~)~]~@[~:((~a)~)~]~@[~:((~a)~)~]~@[/~:(~a~)~]"
                   (chord-fundamental struct)
                   (chord-mode struct)
                 ;;; possível bug em acordes que tenham a sétima diminuta mas não sejam X°7
                   (if (string= (chord-7th struct) "7-") "7" (chord-7th struct))
                   (chord-9th struct)
                   (chord-11th struct)
                   (chord-13th struct)
                   (chord-bass struct))))
      )
  fundamental 7th 9th 11th 13th bass inversion mode)

(defun chordp (chord?)
  (eq (type-of chord?) 'CHORD))

(defparameter *inversions-pop* '(1 3 5 7))

(defun %chord-interval-code (fundamental bass)
  "Retorna o interval-code do intervalo entre o bass e a fundamental
do acorde. Expects fundamental and bass to be a string."
  (interval->code (interval (note->code bass)
                            (note->code fundamental))))

(defun return-inversion (fundamental bass)
  "Return the inversion number of the chord with fundamental and bass (both
as strings). If bass is nil the chord is suposed to be in fundamental
position."
  (when bass
    (aif (first (%chord-interval-code fundamental bass))
         (position it *inversions-pop*)
         (error "don't know inversion ~a" it))))

(defun %parse-chord (chord)
  (let* ((poplist (cl-ppcre:split "/" (stringify chord)))
         (bass-note (second poplist)))
    (cl-ppcre:register-groups-bind (fundamental mode 7th 9th 11th 13th)
        ("([cdefgab]+[#b]?)(m|°|ø|!|\\+)?(7[\\+-]?)?\\.?(9[b\\#]?)?\\.?(11[b\\#]?)?\\.?(13[b\\#]?)?"
         (first poplist) :sharedp t)
      (make-chord :fundamental fundamental
                  ;;; mode = nil é maior
                  :mode mode
                  :bass bass-note
                  :inversion (return-inversion fundamental bass-note)
                  :7th (if (and (string= 7th "7") (string= mode "°"))
                           "7-"
                           7th)
                  
                  :9th 9th
                  :11th 11th
                  :13th 13th))))

(defun parse-chord (chord)
  (typecase chord
    (list (case (first chord)
            (m! (make-melodic-note :notes (rest chord)))
            (t (mapcar #'parse-chord chord))))
    (t (%parse-chord chord))))

(defun read-chords (list)
  (mapcar #'parse-chord (expand-chords list)))

#|
testes

(defun roda-all-pop ()
  (loop for file in (directory "/home/kroger/src/rameau/gabaritos/bach-corais/*.pop") do
       (print file)
       (print (read-chords (read-file-as-sexp file)))))

(read-chords (read-file-as-sexp "/home/kroger/src/rameau/gabaritos/bach-corais/001.pop"))
|#