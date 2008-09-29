; Main
;;; Define rameau-main package
(defpackage :rameau-main
  (:import-from #:arnesi "AIF" "AWHEN" "IT" "LAST1" "ENABLE-SHARP-L-SYNTAX")
  (:shadowing-import-from #:rameau-base #:defun #:defmacro #:defparameter #:defvar #:defstruct)
  (:use :rameau :cl :cl-ppcre :lisp-unit :iterate :genoslib)
  (:documentation "Code for the main program that drives \\texttt{rameau}"))

(in-package :rameau-main)

(enable-sharp-l-syntax)

(defun %string->symbol (string &optional (package #+sbcl(sb-int:sane-package) #-sbcl *package*))
  (intern (string-upcase string) package))

(defun rameau-args ()
  "The command-line arguments, minus the first one."
  #+sbcl (rest sb-ext:*posix-argv*)
  #+cmu (subseq cmu-args (1+ (position "cmurameau" extensions:*command-line-strings* :test #'string=)))
  #+clisp ext:*args*)

(defun maptrace :private (lista-string &optional (trace 'trace))
  (let ((expr (append (list trace) (mapcar2 #'read-from-string #'string-upcase lista-string))))
    (eval expr)))

;;; Print messages
(defun print-help :private ()
  (iter (for (key value) in *commands*)
        (format t "~%~:@(* ~a~)~%" (substitute #\Space #\- key :test #'equal))
        (iter (for (short long help) in value)
              (format t "~4T~4a--~25a ~a~%" short long (remove #\Newline help))))
  (rameau-quit))

(defun print-warning :private (message)
  (format t "~&WARNING: ~a~%" message))

(defun print-fatal :private (message)
  (format t "~&FATAL: ~a~%" message))

;;; Tests
(defun print-condition :private (status file expr)
  (format t "[~a] ~a: ~a~%" status (pathname-name file) expr))

(defun print-ok/no-list :private (list options)
  (destructuring-bind (ok no) list
    (let* ((s2 (length no))
           (no-string
            (cond ((zerop (arg :max-print-error options)) no)
                  ((> s2 (arg :max-print-error options))
                   (format nil "~a ..." (subseq no 0 (arg :max-print-error options))))
                  (t no))))
      (format t "  [OK]: ~a [NO]: ~a ~@[~a ~]~%" (length ok) s2 no-string))))

(defun parse-verbose :private (files)
  (dolist (file files)
    (handler-case (parse-file file)
      (serious-condition (expr) (print-condition 'no file expr))
      (:no-error (&rest rest) (print-condition 'ok file rest)))))

(defun parse-summary :private (files)
  (let (ok no)
    (dolist (file files)
      (handler-case (parse-file file)
        (serious-condition (expr)
          (declare (ignore expr))
          (push (pathname-name file) no))
        (:no-error (&rest rest)
          (declare (ignore rest))
          (push (pathname-name file) ok))))
    (list (reverse ok) (reverse no))))

(defun regression :private (options)
  (if (arg :verbose options)
      (parse-verbose (arg :files options))
      (print-ok/no-list (parse-summary (arg :files options)) options)))

(defun unit :private (options)
  (let ((string-result
         (with-output-to-string (string)
           (let ((*standard-output* string))
             (lisp-unit:run-all-tests :rameau-test)
             (format t "~%")))))
    (if (arg :verbose options)
        (write-line string-result)
        (write-line (subseq (last1 (cl-ppcre:split "\\n" string-result)) 34)))))

(defcommand test (options)
  (when (arg :unit options) (unit options))
  (when (arg :regression options) (regression options)))

;;; Analysis
(defcommand analysis (options)
  (let ((analysis (analyse-files options)))
    (iter (for anal in analysis)
          (cond ((arg :dont-compare options) (analysis-terminal-no-answer options anal))
                ((analysis-answer-sheet anal)
                 (analysis-terminal options anal))
                (t (print-warning (concat "the answer sheet for "
                                          (analysis-file-name anal)
                                          " doesn't exist"))
                   (analysis-terminal-no-answer options anal)))
          (when (or (arg :score options) (arg :view-score options) (arg :lily options))
            (analysis-lily options anal)))))

(defcommand functional (options)
  (let ((analysis (functional-analyse-files options)))
    (iter (for anal in analysis)
          (cond ((arg :dont-compare options) (analysis-terminal-no-answer options anal))
                ((analysis-answer-sheet anal)
                 (analysis-terminal options anal))
                (t (print-warning (concat "the answer sheet for "
                                          (analysis-file-name anal)
                                          " doesn't exist"))
                   (analysis-terminal-no-answer options anal)))
          (when (or (arg :score options) (arg :view-score options) (arg :lily options))
            (analysis-lily options anal)))))

(defun average :private (r)
  (let ((l (length r)))
    (iter (for n in r)
          (sum (/ n (coerce l 'single-float))))))

(defun stddev :private (r a)
  (sqrt (iter (for n in r)
              (sum (* (- n a) (- n a))))))

(defun count-hits :private (res gab)
  (length (remove-if #'null (mapcar #'compare-answer-sheet res gab))))

(defcommand collect-data (options)
  (let* ((analysis (analyse-files options))
         (a (first analysis)))
    (format t "~5a|" " ")
    (iter (for alg in (analysis-algorithms a))
          (format t "~7a|" (alg-name alg)))
    (format t "~%")
    (let ((res (iter (for i in (analysis-algorithms (first analysis))) (collect (list 0)))))
      (iter (for anal in analysis)
            (when (analysis-answer-sheet anal)
              (format t "~5a|" (analysis-file-name anal))
              (iter (for r in (analysis-results anal))
                    (for i from 0)
                    (let ((c (count-hits r (analysis-answer-sheet anal))))
                      (format t "~6,2f%|" (% c (length r)))
                      (apush (% c (length r)) (nth i res))))
              (format t "~%")))
      (format t "Medias:~%~5a|" " ")
      (iter (for r in res)
            (format t "~6,2f%|" (average (butlast r))))
      (format t "~%Desvios:~%~5a|" " ")
      (iter (for r in res)
            (format t "~6,2f |" (stddev (butlast r) (average (butlast r)))))
      (format t "~%"))))

(defcommand schoenberg (options)
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

(defun all-chords :private (options analysis)
  (iter (for anal in analysis)
        (nconcing
         (append '(nil nil nil nil nil)
                 (all-chords-single options anal)))))

(defcommand resolve-seventh (options)
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

(defun equivalent-pitch (chord)
  (if (chord-p chord)
      (parse-note (chord-root chord))
      97))

(defcommand view (options)
  (let ((analysis (analyse-files options))
        (pitch-colors (make-hash-table :test #'equal)))
    (iter (for anal in analysis)
          (iter (for alg in (analysis-results anal))
                (for name in (mapcar #'alg-name (analysis-algorithms anal)))
                (for height = (+ 100 (* 20 (length alg))))
                (for width = 500)
                (cl-cairo2:with-png-file ((concat *rameau-path* "analysis/analysis-" (analysis-file-name anal) "-" name ".png")
                                          'cl-cairo2:format-argb32
                                          width
                                          height)
                  (cl-cairo2:select-font-face "Vera" 'cl-cairo2:font-slant-normal 'cl-cairo2:font-weight-bold)
                  (cl-cairo2:set-font-size 20)
                  (cl-cairo2:rectangle 0 0 width height)
                  (cl-cairo2:set-source-rgb 1 1 1)
                  (cl-cairo2:fill-path)
                  (cl-cairo2:set-source-rgb 0 0 0)
                  (cl-cairo2:move-to 20 20)
                  (cl-cairo2:show-text "Pitches")
                  (cl-cairo2:move-to 200 20)
                  (cl-cairo2:show-text (format nil "==> Chords by ~a" name))
                  (iter (for cur-h from 40 below height by 20)
                        (for seg in (analysis-segments anal))
                        (for re in alg)
                        (for vec = (extract-feature-list seg 0))
                        (for cho = (format nil "~a" re))
                        (iter (for pitch in vec)
                              (for i from 2 by 2)
                              (for p from 0)
                              (unless (= 0 pitch)
                                (cl-cairo2:set-font-size (max 5 (min 15 (* 35 pitch))))
                                (aif (gethash p pitch-colors)
                                     (cairo-set-stroke-fill-colors it)
                                     (setf (gethash p pitch-colors) (cairo-random-stroke-fill-colors)))
                                (cl-cairo2:move-to  (+ 20 i) cur-h)
                                (cl-cairo2:show-text (print-note (code->notename p)))))
                        (cl-cairo2:set-font-size 20)
                        (aif (gethash (equivalent-pitch re) pitch-colors)
                             (cairo-set-stroke-fill-colors it)
                             (setf (gethash (equivalent-pitch re) pitch-colors) (cairo-random-stroke-fill-colors)))
                        (cl-cairo2:move-to 400 (- cur-h 5))
                        (cl-cairo2:show-text cho)))))))

(defcommand jumps (options)
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

(defcommand ambito (options)
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

(defcommand kostka-amb (options)
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

(defun repeated-notes :private (segmento)
  (/= 4 (length (remove-duplicates (sorted segmento #'event-<)
                                   :test #'equal
                                   :key #L(cons (event-pitch !1) (event-octave !1))))))

(defcommand cruzamento (options)
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

(defcommand parallel-fifths (options)
  (let ((analysis (analyse-files options)))
    (format t "Quintas \"reais\":~%")
    (do-parallel options analysis 5 "fifths" nil)
    (format t "Quintas nos tempos fortes:~%")
    (do-parallel options analysis 5 "fifths" t)))

(defcommand parallel-octaves (options)
  (let ((analysis (analyse-files options)))
    (format t "Oitavas reais:~%")
    (do-parallel options analysis 1 "octaves" nil)
    (format t "Oitavas no compassos forte:~%")
    (do-parallel options analysis 1 "octaves" t)))

(defcommand print-segments (options)
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

(defun answer->mode (answer)
  (cond ((chord-p answer) (list :chord
                                (make-keyword (chord-mode answer))
                                (make-keyword (chord-7th answer))))
        ((melodic-note-p answer) (list :non-chord-tone))
        ((augmented-sixth-p answer) (list :aug6 (make-keyword (augmented-sixth-type answer))))
        (t nil)))

(defun make-precision-table (f name func algorithms answer correct obtained modes)
  (format f "\\begin{table}~%\\begin{center}~%\\begin{tabular}{r|~{~a~^|~}}~%"
          (mapcar (lambda (x) (declare (ignore x)) "r") algorithms))
  (format f "   ~{& ~a~}  \\\\~%" (mapcar #'alg-name algorithms))
  (iter (for m in modes)
        (format f " ~a " (mode->answer m))
        (iter (for a in algorithms)
              (for re in answer)
              (for right in correct)
              (for ob in obtained)
              (format f "& $~,1f$ " (* 100 (funcall func m re right ob))))
        (format f " \\\\~%"))
  (format f "\\end{tabular}~%\\caption{~a matrix}~%\\end{center}~%\\end{table}~%"
          name))

(defun mode->answer (mode)
  (case (first mode)
    (:chord (format nil "~a~a"
                    (if (or (null (second mode))
                            (equal :|| (second mode)))
                        "M"
                        (format nil "~(~a~)" (second mode)))
                    (format nil "~(~a~)" (third mode))))
    (:non-chord-tone "nct")
    (:aug6 (make-augmented-sixth :type (format nil "~(~a~)" (second mode))))
    (t "")))

(defun make-confusion-matrixes (f algorithms matrixes modes)
  (iter (for a in algorithms)
        (for cm in matrixes)
        (for nmodes = (length modes))
        (format f "\\begin{table}~%\\begin{center}~%\\begin{tabular}{r|~{~a~^|~}}~%"
                (mapcar (lambda (x) (declare (ignore x)) "r") modes))
        (format f "       & ~{~a~^ & ~} \\\\ \\hline~%" (mapcar #'mode->answer modes))
        (iter (for m in modes)
              (for n from 0)
              (format f " ~a " (mode->answer m))
              (iter (for i from 0 below nmodes)
                    (format f "& $~,1f$ " (if (or (= 0.0 (aref cm n i))
                                                  (= i n))
                                              " "
                                              (aref cm n i))))
              (format f " \\\\ \\hline~%"))
        (format f "\\end{tabular}~%\\caption{Confusion matrix for ~a}~%\\end{center}~%\\end{table}~%"
                (alg-name a))))

(defun build-confusion-matrixes (confusion-matrix countings matrixes modes)
  (iter (for a in *algorithms*)
        (for c in confusion-matrix)
        (for co in countings)
        (for i from 0)
        (let ((conf (make-array (list (length modes) (length modes)) :initial-element 0)))
          (iter (for ((an ga) count) in-hashtable c)
                (incf (aref conf (position ga modes :test #'equal) (position an modes :test #'equal))
                      (% count (gethash ga co 0.0000000001))))
          (setf (nth i matrixes) conf))))

(defun /0 (a b)
  (if (zerop b) 0 (/ a b)))

(defun precision (m re right ob)
  (declare (ignore re))
  (/0 (gethash m right 0) (+ (gethash m right 0) (gethash m ob 0))))

(defun recall (m re right ob)
  (declare (ignore ob))
  (/0 (gethash m right 0) (+ (gethash m right 0) (gethash m re 0))))

(defun f-measure (m re right ob)
  (sqrt (* (precision m re right ob)
           (recall    m re right ob))))

(defcommand report (options)
  (let* ((analysis (analyse-files options))
         (algorithms (analysis-algorithms (first analysis)))
         (confusion-matrix (iter (for a in algorithms)
                                 (collect (make-hash-table :test #'equal))))
         (countings (iter (for a in algorithms)
                          (collect (make-hash-table :test #'equal))))
         (modes (make-hash-table :test #'equal))
         (matrixes (repeat-list (length algorithms) nil))
         (obtained (iter (for i in algorithms) (collect (make-hash-table :test #'equal))))
         (correct (iter (for i in algorithms) (collect (make-hash-table :test #'equal))))
         (answer (iter (for i in algorithms) (collect (make-hash-table :test #'equal)))))
    (iter (for anal in analysis)
          (iter (for alg in algorithms)
                (for r in (analysis-results anal))
                (for m in confusion-matrix)
                (for co in countings)
                (for re in answer)
                (for ob in obtained)
                (for right in correct)
                (iter (for an in r)
                      (for ga in (analysis-answer-sheet anal))
                      (let ((ga (if (listp ga) (first ga) ga)))
                        (incf (gethash (answer->mode ga)
                                       co
                                       0))
                        (setf (gethash (answer->mode an) modes) t
                              (gethash (answer->mode ga) modes) t)
                        (incf (gethash (list (answer->mode an) (answer->mode ga)) m 0))
                        (if  (rameau::%compare-answer-sheet an ga)
                             (incf (gethash (answer->mode an) right 0))
                             (progn
                               (incf (gethash (answer->mode ga) re 0))
                               (incf (gethash (answer->mode an) ob 0))))))))
    (format t "Done counting...~%")
    (setf modes (iter (for (mode va) in-hashtable modes) (collect mode)))
    (build-confusion-matrixes confusion-matrix countings matrixes modes)
    (format t "Done building confusion matrix...~%")
    (with-open-file (f (concat *rameau-path* "analysis/report.tex")
                       :direction :output
                       :if-exists :supersede)
      (format f "
\\documentclass{article}
\\usepackage{amsmath}
\\usepackage[utf8x]{inputenc}
\\usepackage[T1]{fontenc}
\\usepackage[english]{babel}
\\usepackage{times}
\\usepackage{color}
\\usepackage[displaymath,textmath,sections,graphics,floats,auctex]{preview}

\\title{Tabelas de resultados do Rameau}
\\author{Rameau}

\\begin{document}

\\maketitle

")
      (make-confusion-matrixes f algorithms matrixes modes)
      (make-precision-table f "Precision"
                            #'precision
                            algorithms
                            answer
                            correct
                            obtained
                            modes)
      (make-precision-table f "Recall"
                            #'recall
                            algorithms
                            answer
                            correct
                            obtained
                            modes)
      (make-precision-table f "F-measure"
                            #'f-measure
                            algorithms
                            answer
                            correct
                            obtained
                            modes)
      (format f "~%\\end{document}~%")
      (format t "Modes: ~s~%" modes))))

(defun make-training-data (options)
  (setf *training-data*
        (iter (for f in (arg :files options))
              (awhen (path-parse-answer-sheet (format nil "~a" f))
                (collect (list (sonorities (parse-file f))
                               it))))))

(defun make-functional-training-data (options)
  (setf *training-data*
        (iter (for f in (arg :files options))
              (awhen (path-parse-functional-answer-sheet (format nil "~a" f))
                (collect (list (sonorities (parse-file f))
                               it))))))

(defcommand algorithms (options &rest ignore)
  (declare (ignore ignore))
  (make-training-data options)
  (setf (arg :algorithms options) (mapcar #'load-alg (filter-algorithms (arg :algorithms options) *algorithms*))
        (arg :options options) (process-option-list (arg :options options)))
  (iter (for alg in (arg :algorithms options))
        (do-options alg options)
        (save-alg alg))
  (setf (arg :algorithms options) nil
        *training-data* nil))

(defcommand funalg (options &rest ignore)
  (declare (ignore ignore))
  (make-functional-training-data options)
  (setf (arg :algorithms options) (mapcar #'load-alg (filter-algorithms (arg :algorithms options) *functional-algorithms*))
        (arg :options options) (process-option-list (arg :options options)))
  (iter (for alg in (arg :algorithms options))
        (format t "Options for ~a~%" (alg-name alg))
        (do-options alg options)
        (save-alg alg))
  (setf (arg :algorithms options) nil
        *training-data* nil))

(defcommand web (options &rest ignore)
  (declare (ignore ignore))
  (let ((port (arg :port options)))
    (format t "Starting rameau web on port ~a.~%" port)
    (write-line "Open http://localhost:4242/rameau/index.html on your browser")
    (rameau-web::start-rameau-web port))
  (loop))

(defcommand document (options &rest ignore)
  (declare (ignore ignore options))
  (rameau-doc:create-documentation-for-all-packages))

;;; Main
(defun split-command-list :private (command-list)
  (let ((pos (position "and" command-list :test #'string=)))
    (if pos
        (append (list (subseq command-list 0 pos))
                (split-command-list (subseq command-list (1+ pos))))
        (list command-list))))

(defun parse-options :private (command list)
  "Parse the list of options to a structure."
  (loop for item in (sublist-of-args list #\-) collect
        (destructuring-bind (flag &rest value) item
          (list (cond ((long-flag? flag)
                       (make-keyword (get-long-flag-name command flag)))
                      ((short-flag? flag)
                       (make-keyword (get-short-flag-name command flag))))
                (if value
                    (let ((type (cond ((long-flag? flag)
                                       ;; FIXME: that's ugly
                                       (get-type-by-name command (remove #\- flag :count 2)))
                                      ((short-flag? flag)
                                       (get-type-by-flag command flag)))))
                      (case type
                        (type-list value)
                        (type-integer (parse-integer (first value)))
                        (t (first value))))
                    t)))))

(defun parse-files :private (options)
  (loop for file in (arg :files options) append
        (if (search "/" file)
            (list file)
            (parse-file-name file options))))

(defun print-about ()
  (macrolet ((get-info (info)
               `(when (boundp ',info)
                  ,info)))
    (format t
            "Rameau ~@[~a~] was compiled with ~@[~a~], version ~@[~a~], in ~@[~a~] by ~@[~a~],
  at least using commit ~@[~a~], on the system:~%  ~@[~a~],
  using libc version ~@[~a~]~%"
            (get-info cl-user::*rameau-version*)
            (lisp-implementation-type)
            (lisp-implementation-version)
            (get-info cl-user::*compilation-date*)
            (get-info cl-user::*user*)
            (get-info cl-user::*git-commit*)
            (get-info cl-user::*kernel-info*)
            (get-info cl-user::*libc-version*))
    (rameau-quit)))

(defun main (&optional args)
  "You can run main from the REPL with all arguments as a
  string: (main \"analysis chorales -v -f 001\")"
                                        ;(format t "Done, processing arguments...~%")
  (let* ((*package* (find-package :rameau-main))
         (rameau-args (rameau-args))
         (arguments (if rameau-args rameau-args (cl-ppcre:split " " args)))
         (options (make-default-arguments)))
    (if arguments
        (iter (for command-list in (split-command-list arguments))
              (for cmd = (first command-list))
              (for command = (search-string-in-list cmd *command-names*))
              ;; revert to default arguments
              ;; apply command-line options
              (iter (for (key value) in (parse-options command (rest command-list)))
                    (if key
                        (setf (arg key options) value)
                        (return-from main  (progn (format t "ERROR: command not found. Exiting.~%") 1))))
              (aif (arg :debug options)
                   (mapcar2 #'rameau-debug #'make-keyword it)
                   (rameau-undebug))
              (when (arg :crazy-debug options)
                (setf yacc::*warn-on-tokens* t
                      lexer::*warn-on-token* t))
              (when (arg :profile options)
                (rameau-profile))
              (awhen (arg :trace options)
                (maptrace it))
              (when (or (arg :help options) (string= cmd "-h")) (print-help))
              (when (or (arg :about options) (string= cmd "-A"))
                (print-about))
              ;; parse file options
              (setf (arg :files options) (parse-files options))
              ;; parse algorithms options
              (let ((fn (%string->symbol command)))
                (if (fboundp fn)
                    (funcall fn options)
                    (print-fatal (concat cmd " is not a rameau command."))))
              (when (arg :profile options)
                (rameau-report)))
        ;;(dbg 'main "~a" (print-slots options))

        (print-help)))
  #+clisp(ext:exit)
  0)
(format t "Algorithms: ~a~%" (mapcar #'alg-name *algorithms*))
(main "algorithms -o train -a net -f chor:1..6 exa:11..13 exa:23..28")
(main "algorithms -o train -a hmm tree bay knn -f chor:1..10 exa:11..13 exa:23..28 chor:12 chor:14 chor:17..33 ")
(format t "FAlgorithms: ~a~%" (mapcar #'alg-name *functional-algorithms*))
(main "funalg -o train -a hmm -f chor:1..3 exa:001 chor:1..3 chor:006")
