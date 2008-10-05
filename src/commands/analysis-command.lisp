(defpackage :rameau-analysis
  (:shadowing-import-from #:rameau-base #:defun #:defmacro #:defgeneric
                          #:defparameter #:defvar #:defstruct #:defclass)
  (:import-from #:arnesi "AIF" "AWHEN" "IT" "LAST1" "ENABLE-SHARP-L-SYNTAX")
  (:use :rameau :genoslib :cl :iterate :cl-lily)
  (:documentation "The harmonic analysis commands for @rameau"))

(in-package :rameau-analysis)


(defparameter *analysis-options*
    '(("" "dont-compare" "don't compare the results with the answer sheet")
      ("" "sonorities" "print total number of sonorities")
      ("-u" "show-dur" "")
      ("-n" "show-notes" "")
      ("-i" "ignore" "ignora (não imprime) corais sem gabaritos")
      ("-c" "no-color" "don't use color in the answer")
      ("-s" "score" "generate annotated scores as answer")
      ("-z" "column-chord-size" "" "7")
      ("" "column-number-size" "" "3")
      ("" "column-notes-size" "" "12")
      ("" "column-dur-size" "" "4")
      ("" "column-separator" "" "|")
      ("" "wrong-answer-color" "" "red")
      ("" "lily" "roda lilypond")
      ("" "gv" "roda gv")
      ("" "png" "gera png")
      ("-S" "view-score" "gera score, roda lily e gv")))


(defun analysis-terminal (options analysis)
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
           (print-line-term options "#" "notes" "dur" "answer")
           (iter (for algo in (arg :algorithms options))
                 (print-chord-column options (alg-name algo)))
           (print-hline-term size-line)
           (print-footer-term "CORRECT(%)" size-line number-algorithms options)
           (iter (for i in (mapcar (lambda (x) (% x seg-number)) right-answer-list))
                 (print-chord-column options (format nil "~,2f" i)))
           (format t "~%")
           (print-hline-term size-line)
           (format t "~%")))))

(defun analysis-terminal-no-answer (options analysis)
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
             (format t "~&TOTAL SONORITIES: ~a~%" seg-number))
           (format t "~%")))))

(defun analysis-lily (options analysis)
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
          do (format variables (print-compare-answer-sheet re
                                                           (analysis-answer-sheet analysis)
                                                           (alg-name al)
                                                           options
                                                           (cleanup-keys re)))
          (format in-score (make-lyrics (alg-name al))))
    (when (analysis-answer-sheet analysis)
      (format variables (make-answer-sheet (analysis-answer-sheet analysis)))
      (format in-score (make-lyrics "answer")))
    (setf (node-text score) (append (list (get-output-stream-string variables)
                                          "\\score { "
                                          "<< "
                                          (make-devnull-voice)
                                          "  ")
                                    (node-text music)
                                    (list (get-output-stream-string in-score)
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
    (let* ((result-dir (concat *rameau-path* "/analysis/"))
           (result-file (make-pathname :directory result-dir
                                       :name (concat "analysis-" (pathname-name (analysis-full-path analysis)))
                                       :type (pathname-type (analysis-full-path analysis))))
           (ps-file (make-pathname :directory result-dir
                                   :name (pathname-name result-file)
                                   :type "ps")))
      (ensure-directories-exist result-dir)
      (with-open-file (f result-file :direction :output :if-exists :supersede)
        (format f "~a" (print-ast (cdr ast))))
      (when (or (arg :lily options) (arg :view-score options))
        #+sbcl (progn
                 (sb-posix:chdir result-dir)
                 (sb-ext:run-program "/usr/bin/lilypond" (list "-f"
                                                               "ps"
                                                               (when (arg :png options) "--png")
                                                               (file-namestring result-file)))))
      (when (or (arg :gv options) (arg :view-score options))
        #+sbcl (sb-ext:run-program "/usr/bin/gv" (list (file-namestring ps-file))))
      )))


;;; Analysis
(defun analysis (options)
  (let ((analysis (analyse-files options)))
    (iter (for anal in analysis)
          (cond ((arg :dont-compare options) (analysis-terminal-no-answer options anal))
                ((analysis-answer-sheet anal)
                 (analysis-terminal options anal))
                (t (analysis-terminal-no-answer options anal)))
          (when (or (arg :score options) (arg :view-score options) (arg :lily options))
            (analysis-lily options anal)))))

(register-command :name "analysis"
                  :documentation "Perform chord labeling with the specified algorithms on the specified files."
                  :action #'analysis
                  :options *analysis-options*)


(defun functional (options)    
  (let ((analysis (functional-analyse-files options)))
    (iter (for anal in analysis)
          (cond ((arg :dont-compare options) (analysis-terminal-no-answer options anal))
                ((analysis-answer-sheet anal)
                 (analysis-terminal options anal))
                (t (analysis-terminal-no-answer options anal)))
          (when (or (arg :score options) (arg :view-score options) (arg :lily options))
            (analysis-lily options anal)))))

(register-command :name "functional"
                  :documentation "Perform roman numeral functional analysis with the specified functional algorithms on the specified files."
                  :action #'functional
                  :options *analysis-options*)


(defun equivalent-pitch (chord)
  (if (chord-p chord)
      (parse-note (chord-root chord))
      97))

(defun view-analysis (options)
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

(register-command :name "view"
                  :action #'view-analysis
                  :documentation   "Pretty visualization of the notes and chords produced by the chord labeling algorithms. The
result will be in analysis/analysis-<file>-<algorithm>.png")
