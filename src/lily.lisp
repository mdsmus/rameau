(in-package :rameau)

(enable-sharp-l-syntax)

(defparameter *lily-score-string*
  "\\score {
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
}~%
 \\paper {
  paper-width = ~a\\cm
  paper-height = ~a\\cm
  line-width = 8\\cm
  top-margin = -.5\\cm
  left-margin = -1.2\\cm
  tagline = 0
}~%")

(defun make-variable  (name content)
  "Create a lilypond variable named @var{name} with value @var{content}"
  (concat name " = " content "

"))

(defun make-lily-list (content)
  "List the values in @var{content} in a form amenable to lilypond."
  (reduce #L(concat !1 "
" !2)
          content))

(defun make-lyrics (name)
  "Make lilypond lyrics code with name @var{name}."
  (format nil "\\new Lyrics \\lyricsto \"nowhere\" \\~a~%" (remove #\- name)))

(defun intervalo (s1 s2)
  "Retorna o intervalo entre dois segmentos."
  (if s2
      (- (event-start (first s2))
         (event-end (first s1)))
      0))

(defun make-lily-sonorities (notes)
  (let ((content (loop for x from 1
                       for s = notes then (rest s)
                       unless s return res
                       collect (format nil "\"~a\" " x) into res)))
    (make-variable "sonorities"
                  (format nil " \\lyricmode {~%\\set Stanza = \"Sonority\"~a}"
                          (make-lily-list content)))))

(defun frac->dur-lily (dur)
  "Convert duration @var{dur} to a lilypond-style duration"
  (let ((numer (numerator (abs dur)))
        (denom (denominator (abs dur))))
    (cond ((= numer 1) (format nil "~a" denom))
          ((= numer 3) (format nil "~a." (/ denom 2)))
          (t (format nil "~a*~a" denom numer)))))

(defun print-duracoes (segmento)
  "Output the lilypond code for the durations of the sonority in @var{segmento}."
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

(defun make-devnull-var (sonorities)
  "The variable that is set to a devnull voice."
  (multiple-value-bind (durs first-rest) (print-duracoes sonorities)
    (make-variable "texto"
                   (if first-rest
                       (format nil "{~{s~a ~} ~{~a ~}}~%~%" first-rest durs)
                       (format nil "{~{~a ~}}~%~%" durs)))))

(defun make-devnull-voice ()
  "The empty template for a devnull voice in lilypond."
  "\\new Devnull = \"nowhere\" \\texto")

(defun print-compare-answer-sheet (analysis answer name options cleaned)
  "Print analysis @var{analysis} as a lilypond source matching it with
answer sheet @var{answer}."
  (let* ((markup-no-color "\\markup { \\roman \\italic \\bold \"~a\"}")
         (markup-color "\\markup { \\roman \\italic \\bold \\with-color #(x11-color '~a)\"~a\"}")
         (color (dashs->space (arg :wrong-answer-color options)))
         (content (loop for al in analysis
                        for ans =  answer then (rest ans)
                        for an = (first ans)
                        for cl in cleaned
                        collect (if (or (null answer) (compare-answer-sheet al an))
                                    (concat "\"" (format nil "~a" cl) "\"")
                                    (if (arg :no-color options)
                                        (format nil markup-no-color cl)
                                        (format nil markup-color color cl))))))
    (make-variable (remove #\- name)
                   (format nil
                           " \\lyricmode {~%\\set stanza = \"~a\"~%~a}~%"
                           (dashs->space name)
                           (make-lily-list content)))))

(defun make-answer-sheet (answer)
  "Create the lilypond source for the answer-sheet answer."
  (make-variable "answer"
                 (format nil
                         "\\lyricmode {~%\\set stanza = \"Answer\" ~a}~%"
                         (make-lily-list (mapcar #L(format nil "\"~a\"" !1)
                                                 (cleanup-keys answer))))))

(defun make-note-list (notes)
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

(defun add-rests (notes)
  "Add the rests between the notes in @var{notes}."
  (format nil " { ~{~a ~% ~} }"
          (iter (for note in notes)
                (for prev previous note)
                (when (and note prev (not (= (event-end prev) (event-start note))))
                  (collect (format nil "r~a " (frac->dur-lily (- (event-start note) (event-end prev))))))
                (collect (format nil "~a~a~a "
                                 (print-event-note note :lily)
                                 (show-octave (event-octave note))
                                 (frac->dur-lily (event-dur note)))))))

(defun %get-voice (voice segments)
  (add-rests (make-note-list (mapcar #L(extract-note !1 (make-event :voice-name voice))
                                     segments))))

(defun make-lily-segments (options segments)
  "Make the lilypond for a chorale snippet based on @var{segments}."
  (when segments
    (destructuring-bind (key mode) (event-key (first (first segments)))
      (format nil
              *lily-score-string*
              (stringify key)
              (stringify mode)
              (%get-voice "\"soprano\"" segments)
              (%get-voice "\"alto\"" segments)
              (stringify key)
              (stringify mode)
              (%get-voice "\"tenor\"" segments)
              (%get-voice "\"baixo\"" segments)
              (arg :paper-width options)
              (arg :paper-height options)))))
