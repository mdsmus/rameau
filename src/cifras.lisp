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

(do-not-test expand-mel expand-repeat)

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

(do-not-test expand-chords)

(defstruct (melodic-note
             (:print-function
              (lambda (struct stream depth)
                (declare (ignore struct depth))
                (format stream (if (unicode-term stream)
                                   "—"
                                   "--")))))
  notes)

(defstruct
    (chord
      (:print-function
       (lambda (struct stream depth)
           (declare (ignore depth))
           (format stream "~:(~a~)~@[~a~]~@[~:(~a~)~]~@[~:((~a)~)~]~@[~:((~a)~)~]~@[~:((~a)~)~]~@[/~:(~a~)~]"
                   (chord-fundamental struct)
                   (if (unicode-term stream)
                       (chord-mode struct)
                       (cond ((equal "ø" (chord-mode struct))
                              "hdim")
                             ((equal "°" (chord-mode struct))
                              "dim")
                             (t (chord-mode struct))))
                 ;;; possível bug em acordes que tenham a sétima diminuta mas não sejam X°7
                   (if (string= (chord-7th struct) "7-") "7" (chord-7th struct))
                   (chord-9th struct)
                   (chord-11th struct)
                   (chord-13th struct)
                   (chord-bass struct))))
      )
  fundamental 7th 9th 11th 13th bass inversion mode)

(defparameter *augmented-sixth-templates* '((al (0 28 55 70))
                                            (it (0 28 70))
                                            (fr (0 28 42 70))))

(defstruct (augmented-sixth
             (:constructor make-augmented-sixth
                           (&key type (template (second (assoc type *augmented-sixth-templates*)))))
             (:print-function
              (lambda (struct stream depth)
                (declare (ignore depth))
                (format stream "~:(~a+6~)" (augmented-sixth-type struct)))))
  type
  key
  template)

(defun chordp (chord?)
  (eq (type-of chord?) 'CHORD))

(do-not-test chordp)

(defparameter *inversions-pop* '(1 3 5 7))

(defun %chord-interval-code (fundamental bass)
  "Retorna o interval-code do intervalo entre o bass e a fundamental
do acorde. Expects fundamental and bass to be a string."
  (interval->code (interval (parse-note bass)
                            (parse-note fundamental))))

(do-not-test %chord-interval-code)

(defun return-inversion (fundamental bass)
  "Return the inversion number of the chord with fundamental and bass (both
as strings). If bass is nil the chord is suposed to be in fundamental
position."
  (when bass
    (aif (first (%chord-interval-code fundamental bass))
         (position it *inversions-pop*)
         (error "don't know inversion ~a" it))))

(defun %parse-chord (chord)
  (let* ((6+ (second (multiple-value-list (cl-ppcre:scan-to-strings "(al|fr|it)+\\+6" (stringify chord)))))
         (poplist (cl-ppcre:split "/" (stringify chord)))
         (bass-note (second poplist)))
    (if 6+
        (make-augmented-sixth :type (string->symbol (elt 6+ 0)))
        (cl-ppcre:register-groups-bind (fundamental mode 7th 9th 11th 13th)
            ("([cdefgab]+[#b]?)(m|°|ø|!|\\+)?(7[\\+-]?)?\\.?(9[b\\#]?)?\\.?(11[b\\#]?)?\\.?(13[b\\#]?)?"
             (first poplist) :sharedp t)
          (make-chord :fundamental fundamental
                      ;; mode = nil é maior
                      :mode mode
                      :bass bass-note
                      :inversion (return-inversion fundamental bass-note)
                      :7th (if (and (string= 7th "7") (string= mode "°"))
                               "7-"
                               7th)
                  
                      :9th 9th
                      :11th 11th
                      :13th 13th)))))

(do-not-test %parse-chord)

(defun parse-chord (chord)
  (typecase chord
    (list (case (first chord)
            (m! (make-melodic-note :notes (rest chord)))
            (t (mapcar #'parse-chord chord))))
    (t (%parse-chord chord))))

(defun read-chords (list)
  (mapcar #'parse-chord (expand-chords list)))

(do-not-test read-chords)

(defun transpose-chord (c n)
  (if (chordp c)
      (make-chord :fundamental (print-note (code->notename
                                             (+ n
                                                (parse-note
                                                 (chord-fundamental c))))
                                        'latin)
                  :bass (chord-bass c)
                  :mode (chord-mode c)
                  :inversion (chord-inversion c)
                  :7th (chord-7th c)
                  :9th (chord-9th c)
                  :11th (chord-11th c)
                  :13th (chord-13th c))
      c))

(do-not-test transpose-chord)

(defun transpose-chords (chords n)
  (loop for c in chords
     collect (transpose-chord (if (listp c) (find-if #'chordp c) c)
                              n)))


(defun compara-gabarito-temperado-individual (resultado gabarito)
  (or (and (melodic-note-p resultado)
           (melodic-note-p gabarito))
      (and (augmented-sixth-p resultado)
           (augmented-sixth-p gabarito)
           (equalp (stringify (augmented-sixth-type resultado))
                   (stringify (augmented-sixth-type gabarito))))
      (and (chordp resultado)
           (chordp gabarito)
           (enharmonicaly-equal-p (chord-fundamental resultado)
                                  (chord-fundamental gabarito))
           (equal (chord-mode resultado) (chord-mode gabarito))
           (equal (chord-7th resultado) (chord-7th gabarito)))))

(defun compara-gabarito-temperado (res gab)
  (if (atom gab)
      (compara-gabarito-temperado-individual res gab)
      (some (lambda (x)
              (compara-gabarito-temperado-individual res x))
            gab)))

(defun compara-gabarito-tonal-individual (resultado gabarito)
  (or (and (melodic-note-p resultado)
           (melodic-note-p gabarito))
      (and (augmented-sixth-p resultado)
           (augmented-sixth-p gabarito)
           (equalp (stringify (augmented-sixth-type resultado))
                   (stringify (augmented-sixth-type gabarito))))
      (and (chordp resultado)
           (chordp gabarito)
           (equalp (chord-fundamental resultado) (chord-fundamental gabarito))
           (equalp (chord-mode resultado) (chord-mode gabarito))
           (equal (chord-7th resultado) (chord-7th gabarito)))))

(defun compara-gabarito-tonal (res gab)
  (if (atom gab)
      (compara-gabarito-tonal-individual res gab)
      (some (lambda (x)
              (compara-gabarito-tonal-individual res x))
            gab)))

(do-not-test compara-gabarito-temperado-individual compara-gabarito-tonal-individual)

(defun coloca-inversao (segmento acorde)
  (if (chordp acorde)
      (make-chord :fundamental (chord-fundamental acorde)
                  :7th (chord-7th acorde)
                  :mode (chord-mode acorde)
                  :bass (let ((inv (first (lista-notas segmento))))
                          (when (not (equal inv (chord-fundamental acorde)))
                            inv)))
      acorde))

(defun coloca-inversoes (segmentos acordes)
  (mapcar #'coloca-inversao segmentos acordes))

(do-not-test coloca-inversao coloca-inversoes)