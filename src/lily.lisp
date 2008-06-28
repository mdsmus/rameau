(defpackage :rameau-lily
  (:import-from #:arnesi "AIF" "AWHEN" "IT" "LAST1" "ENABLE-SHARP-L-SYNTAX")
  (:shadowing-import-from #:rameau-base #:defun #:defmacro #:defparameter #:defvar #:defstruct)
  (:use :rameau :cl :cl-ppcre :lisp-unit :iterate :rameau-options  :genoslib :fann :rameau-neural))

(in-package :rameau-lily)

(enable-sharp-l-syntax)

(defun make-variable :private (name content)
  (concat name " = " content "

"))

(defun make-lily-list :private (content)
  (reduce #L(concat !1 "
" !2)
          content))

(defun make-lyrics :private (name)
  (format nil "\\new Lyrics \\lyricsto \"nowhere\" \\~a~%" (remove #\- name)))

(defun intervalo :private (s1 s2)
  "Retorna o intervalo entre dois segmentos."
  (if (null s2)
      0
      (- (event-start (first s2))
         (event-end (first s1)))))


(defun make-lily-sonorities :private (notes)
  (make-variable "sonorities" 
                 (concat " \\lyricmode {
 \\set Stanza = \"Sonority\""
                         (make-lily-list
                          (loop for x from 1
                             for s = notes then (rest s)
                             unless s return res
                             collect (format nil "\"~a\" " x) into res))
                             ;unless (= 0 (intervalo (first s) (second s)))
                             ;collect "\" \" " into res))
                               
                         "}")))

(defun frac->dur-lily :private (dur)
  "Convert duration \\texttt{dur} to a lilypond-style duration"
  (let ((numer (numerator (abs dur)))
        (denom (denominator (abs dur))))
    (cond ((= numer 1) (format nil "~a" denom))
          ((= numer 3) (format nil "~a." (/ denom 2)))
          (t (format nil "~a*~a" denom numer)))))

(defun print-duracoes :private (segmento)
  (values (loop for s = segmento then (rest s)
            unless s return res
            collect (concat "c" (frac->dur-lily (event-dur (first (first s))))) into res
            unless (= 0 (intervalo (first s) (second s)))
            collect (concat "r" (frac->dur-lily (intervalo (first s) (second s)))) into res)
          (when (< 0 (event-start (first (first segmento))))
            (let ((n (frac->dur-lily (abs (event-start (first (first segmento)))))))
              (if (listp n)
                  n
                  (list n))))))

(defun make-devnull-var :private (sonorities)
  (multiple-value-bind (durs first-rest) (print-duracoes sonorities)
        (make-variable "texto"
                       (if first-rest
                           (format nil "{~{s~a ~} ~{~a ~}}~%~%" first-rest durs)
                           (format nil "{~{~a ~}}~%~%" durs)))))

(defun make-devnull-voice :private ()
  "\\new Devnull = \"nowhere\" \\texto")

(defun print-compare-answer-sheet :private (analysis answer name options)
  (make-variable (remove #\- name)
                 (concat " \\lyricmode {
 \\set stanza = \""
                         (substitute #\Space #\- name)
           "\"
"
           (make-lily-list
            (loop for al in analysis
               for ans =  answer then (rest ans)
               for an = (first ans)
               collect (if (or (null answer) (compare-answer-sheet al an))
                           (concat "\"" (format nil "~a" al) "\"")
                           (if (arg :no-color options)
                               (concat "\\markup { \\roman \\italic \\bold \""
                                       (format nil "~a" al)
                                       "\"}")
                               (concat "\\markup { \\roman \\italic \\bold \\with-color #(x11-color '"
                                       (substitute #\Space #\- (arg :wrong-answer-color options))
                                       ") "
                                       "\""
                                       (format nil "~a" al)
                                       "\"}")))))
           "}
")))

(defun make-answer-sheet :private (answer)
  (make-variable "answer"
                 (concat "\\lyricmode {
  \\set stanza = \"Answer\" "
                         (make-lily-list (mapcar #L(format nil "\"~a\"" !1) answer))
                         "}

")))



(defun make-note-list :private (notes)
  (let (notelist
        (rest 0)
        (notes (remove-if #'null notes)))
    (iter (for note in notes)
          (for i from 0)
          (until (not (equal :piece (event-original-event note))))
          (setf notelist (append notelist (list note)))
          (setf rest i))
    (iter (for note in (nthcdr rest notes))
          (if (equal :self (event-original-event note))
              (setf notelist (append notelist (list note)))
              (when (not (equal :piece (event-original-event note)))
                (setf notelist (append notelist (list (event-original-event note)))))))
    notelist))

(defun add-rests :private (notes)
  (format nil " { ~{~a ~% ~} }"
          (iter (for note in notes)
                (for prev previous note)
                (when (and note prev (not (= (event-end prev) (event-start note))))
                  (collect (format nil "r~a " (frac->dur-lily (- (event-start note) (event-end prev))))))
                (collect (format nil "~a~a~a "
                                 (print-event-note note 'lily)
                                 (show-octave (event-octave note))
                                 (frac->dur-lily (event-dur note)))))))

(defun make-lily-segments (options segments)
  (let ((baixos (add-rests (make-note-list (mapcar #L(extract-note !1 (make-event :voice-name "\"baixo\"")) segments))))
        (tenores (add-rests (make-note-list (mapcar #L(extract-note !1 (make-event :voice-name "\"tenor\"")) segments))))
        (altos (add-rests (make-note-list (mapcar #L(extract-note !1 (make-event :voice-name "\"alto\"")) segments))))
        (sopranos (add-rests (make-note-list (mapcar #L(extract-note !1 (make-event :voice-name "\"soprano\"")) segments)))))
    (format nil "\\score {
  <<
    \\new StaffGroup <<
      \\override StaffGroup.SystemStartBracket #'style = #'line 
      \\new Staff \\with {\\remove \"Time_signature_engraver\" } {
        <<
          \\key ~a \\~a
          \\new Voice = \"soprano\" { \\voiceOne ~a }
          \\new Voice = \"alto\" { \\voiceTwo ~a }
        >>
      }
      \\new Staff \\with {\\remove \"Time_signature_engraver\" }{
        <<
          \\key ~a \\~a
          \\clef \"bass\"
          \\new Voice = \"tenor\" {\\voiceOne ~a }
          \\new Voice = \"baixo\" { \\voiceTwo ~a \\bar \"|.\"}
        >>
      }
    >>
  >>
  \\layout {}
  \\midi {}
}


 \\paper {
  paper-width = ~a\\cm
  paper-height = ~a\\cm
  line-width = 8\\cm
  top-margin = -.5\\cm
  left-margin = -1.2\\cm
  tagline = 0
}

"
            (string-downcase (first (event-key (first (first segments)))))
            (string-downcase (second (event-key (first (first segments)))))
            sopranos
            altos
            (string-downcase (first (event-key (first (first segments)))))
            (string-downcase (second (event-key (first (first segments)))))
            tenores
            baixos
            (arg :paper-width options)
            (arg :paper-height options))))


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