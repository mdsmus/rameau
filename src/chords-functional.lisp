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
  "Print \\texttt{struct} to \\texttt{stream}."
  (declare (ignore depth))
  (format stream "~a:~a" (fchord-key struct) (fchord-roman-function struct)))
         
(defstruct (fchord (:print-function print-fchord))
  root 7th 9th 11th 13th bass inversion key roman-function)

(defun match-inversion (inversion-list)
  (nthcdr 2 (assoc (mapcar #'parse-integer (sort inversion-list #'string>))
                   *inversions-template*
                   :test #'equalp)))

(defun %parse-fchord (function-string key)
  (when (and function-string (not (equal "-" function-string)))
    (let* ((split-secondary (cl-ppcre:split "/" function-string))
           (function (first split-secondary))
           (center-function (second split-secondary)))
      (multiple-value-bind (roman-function figured-bass)
          (parse-roman-function function)
        (destructuring-bind (&optional inversion 7th)
            (match-inversion (cl-ppcre:split "\\." figured-bass))
          (let* ((root (roman-function-root roman-function key))
                 (mode (if (eq :major (roman-function-mode roman-function)) :major :minor)))
            (if center-function
                (%parse-fchord center-function (make-tonal-key :center-pitch root :mode mode))
                (make-fchord :root root
                             :bass nil
                             :7th 7th
                             :key key
                             :roman-function roman-function))))))))

(defun parse-fchords (chords center)
  (mapcar #'(lambda (chord)
              (if (consp chord)
                  (mapcar #L(unless (equal '- !1) (%parse-fchord (stringify !1) center)) chord)
                  (%parse-fchord (stringify chord) center)))
          chords))

(defun read-fchords (list)
  (iter (for chord in (iter (for item in (sublist-of-args list #\@))
                            (for center = (parse-tonal-key (subseq (symbol-name (first item)) 1)))
                            (for chords = (rest item))
                            (nconcing (parse-fchords chords center))))
        (with last-chord = nil)
        (when chord
          (setf last-chord chord))
        (collect last-chord)))

(defun mode->keyword (mode)
  (cond ((equal mode "") :major)
        ((equal mode "m") :minor)
        ((equal mode "ø") :half-diminished)
        ((equal mode "°") :diminished)
        ((equal mode "+") :augmented)
        (t :major)))

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
               :roman-function (get-roman-function (chord-root chord) (mode->keyword (chord-mode chord)) center)
               ))

(defmethod %compare-answer-sheet ((answer fchord) (sheet fchord) &optional tempered?)
  (declare (ignore tempered?))
  (and (equalp (fchord-key answer) (fchord-key sheet))
       (equalp (fchord-roman-function answer) (fchord-roman-function sheet))))

;; (read-fchords (read-file-as-sexp (concat *rameau-path* "answer-sheets/chorales-bach/006.fun") :preserve))
;; (path-parse-functional-answer-sheet "/home/top/programas/analise-harmonica/music/chorales-bach/006.ly")
;; (%parse-fchord "vi6" "F")
;; (chord->fchord (make-chord :root "a" :mode "") (make-tonal-key :center-pitch 0 :mode :minor))