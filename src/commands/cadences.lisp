(defpackage :rameau-cadences
  (:import-from #:arnesi "AIF" "AWHEN" "IT" "LAST1" "ENABLE-SHARP-L-SYNTAX")
  (:use :rameau :cl-utils :cl-music :cl :iterate)
  (:documentation "The cadence detection code for @rameau"))

(in-package :rameau-cadences)

(enable-sharp-l-syntax)

(defun remove-repeated-fchords (chords)
  (let (last-chord)
    (iter (for chord in chords)
          (for prev previous chord)
          (for c = (first chord))
          (for lc = (first last-chord))
          (if (not last-chord)
              (progn (setf last-chord chord)
                     (collect chord))
              (unless  (and (equalp (fchord-key c) (fchord-key lc))
                            (equal (roman-function-degree-number (fchord-roman-function c))
                                   (roman-function-degree-number (fchord-roman-function lc))))
                (collect chord)
                (setf last-chord chord))))))

(defun prepare-cadence (options anal n)
  (butlast (group (remove-repeated-fchords (all-chords-single options anal))
                  n)
           (1- n)))

(defun normalize-to-key (fchord first-key)
  "Normalize fchord @var{fchord} to be in relation to @var{key}."
  (let* ((this-key (fchord-key fchord))
         (center-pitch (interval (tonal-key-center-pitch first-key)
                                 (tonal-key-center-pitch this-key))))
    (make-fchord :roman-function (fchord-roman-function fchord)
                 :key (make-tonal-key :center-pitch  center-pitch
                                      :mode (tonal-key-mode this-key))
                 :inversion (fchord-inversion fchord)
                 :bass (fchord-bass fchord)
                 :7th (fchord-7th fchord))))

(defun add-to-cadence-hash (hash chords file-name segno)
  (let ((key (fchord-key (first chords))))
    (push (list file-name segno)
          (gethash (reduce #'concat
                           (mapcar #L(format nil "~a " !1)
                                   (cleanup-keys (mapcar #L(normalize-to-key !1 key)
                                                         chords))))
                   hash))))

(defun sorted-cadences (cadences)
  (sorted (iter (for (cadence places) in-hashtable cadences)
                (collect (list cadence places)))
          #L(> (length (second !1))
               (length (second !2)))))

(defun show-cadence-hash (options cadences)
  (iter (for (cadence  places) in (sorted-cadences cadences))
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

(defun make-cadence-figure (cadences name)
  "Draw the cadence figure for the cadences."
  (make-random-state t)
  (cl-cairo2:with-png-file
      ((make-analysis-file "png" "cadences" name)
       :rgb24 2000 2000)
    (let* ((center (list 1000 1000))
           (boxes nil)
           (cadences (sorted-cadences cadences))
           (max-size (length (second (first cadences)))))
      (cl-cairo2:select-font-face "Times" :normal :normal)
      (cl-cairo2:rectangle 0 0 2000 2000)
      (cl-cairo2:set-source-rgb 1 1 1)
      (cl-cairo2:fill-path)
      (iter (for (cadence  places) in cadences)
            (for i from 1)
            (let* ((size (normalize-line 10d0
                                         55d0
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

(defun cadences (options)
  "Run analysis and report the found cadences."
  (let ((analysis (analyse-files options :roman-function))
        (cadences (make-hash-table :test #'equal))
        (last-cadences (make-hash-table :test #'equal)))
    (iter (for anal in analysis)
          (let ((prep (prepare-cadence options
                                       anal
                                       (arg :cadence-number options))))
            (iter (for chords in prep)
                  (add-to-cadence-hash cadences
                                       (mapcar #'first chords)
                                       (third (first chords))
                                       (fourth (first chords))))
            (add-to-cadence-hash last-cadences
                                 (mapcar #'first (last1 prep))
                                 (third (first (last1 prep)))
                                 "end")))
    (format t "All cadences:~%")
    (show-cadence-hash options cadences)
    (make-cadence-figure cadences "cadences")
    (format t "Cadences in the end:~%")
    (show-cadence-hash options last-cadences)
    (make-cadence-figure last-cadences "last-cadences")))

(register-command :name "cadences"
                  :action #'cadences
                  :options '(("-z" "cadence-number" "number of chords to consider" 4 type-integer))
                  :documentation "Detect the chord progressions and
cadences in the specified files using the first specified roman
numeral functional analysis algorithm. The chord progressions will be
in analysis/cadences-cadences.png and the cadences will be in
analysis/cadences-last-cadences.png")
