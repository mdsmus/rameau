(in-package :rameau)

(enable-sharp-l-syntax)

(defstruct analysis
  segments results answer-sheet file-name notes dur size-answer-sheet
  number-algorithms ast full-path algorithms title)

(defun main-perform-analysis :private (segments options alg)
  (safe-with-backtrace
      (:condition  (arg :debug options)
       :print-error-msg (format t "Analysis failed for algorithm ~a.~%" alg))
    (perform-analysis segments options alg)))

(defun main-perform-functional-analysis :private (segments options alg)
  (safe-with-backtrace
      (:condition  (arg :debug options)
      :print-error-msg
      (format t "Functional analysis failed for algorithm ~a.~%" alg))
    (functional-analysis segments options alg)))

(defun main-parse-file :private (file options)
  (safe-with-backtrace (:condition (arg :debug options)
                        :print-error-msg (format t "Could not parse file ~a.
Please check with lilypond to see if it is valid.
If it is, please report a bug.~%" file)
                        :exit t)
     (parse-file file)))

(defun all-chords-single (options anal)
  (declare (ignore options))
  (iter (for chord in (first (analysis-results anal)))
        (for segment in (analysis-segments anal))
        (for i from 0)
        (collect (list chord segment (analysis-file-name anal) i))))

(defun make-result-list (analysis)
  (apply #'mapcar #'list (analysis-results analysis)))

(defun analyse-files (options)
  (setf (arg :algorithms options) (mapcar #'load-alg
                                          (filter-algorithms
                                           (arg :algorithms options)
                                           *algorithms*))
        (arg :options options) (process-option-list (arg :options options)))
  (unless (arg :algorithms options)
    (format t "No valid algorithm found.
Try omitting the \"-a\" option and trying again.~%")
    (rameau-quit))
  (let (last-file)
    (safe-with-backtrace
        (:condition (arg :debug options)
         :print-error-msg (format t "Could not analyse ~a.~%" last-file)
         :exit t)
      (iter (for file in (arg :files options))
            (setf last-file file)
            (for segments = (sonorities (main-parse-file file options)))
            (collect
                (make-analysis
                 :segments segments
                 :results (mapcar #L(main-perform-analysis segments options !1)
                                  (arg :algorithms options))
                 :answer-sheet (path-parse-answer-sheet file)
                 :file-name (pathname-name file)
                 :number-algorithms (length (arg :algorithms options))
                 :algorithms (arg :algorithms options)
                 :notes (mapcar #'list-events segments)
                 :ast (file-ast file)
                 :full-path file
                 :dur (durations segments)))))))

(defun functional-analyse-files (options)
  (setf (arg :algorithms options) (mapcar
                                   #'load-alg
                                   (filter-algorithms (arg :algorithms options)
                                                      *functional-algorithms*))
        (arg :options options) (process-option-list (arg :options options)))
  (unless (arg :algorithms options)
    (format t "No valid algorithm found.
Try omitting the \"-a\" option and trying again.~%")
    (rameau-quit))
  (let (last-file)
    (safe-with-backtrace
        (:condition (arg :debug options)
         :print-error-msg (format t "Could not analyse ~a. Error." last-file)
         :exit t)
      (iter (for file in (arg :files options))
            (for segments = (sonorities (main-parse-file file options)))
            (collect
                (make-analysis
                 :segments segments
                 :results (mapcar #L(main-perform-functional-analysis
                                     segments
                                     options
                                     !1)
                                  (arg :algorithms options))
                 :answer-sheet (path-parse-functional-answer-sheet file)
                 :file-name (pathname-name file)
                 :number-algorithms (length (arg :algorithms options))
                 :algorithms (arg :algorithms options)
                 :notes (mapcar #'list-events segments)
                 :ast (file-ast file)
                 :full-path file
                 :dur (durations segments)))))))


