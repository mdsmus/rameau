(defpackage :rameau-musicology
  (:import-from #:arnesi "AIF" "AWHEN" "IT" "LAST1" "ENABLE-SHARP-L-SYNTAX")
  (:use :rameau :cl-utils :cl-music :cl :iterate :cl-lily)
  (:export :register-musicology-command)
  (:documentation "The computational musicology query framework for @rameau"))

(in-package :rameau-musicology)

(enable-sharp-l-syntax)

(defun do-classifier (classifier hash chorale-hash contextual options)
  (when contextual
    (destructuring-bind (chor seg segm answ &rest results) (first contextual)
      (declare (ignore segm answ results))
      (assert chor)
      (awhen (listify (funcall classifier contextual options))
        (iter (for i in it)
              (when chorale-hash
                (if (gethash chor chorale-hash)
                    (push seg (gethash chor chorale-hash))
                    (setf (gethash chor chorale-hash) (list seg))))
              (if (gethash i hash)
                  (push (list chor seg) (gethash i hash))
                  (setf (gethash i hash) (list (list chor seg)))))))))

(defun count-occurences-into-hash (analysis
                                   context-window
                                   classifier
                                   pre-filter
                                   options)
  (let ((h (make-hash-table :test #'equal))
        (c (make-hash-table :test #'equal))
        (e (make-hash-table :test #'equal)))
    (iter (for anal in analysis)
          (for segno = (iter (for i from 0)
                             (for e in (analysis-segments anal))
                             (collect i)))
          (for results = (analysis-results anal))
          (for answer = (analysis-answer-sheet anal))
          (for segments = (analysis-segments anal))
          (for choraleno = (repeat-list (length segments)
                                        (analysis-file-name anal)))
          (assert choraleno)
          (for full-list = (apply #'zip (append (list choraleno
                                                    segno
                                                    segments
                                                    answer)
                                              results)))
          (for contextual = (butlast (group (funcall pre-filter full-list)
                                            context-window)
                                     (1- context-window)))
          (mapcar #L(do-classifier classifier h c !1 options) contextual)
          (do-classifier classifier e nil (last1 contextual) options))
    (values h c e)))


(defun text-dimensions (text size)
  "The size of @var{text} when printed as a size @var{size}."
  (cl-cairo2:set-font-size size)
  (multiple-value-bind (xbear ybear width height)
      (cl-cairo2:text-extents text)
    (list (/ (+ width xbear) 2) (/ (- height ybear) 2))))

(defun collides (boxa boxb)
  "True if the boxes collide."
  (destructuring-bind ((cxa cya dxa dya &rest foo)
                       (cxb cyb dxb dyb &rest bar))
      (list boxa boxb)
    (declare (ignore foo bar))
    (and (> (+ 10 dxa dxb) (abs (- cxa cxb)))
         (> (+ 5 dya dyb) (abs (- cya cyb))))))

(defun approach-0 (number step)
  "Bring number closer to 0 by a step."
  (if (< number 0)
      (- number step)
      (+ number step))) 

(defun sorted-hash (hash)
  "The elements in a frequency hash, sorted by least common first."
  (sorted (all-elements-hash hash) #'< :key #L(length (second !1))))

(defun figure-compute-boxes (cadences max-size center)
  (let (boxes)
    (iter (for (cadence places) in cadences)
          (for i from 1)
          (let* ((size (normalize-line 10d0
                                       20d0
                                       0d0
                                       max-size
                                       (length places)))
                 (dim (append (text-dimensions cadence size)
                              (list cadence size)))
                 (angle (random (* 2 pi)))
                 (cenx (first center))
                 (ceny (second center))
                 (box (cons cenx (cons ceny dim)))
                 (stepx (* 10 (cos angle)))
                 (stepy (* 10 (sin angle))))
            (iter (for n from 1 to 220)
                  (always (some #'identity (mapcar #L(collides !1 box) boxes)))
                  (setf box (cons (+ (first box) stepx)
                                  (cons (+ (second box) stepy) dim))))
            (push box boxes)))
    boxes))

(defun figure-show-hash (hash options)
  "Draw the cadence figure for the cadences."
  (make-random-state t)
  (cl-cairo2:with-png-file
      ((stringify
               (make-analysis-file "png"
                                   (arg :command options)))
       :rgb24 2000 2000)
    (let* ((center (list 1000 1000))
           (boxes nil)
           (cadences (reverse (sorted-hash hash)))
           (max-size (length (second (first cadences)))))
      (cl-cairo2:select-font-face "Times" :normal :normal)
      (cl-cairo2:rectangle 0 0 2000 2000)
      (cl-cairo2:set-source-rgb 1 1 1)
      (cl-cairo2:fill-path)
      (setf boxes (figure-compute-boxes cadences max-size center))
      (iter (for (cx cy dx dy cadence size) in boxes)
            (for i from 1)
            (for (red green blue) = (cairo-random-stroke-fill-colors))
            (cl-cairo2:set-font-size size)
            (multiple-value-bind (xbear ybear xwidth yheight)
                (cl-cairo2:text-extents cadence)
              (cl-cairo2:move-to (+ (- cx xwidth) xbear)
                                 (- (- cy yheight) ybear)))
            (cl-cairo2:text-path cadence)
            (cl-cairo2:stroke-preserve)
            (cairo-brighten-source red green blue)
            (cl-cairo2:fill-path)))))

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

(defun empty-show-hash (hash options)
  (declare (ignore hash options)))

(defun lily-show-hash (hash options)
  (iter (with name = (arg :command options))
        (for (chorale segments) in-hashtable hash)
        (for max = (1+ (reduce #'max segments)))
        (for min = (1- (reduce #'min segments)))
        (for file = (first (member chorale
                                   (arg :files options)
                                   :key #'pathname-name)))
        (with-output-file (f (make-analysis-file "ly"
                                                 name
                                                 chorale
                                                 min
                                                 max))
          (format f "~a" (make-lily-segments options
                                             (subseq (sonorities
                                                      (parse-file file))
                                                     min
                                                     max))))))

(defun lily-each-hash (hash options)
  (iter (with name = (arg :command options))
        (for (chorale segments) in-hashtable hash)
        (when chorale
          (for file = (first (member chorale
                                     (arg :files options)
                                     :key #'pathname-name)))
          (for segs = (sonorities (parse-file file)))
          (for len = (length segs))
          (iter (for s in segments)
                (with-output-file (f (make-analysis-file "ly"
                                                         name
                                                         chorale
                                                         (max 0 (1- s))
                                                         (min len (1+ s))))
                  (format f "~a" (make-lily-segments options
                                                     (subseq segs
                                                             (max 0 (1- s))
                                                             (min len (1+ s))))))))))

(defun get-lily-display-function (key)
  (case key
    (:each #'lily-each-hash)
    (:all #'lily-show-hash)
    (:none #'empty-show-hash)
    (t #'empty-show-hash)))

(defun get-figure-display-function (key)
  (case key
    (:cloud #'figure-show-hash)
    (:none #'empty-show-hash)
    (t #'empty-show-hash)))

(defun get-text-display-function (key)
  (case key
    (:text-list #'text-show-hash)
    (:frequency #'frequency-text-show-hash)
    (t #'empty-show-hash)))

(defun make-musicology-action (classifier
                               context
                               display
                               functional
                               chor-dis
                               fig-dis
                               name
                               pre-filter)
  (lambda (options)
    (let* ((analysis (if functional
                         (analyse-files options :roman-analysis)
                         (analyse-files options :chord-names))))
      (setf (arg :command options) name)
      (multiple-value-bind (hash chorale-hash end-hash)
          (count-occurences-into-hash analysis
                                      context
                                      classifier
                                      pre-filter
                                      options)
        (when (arg :last options)
          (setf hash end-hash))
        (cond ((arg :freq options) (frequency-text-show-hash hash options))
              ((arg :text options) (text-show-hash hash options))
              (t (funcall display hash options)))
        (cond ((arg :all-lily options) (lily-show-hash chorale-hash options))
              ((arg :each-lily options) (lily-each-hash chorale-hash options))
              (t (funcall chor-dis chorale-hash options)))
        (cond ((arg :cloud options) (funcall #'figure-show-hash hash options))
              (t (funcall fig-dis hash options)))))))
    
(defun register-musicology-command (&key classifier
                                    (context 1)
                                    functional
                                    (show-as :text-list)
                                    (generate-lily :none)
                                    (generate-figure :none)
                                    (pre-filter #'identity)
                                    name
                                    doc
                                    options)
  "Register a command using @rameau's musicological queries framework.

This framework encapsulates counting excerpts matching a given query
and displaying this data in a user-friendly fashion. Using this
framework is as simple as deciding which things to observe in a given
query, writing a small lisp function that does the observing,
receiving as parameters the data in a small window of a chorale and
returns a list of the queries that window matched. The framework,
then, deals with the messy details of analysing the files, storing the
matches and generating the output.

A simple example: suppose one wants to count the different chord modes
in a few chorales. The classifier function will look something like

@code{
(defun chords-classifier (context options)
  (declare (ignore options))
  (destructuring-bind ((chor segno segm ans chord &rest ignore))
      context
    (declare (ignore chor segno segm ans ignore))
    (if (chord-p chord)
        (format nil \"~a\" (transpose-chord chord
                                            (- (parse-note (chord-root chord)))))
        (format nil \"~a\" chord))))
}
 
and the call to
@function{rameau-musicology}{register-musicology-command} will look
like:

@code{
(register-musicology-command
  :name \"chords\"
  :classifier #'chords-classifier
  :context 1
  :show-as :frequency
  :doc \"List all the chord modes in the analyzed files.\")
}

After this, @rameau will group and count all the distinct values
returned by the classifier function and output them as a frequency
list on the terminal.

Tha keyword arguments are:

@var{:classifier} is the function used to classify.

@var{:name} is the name of the command, used to run it via the
command-line. Failing to specify the name is an error.

@var{:doc} is a string describing the command. It will show in
@rameau's help.

@var{:options} are any extra command-line options the classifier
accepts.

@var{:context} is the amount of context the classifier wants. Defaults
to 1.

@var{:functional} is @var{t} if and only if the command expects
functional analysis as its input.

@var{:show-as} controls how the results will be displayed in the
terminal. The posible values are @var{:text-list} (the default, which
shows the occurrences and their origins), @var{:frequency} which,
instead, shows the frequency of each occurrence and @var{:none} which
displays nothign at all. 

@var{:generate-figure} controls whether a figure will be
generated. The possible values are @var{:cloud}, which generates a
cloud-like display of the frequencies and @var{:none}, which does not
generate a figure. The figure, if any, will be named
analysis/<command>.png .

@var{:generate-lily} controls whether lilypond will be generated for
the results. The possible values are @var{:each}, which will generate
a lilypond for each match, @{:all} which generates a lilypond
containing all matches in a given chorale and @var{:none}, which does
not generate a lilypond file. The lilypond, if any, will be named
analysis/<command>-<start-of-match>-<end-of-match>.ly .

If a function is passed as a @var{:pre-filter} it will be called
before doing classification. Its job is to preemptively remove
uninteresting data that would be hard to ignore from inside the
classifier.

"
  (register-command
   :name name
   :documentation doc
   :options (append options
                    '(("" "freq" "Show as a frequency hash")
                      ("" "text" "Show as a text hash")
                      ("" "all-lily"
                       "Create a lily for all matches")
                      ("" "each-lily"
                       "Create a lily for each match")
                      ("" "cloud"
                       "Create a cloud figure for the results")
                      ("" "last"
                       "Match only the final segments")
                      ("" "context" (format nil
                                     "Override default context, ~a"
                                     context)
                       context 'rameau::type-int)
                      ("-m" "max-print-error"
                       "Maximum number of elements to be printed."
                       10
                       'rameau::type-int)))
   :action (make-musicology-action classifier
                                   context
                                   (get-text-display-function show-as)
                                   functional
                                   (get-lily-display-function generate-lily)
                                   (get-figure-display-function generate-figure)
                                    name
                                    pre-filter))
 nil)