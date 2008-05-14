;; Main
;;; Define rameau-main package
(defpackage :rameau-main
  (:import-from #:arnesi "AIF" "AWHEN" "IT" "LAST1" "ENABLE-SHARP-L-SYNTAX")
  (:shadowing-import-from #:rameau-base #:defun #:defmacro #:defparameter #:defvar #:defstruct)
  (:use :rameau :cl :cl-ppcre :lisp-unit :iterate :rameau-options :rameau-terminal :genoslib :fann :rameau-neural))

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

(defun parse-options (command list)
  "Parse the list of options to a structure."
  (loop for item in (sublist-of-args list) collect
       (destructuring-bind (flag &rest value) item
         (list (cond ((long-flag? flag)
                      (%string->symbol (concat "SET-" (get-long-flag-name command flag))))
                     ((short-flag? flag)
                      (%string->symbol (concat "SET-" (get-short-flag-name command flag)))))
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

(defun rameau-args ()
  #+sbcl (rest sb-ext:*posix-argv*)
  #+cmu (subseq cmu-args (1+ (position "cmurameau" extensions:*command-line-strings* :test #'string=)))
  #+clisp ext:*args*)

(defmacro with-profile (args &body body)
  `(progn
     (when (get-profile ,args)
       (rameau-profile))
     ,@body
     (when (get-profile ,args)
       (rameau-report))))

(defun maptrace (lista-string &optional (trace 'trace))
  (let ((expr (append (list trace) (mapcar2 #'read-from-string #'string-upcase lista-string))))
    (eval expr)))

;;; Make analysis
(defstruct analysis
  segments results answer-sheet file-name notes dur size-answer-sheet
  number-algorithms ast full-path)

(defun analyse-files (options)
  (loop
     for file in (get-files options)
     for segments = (sonorities (parse-file file))
     collect
       (make-analysis
        :segments segments
        :results (mapcar #L(funcall (algorithm-classify !1) segments options)
                         (get-algorithms options))
        :answer-sheet (new-parse-answer-sheet (pathname-name file) (get-substring options))
        :file-name (pathname-name file)
        :number-algorithms (length (get-algorithms options))
        :notes (mapcar #'list-events segments)
        :ast (file-ast file)
        :full-path file
        :dur (durations segments))))

;;; Print messages
 (defun print-help ()
   (iter (for (key value) in *commands*)
      (format t "~%~:@(* ~a~)~%" (substitute #\Space #\- key :test #'equal))
      (iter (for (short long help) in value)
            (format t "~4T~4a--~25a ~a~%" short long (remove #\Newline help))))
   (rameau-quit))

(defun print-warning (message)
  (format t "~&WARNING: ~a~%" message))

(defun print-fatal (message)
  (format t "~&FATAL: ~a~%" message))

;;; Tests
(defun print-condition (status file expr)
  (format t "[~a] ~a: ~a~%" status (pathname-name file) expr))

(defun print-ok/no-list (list options)
  (destructuring-bind (ok no) list
    (let* ((s2 (length no))
           (no-string
            (cond ((zerop (get-max-print-error options)) no)
                  ((> s2 (get-max-print-error options))
                   (format nil "~a ..." (subseq no 0 (get-max-print-error options))))
                  (t no))))
      (format t "  [OK]: ~a [NO]: ~a ~@[~a ~]~%" (length ok) s2 no-string))))

(defun parse-verbose (files)
  (dolist (file files)
    (handler-case (parse-file file)
      (serious-condition (expr) (print-condition 'no file expr))
      (:no-error (&rest rest) (print-condition 'ok file rest)))))

(defun parse-summary (files)
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

(defun regression (options)
  (if (get-verbose options)
      (parse-verbose (get-files options))
      (print-ok/no-list (parse-summary (get-files options)) options)))

(defun unit (options)
  (let ((string-result
         (with-output-to-string (string)
           (let ((*standard-output* string))
             (lisp-unit:run-all-tests :rameau-test)
             (format t "~%")))))
    (if (get-verbose options)
        (write-line string-result)
        (write-line (subseq (last1 (cl-ppcre:split "\\n" string-result)) 34)))))

(defcommand test (options analysis)
  (declare (ignorable analysis))
  (when (get-unit options) (unit options))
  (when (get-regression options) (regression options)))

;;; Analysis
(defun make-result-list (analysis)
  (apply #'mapcar #'list (analysis-results analysis)))

(defun analysis-terminal (options analysis)
  (let* ((number-algorithms (analysis-number-algorithms analysis))
         (size-line (hline-size number-algorithms options)))
    (format t "~2%")
    (print-line-term options "#" "notes" "dur" "answer")
    (iter (for algo in (get-algorithms options))
          (print-chord-column options (algorithm-name algo)))
    (print-hline-term size-line)
    (iter (with right-answer-list = (make-list number-algorithms :initial-element 0))
          (for note in (analysis-notes analysis))
          (for dur in (analysis-dur analysis))
          (for seg-number from 1)
          (for answer in (analysis-answer-sheet analysis))
          (for result in (make-result-list analysis))
          (for comparison = (mapcar (lambda (x) (compare-answer-sheet answer x)) result))
          (setf right-answer-list (inc-bool-list comparison right-answer-list))
          (print-line-term options seg-number note dur answer)
          (iter (for res in result)
                (for comp in comparison)
                (print-color-terminal res comp options))
          (finally
           (print-hline-term size-line)
           (print-footer-term "CORRECT(%)" size-line number-algorithms options)
           (iter (for i in (mapcar (lambda (x) (% x seg-number)) right-answer-list))
                 (print-chord-column options (format nil "~,2f" i)))))))

(defun analysis-lily (options analysis)
  (let* ((ast (analysis-ast analysis))
         (score (first (get-children-by-type ast 'rameau::score)))
         (music (first-child (first-child (first (children score)))))
         (variables (make-string-output-stream))
         (in-score (make-string-output-stream)))
    (format variables (make-devnull-var (analysis-segments analysis)))
    (format variables (make-lily-sonorities (analysis-segments analysis)))
    (format in-score (make-lyrics "sonorities"))
    (loop for al in (get-algorithms options)
       for re in (analysis-results analysis)
       do (format variables (print-compare-answer-sheet re
                                                        (analysis-answer-sheet analysis)
                                                        (algorithm-name al)
                                                        options))
         (format in-score (make-lyrics (algorithm-name al))))
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
    (let ((result-file (make-pathname :directory (pathname-directory (analysis-full-path analysis))
                                      :name (concat "analysis-" (pathname-name (analysis-full-path analysis)))
                                      :type (pathname-type (analysis-full-path analysis)))))
      (with-open-file (f result-file
                         :direction :output
                         :if-exists :supersede)
        (format f "~a" (print-ast (cdr ast))))
      ;#+sbcl(sb-ext:run-program "/usr/bin/lilypond" (list (format nil "~a" result-file)))
      )))



(defun analysis-terminal-no-answer (options analysis)
  (let* ((number-algorithms (analysis-number-algorithms analysis))
         (size-line (hline-size number-algorithms options 'no-answer)))
    (format t "~2%")
    (print-line-term options "#" "notes" "dur")
    (iter (for algo in (get-algorithms options))
          (print-chord-column options (algorithm-name algo)))
    (print-hline-term size-line)
    (iter (for note in (analysis-notes analysis))
          (for dur in (analysis-dur analysis))
          (for seg-number from 1)
          (for result in (make-result-list analysis))
          (print-line-term options seg-number note dur)
          (iter (for res in result)
                (print-chord-column options res))
          (finally
           (print-hline-term size-line)))))

(defcommand analysis (options analysis)
  (iter (for anal in analysis)
        (cond ((get-dont-compare options) (analysis-terminal-no-answer options anal))
              ((analysis-answer-sheet anal)
               (analysis-terminal options anal))
              (t (print-warning (concat "the answer sheet for "
                                        (analysis-file-name anal)
                                        " doesn't exist"))
                 (analysis-terminal-no-answer options anal)))
        (when (get-score options)
          (analysis-lily options anal))))

(defcommand all-chords (options analysis)
  (iter (for anal in analysis)
        (iter (for chord in (first (analysis-results anal)))
              (format t "~a " chord))))

(defcommand cadences (options analysis)
  (iter (for anal in analysis)
        (iter (for chord in (first (analysis-results anal)))
              (for p previous chord)
              (for sonority from 1)
              ; detect cadences
              ;perfect cadence
              (when (and (chord-p chord)
                         (chord-p p))
                (when (= 55 (- (parse-note (chord-root chord))
                               (parse-note (chord-root p))))
                  (format t "  possibly authentic or half: chorale ~a sonority ~a from ~a to ~a ~%"
                          (analysis-file-name anal)
                          sonority
                          p
                          chord))
                (when (= 41(- (parse-note (chord-root chord))
                               (parse-note (chord-root p))))
                  (format t "     possibly amen or plagal: chorale ~a sonority ~a from ~a to ~a ~%"
                          (analysis-file-name anal)
                          sonority
                          p
                          chord))
                         ))))

(defcommand jumps (options analysis)
  (let ((jumps (make-hash-table :test #'equal)))
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
                                        (* 100.0 (/ i total)))
                                  (gethash (module (- (event-pitch n) (event-pitch p)))
                                           jumps))))))))
    (if (get-verbose options)
      (iter (for (k v) in-hashtable jumps)
            (format t "~20a:" (print-interval k))
            (iter (for i in v)
                  (for n from 0)
                  (format t "~a ~,2f%, " (first i) (second i))
                  (when (= n 5)
                    (setf n 0) (format t "~%                       ")))
            (format t "~%~%"))
      (iter (for (k v) in-hashtable jumps)
            (format t "~20a: ~a~%" (print-interval k) (length v))))))

(defun show-octave (octave)
  (cond ((= octave 0) "")
        ((< octave 0) (repeat-string (- octave) ","))
        (t (repeat-string octave "'"))))

(defcommand ambito (options analysis)
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
                  (format t "Chorale ~a voice ~a min ~a~a max ~a~a~%"
                          (analysis-file-name anal)
                          voice
                          (print-note (code->notename (event-pitch min)))
                          (show-octave (event-octave min))
                          (print-note (code->notename (event-pitch max)))
                          (show-octave (event-octave max)))
                  )))))


(defcommand cruzamento (options analysis)
  (iter (for anal in analysis)
        (let ((notes (analysis-segments anal)))
          (iter (for segment in notes)
                (for segno from 1)
                (let ((segment (sorted segment #'event-<)))
                  (when (= 4 (length segment))
                    (unless (and (equal (event-voice-name (first segment)) "\"baixo\"")
                                 (equal (event-voice-name (second segment)) "\"tenor\"")
                                 (equal (event-voice-name (third segment)) "\"alto\"")
                                 (equal (event-voice-name (fourth segment)) "\"soprano\""))
                      (format t "Cruzamento coral ~a segmento ~5a ordem ~a~%"
                              (analysis-file-name anal)
                              segno
                              (mapcar #'event-voice-name segment)))))))))

;;; Training
(defcommand train-neural (options &rest ignore)
  (declare (ignore ignore))

  (when (get-e-chord-data-set options)
    (e-chord-data-set options))

  (when (get-context-data-set options)
    (context-data-set options))

  (when (get-e-chord-fann-file options)
    (train-e-chord-net options))
  
  (when (get-context-fann-file options)
    (train-context-net options))
  )

;;; Main
(defun split-command-list (command-list)
  (let ((pos (position "and" command-list :test #'string=)))
    (if pos
        (append (list (subseq command-list 0 pos))
                (split-command-list (subseq command-list (1+ pos))))
        (list command-list))))

(defun sublist-of-args (list)
  "Separate the arguments in a list in sublist of arguments."
  (labels ((next-flag (list)
             (loop for x in (rest list) do
                  (if (and (< 0 (length x)) (equal #\- (aref x 0)))
                      (return x))))
           (pos (list)
             (let ((pos (position (next-flag list) list :test #'string=)))
               (if pos pos 0))))
    (when list
      (if (next-flag list)
          (let ((p (pos list)))
            (cons (subseq list 0 p)
                  (sublist-of-args (nthcdr p list))))
          (list list)))))

(defun parse-file-name (exp options)
  (unless (search ":" exp)
    (error "expression should be in the format <substring>:<expression>"))
  (let* ((tmp (cl-ppcre:split ":" exp))
         (substring (first tmp))
         (file-or-range (second tmp))
         (dir (search-music-dirs substring "music")))
    (set-substring substring options)
    (mapcar (lambda (item) (concat dir item ".ly"))
            (cond ((search ".." file-or-range)
                   (files-range (cl-ppcre:split "\\.\\." file-or-range)))
                  ((search "," file-or-range)
                   (cl-ppcre:split "," file-or-range))
                  (t (search " " file-or-range)
                     (cl-ppcre:split " " file-or-range))))))

(defun parse-files (options)
  (loop for file in (get-files options) append
       (if (search "/" file)
           (list file)
           (parse-file-name file options))))

(defun print-slots (obj)
  (iter (for slot in (sb-mop:class-slots (class-of obj)))
        ;;; FIXME that's f*cking ugly, why sb-mop:slot-definition-readers dont work?
        (for s = (intern (concat "GET-" (symbol-name (sb-mop:slot-definition-name slot)))))
        (format t "~a: ~a~%" s (funcall s obj))))

(defun default-arguments (options)
  (let* ((neural-version "005")
         (neural-path (concat *rameau-path* "neural-nets/master-" neural-version "-")))
    (iter outer (for (k v) in *commands*)
          (iter (for (short long doc init list) in v)
                (for writer = (intern (concat "SET-" (string-upcase long))))
                (funcall writer init options)))
    (set-context-value (* (+ 1 (get-context-after options) (get-context-before options))
                          96)
                       options)
    (set-context-fann (concat neural-path "context.fann") options)
    (set-context-data (concat neural-path "context-train.data") options)
    (set-e-chord-fann (concat neural-path "e-chord.fann") options)
    (set-e-chord-data (concat neural-path "e-chord-train.data") options)))

(defun main (&optional args)
  "You can run main from the REPL with all arguments as a
  string: (main \"analysis chorales -v -f 001\")"
  (let* ((*package* (find-package :rameau-main))
         (rameau-args (rameau-args))
         (arguments (if rameau-args rameau-args (cl-ppcre:split " " args)))
         (options (make-instance 'arguments)))
    (if arguments
        (iter (for command-list in (split-command-list arguments))
              (for cmd = (first command-list))
              (for command = (search-string-in-list cmd *command-names*))
              ;;; revert to default arguments
              (default-arguments options)
              ;;; apply command-line options
              (iter (for (key value) in (parse-options command (rest command-list)))
                    (funcall key value options))
              (when (or (get-help options) (string= cmd "-h")) (print-help))
              ;;; parse file options
              (set-files (parse-files options) options)
              ;;; parse algorithms options
              (set-algorithms (filter-algorithms (get-algorithms options)) options)
              (for analysis = (analyse-files options))
              ;; FIXME debug is not working
              (aif (get-debug options)
                   (mapcar2 #'rameau-debug #'string->symbol it)
                   (rameau-undebug))
              (awhen (get-trace options)
                (trace maptrace)
                (trace %do-relative)
                (maptrace it))
                   ;(maptrace it 'untrace))
              (with-profile options
                (if (and (string= command "analysis")
                         (every #'null (mapcar #'analysis-segments analysis)))
                    (progn
                      (print-fatal "It seems I couldn't make the analysis. Check if your file is correct.")
                      (rameau-quit))
                    (funcall (%string->symbol command) options analysis)))
              ;;(dbg 'main "~a" (print-slots options))
              )
        (print-help)))
  #+clisp(ext:exit)
  0)

;(trace module genoslib::get-system-module)