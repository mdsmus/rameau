(defpackage :rameau-musicology
  (:shadowing-import-from #:rameau-base #:defun #:defmacro #:defgeneric
                          #:defparameter #:defvar #:defstruct #:defclass)
  (:import-from #:arnesi "AIF" "AWHEN" "IT" "LAST1" "ENABLE-SHARP-L-SYNTAX")
  (:use :rameau :genoslib :cl :iterate :cl-lily)
  (:documentation "The computational musicology commands for @rameau{}"))

(in-package :rameau-musicology)

(enable-sharp-l-syntax)

(defun schoenberg (options)
  (let ((analysis (analyse-files options))
        ascending
        descending
        superstrong
        neutral)
    (iter (for anal in analysis)
          (iter (for (chord sonority chorale segno) in (remove-if-not #L(chord-p (first !1)) (all-chords-single options anal)))
                (for p previous chord)
                (for ps previous sonority)
                (when (and p ps chord sonority)
                  (cond ((equal (chord-root p) (chord-root chord))
                         (push (list chorale segno) neutral))
                        ((null (intersection (remove-duplicates (mapcar #'event-pitch ps))
                                             (remove-duplicates (mapcar #'event-pitch sonority))))
                         (push (list chorale segno) superstrong))
                        ((and (member (parse-note (chord-root chord))
                                      (mapcar #'event-pitch ps)))
                         (push (list chorale segno) descending))
                        ((intersection (remove-duplicates (mapcar #'event-pitch ps))
                                       (remove-duplicates (mapcar #'event-pitch sonority)))
                         (push (list chorale segno) ascending))
                        (t (format t "Error: ~a ~a ~a ~a~%" p chord chorale segno))))))
    (let ((total (length (append ascending descending superstrong neutral))))
      (format t "  Ascending: ~,1f%~%" (% (length ascending) total))
      (format t " Descending: ~,1f%~%" (% (length descending) total))
      (format t "Superstrong: ~,1f%~%" (% (length superstrong) total))
      (format t "    Neutral: ~,1f%~%" (% (length neutral) total)))))

(register-command :name "schoenberg"
                  :documentation  "Collect stats on how many chord progressions found in the chorales are strong,
weak, superstrong and neutral, according to Schoenberg's theory of harmony."
                  :action #'schoenberg)


(defun all-chords :private (options analysis)
  (iter (for anal in analysis)
        (nconcing
         (append '(nil nil nil nil nil)
                 (all-chords-single options anal)))))

(defun resolve-seventh (options)
  (let ((analysis (analyse-files options)))
    (iter (for next in (all-chords options analysis))
          (for chord previous next)
          (for prev previous chord)
          (when (and chord next prev (chord-p (first chord)) (not (equal "" (chord-7th (first chord)))))
            (let* ((pitch (7th-pitch (first chord)))
                   (voices (remove-if-not #L(equal (event-pitch !1) pitch) (second chord))))
              (iter (for voice in voices)
                    (let* ((nota1 (extract-note (second prev) voice))
                           (nota2 (extract-note (second chord) voice))
                           (nota3 (extract-note (second next) voice))
                           (diferenca (and nota1 nota2 nota3
                                           (- (absolute-pitch nota2) (absolute-pitch nota3))))
                           (sinal (and diferenca (if (< diferenca 0) "+" "-")))
                           (intervalo (and diferenca (interval->code (module diferenca)))))
                      (when intervalo
                        (with-open-file (f (concat *rameau-path* (format nil "analysis/seventh-~a-~a.ly"
                                                                         (third chord)
                                                                         (fourth chord)))
                                           :direction :output
                                           :if-exists :supersede)
                          (format f "~a" (make-lily-segments options
                                                             (list (second prev)
                                                                   (second chord)
                                                                   (second next)))))
                        (format t "  ~3a ~3a ~9a de ~2a setima ~2a resolve ~2a ~a~9a~%"
                                (third chord)
                                (fourth chord)
                                (event-voice-name nota1)
                                (print-event-note nota1)
                                (print-event-note nota2)
                                (print-event-note nota3)
                                sinal
                                intervalo)))))))))

(register-command :name "resolve-seventh"
                  :action #'resolve-seventh
                  :documentation "Show a summary of all the seventh-note resolutions found in the files. Only for Bach chorales.")

(defun jumps (options)
  (let ((jumps (make-hash-table :test #'equal))
        (analysis (analyse-files options)))
    (iter (for anal in analysis)
          (let ((notes (parse-file (analysis-full-path anal)))
                (voices nil))
            (iter (for note in notes)
                  (setf voices (union voices (list (event-voice-name note)))))
            (iter (for voice in voices)
                  (let* ((ns (iter (for note in notes)
                                   (if (equal (event-voice-name note) voice)
                                       (collect note))))
                         (total (length ns)))
                    (iter (for n in ns)
                          (for i from 0)
                          (for p previous n)
                          (when (and n p)
                            (push (list (analysis-file-name anal)
                                        (* 100.0 (/ i total))
                                        voice
                                        (print-event-note p)
                                        (print-event-note n))
                                  (gethash (absolute-interval-code n p)
                                           jumps))))))))
    (if (arg :verbose options)
        (iter (for (k v) in-hashtable jumps)
              (format t "~20a: ~%" (print-absolute-interval k))
              (if (< (length v) (make-int (arg :max-print-error options)))
                  (iter (for i in v)
                        (for n from 0)
                        (format t "          chorale ~a in ~,2f%, of voice ~a from ~a to ~a~%"
                                (first i)
                                (second i)
                                (third i)
                                (fourth i)
                                (fifth i)))
                  (format t "               ~a saltos" (length v)))
              (format t "~%~%"))
        (iter (for (k v) in-hashtable jumps)
              (format t "~20a: ~a~%" (print-absolute-interval k) (length v))))))

(register-command :name "jumps"
                  :action #'jumps
                  :documentation "List all the steps and leaps in the analysed files. Only for Bach chorales.")

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
                  :documentation  "List the ranges of the voices in the analysed files. Only for Bach chorales.")


(defun print-report-ambito :private (notes min max segs chorale voice options)
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
          (with-open-file (f (concat *rameau-path* (format nil "analysis/ambito-~a-~a-~a.ly"
                                                           chorale
                                                           voice
                                                           segno))
                             :direction :output
                             :if-exists :supersede)
            (format f "~a" (make-lily-segments options (list pseg seg nseg)))))))

(defun kostka-amb (options)
  (iter (for anal in (analyse-files options))
        (let ((baixos   (mapcar #L(extract-note !1 (make-event :voice-name "\"baixo\"")) (analysis-segments anal)))
              (tenores  (mapcar #L(extract-note !1 (make-event :voice-name "\"tenor\"")) (analysis-segments anal)))
              (altos    (mapcar #L(extract-note !1 (make-event :voice-name "\"alto\"")) (analysis-segments anal)))
              (sopranos (mapcar #L(extract-note !1 (make-event :voice-name "\"soprano\"")) (analysis-segments anal)))
              (mins (make-event :pitch 0 :octave 1))
              (maxs (make-event :pitch 55 :octave 2))
              (mina (make-event :pitch 55 :octave 0))
              (maxa (make-event :pitch 14 :octave 2))
              (mint (make-event :pitch 0 :octave 0))
              (maxt (make-event :pitch 55 :octave 1))
              (minb (make-event :pitch 28 :octave -1))
              (maxb (make-event :pitch 0 :octave 1)))
          (print-report-ambito baixos minb maxb (analysis-segments anal) (analysis-file-name anal) "baixo" options)
          (print-report-ambito tenores mint maxt (analysis-segments anal) (analysis-file-name anal) "tenor" options)
          (print-report-ambito altos mina maxa (analysis-segments anal) (analysis-file-name anal) "alto" options)
          (print-report-ambito sopranos mins maxs (analysis-segments anal) (analysis-file-name anal) "soprano" options))))

(register-command :name "kostka-amb"
                  :action #'kostka-amb
                  :documentation "Show where the note ranges for the voices in a chorale are different from KP rules. Only for Bach chorales.")


(defun repeated-notes :private (segmento)
  (/= 4 (length (remove-duplicates (sorted segmento #'event-<)
                                   :test #'equal
                                   :key #L(cons (event-pitch !1) (event-octave !1))))))

(defun cruzamento (options)
  (iter (for anal in (analyse-files options))
        (let ((notes (analysis-segments anal))
              min max)
          (iter (for segment in notes)
                (for segno from 0)
                (let ((segment (sorted segment #'event-<)))
                  (when (= 4 (length segment))
                    (unless (or
                             (and (equal (event-voice-name (first segment)) "\"baixo\"")
                                  (equal (event-voice-name (second segment)) "\"tenor\"")
                                  (equal (event-voice-name (third segment)) "\"alto\"")
                                  (equal (event-voice-name (fourth segment)) "\"soprano\""))
                             (repeated-notes segment))
                      (unless min
                        (setf min segno))
                      (setf max (1+ segno))
                      (format t "Cruzamento coral ~a segmento ~5a ordem ~a~%"
                              (analysis-file-name anal)
                              segno
                              (mapcar #'event-voice-name segment))))))
          (when (and min max)
            (with-open-file (f (concat *rameau-path* (format nil "analysis/cruzamento-~a-~a-~a.ly"
                                                             (analysis-file-name anal)
                                                             min
                                                             max))
                               :direction :output
                               :if-exists :supersede)
              (format f "~a" (make-lily-segments options (subseq (analysis-segments anal) min max))))))))

(register-command :name "crossings"
                  :action #'cruzamento
                  :documentation  "Find all voice crossings in the specified files. Only for Bach chorales. Each crossing will be saved
as a lilypond snippet in analysis/cruzamento-<chorale>-<first-sonority>-<last-sonority>.ly")


(defun intervals :private (segment number)
  (iter (for n in segment)
        (for s previous n)
        (when (and n s)
          (when (= number
                   (first (interval->code (module (- (event-pitch n) (event-pitch s))))))
            (return (list s n))))))

(defun get-strong :private (strong? segments)
  (if strong?
      (remove-if-not #L(integerp (* 4 (event-dur (first !1)))) segments)
      segments))

(defun do-parallel :private (options analysis number name strong)
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
                      (with-open-file (f (concat *rameau-path* (format nil "analysis/parallel-~a-~a-~a.ly"
                                                                       name
                                                                       (analysis-file-name anal)
                                                                       i))
                                         :direction :output
                                         :if-exists :supersede)
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
          (with-open-file (f (concat *rameau-path* (format nil "analysis/segments-~a-~a-~a.ly"
                                                           (analysis-file-name anal)
                                                           ini
                                                           fim))
                             :direction :output
                             :if-exists :supersede)
            (format f "~a"
                    (make-lily-segments
                     options
                     (remove-if #'null (firstn (nthcdr ini (analysis-segments anal))
                                               (min (- fim ini) (length (analysis-segments anal))))))))
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
                               ("-z" "end" "segmendo final" 1000000 type-integer))
                  :documentation "Create a lilypond snippet of the given file between the given sonorities. It will be saved
as analysis/segments-<file>-<start>-<end>.ly")
