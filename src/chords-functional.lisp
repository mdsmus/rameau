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

(defstruct fchord
  root 7th 9th 11th 13th bass inversion mode function center)

(defun match-inversion (inversion-list)
  (nthcdr 2 (assoc (mapcar #'parse-integer (sort inversion-list #'string>))
                   *inversions-template*
                   :test #'equalp)))

(defun %parse-fchord (symbol center)
  (let* ((function-string (symbol-name symbol))
         (split-secondary (cl-ppcre:split "/" function-string))
         (function (first split-secondary))
         (center-function (second split-secondary)))
    (cl-ppcre:register-groups-bind (roman-function rest)
        ("^(iii|ii|iv|i|v|vi|vii|III|II|IV|I|V|VI|VII)([0-9](\\.[0-9])*)?$" function)
      (destructuring-bind (&optional inversion 7th)
          (match-inversion (cl-ppcre:split "\\." rest))
        ;;; TODO usar center-function para achar centro real
        (make-fchord :root nil
                     :bass nil
                     :7th 7th
                     :inversion inversion
                     :mode (if (upper-case-p (char roman-function 0)) :major :minor)
                     :function (1+ (position roman-function *roman-functions* :test #'equalp))
                     :center center)))))

(defun parse-fchords (chords center)
  (mapcar #'(lambda (chord)
              (if (consp chord)
                  (mapcar #L(%parse-fchord !1 center) chord)
                  (%parse-fchord chord center)))
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

(defmethod chord->fchord ((chord chord) center scale-mode)
  "Convert a chord of type 'chord' to a functional chord according to
center. center must be a string and scale-mode a keyword."
  (make-fchord :root (chord-root chord)
               :bass (chord-bass chord)
               :inversion (chord-inversion chord)
               :mode (chord-mode chord)
               :7th (chord-7th chord)
               :9th (chord-9th chord)
               :11th (chord-11th chord)
               :13th (chord-13th chord)
               :function (get-roman-function (chord-root chord)
                                             (chord-mode chord)
                                             center
                                             scale-mode)))

;; (read-fchords (read-file-as-sexp (concat *rameau-path* "answer-sheets/chorales-bach/006.fun") :preserve))
;; (%parse-fchord '|vi6| "F")