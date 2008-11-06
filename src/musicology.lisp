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
          (for choraleno = (repeat-list (length answer)
                                        (analysis-file-name anal)))
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
          (let* ((size (normalize 10d0
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
        (for file = (first (member chorale
                                   (arg :files options)
                                   :key #'pathname-name)))
        (iter (for s in segments)
              (with-output-file (f (make-analysis-file "ly"
                                                       name
                                                       chorale
                                                       (1- s)
                                                       (1+ s)))
                (format f "~a" (make-lily-segments options
                                                   (subseq (sonorities
                                                            (parse-file file))
                                                           (1- s)
                                                           (1+ s))))))))

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
        (cond ((arg :figure options) (funcall #'figure-show-hash hash options))
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
                                    pre-filter)))