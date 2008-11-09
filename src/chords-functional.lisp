(in-package #:rameau)
(enable-sharp-l-syntax)


(defparameter *inversions-template*
  '(((7)   => nil 7)
    ((6)   => 1)
    ((6 4) => 2)
    ((6 5) => 1 7)
    ((4 3) => 2 7)
    ((4 2) => 3 7))
  "The format is ((<inversion 'code'>) => <inversion number> <7 if the
  chord has a seventh>.")

(defun print-fchord (struct stream depth)
  "Print @var{struct} to @var{stream}."
  (declare (ignore depth))
  (if (fchord-key struct)
      (format stream "~a: ~a~a~a"
              (fchord-key struct)
              (fchord-roman-function struct)
              (or (fchord-7th struct) "")
              (or (fchord-inversion struct) ""))
      (format stream "~a~a~a"
              (fchord-roman-function struct)
              (or (fchord-7th struct) "")
              (or (fchord-inversion struct) ""))))
         
(defstruct (fchord (:print-function print-fchord))
  root 7th 9th 11th 13th bass inversion key roman-function)

(defun transpose-fchord (fchord pitches)
  "Transpose fchord @var{fchord} by @var{pitches}"
  (let ((center-pitch (+ pitches (tonal-key-center-pitch (fchord-key fchord)))))
    (make-fchord :7th (fchord-7th fchord)
                 :9th (fchord-9th fchord)
                 :11th (fchord-11th fchord)
                 :13th (fchord-13th fchord)
                 :inversion (fchord-inversion fchord)
                 :roman-function (fchord-roman-function fchord)
                 :key (make-tonal-key :center-pitch (module center-pitch)
                                      :mode (tonal-key-mode (fchord-key fchord))))))

(defun match-inversion :private (inversion-list)
  (nthcdr 2 (assoc (mapcar #'parse-integer (sort inversion-list #'string>))
                   *inversions-template*
                   :test #'equalp)))

(defun %parse-fchord  :private (function-string key)
  (when (and function-string (not (equal "-" function-string)))
    (let* ((split-secondary (cl-ppcre:split "/" function-string))
           (function (first split-secondary))
           (center-function (second split-secondary)))
      (multiple-value-bind (roman-function figured-bass)
          (parse-roman-function function)
        (destructuring-bind (&optional inversion 7th)
            (match-inversion (cl-ppcre:split "\\." figured-bass))
            (if center-function
                (let* ((func (parse-roman-function center-function))
                       (root (roman-function-root func key))
                       (mode (if (eql :major (roman-function-mode func))
                                 :major
                                 :minor)))
                  (%parse-fchord function (make-tonal-key :center-pitch root
                                                          :mode mode)))
                (make-fchord :root (roman-function-root roman-function key)
                             :bass nil
                             :7th 7th
                             :key key
                             :roman-function roman-function)))))))

(defun parse-fchords (chords center)
  "Parse the fchords in @var{chords} as having @var{center} as their key."
  (mapcar #'(lambda (chord)
              (if (consp chord)
                  (mapcar #L(unless (equal '- !1)
                              (%parse-fchord (symbol-name !1) center))
                          chord)
                  (%parse-fchord (symbol-name chord) center)))
          chords))

(defun read-fchords (list)
  "Read the fchords in @var{list}."
  (flet ((get-key (list)
           (subseq (symbol-name (first list)) 1)))
    (iter (for chord in (mapcan #L(parse-fchords (rest !1)
                                                 (parse-tonal-key (get-key !1)))
                                (sublist-of-args list #\@)))
          (with last-chord = nil)
          (when chord
            (setf last-chord chord))
          (collect last-chord))))

(defun get-fchords (string)
  "Read the fchords from @var{string}."
  (read-fchords (read-from-string-as-sexp (cl-ppcre:regex-replace-all "([A-Ga-g](#|b)*):"
                                                                      string
                                                                      "@\\1")
                                          :preserve)))

(defun mode->keyword (mode)
  "Match the chord-mode @var{mode} with the appropriate fchord-mode keyword."
  (cond ((equal mode "") :major)
        ((equal mode "m") :minor)
        ((equal mode "ø") :half-diminished)
        ((equal mode "°") :diminished)
        ((equal mode "+") :augmented)
        (t :major)))

(defun keyword->mode (mode)
  "Match the chord-mode @var{mode} with the appropriate fchord-mode keyword."
  (cond ((equal mode :major)  "")
        ((equal mode :minor) "m")
        ((equal mode :half-diminished) "ø")
        ((equal mode :diminished) "°")
        ((equal mode :augmented) "+")
        (t "")))

(defmethod chord->fchord ((chord chord) center)
  "Convert a chord of type 'chord' to a functional chord according to
center. center must be a string and scale-mode a keyword."
  (make-fchord :root (chord-root chord)
               :bass (chord-bass chord)
               :inversion (chord-inversion chord)
               :7th (chord-7th chord)
               :9th (chord-9th chord)
               :11th (chord-11th chord)
               :13th (chord-13th chord)
               :key center
               :roman-function (get-roman-function (chord-root chord)
                                                   (mode->keyword (chord-mode chord))
                                                   center)))

(defmethod chord->fchord (chord center)
  "Fallback for non-chord tones and augmented sixths until we do have a syntax for it. FIXME."
  (make-fchord :key center
               :roman-function (make-roman-function :degree-number 1
                                                    :degree-accidentals 0
                                                    :mode :major)))

(defun fchord->chord (fchord)
  (let ((f (fchord-roman-function fchord))
        (k (fchord-key fchord)))
    (cond ((eql :german-sixth (roman-function-mode f))
           (make-augmented-sixth :type :al))
          ((eql :french-sixth (roman-function-mode f))
           (make-augmented-sixth :type :it))
          ((eql :italian-sixth (roman-function-mode f))
           (make-augmented-sixth :type :fr))
          (t (make-chord :root (print-pitch (roman-function-root f k))
                         :mode (keyword->mode (roman-function-mode f)))))))
        

(defmethod %compare-answer-sheet ((answer fchord) (sheet fchord) &optional tempered?)
  (declare (ignore tempered?))
  (and (equalp (fchord-key answer) (fchord-key sheet))
       (equalp (fchord-roman-function answer) (fchord-roman-function sheet))))

(defun same-key (a b)
  "True if @var{a} and @var{b} are the same key."
  (and (tonal-key-p a)
       (tonal-key-p b)
       (eq (tonal-key-mode a) (tonal-key-mode b))
       (eq (tonal-key-center-pitch a) (tonal-key-center-pitch b))))

(defun cleanup-keys (fchords)
  "Clean the keys from @var{fchords} before outputting them to sensitive musicians."
  (if (fchord-p (first fchords))
      (iter (with current-key = nil)
            (with last-chord = nil)
            (for chord in fchords)
            (for this-chord =  chord)
            (if (same-key current-key (fchord-key chord))
                (setf chord (make-fchord :key nil
                                         :7th (fchord-7th chord)
                                         :roman-function (fchord-roman-function chord)))
                (setf current-key (fchord-key chord)))
            (when (equalp chord last-chord)
              (setf chord '-))
            (setf last-chord this-chord)
            (collect chord))
      fchords))

;; (read-fchords (read-file-as-sexp (concat *rameau-path* "answer-sheets/chorales-bach/006.fun") :preserve))
;; (trace %parse-fchord)
;; (trace parse-roman-function)
;; (cleanup-keys (path-parse-functional-answer-sheet "/home/top/programas/analise-harmonica/music/chorales-bach/006.ly"))
;; (%parse-fchord "vi6" "F")
;; (chord->fchord (make-chord :root "a" :mode "") (make-tonal-key :center-pitch 0 :mode :minor))
