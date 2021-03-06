(defpackage :rameau-analysis
  (:import-from #:arnesi "AIF" "AWHEN" "IT" "LAST1" "ENABLE-SHARP-L-SYNTAX")
  (:use :rameau :cl-utils :cl-music :cl :iterate :cl-lily)
  (:documentation "The harmonic analysis commands for @rameau"))

(in-package :rameau-analysis)

(enable-sharp-l-syntax)

(defparameter *analysis-options*
  (append
   '(("" "dont-compare" "don't compare the results with the answer sheet")
     ("" "sonorities" "print total number of sonorities")
     ("" "start" "analyze from start to end" 0 type-integer)
     ("" "end" "analyze from start to end" nil type-integer)
     ("-u" "show-dur" "")
     ("-n" "show-notes" "")
     ("" "as-chords" "show fchords as chords in functional analysis")
     ("-i" "ignore" "ignora (não imprime) corais sem gabaritos")
     ("-s" "score" "generate annotated scores as answer")
     ("" "lily" "roda lilypond")
     ("" "gv" "roda gv")
     ("" "png" "gera png")
     ("-S" "view-score" "gera score, roda lily e gv"))
   *terminal-options*))

(defun analysis-terminal (options analysis)
  "Displays the analysis in @var{analysis} as a table on the console."
  (let* ((number-algorithms (analysis-number-algorithms analysis))
         (size-line (hline-size number-algorithms options)))
    (format t "~2%")
    (print-line-term options "#" "notes" "dur" "answer")
    (iter (for algo in (arg :algorithms options))
          (print-chord-column options (alg-name algo)))
    (print-hline-term size-line)
    (iter (with right-answer-list = (make-list number-algorithms
                                               :initial-element 0))
          (for note in (analysis-notes analysis))
          (for dur in (analysis-dur analysis))
          (for seg-number from 1)
          (for answer in (analysis-answer-sheet analysis))
          (for result in (make-result-list analysis))
          (for comparison = (mapcar #L(compare-answer-sheet !1 answer) result))
          (setf right-answer-list (inc-bool-list comparison right-answer-list))
          (when (arg :as-chords options)
            (setf result (mapcar #'fchord->chord result)
                  answer (fchord->chord answer)))
          (print-line-term options seg-number note dur answer)
          (iter (for res in result)
                (for comp in comparison)
                (print-color-terminal res comp options))
          (finally
           (print-hline-term size-line)
           (print-line-term options "#" "notes" "dur" "answer")
           (iter (for algo in (arg :algorithms options))
                 (print-chord-column options (alg-name algo)))
           (print-hline-term size-line)
           (print-footer-term "CORRECT(%)" size-line number-algorithms options)
           (iter (for i in (mapcar #L(% !1 seg-number) right-answer-list))
                 (print-chord-column options (format nil "~,2f" i)))
           (format t "~%")
           (print-hline-term size-line)
           (format t "~%")))))

(defun analysis-terminal-no-answer (options analysis)
  "Displays the analysis in @var{analysis} as a table on the console."
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
          (when (arg :as-chords options)
            (setf result (mapcar #'fchord->chord result)))
          (iter (for res in result)
                (print-chord-column options res))
          (finally
           (print-hline-term size-line)
           (when (arg :sonorities options)
             (format t "~&TOTAL SONORITIES: ~a~%" seg-number))
           (format t "~%")))))

(defun %make-score-list (object variables stream)
  (append (list (get-output-stream-string variables)
                "\\score { "
                "<< "
                (make-devnull-voice)
                "  ")
          (node-text object)
          (list (get-output-stream-string stream)
                " >>
  \\layout {
    \\context {
      \\Lyrics
      \\override LyricSpace #'minimum-distance = #1.0
      \\override LyricText #'font-size = #-1
      \\override LyricText #'font-family = #'roman
    }
  }
  \\midi {}
}
")))

(defun analysis-lily (options analysis)
  "Displays the analysis in @var{analysis} as a lilypond score."
  (let* ((ast (analysis-ast analysis))
         (score (first (get-children-by-type ast 'rameau::score)))
         (music (first-child (first-child (first (children score)))))
         (variables (make-string-output-stream))
         (in-score (make-string-output-stream)))
    (format variables (make-devnull-var (analysis-segments analysis)))
    (format variables (make-lily-sonorities (analysis-segments analysis)))
    (format in-score (make-lyrics "sonorities"))
    (loop for al in (arg :algorithms options)
          for re in (analysis-results analysis)
          do (format variables
                     (print-compare-answer-sheet re
                                                 (analysis-answer-sheet analysis)
                                                 (alg-name al)
                                                 options
                                                 (if (arg :as-chords options)
                                                     (mapcar #'fchord->chord re)
                                                     (cleanup-keys re))))
          (format in-score (make-lyrics (alg-name al))))
    (when (analysis-answer-sheet analysis)
      (when (arg :as-chords options)
        (setf (analysis-answer-sheet analysis)
              (mapcar #'fchord->chord (analysis-answer-sheet analysis))))
      (format variables (make-answer-sheet (analysis-answer-sheet analysis)))
      (format in-score (make-lyrics "answer")))
    (setf (node-text score) (%make-score-list music variables in-score))
    (let* ((result-path (translate-logical-pathname "rameau:analysis;"))
           (result-dir (pathname-directory result-path))
           (full-path (analysis-full-path analysis))
           (name (concat "analysis-" (pathname-name full-path)))
           (result-file (make-pathname :directory result-dir
                                       :name name
                                       :type (pathname-type full-path)))
           (ps-file (make-pathname :directory result-dir
                                   :name (pathname-name result-file)
                                   :type "ps")))
      (print full-path)
      (ensure-directories-exist result-file)
      (with-output-file (f result-file)
        (format f "~a" (print-ast (cdr ast))))
      (when (or (arg :lily options) (arg :view-score options))
        (run-lily result-path result-file (arg :png options)))
      (when (or (arg :gv options) (arg :view-score options))
        (run-gv ps-file)))))

;;; Analysis
(defun %analysis (options algorithm-type)
  "Run analysis according to options."
  (iter (for anal in (analyse-files options algorithm-type))
        (cond ((arg :dont-compare options)
               (analysis-terminal-no-answer options anal))
              ((analysis-answer-sheet anal)
               (analysis-terminal options anal))
              (t (analysis-terminal-no-answer options anal)))
        (when (or (arg :score options)
                  (arg :view-score options)
                  (arg :lily options))
          (analysis-lily options anal))))

(defun analysis (options)
  "Run analysis according to options."
  (%analysis options :chord-names))

(register-command :name "analysis"
                  :documentation "Perform chord labeling with the
                  specified algorithms on the specified files."
                  :action #'analysis
                  :options *analysis-options*)


(defun functional (options)    
  "Run functional analysis according to options."
  (%analysis options :roman-analysis))

(register-command :name "functional"
                  :documentation "Perform roman numeral functional
                  analysis with the specified functional algorithms on
                  the specified files."
                  :action #'functional
                  :options *analysis-options*)


(defun equivalent-pitch (chord)
  "The pitch for chord @var{chord}"
  (if (chord-p chord)
      (parse-note (chord-root chord))
      97))

(defun view-analysis (options)
  "Run analysis according to options and show the output as a cairo graph."
  (let ((analysis (analyse-files options :chord-names))
        (pitch-colors (make-hash-table :test #'equal)))
    (iter (for anal in analysis)
          (iter (for alg in (analysis-results anal))
                (for name in (mapcar #'alg-name (analysis-algorithms anal)))
                (for height = (+ 100 (* 20 (length alg))))
                (for width = 500)
                (cl-cairo2:with-png-file
                    ((make-analysis-file "png" "analysis" (analysis-file-name anal) name)
                     :argb32
                     width
                     height)
                  (cl-cairo2:select-font-face "Vera" :nolmal :bold)
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
                                     (setf (gethash p pitch-colors)
                                           (cairo-random-stroke-fill-colors)))
                                (cl-cairo2:move-to  (+ 20 i) cur-h)
                                (cl-cairo2:show-text (print-pitch p))))
                        (cl-cairo2:set-font-size 20)
                        (aif (gethash (equivalent-pitch re) pitch-colors)
                             (cairo-set-stroke-fill-colors it)
                             (setf (gethash (equivalent-pitch re) pitch-colors)
                                   (cairo-random-stroke-fill-colors)))
                        (cl-cairo2:move-to 400 (- cur-h 5))
                        (cl-cairo2:show-text cho)))))))

(register-command :name "view"
                  :action #'view-analysis
                  :documentation "Pretty visualization of the notes
and chords produced by the chord labeling algorithms. The result will
be in analysis/analysis-<file>-<algorithm>.png")
