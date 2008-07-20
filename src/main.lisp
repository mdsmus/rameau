; Main
;;; Define rameau-main package
(defpackage :rameau-main
  (:import-from #:arnesi "AIF" "AWHEN" "IT" "LAST1" "ENABLE-SHARP-L-SYNTAX")
  (:import-from #:rameau-options #:parse-file-name)
  (:shadowing-import-from #:rameau-base #:defun #:defmacro #:defparameter #:defvar #:defstruct)
  (:use :rameau :cl :cl-ppcre :lisp-unit :iterate :rameau-options :rameau-terminal :genoslib :rameau-lily)
  (:documentation "Code for the main program that drives \\texttt{rameau}"))

(in-package :rameau-main)

(enable-sharp-l-syntax)

(defparameter *command-names* nil)

(defmacro defcommand (name (&rest args) &body body)
  "Wrapper to defun. Store the name of the command in *commands-names."
  `(progn
     (push (string-downcase (symbol-name ',name)) *command-names*)
     (defun ,name ,args
     ,@body)))

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

;;; Make analysis

(defun main-perform-analysis (segments options alg)
  (handler-case (perform-analysis segments options alg)
    (t ()
      (format t "Analysis failed for algorithm ~a. Please report a bug.~%" alg)
      nil)))

(defun main-parse-file (file)
  (handler-case (parse-file file)
    (t ()
      (format t "Could not parse file ~a.
Please check with lilypond to see if it is valid. If it is, please report a bug.~%"
              file)
      (rameau-quit))))

(defun analyse-files :private (options)
  (setf (arg :algorithms options) (mapcar #'load-alg (filter-algorithms (arg :algorithms options)))
        (arg :options options) (process-option-list (arg :options options)))
  (let ((analysis (handler-case (loop
                                   for file in (arg :files options)
                                   for segments = (sonorities (main-parse-file file))
                                   collect
                                     (make-analysis
                                      :segments segments
                                      :results (mapcar #L(main-perform-analysis segments options !1)
                                                       (arg :algorithms options))
                                      :answer-sheet (new-parse-answer-sheet (pathname-name file) (arg :substring options))
                                      :file-name (pathname-name file)
                                      :number-algorithms (length (arg :algorithms options))
                                      :algorithms (arg :algorithms options)
                                      :notes (mapcar #'list-events segments)
                                      :ast (file-ast file)
                                      :full-path file
                                      :dur (durations segments)))
                    (t () (list (make-analysis :segments (list nil)))))))
    (when (every #'null (mapcar #'analysis-segments analysis))
      (format t "ERROR: Couldn't analyse. Did you specify the files and the algorithms?
If you did, we have a bug, so please report.~%")
      (rameau-quit))
    analysis))

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
(defun make-result-list :private (analysis)
  (apply #'mapcar #'list (analysis-results analysis)))

(defun analysis-terminal :private (options analysis)
  (let* ((number-algorithms (analysis-number-algorithms analysis))
         (size-line (hline-size number-algorithms options)))
    (format t "~2%")
    (print-line-term options "#" "notes" "dur" "answer")
    (iter (for algo in (arg :algorithms options))
          (print-chord-column options (alg-name algo)))
    (print-hline-term size-line)
    (iter (with right-answer-list = (make-list number-algorithms :initial-element 0))
          (for note in (analysis-notes analysis))
          (for dur in (analysis-dur analysis))
          (for seg-number from 1)
          (for answer in (analysis-answer-sheet analysis))
          (for result in (make-result-list analysis))
          (for comparison = (mapcar (lambda (x) (compare-answer-sheet x answer)) result))
          (setf right-answer-list (inc-bool-list comparison right-answer-list))
          (print-line-term options seg-number note dur answer)
          (iter (for res in result)
                (for comp in comparison)
                (print-color-terminal res comp options))
          (finally
           (print-hline-term size-line)
           (print-footer-term "CORRECT(%)" size-line number-algorithms options)
           (iter (for i in (mapcar (lambda (x) (% x seg-number)) right-answer-list))
                 (print-chord-column options (format nil "~,2f" i)))
           (format t "~%")))))



(defun analysis-terminal-no-answer :private (options analysis)
  (let* ((number-algorithms (analysis-number-algorithms analysis))
         (size-line (hline-size number-algorithms options 'no-answer)))
    (format t "~2%")
    (print-line-term options "#" "notes" "dur")
    (iter (for algo in (arg :algorithms options))
          (print-chord-column options (alg-name algo)))
    (print-hline-term size-line)
    (iter (for note in (analysis-notes analysis))
          (for dur in (analysis-dur analysis))
          (for seg-number from 1)
          (for result in (make-result-list analysis))
          (print-line-term options seg-number note dur)
          (iter (for res in result)
                (print-chord-column options res))
          (finally
           (print-hline-term size-line)
	   (when (arg :sonorities options)
	     (format t "~&TOTAL SONORITIES: ~a~%" seg-number))))))

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
          (when (or (arg :score options) (arg :view-score options))
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

(defun all-chords-single :private (options anal)
  (declare (ignore options))
  (iter (for chord in (first (analysis-results anal)))
        (for segment in (analysis-segments anal))
        (for i from 0)
        (collect (list chord segment (analysis-file-name anal) i))))

(defun all-chords :private (options analysis)
	(iter (for anal in analysis)
				(nconcing
						(append '(nil nil nil nil nil)
										(all-chords-single options anal)))))

(defun root-pitch :private (chord)
  (parse-note (chord-root chord)))

(defun chord-interval-number :private (a b)
  (first (interval->code (module (- (root-pitch a) (root-pitch b))))))

(defun remove-repeated-chords :private (chords)
  (let (last-chord)
    (iter (for chord in chords)
          (for prev previous chord)
          (if (not last-chord)
              (progn (setf last-chord chord)
                     (collect chord))
              (unless  (equal (chord-root (first chord))
                              (chord-root (first last-chord)))
                (collect chord)
                (setf last-chord chord))))))

(defun prepare-cadence :private (options anal n)
  (butlast (group (remove-repeated-chords (remove-if-not #L(chord-p (first !1)) (all-chords-single options anal)))
                  n)
           (1- n)))

(defun print-roman :private (number chord)
  (let* ((mode (chord-mode chord))
         (major? (equal "" mode)))
    (if major?
        (format nil "~@r" number)
        (format nil "~(~@r~a~)" number (if (equal mode "m") "" mode)))))

(defun add-to-cadence-hash :private (hash chords file-name segno)
  (let ((root (last1 chords)))
    (push (list file-name segno)
          (gethash (reduce #'concat (mapcar #L(format nil "~4a " (print-roman (chord-interval-number !1 root) !1)) chords))
                   hash))))

(defun make-int :private (value)
  (if (integerp value)
      value
      (parse-integer value)))

(defun show-cadence-hash :private (options cadences)
  (iter (for (cadence  places) in (sorted (iter (for (cadence places) in-hashtable cadences)
                                                (collect (list cadence places)))
                                          #L(< (length (second !1))
                                               (length (second !2)))))
        (if (< (make-int (arg :max-print-error options))
               (length places))
            (format t "  ~a found ~a times (max ~a)~%"
                    cadence (length places) (arg :max-print-error options))
            (progn
              (format t " ~a [~a] found in: "
                      cadence (length places))
              (iter (for cad in places)
                    (format t "(~a ~a) " (first cad) (second cad)))
              (format t "~%")))))

(defun dimensions (box)
  (let ((x0 (svref box 0))
        (y0 (svref box 1))
        (x1 (svref box 2))
        (y1 (svref box 3)))
    (list (/ (- x1 x0) 2) (/ (- y1 y0) 2))))

(defun collides (boxa boxb)
  (destructuring-bind ((cxa cya dxa dya &rest foo) (cxb cyb dxb dyb &rest bar))
      (list boxa boxb)
    (declare (ignore foo bar))
    (and (> (+ 10 dxa dxb) (abs (- cxa cxb)))
         (> (+ 5 dya dyb) (abs (- cya cyb))))))

(defun approach-0 (number step)
  (if (< number 0)
      (- number step)
      (+ number step))) 

(defun make-cadence-figure (cadences name)
  (make-random-state t)
  (dbg :cadence-figure "Setting up...~%")
  (vecto:with-canvas (:width 2000 :height 2000)
      (let* ((font (vecto:get-font (rameau-get-font-path "Vera.ttf")))
             (center (list 1000 1000))
             (boxes nil)
             (cadences (sorted (iter (for (cadence places) in-hashtable cadences)
                                     (collect (list cadence places)))
                               #L(> (length (second !1))
                                    (length (second !2)))))
             (max-size (length (second (first cadences)))))
        (vecto:rectangle 0 0 2000 2000)
        (vecto:set-rgb-stroke 0 0 0)
        (vecto:fill-path)
        (dbg :cadence-figure "Done. Computing the positions...~%")
        (iter (for (cadence  places) in cadences)
              (for i from 1)
              (dbg :cadence-figure "  Computing position step ~a~%" i)
              (let* ((size (genoslib::normalize 10d0 55d0 0d0 max-size  (length places)))
                     (dim (append (dimensions (vecto:string-bounding-box cadence size font))
                                  (list cadence size)))
                     (angle (random (* 2 pi)))
                     (cenx (* 1500 (cos angle)))
                     (ceny (* 1500 (sin angle)))
                     (box (cons cenx (cons ceny dim)))
                     (stepx (* 10 (cos angle)))
                     (stepy (* 10 (sin angle))))
                (iter (for n from 1 to 220)
                      (if boxes
                          (if (some #'identity (mapcar #L(collides !1 box) boxes))
                              (return)
                              (setf box (cons (- (first box) stepx)
                                              (cons (- (second box) stepy)
                                                    dim))))
                          (progn (setf box (cons 0 (cons 0 dim)))
                                 (return))))
                (push box boxes)
                (dbg :cadence-figure "  Cadence ~a at ~a sx ~a sy ~a ~%" i box stepx stepy)))
        (dbg :cadence-figure "Done. Painting cadences...~%")
        (iter (for (cx cy dx dy cadence size) in boxes)
              (for i from 1)
              (dbg :cadence-figure "  Painting cadence ~a at center ~a ~a size ~a~%" i
                      (+ cx (first center))
                      (+ cy (second center))
                      size)
              (random-stroke-fill-colors)
              (vecto:set-font font size)
              (vecto:centered-string-paths (+ cx (first center))
                                           (+ cy (second center))
                                           cadence)
              (vecto:fill-and-stroke))
        (dbg :cadence-figure "Done. Saving...~%")
        (vecto:save-png (format nil "~a/analysis/cadences-~a.png" *rameau-path* name))
        (dbg :cadence-figure "Done.~%"))))
                                           
                      

(defcommand cadences (options)
  (let ((analysis (analyse-files options))
        (cadences (make-hash-table :test #'equal))
        (last-cadences (make-hash-table :test #'equal)))
    (iter (for anal in analysis)
          (let ((prep (prepare-cadence options
                                      anal
                                      (arg :cadence-number options))))
            (iter (for chords in prep)
                  (add-to-cadence-hash cadences (mapcar #'first chords) (third (first chords)) (fourth (first chords))))
            (add-to-cadence-hash last-cadences (mapcar #'first (last1 prep)) (third (first (last1 prep))) "end")))
    (format t "All cadences:~%")
    (show-cadence-hash options cadences)
    ;(make-cadence-figure cadences "cadences")
    (format t "Cadences in the end:~%")
    (show-cadence-hash options last-cadences)
    (make-cadence-figure last-cadences "last-cadences")
    ))

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

(defcommand view-analysis (options)
  (let ((analysis (analyse-files options))
        (colors (make-hash-table :test #'equal)))
    (iter (for anal in analysis)
          (iter (for alg in (analysis-results anal))
                (for name in (mapcar #'alg-name (analysis-algorithms anal)))
                (for height = (+ 50 (* 20 (length alg))))
                (for width = 500)
                (vecto:with-canvas (:width width :height height)
                  (let ((font (vecto:get-font (rameau-get-font-path "Vera.ttf"))))
                    (vecto:set-font font 20)
                    (vecto:rectangle 0 0 width height)
                    (vecto:set-rgb-fill 0 0 0)
                    (vecto:fill-path)
                    (vecto:set-rgb-stroke 1 1 1)
                    (vecto:string-paths 20 (- height 20) "Pitches")
                    (vecto:string-paths 260
                                        (- height 20)
                                        (format nil "==> Chords by ~a" name))
                    (vecto:stroke)
                    (iter (for cur-h from (- height 40) above 0 by 20)
                          (for seg in (analysis-segments anal))
                          (for re in alg)
                          (for vec = (extract-feature-list seg 0))
                          (for cho = (format nil "~a" re))
                          (vecto:set-rgb-fill 1 0 0)
                          (iter (for pitch in vec)
                                (for i from 2 by 2)
                                (vecto:centered-circle-path i cur-h (* 5 pitch))
                                (vecto:fill-path))
                          (aif (gethash (remove-inversions cho) colors)
                               (set-stroke-fill-colors it)
                               (setf (gethash (remove-inversions cho) colors) (rameau::random-stroke-fill-colors)))
                          (vecto:centered-string-paths 400 (- cur-h 5) cho)
                          (vecto:fill-and-stroke))
                    (vecto:save-png (concat *rameau-path*
                                            "analysis/analysis-"
                                            (analysis-file-name anal)
                                            "-"
                                            name
                                            ".png"))))))))
            
      
        

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

(defcommand report (options)
  (let* ((analysis (analyse-files options))
         (algorithms (analysis-algorithms (first analysis)))
         (confusion-matrix (iter (for a in algorithms)
                                 (collect (make-hash-table :test #'equal))))
         (countings (iter (for a in algorithms)
                          (collect (make-hash-table :test #'equal))))
         (modes (make-hash-table :test #'equal))
         (matrixes (repeat-list (length algorithms) nil)))
    (iter (for anal in analysis)
          (iter (for alg in algorithms)
                (for r in (analysis-results anal))
                (for m in confusion-matrix)
                (for co in countings)
                (iter (for an in r)
                      (for ga in (analysis-answer-sheet anal))
                      (let ((ga (if (listp ga) (first ga) ga)))
                        (incf (gethash (answer->mode ga)
                                         co
                                         0))
                        (setf (gethash (answer->mode an) modes) t
                              (gethash (answer->mode ga) modes) t)
                        (unless (rameau::%compare-answer-sheet an ga)
                          (incf (gethash (list (answer->mode an) (answer->mode ga))
                                         m
                                         0)))))))
    (format t "Done counting...~%")
    (setf modes (iter (for (mode va) in-hashtable modes) (collect mode)))
    (iter (for a in *algorithms*)
          (for c in confusion-matrix)
          (for co in countings)
          (for i from 0)
          (let ((conf (make-array (list (length modes) (length modes)) :initial-element 0)))
            (iter (for ((an ga) count) in-hashtable c)
                  (incf (aref conf (position ga modes :test #'equal) (position an modes :test #'equal))
                        (% count (gethash ga co 0.0000000001))))
            (setf (nth i matrixes) conf)))
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
                        (format f "& $~,1f$ " (aref cm i n)))
                  (format f " \\\\ \\hline~%"))
            (format f "\\end{tabular}~%\\caption{Confusion matrix for ~a}~%\\end{center}~%\\end{table}~%"
                    (alg-name a)))
      (format f "~%\\end{document}~%")
      (format t "Modes: ~s~%" modes))))

(defun make-training-data (options)
  (setf *training-data*
        (iter (for f in (arg :files options))
              (awhen (new-parse-answer-sheet (pathname-name f)
                                                     (arg :substring options))
                (collect (list (sonorities (parse-file f))
                               it))))))

(defcommand algorithms (options &rest ignore)
  (declare (ignore ignore))
  (make-training-data options)
  (setf (arg :algorithms options) (mapcar #'load-alg (filter-algorithms (arg :algorithms options)))
        (arg :options options) (process-option-list (arg :options options)))
  (iter (for alg in (arg :algorithms options))
        (do-options alg options)
        (save-alg alg))
  (setf *training-data* nil))

(defcommand web (options &rest ignore)
  (declare (ignore ignore options))

  (rameau-web::start-rameau-web)
  (loop))

(defcommand document (options &rest ignore)
  (declare (ignore ignore options))
  (create-documentation-for :rameau
                            :rameau-options
                            :rameau-base
                            :genoslib
                            :rameau-web
                            :rameau-main
                            :rameau-terminal
                            :rameau-lily
                            :rameau-hmm
                            :rameau-neural
                            :rameau-knn
                            :rameau-tree-enarm
                            :rameau-pardo
                             ))
                            

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

(defun process-option-list :private (options)
  (iter (for op in options)
        (aif (search "=" op)
             (collect (list (make-keyword (subseq op 0 it)) (read-from-string (subseq op (1+ it) (length op)))))
             (collect (list (make-keyword op) t)))))


(defun parse-files :private (options)
  (loop for file in (arg :files options) append
       (if (search "/" file)
           (list file)
           (parse-file-name file options))))

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
              ;;; revert to default arguments
              ;;; apply command-line options
              (iter (for (key value) in (parse-options command (rest command-list)))
                    (if key
                        (setf (arg key options) value)
                        (return-from main  (progn (format t "ERROR: command not found. Exiting.~%") 1))))
              (aif (arg :debug options)
                   (mapcar2 #'rameau-debug #'make-keyword it)
                   (rameau-undebug))
              (when (arg :profile options)
                (rameau-profile))
              (awhen (arg :trace options)
                (maptrace it))
              (when (or (arg :help options) (string= cmd "-h")) (print-help))
              ;;; parse file options
              (setf (arg :files options) (parse-files options))
              ;;; parse algorithms options
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
;(trace module genoslib::get-system-module)