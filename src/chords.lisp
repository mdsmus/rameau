(in-package #:rameau)

(enable-sharp-l-syntax)

(defun expand-non-chord-tones :private (stream char)
  "[NOTEST]"
  (declare (ignore char))
  (let ((*package* (find-package :rameau)))
    `(m! ,@(read-delimited-list #\] stream t))))

(defun expand-repeat :private (stream char)
  "[NOTEST]"
  (declare (ignore char))
  (let ((*package* (find-package :rameau)))
    `(* 1 ,@(read-delimited-list #\} stream t))))

(set-macro-character #\[ #'expand-non-chord-tones)
(set-macro-character #\] (get-macro-character #\)))

(set-macro-character #\{ #'expand-repeat)
(set-macro-character #\} (get-macro-character #\)))

(defun parse-multiplication :private (chord)
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
                  (make-keyword (subseq chord-string 0 pos)))
            chord))))

(defun expand-multiplications :private (gab)
  (when gab
    (let ((atual (first gab))
          (resto (rest gab)))
      (if (and (listp atual) (eq '* (first atual)))
          (nconc
           (reduce #'append (repeat-list (second atual)
                                         (expand-multiplications (subseq atual 2))))
           (expand-multiplications resto))
          (cons atual (expand-multiplications resto))))))

(defun expand-chords :private (list)
  "[NOTEST]"
  (expand-multiplications (mapcar #'parse-multiplication list)))

(defstruct (melodic-note
             (:print-function
              (lambda (struct stream depth)
                (declare (ignore struct depth))
                (format stream (if (unicode-term stream)
                                   "--"
                                   "--")))))
  notes)

(defun print-chord (struct stream depth)
  "Print chord @var{struct} to stream @var{stream}, ignoring @var{depth}."
  (declare (ignore depth))
  (format stream
          "~:(~a~)~@[~a~]~@[~:(~a~)~]~@[~:((~a)~)~]~@[~:((~a)~)~]~@[~:((~a)~)~]~@[/~:(~a~)~]"
          (chord-root struct)
          (if #+sbcl(unicode-term stream) #-sbcl t
              (chord-mode struct)
              (cond ((equal "ø" (chord-mode struct)) "hdim")
                    ((equal "°" (chord-mode struct)) "dim")
                    (t (chord-mode struct))))
          ;; %EXPMERGE possível bug em acordes que tenham a sétima diminuta mas não sejam X°7
          (if (string= (chord-7th struct) "7-") "7" (chord-7th struct))
          (chord-9th struct)
          (chord-11th struct)
          (chord-13th struct)
          (chord-bass struct)))

(defun print-augmented-sixth (struct stream depth)
  "Print augmented sixth chord @var{struct} to @var{stream}
  ignoring @var{depth}."
  (declare (ignore depth))
  (format stream "~:(~a+6~)" (augmented-sixth-type struct)))

(defstruct (chord (:print-function print-chord))
  root 7th 9th 11th 13th bass inversion mode)

(defun %get-augmented-sixth :private (type)
  (get-item type '((al (0 28 55 70))
                   (it (0 28 70))
                   (fr (0 28 42 70)))))

(defstruct (augmented-sixth
             (:constructor make-augmented-sixth (&key type))
             (:print-function print-augmented-sixth))
  type
  key
  (template (%get-augmented-sixth type)))

(defun chord-interval-code (root bass)
  "Return the interval-code of the interval between the root and
root. Expects root and bass to be a string."
  (interval->code (interval (parse-note bass)
                            (parse-note root))))

(defun return-inversion (root bass)
  "Return the inversion number of the chord with root and bass (both
as strings). If bass is nil the chord is suposed to be in root
position."
  (when bass
    (aif (first (chord-interval-code root bass))
         (position it '(1 3 5 7))
         (error "don't know inversion ~a" it))))

(defun %parse-chord :private (chord)
  (let* ((6+ (second (multiple-value-list (cl-ppcre:scan-to-strings "(al|fr|it)+\\+6"
                                                                    (stringify chord)))))
         (poplist (cl-ppcre:split "/" (stringify chord)))
         (bass-note (second poplist)))
    (if 6+
        (make-augmented-sixth :type (make-keyword (elt 6+ 0)))
        (cl-ppcre:register-groups-bind (root mode 7th 9th 11th 13th)
            ("([cdefgab]+[#b]?)(m|°|ø|!|\\+)?(7[\\+-]?)?\\.?(9[b\\#]?)?\\.?(11[b\\#]?)?\\.?(13[b\\#]?)?"
             (first poplist) :sharedp t)
          (make-chord :root root
                      :mode (or mode "") ; mode = nil é maior
                      :bass bass-note
                      :inversion (return-inversion root bass-note)
                      :7th (if (and (string= 7th "7") (string= mode "°"))
                               "7-"
                               (or 7th ""))
                      :9th 9th
                      :11th 11th
                      :13th 13th)))))

(defun parse-chord (chord)
  "Parse symbol or list @var{chord} into a chord or melodic note
  or augmented sixth."
  (typecase chord
    (list (case (first chord)
            (m! (make-melodic-note :notes (rest chord)))
            (t (mapcar #'parse-chord chord))))
    (t (%parse-chord chord))))

(defun read-chords (list)
  "Parse the chords in list @var{list}.[NOTEST]"
  (mapcar #'parse-chord (expand-chords list)))

(defun transpose-chord (c n)
  "Transpose chord @var{c} by @var{n} pitches.[NOTEST]"
    (if (chord-p c)
        (let ((root (print-note (code->notename (+ n (parse-note (chord-root c))))
                                :latin)))
          (make-chord :root root
                      :bass (chord-bass c)
                      :mode (chord-mode c)
                      :inversion (chord-inversion c)
                      :7th (chord-7th c)
                      :9th (chord-9th c)
                      :11th (chord-11th c)
                      :13th (chord-13th c)))
        c))

(defun transpose-chords (chords n)
  (loop for c in chords
        collect (transpose-chord (if (listp c)
                                     (find-if #'chord-p c)
                                     c)
                                 n)))

(defgeneric %compare-answer-sheet (answer answer-sheet &optional tempered?)
  (:documentation "Compare an answer sheet"))

(defmethod %compare-answer-sheet (result (answer-sheet list) &optional tempered?)
  (some #'identity (mapcar #L(%compare-answer-sheet result !1 tempered?)
                           answer-sheet)))

(defmethod %compare-answer-sheet (result answer-sheet &optional tempered?)
  (declare (ignore result answer-sheet tempered?))
  nil)

(defmethod %compare-answer-sheet ((result chord) (answer-sheet chord)
                                  &optional tempered?)
  (and (funcall (if tempered? #'enharmonicaly-equal-p #'equalp)
                (chord-root result) (chord-root answer-sheet))
       (equalp (chord-mode result) (chord-mode answer-sheet))
       (equal (chord-7th result) (chord-7th answer-sheet))))

(defmethod %compare-answer-sheet ((result melodic-note) (answer melodic-note)
                                  &optional tempered?)
  (declare (ignore tempered?))
  t)

(defmethod %compare-answer-sheet ((result augmented-sixth) (answer-sheet augmented-sixth)
                                  &optional tempered?)
  (declare (ignore tempered?))
  (equalp (stringify (augmented-sixth-type result))
          (stringify (augmented-sixth-type answer-sheet))))

(defun compare-answer-sheet (answer answer-sheet &optional tempered?)
  "Compare result @var{answer} with answer-sheet
@var{answer-sheet}. True if they match."
  (if (atom answer-sheet)
      (%compare-answer-sheet answer answer-sheet tempered?)
      (some (lambda (x) (%compare-answer-sheet answer x tempered?)) answer-sheet)))

(defun add-inversion (segment chord)
  "Label the chord @var{chord} with the inversion found in
@var{segmento}.[NOTEST]"
  (let ((inv (first (list-events segment))))
    (if (chord-p chord)
        (make-chord :root (chord-root chord)
                    :7th (chord-7th chord)
                    :mode (chord-mode chord)
                    :bass (unless (equal inv (chord-root chord))
                            inv))
        chord)))

(defun add-inversions (segmentos acordes)
  "Label all chords in @var{acordes} with the appropriate inversion
according to the music in @var{segmentos}.[NOTEST]"
  (mapcar #'add-inversion segmentos acordes))

(defun 7th-pitch (chord)
  "The pitch of chord @var{chord}'s seventh note."
  (let ((root (parse-note (chord-root chord))))
    (module
     (cond ((equal "7+" (chord-7th chord))
            (+ root (code->interval '(7 :maj))))
           ((or (equal "7-" (chord-7th chord))
                (and (equal "°" (chord-mode chord))
                     (equal "7" (chord-7th chord))))
            (+ root (code->interval '(7 :dim))))
           (t (+ root (code->interval '(7 :min))))))))
