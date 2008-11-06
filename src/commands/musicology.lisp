(defpackage :musicology-commands
  (:import-from #:arnesi "AIF" "AWHEN" "IT" "LAST1" "ENABLE-SHARP-L-SYNTAX")
  (:use :rameau :cl-utils :cl-music :cl :iterate :cl-lily :rameau-musicology)
  (:documentation "The computational musicology commands for @rameau"))

(in-package :musicology-commands)

(enable-sharp-l-syntax)

(defun cadence-remove-repeated-chords (full-list)
  (iter (with last-chord = nil)
        (for element in full-list)
        (for (chorale segno segm answ chord &rest ignore) = element)
        (for c = chord)
        (for lc = (fifth last-chord))
        (if (not last-chord)
            (progn (setf last-chord element)
                   (collect element))
            (unless  (and (equalp (fchord-key c) (fchord-key lc))
                          (equal (roman-function-degree-number
                                  (fchord-roman-function c))
                                 (roman-function-degree-number
                                  (fchord-roman-function lc))))
              (collect element)
              (setf last-chord element)))))

(defun normalize-to-key (fchord first-key)
  "Normalize fchord @var{fchord} to be in relation to @var{key}."
  (let* ((this-key (fchord-key fchord))
         (center-pitch (interval (tonal-key-center-pitch first-key)
                                 (tonal-key-center-pitch this-key))))
    (make-fchord :roman-function (fchord-roman-function fchord)
                 :key (make-tonal-key :center-pitch  center-pitch
                                      :mode (tonal-key-mode this-key))
                 :inversion (fchord-inversion fchord)
                 :bass (fchord-bass fchord)
                 :7th (fchord-7th fchord))))


(defun cadence-classifier (window options)
  (declare (ignore options))
  (when (first window)
    (let* ((chords (mapcar #'fifth window))
           (key (fchord-key (first chords))))
      (reduce #'concat
              (mapcar #L(format nil "~a " !1)
                      (cleanup-keys (mapcar #L(normalize-to-key !1 key) chords)))))))

(register-musicology-command :classifier #'cadence-classifier
                             :context 4
                             :functional t
                             :show-as :frequency
                             :generate-figure :cloud
                             :pre-filter #'cadence-remove-repeated-chords
                             :name "cadences"
                             :doc "Detect the chord progressions and
cadences in the specified files using the first specified roman
numeral functional analysis algorithm. The chord progressions will be
in analysis/cadences.png . To detect the end cadences, use the parameter
--last")

(defun %pith-intersection (s1 s2)
  "Calculate the intersection between the pitches of two sonorities."
  (intersection (remove-duplicates (mapcar #'event-pitch s1))
                (remove-duplicates (mapcar #'event-pitch s2))))

(defun schoenberg-classifier (context options)
  (declare (ignore options))
  (destructuring-bind ((chorale segno ps ignore0 p &rest ignore1)
                       (ignore2 ignore3 sonority ignore4 chord &rest ignore5))
      context
    (declare (ignore chorale segno ignore0 ignore1 ignore2 ignore3 ignore4 ignore5))
    (when (and p ps chord sonority (chord-p chord) (chord-p p))
      (cond ((equal (chord-root p) (chord-root chord))
             "Neutral")
            ((null (%pith-intersection ps sonority))
             "Superstrong")
            ((and (member (parse-note (chord-root chord))
                          (mapcar #'event-pitch ps)))
             "Descending")
            ((%pith-intersection ps sonority)
             "Ascending")
            (t "Unexpected")))))

(register-musicology-command :classifier #'schoenberg-classifier
                             :name "schoenberg"
                             :context 2
                             :show-as :frequency
                             :doc "Collect stats on how many chord
progressions found in the chorales are strong, weak, superstrong and
neutral, according to Schoenberg's theory of harmony.") 

(defun has-7th (chord seg)
  (when (not (equal "" (chord-7th chord)))
    (first (member (7th-pitch chord) seg :key #'event-pitch))))

(defun resolve-seventh-classifier (context options)
  (declare (ignore options))
  (destructuring-bind ((i ig ps &rest igno)
                       (ignor ignore seg chord &rest ignore1)
                       (ignore2 ignore3 nseg &rest ignore4))
      context
    (declare (ignore i ig igno ignor ignore ignore1 ignore2 ignore3 ignore4))
    (when (and  ps seg chord nseg (chord-p chord) (has-7th chord seg))
      (let* ((note (has-7th chord seg))
             (pnote (extract-note ps note))
             (nnote (extract-note nseg note))
             (diferenca (- (absolute-pitch note)
                           (absolute-pitch nnote)))
             (sinal (and diferenca (if (< diferenca 0) "up" "down")))
             (pitches (mapcar #'event-pitch (list pnote note nnote)))
             (pitches (mapcar #L(interval !1 (second pitches)) pitches)))
        (format nil "prepare with a~15a, resolved with a ~15a ~5a"
                (print-interval (first pitches))
                (print-interval (third pitches))
                sinal)))))

(register-musicology-command :name "resolve-seventh"
                             :classifier #'resolve-seventh-classifier
                             :context 3
                             :show-as :text-list
                             :doc "Show a summary of all the
seventh-note resolutions found in the files. Only for Bach chorales
or other media with voicing information.")

(defun all-chords (options analysis)
  (iter (for anal in analysis)
        (nconcing
         (append '(nil nil nil nil nil)
                 (all-chords-single options anal)))))

(defun jumps-classifier (context options)
  (declare (ignore options))
  (destructuring-bind ((i ig seg &rest ignore)
                       (ign igno nseg &rest ignore2))
      context
    (declare (ignore i ig ign igno ignore ignore2))
    (iter (for (pnote note) in (zip (sorted seg #'event-<)
                                    (sorted nseg #'event-<)))
          (when (eq :self (event-original-event pnote))
            (collect (print-absolute-interval 
                      (absolute-interval-code note pnote)))))))

(register-musicology-command :name "jumps"
                             :classifier #'jumps-classifier
                             :context 2
                             :doc "List all the steps and leaps in the
                  analysed files. Only for Bach chorales.")

(defun make-report (name segment min-pitch min-octave max-pitch max-octave)
  (let ((note (extract-note segment (make-event :voice-name (quote-string name))))
        (min-ev (make-event :pitch min-pitch :octave min-octave))
        (max-ev (make-event :pitch max-pitch :octave max-octave)))
    (when (or (event-< note min-ev) (event-< max-ev note))
      (format nil "~a ~a ~a"
              name
              (print-event-note note)
              (+ 3 (event-octave note))))))

(defun kostka-amb-classifier (context options)
  (declare (ignore options))
  (destructuring-bind ((i ig segment &rest ignore)) context
    (declare (ignore i ig ignore))
    (remove-if #'null
               (list (make-report "baixo" segment 28 -1 0 1)
                     (make-report "tenor" segment 0 0 55 1)
                     (make-report "alto" segment 55 0 14 2)
                     (make-report "soprano" segment 0 1 55 2)))))

(register-musicology-command :name "kostka-amb"
                             :classifier #'kostka-amb-classifier
                             :show-as :frequency
                             :generate-lily :all
                             :doc "Show where the note ranges for the
voices in a chorale are different from KP rules.
Only for Bach chorales.")

(defun repeated-notes (segmento)
  (/= 4 (length (remove-duplicates (sorted segmento #'event-<)
                                   :test #'equal
                                   :key #L(cons (event-pitch !1)
                                                (event-octave !1))))))

(defun crossing-classifier (context options)
  (declare (ignore options))
  (destructuring-bind ((i ig segment &rest ignore))
      context
    (declare (ignore i ig ignore))
    (when (= 4 (length segment))
      (destructuring-bind (bass tenor alto soprano) (sorted segment #'event-<)
        (unless (or (and (equal (event-voice-name bass) "\"baixo\"")
                         (equal (event-voice-name tenor) "\"tenor\"")
                         (equal (event-voice-name alto) "\"alto\"")
                         (equal (event-voice-name soprano) "\"soprano\""))
                    (repeated-notes segment))
          (format nil "Crossing ~a ~a ~a ~a"
                  (event-voice-name bass)
                  (event-voice-name tenor)
                  (event-voice-name alto)
                  (event-voice-name soprano)))))))

(register-musicology-command :name "crossings"
                             :classifier #'crossing-classifier
                             :show-as :frequency
                             :generate-lily :all
                             :context 1
                             :doc "Find all voice crossings in the
specified files. Only for Bach chorales. Each crossing will be saved
as a lilypond snippet in
analysis/cruzamento-<chorale>-<first-sonority>-<last-sonority>.ly")

(defun chords-classifier (context options)
  (declare (ignore options))
  (destructuring-bind ((chor segno segm ans chord &rest ignore))
      context
    (declare (ignore chor segno segm ans ignore))
    (if (chord-p chord)
        (format nil "~a" (transpose-chord chord
                                          (- (parse-note (chord-root chord)))))
        (format nil "~a" chord))))

(register-musicology-command :name "chords"
                             :classifier #'chords-classifier
                             :context 1
                             :show-as :frequency
                             :doc "List all the chord modes in the analyzed files.")

(defun interval-match (a b interval)
  (= interval (first (interval->code (module (- (event-pitch b)
                                                (event-pitch a)))))))

(defun parallel-classifier (context interval)
  (destructuring-bind (prev seg) (mapcar #L(sorted !1 #'event-<)
                                         (mapcar #'third context))
    (iter (for (a b) in (cartesian-product prev prev))
          (when (and (not (eql a b))
                     (event-< a b)
                     (interval-match a b interval))
            (let ((nexts (sorted (mapcar #L(extract-note seg !1) (list a b))
                                 #'event-<)))
              (when (interval-match (first nexts) (second nexts) interval)
                (collect (format nil "Between ~a and ~a"
                                 (event-voice-name a)
                                 (event-voice-name b)))))))))

(defun get-strong (strong? segments)
  (if strong?
      (remove-if-not #L(integerp (* 4 (event-dur (first !1)))) segments)
      segments))

(defun parallel-fifth-classify (context options)
  (declare (ignore options))
  (parallel-classifier context 5))

(register-musicology-command :classifier #'parallel-fifth-classify
                             :context 2
                             :generate-lily :each
                             :name "fifths"
                             :doc "Detect consecutive fifths in given files")


(defun parallel-octave-classify (context options)
  (declare (ignore options))
  (parallel-classifier context 1))

(register-musicology-command :classifier #'parallel-octave-classify
                             :context 2
                             :generate-lily :each
                             :name "octaves"
                             :doc "Detect consecutive octaves in given files")

(defun print-segments (options)
  (iter (for anal in (analyse-files options :chord-names))
        (format t "Chorale ~a ~%" (analysis-file-name anal))
        (let ((ini (or (arg :start options) 0))
              (fim (or (arg :end options) 1000000)))
          (with-output-file (f (make-analysis-file "ly"
                                                   "segments"
                                                   (analysis-file-name anal)
                                                   ini
                                                   fim))
            (format f "~a"
                    (make-lily-segments
                     options
                     (remove-if #'null
                                (firstn (nthcdr ini (analysis-segments anal))
                                        (min (- fim ini)
                                             (length (analysis-segments anal))))))))
          (iter (for seg in (analysis-segments anal))
                (for i from 0)
                (when (<= ini i fim)
                  (let ((s (sorted seg #'event-<)))
                    (format t "   ~3a ~3a      "
                            i
                            (event-dur (first seg)))
                    (iter (for note in s)
                          (format t "~9a ~2a~2a, "
                                  (event-voice-name note)
                                  (print-event-note note)
                                  (event-octave note)))
                    (format t "~%")))))))

(register-command :name "print-segments"
                  :action #'print-segments
                  :options   '(("-i" "start" "segmento inicial" 0 type-integer)
                               ("-z" "end" "segmento final" 1000000 type-integer))
                  :documentation "Create a lilypond snippet of the
given file between the given sonorities. It will be saved as
analysis/segments-<file>-<start>-<end>.ly")


(defun count-notes-minor-classifier (context options)
  (declare (ignore options))
  (destructuring-bind ((chorale segno segment answer result &rest ignore))
      context
    (declare (ignore ignore chorale segno result))
    (let ((k (fchord-key answer)))
      (when (eql :minor (tonal-key-mode k))
        (mapcar #'print-event-note
              (first (transpose-segmentos (list segment)
                                          (- (tonal-key-center-pitch k)))))))))

(register-musicology-command :classifier #'count-notes-minor-classifier
                             :name "count-minor-notes"
                             :show-as :frequency
                             :functional t
                             :doc "Count the notes in a minor key")

(defun count-notes-major-classifier (context options)
  (declare (ignore options))
  (destructuring-bind ((chorale segno segment answer result &rest ignore))
      context
    (declare (ignore ignore chorale segno result))
    (let ((k (fchord-key answer)))
      (when (eql :major (tonal-key-mode k))
        (mapcar #'print-event-note
              (first (transpose-segmentos (list segment)
                                          (- (tonal-key-center-pitch k)))))))))

(register-musicology-command :classifier #'count-notes-major-classifier
                             :name "count-major-notes"
                             :functional t
                             :show-as :frequency
                             :doc "Count the notes in a major key")