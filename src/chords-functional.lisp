(in-package #:rameau)
(enable-sharp-l-syntax)

(defparameter *roman-functions* '("i" "ii" "iii" "iv" "v" "vi" "vii"))

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
  (let* ((roman (nth (1- (fchord-function struct)) *roman-functions*))
         (mode (case (fchord-mode struct)
                 (:major (string-upcase roman))
                 (:minor roman)
                 (:half-diminished (format nil "~aø" roman))
                 (:diminished-triad (format nil "~a°" roman))
                 (:fully-diminished (format nil "~a°7" roman))
                 (t (format nil "~a~a" roman (fchord-mode struct)))))
         (center (print-note (code->notename (fchord-center struct))))
         (center (if (eq :major (fchord-key-mode struct)) (string-upcase center) center)))
    (format stream "~a:~a" center mode)))
         
(defstruct (fchord (:print-function print-fchord))
  root 7th 9th 11th 13th bass inversion mode function center accidents key-mode)

(defun match-inversion (inversion-list)
  (nthcdr 2 (assoc (mapcar #'parse-integer (sort inversion-list #'string>))
                   *inversions-template*
                   :test #'equalp)))

(defun parse-mode (function mode-symbol 7th)
  (cond ((upper-case-p function) :major)
        ((null mode-symbol) :minor)
        ((equal mode-symbol "ø") :half-diminished)
        ((and (null 7th) (equal mode-symbol "°")) :diminished-triad)
        ((and (equal 7th "7-") (equal mode-symbol "°")) :fully-diminished)
        ((equal mode-symbol "+") :augmented)
        (t (error "Chord-type not recognized: ~a ~a ~a~%" function mode-symbol 7th))))

(defun make-center (root mode)
  (let ((note (print-note (code->notename root))))
    (if (eq :major mode)
        (string-upcase note)
        note)))

(defun %parse-fchord (function-string center)
  (let* ((split-secondary (cl-ppcre:split "/" function-string))
         (function (first split-secondary))
         (center-function (second split-secondary)))
    (cl-ppcre:register-groups-bind (roman-function mode-symbol figured-bass)
        ("^(iii|ii|iv|i|v|vi|vii|III|II|IV|I|V|VI|VII)(°|ø|\\+)?([0-9](\\.[0-9])*)?$" function)
      (destructuring-bind (&optional inversion 7th)
          (match-inversion (cl-ppcre:split "\\." figured-bass))
        (let* ((tonal-function (1+ (position roman-function *roman-functions* :test #'equalp)))
               (center-pitch (parse-note center))
               (center-mode (if (upper-case-p (char center 0)) :major :minor))
               (root (+ center-pitch (nth (1- tonal-function) (get-scale-mode center-mode))))
               (mode (parse-mode (char roman-function 0) mode-symbol 7th)))
        ;;; TODO usar center-function para achar centro real
          (if center-function
              (%parse-fchord function (make-center root mode))
              (make-fchord :root root
                           :bass nil
                           :7th 7th
                           :inversion inversion
                           :mode mode
                           :accidents 0
                           :function tonal-function
                           :center center-pitch
                           :key-mode center-mode)))))))

(defun parse-fchords (chords center)
  (mapcar #'(lambda (chord)
              (if (consp chord)
                  (mapcar #L(%parse-fchord (stringify !1) center) chord)
                  (%parse-fchord (stringify chord) center)))
          chords))

(defun read-fchords (list)
  (iter (for chord in (iter (for item in (sublist-of-args list #\@))
                            (for center = (subseq (symbol-name (first item)) 1))
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
        ((equal mode "°") :diminished-triad)
        ((equal mode "+") :augmented)
        (t :major)))

(defmethod chord->fchord ((chord chord) center scale-mode)
  "Convert a chord of type 'chord' to a functional chord according to
center. center must be a string and scale-mode a keyword."
  (multiple-value-bind (function accidents)
      (get-roman-function (chord-root chord) center scale-mode)
    (make-fchord :root (chord-root chord)
                 :bass (chord-bass chord)
                 :inversion (chord-inversion chord)
                 :mode (mode->keyword (chord-mode chord))
                 :7th (chord-7th chord)
                 :9th (chord-9th chord)
                 :11th (chord-11th chord)
                 :13th (chord-13th chord)
                 :function function
                 :accidents accidents
                 :key-mode (if (upper-case-p (char center 0)) :major :minor)
                 :center (parse-note center))))

(defmethod %compare-answer-sheet ((answer fchord) (sheet fchord) &optional tempered?)
  (declare (ignore tempered?))
  (and (equal (fchord-function answer) (fchord-function sheet))
       (equal (fchord-center answer) (fchord-center sheet))))

;; (read-fchords (read-file-as-sexp (concat *rameau-path* "answer-sheets/chorales-bach/006.fun") :preserve))
;; (path-parse-functional-answer-sheet "/home/top/programas/analise-harmonica/music/chorales-bach/006.ly")
;; (%parse-fchord '|vi6| "F")
;; (fchord-function (chord->fchord (make-chord :root "a" :mode :major) "B" :minor))