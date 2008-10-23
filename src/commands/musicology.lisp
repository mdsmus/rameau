(defpackage :rameau-musicology
  (:import-from #:arnesi "AIF" "AWHEN" "IT" "LAST1" "ENABLE-SHARP-L-SYNTAX")
  (:use :rameau :genos-utils :musiclib :cl :iterate :cl-lily)
  (:documentation "The computational musicology commands for @rameau"))

(in-package :rameau-musicology)

(enable-sharp-l-syntax)

(defun do-classifier (classifier hash contextual)
  (destructuring-bind (chor seg segm answ &rest results) (first contextual)
    (declare (ignore segm answ results))
    (awhen (listify (funcall classifier contextual))
      (iter (for i in it)
            (if (gethash it hash)
                (push (list chor seg) (gethash i hash))
                (setf (gethash i hash) (list (list chor seg))))))))

(defun count-occurences-into-hash (analysis context-window classifier)
  (let ((h (make-hash-table :test #'equalp)))
    (iter (for anal in analysis)
          (for segno = (iter (for i from 0)
                             (for e in (analysis-segments anal))
                             (collect i)))
          (for results = (analysis-results anal))
          (for answer = (analysis-answer-sheet anal))
          (for segments = (analysis-segments anal))
          (for choraleno = (repeat-list (length answer)
                                        (analysis-file-name anal)))
          (for full-list = (apply #'zip (append (list choraleno
                                                    segno
                                                    segments
                                                    answer)
                                              results)))
          (for contextual = (butlast (group full-list context-window)
                                     (1- context-window)))
          (mapcar #L(do-classifier classifier h !1) contextual))
    h))

(defun sorted-hash (hash)
  "The elements in a frequency hash, sorted by least common first."
  (sorted (all-elements-hash hash) #'< :key #L(length (second !1))))

(defun text-show-hash (hash options)
  "Show a frequency hash as text."
  (iter (for (k v) in (sorted-hash hash))
        (if (< (length v) (arg :max-print-error options))
            (format t " ~20a: ~{~a ~}~%" k v)
            (format t " ~20a: ~a~%" k (length v)))))

(defun frequency-text-show-hash (hash options)
  "Show a frequency hash as frequencies"
  (declare (ignore options))
  (iter (with elements = (sorted-hash hash))
        (with total = (reduce #'+ elements :key #L(length (second !1))))
        (for (k v) in elements)
        (format t " ~20a: ~,1f% (~a of ~a)~%"
                k
                (% (length v) total)
                (length v)
                total)))

(defun make-musicology-action (classifier context display functional)
  (lambda (options)
    (let* ((analysis (if functional
                         (functional-analyse-files options)
                         (analyse-files options)))
           (hash (count-occurences-into-hash analysis
                                             context
                                             classifier)))
      (cond ((arg :freq options) (frequency-text-show-hash hash options))
            ((arg :text options) (text-show-hash hash options))
            (t (funcall display hash options))))))
    
(defun register-musicology-command (&key classifier
                                    (context 1)
                                    functional
                                    (display #'text-show-hash)
                                    name
                                    doc
                                    options)
  (register-command :name name
                    :documentation doc
                    :options (append options
                                     '(("" "freq" "Show as a frequency hash")
                                       ("" "text" "Show as a text hash")
                                       ("" "context" "Override default context"
                                        1 'rameau::type-int)
                                       ("-m" "max-print-error"
                                        "Maximum number of elements to be printed."
                                        10
                                        'rameau::type-int)))
                    :action (make-musicology-action classifier
                                                    context
                                                    display
                                                    functional)))

(defun %pith-intersection (s1 s2)
  "Calculate the intersection between the pitches of two sonorities."
  (intersection (remove-duplicates (mapcar #'event-pitch s1))
                (remove-duplicates (mapcar #'event-pitch s2))))

(defun schoenberg-classifier (context)
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
                             :display #'frequency-text-show-hash
                             :doc "Collect stats on how many chord
progressions found in the chorales are strong, weak, superstrong and
neutral, according to Schoenberg's theory of harmony.") 

(defun has-7th (chord seg)
  (when (not (equal "" (chord-7th chord)))
    (first (member (7th-pitch chord) seg :key #'event-pitch))))

(defun resolve-seventh-classifier (context)
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
                             :display #'text-show-hash
                             :doc "Show a summary of all the
seventh-note resolutions found in the files. Only for Bach chorales
or other media with voicing information.")

(defun all-chords (options analysis)
  (iter (for anal in analysis)
        (nconcing
         (append '(nil nil nil nil nil)
                 (all-chords-single options anal)))))

(defun jumps-classifier (context)
  (destructuring-bind ((i ig seg &rest ignore)
                       (ign igno nseg &rest ignore2))
      context
    (declare (ignore i ig ign igno ignore ignore2))
    (iter (for (pnote note) in (zip seg nseg))
          (when (eq :self (event-original-event pnote))
            (collect (print-absolute-interval 
                      (absolute-interval-code note pnote)))))))


(register-musicology-command :name "jumps"
                             :classifier #'jumps-classifier
                             :context 2
                             :doc "List all the steps and leaps in the
                  analysed files. Only for Bach chorales.")

(defun ambito (options)
  (let ((analysis (analyse-files options)))
    (iter (for anal in analysis)
          (let ((notes (parse-file (analysis-full-path anal)))
                (voices nil))
            (iter (for note in notes)
                  (setf voices (union voices (list (event-voice-name note)))))
            (iter (for voice in voices)
                  (let ((ns (iter (for note in notes)
                                  (if (equal (event-voice-name note) voice)
                                      (collect note))))
                        (min (make-event :pitch 95 :octave 100))
                        (max (make-event :pitch 0 :octave -100)))
                    (iter (for note in ns)
                          (when (event-< note min)
                            (setf min note))
                          (when (event-< max note)
                            (setf max note)))
                    (format t "Chorale ~a voice ~10a min ~2a ~2a max ~2a ~2a~%"
                            (analysis-file-name anal)
                            voice
                            (print-event-note min)
                            (+ 3 (event-octave min))
                            (print-event-note max)
                            (+ 3 (event-octave max)))
                    ))))))

(register-command :name "range"
                  :action #'ambito
                  :documentation "List the ranges of the voices in the
                  analysed files. Only for Bach chorales.")

(defun print-report-ambito (notes min max segs chorale voice options)
  (iter (for next in notes)
        (for segno from 0)
        (for note previous next)
        (for nseg in segs)
        (for seg previous nseg)
        (for pseg previous seg)
        (when (and note
                   (or (event-< note min)
                       (event-< max note)))
          (format t "Chorale ~a voice ~10a note ~a~%" 
                  chorale
                  voice
                  (print-event-note note))
          (with-output-file (f (make-analysis-file "ly" "ambito" chorale voice segno))
            (format f "~a" (make-lily-segments options (list pseg seg nseg)))))))

(defun make-report (name anal options min-pitch min-octave max-pitch max-octave)
  (print-report-ambito (mapcar #L(extract-note !1 (make-event :voice-name
                                                              (quote-string name)))
                               (analysis-segments anal))
                       (make-event :pitch min-pitch :octave min-octave)
                       (make-event :pitch max-pitch :octave max-octave)
                       (analysis-segments anal)
                       (analysis-file-name anal)
                       name
                       options))

(defun kostka-amb (options)
  (iter (for anal in (analyse-files options))
        (make-report "baixo" anal options 28 -1 0 1)
        (make-report "tenor" anal options 0 0 55 1)
        (make-report "alto" anal options 55 0 14 2)
        (make-report "soprano" anal options 0 1 55 2)))

(register-command :name "kostka-amb"
                  :action #'kostka-amb
                  :documentation "Show where the note ranges for the
                  voices in a chorale are different from KP rules.
                  Only for Bach chorales.")

(defun repeated-notes (segmento)
  (/= 4 (length (remove-duplicates (sorted segmento #'event-<)
                                   :test #'equal
                                   :key #L(cons (event-pitch !1)
                                                (event-octave !1))))))

(defun cruzamento (options)
  (iter (for anal in (analyse-files options))
        (let ((notes (analysis-segments anal))
              min max)
          (iter (for segment in notes)
                (for segno from 0)
                (destructuring-bind (baixo tenor alto soprano)
                    (sorted segment #'event-<)
                  (when (= 4 (length segment))
                    (unless (or
                             (and (equal (event-voice-name baixo) "\"baixo\"")
                                  (equal (event-voice-name tenor) "\"tenor\"")
                                  (equal (event-voice-name alto) "\"alto\"")
                                  (equal (event-voice-name soprano) "\"soprano\""))
                             (repeated-notes segment))
                      (unless min
                        (setf min segno))
                      (setf max (1+ segno))
                      (format t "Cruzamento coral ~a segmento ~5a ordem ~a~%"
                              (analysis-file-name anal)
                              segno
                              (mapcar #'event-voice-name segment))))))
          (when (and min max)
            (with-output-file (f (make-analysis-file "ly"
                                                     "cruzamento"
                                                     (analysis-file-name anal)
                                                     min
                                                     max))
              (format f "~a" (make-lily-segments options
                                                 (subseq (analysis-segments anal)
                                                         min
                                                         max))))))))

(register-command :name "crossings"
                  :action #'cruzamento
                  :documentation "Find all voice crossings in the
specified files. Only for Bach chorales. Each crossing will be saved
as a lilypond snippet in
analysis/cruzamento-<chorale>-<first-sonority>-<last-sonority>.ly")


(defun intervals (segment number)
  (iter (for n in segment)
        (for s previous n)
        (when (and n s)
          (when (= number
                   (first (interval->code (module (- (event-pitch n)
                                                     (event-pitch s))))))
            (return (list s n))))))

(defun get-strong (strong? segments)
  (if strong?
      (remove-if-not #L(integerp (* 4 (event-dur (first !1)))) segments)
      segments))

(defun do-parallel (options analysis number name strong)
  #+sbcl(declare (sb-ext:muffle-conditions sb-ext::warning))
  (iter (for anal in analysis)
        (iter (for n in (get-strong strong (analysis-segments anal)))
              (for s previous n)
              (for p previous s)
              (for i from 0)
              (awhen (and n s (intervals (sorted s #'event-<) number))
                (let* ((n1 (first it))
                       (n2 (second it))
                       (v1 (event-voice-name n1))
                       (v2 (event-voice-name n2))
                       (f1 (find-if #L(equal (event-voice-name !1) v1) n))
                       (f2 (find-if #L(equal (event-voice-name !1) v2) n))
                       (d1 (when f1 (- (event-pitch f1)
                                       (event-pitch n1))))
                       (d2 (when f2 (- (event-pitch f2)
                                       (event-pitch n2)))))
                  (when (and f1 f2 (= d1 d2) (not (= d1 0)))
                    (unless strong
                      (with-output-file (f (make-analysis-file "ly"
                                                               "parallel"
                                                               name
                                                               (analysis-file-name anal)
                                                               i))
                        (format f "~a"
                                (make-lily-segments
                                 options
                                 (remove-if #'null (list p s n))))))
                    (format t " parallel ~a chorale ~a voices ~a and ~a sonority ~a notes ~a and ~a to ~a and ~a~%"
                            name
                            (analysis-file-name anal)
                            v1
                            v2
                            i
                            (print-event-note n1)
                            (print-event-note n2)
                            (print-event-note f1)
                            (print-event-note f2))))))))

(defun parallel-fifths (options)
  (let ((analysis (analyse-files options)))
    (format t "Quintas \"reais\":~%")
    (do-parallel options analysis 5 "fifths" nil)
    (format t "Quintas nos tempos fortes:~%")
    (do-parallel options analysis 5 "fifths" t)))

(register-command :name "fifths"
                  :action #'parallel-fifths
                  :documentation "Detect consecutive fifths in the given files.")


(defun parallel-octaves (options)
  (let ((analysis (analyse-files options)))
    (format t "Oitavas reais:~%")
    (do-parallel options analysis 1 "octaves" nil)
    (format t "Oitavas no compassos forte:~%")
    (do-parallel options analysis 1 "octaves" t)))

(register-command :name "octaves"
                  :action #'parallel-octaves
                  :documentation "Detect consecutive octaves and unisons in the given files.")

(defun print-segments (options)
  (iter (for anal in (analyse-files options))
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
