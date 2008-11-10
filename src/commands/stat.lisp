(defpackage :rameau-stat
  (:import-from #:arnesi "AIF" "AWHEN" "IT" "LAST1" "ENABLE-SHARP-L-SYNTAX")
  (:use :rameau :cl-utils :cl-music :cl :iterate :cl-lily)
  (:documentation "The correctness statistics commands for @rameau"))

(in-package :rameau-stat)

(enable-sharp-l-syntax)

(defun beta-cdf (a b x)
  "The cumulative distribution function for a beta(@var{a},@var{b})
random variable."
  (/ (statistics::beta-incomplete a b x)
     (statistics::beta-incomplete a b 1)))

(defun beta-pdf (a b x)
  "The probability density function for a beta(@var{a},@var{b}) random
variable."
  (* (/ 1 (statistics::beta-incomplete a b 1))
     (expt x (- a 1))
     (expt (- 1 x) (- b 1))))

(defun bisect (function xmin xmax)
  "Find the zero of @var{function} between @var{xmin} and @var{xmax}
by bisecting the interval. Wasteful, but works."
  (iter (with x = (* 0.5d0 (+ xmin xmax)))
        (for fx = (funcall function x))
        (dbg :bisect "Guessing ~a obtaining ~a~%" x fx)
        (until (< (abs fx) 1d-5))
        (if (< fx 0)
            (setf xmin x
                  x (* 0.5d0 (+ x xmax)))
            (setf xmax x
                  x (* 0.5d0 (+ xmin x))))
        (finally (return x))))

(defun sum (l)
  (reduce #'+ l))

(defun inverse-beta (confidence a b)
  "The inverse beta cdf for the given confidence value. Returns the
  value of @var{x} for which @code{(beta-cdf a b x)} returns
  @var{confidence}.

It works by finding the zero of @code{(- (beta-cdf a b x) confidence)}"
  (bisect  #L(- (beta-cdf a b (max 0 (min 1 !1))) confidence) 0 1))

(defun beta-ci (confidence correct total)
  "A centered confidence interval for a beta random variable."
  (let* ((alpha (1+ correct))
         (beta (1+ (- total correct))))
    (if (or (= 0 alpha) (= 0 beta))
        (list 1.0 1.0)
        (list (inverse-beta (* 0.5 (- 1 confidence)) alpha beta)
              (inverse-beta (* 0.5 (+ 1 confidence)) alpha beta)))))

(defun count-hits (res gab)
  (count-if-not #'null (mapcar #'compare-answer-sheet res gab)))

(defun collect-data (analysis)
  (let* ((a (first analysis))
         (res (iter (for i in (analysis-algorithms a))
                    (collect (list (list 0 0)))))
         (confidence 0.95)
         (intervals nil))
    (format t "~5a|" " ")
    (iter (for alg in (analysis-algorithms a))
          (format t "~7a|" (alg-name alg)))
    (format t "~%")
    (iter (for anal in analysis)
          (when (analysis-answer-sheet anal)
            (format t "~5a|" (analysis-file-name anal))
            (iter (for r in (analysis-results anal))
                  (for size = (length r))
                  (for c = (count-hits r (analysis-answer-sheet anal)))
                  (for i from 0)
                  (format t "~6,2f%|" (% c size))
                  (apush (list c size) (nth i res)))
            (format t "~%")))
    (setf intervals (mapcar #L(beta-ci confidence
                                       (sum (mapcar #'first !1))
                                       (sum (mapcar #'second !1)))
                            res))
    (format t "De:~%~5a|" " ")
    (iter (for (baixo alto) in intervals)
          (format t "~6,2f%|" (* 100 baixo)))
    (format t "~%Até:~%~5a|" " ")
    (iter (for (baixo alto) in intervals)
          (format t "~6,2f%|" (* 100 alto)))
    (format t "~%")
    intervals))

(defun answer->mode (answer)
  (cond ((chord-p answer)
         (list :chord
               (make-keyword (chord-mode answer))
               (make-keyword (chord-7th answer))))
        ((melodic-note-p answer) (list :non-chord-tone))
        ((augmented-sixth-p answer)
         (list :aug6 (make-keyword (augmented-sixth-type answer))))
        ((fchord-p answer)
         (let ((f (fchord-roman-function answer)))
           (list :functional
                 (roman-function-degree-number f)
                 (roman-function-mode f))))
        (t nil)))

(defun make-precision-table (f name func algorithms answer correct obtained modes)
  (format f "\\begin{table}~%\\begin{center}~%\\begin{tabular}{r|~{~a~^|~}}~%"
          (mapcar (lambda (x) (declare (ignore x)) "r") algorithms))
  (format f "   ~{& ~a~}  \\\\~%" (mapcar #'alg-name algorithms))
  (iter (for m in modes)
        (format f " ~a " (mode->answer m))
        (iter (for a in algorithms)
              (for re in answer)
              (for right in correct)
              (for ob in obtained)
              (format f "& $~,1f$ " (* 100 (funcall func m re right ob))))
        (format f " \\\\~%"))
  (format f "\\end{tabular}~%\\caption{~a matrix}~%\\end{center}~%\\end{table}~%"
          name))

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
    (:functional (make-fchord :key (make-tonal-key :center-pitch 0
                                                   :mode :major)
                              :roman-function (make-roman-function
                                               :degree-number (second mode)
                                               :degree-accidentals 0
                                               :mode (third mode))))
    (t "")))

(defun make-confusion-matrixes (f algorithms matrixes modes)
  (iter (for a in algorithms)
        (for cm in matrixes)
        (for nmodes = (length modes))
        (format f "\\begin{table}~%\\begin{center}~%\\begin{tabular}{r|~{~a~^|~}}~%"
                (mapcar (lambda (x) (declare (ignore x)) "r") modes))
        (format f "       & ~{~a~^ & ~} \\\\ \\hline~%"
                (mapcar #'mode->answer modes))
        (iter (for m in modes)
              (for n from 0)
              (format f " ~a " (mode->answer m))
              (iter (for i from 0 below nmodes)
                    (format f "& $~,1f$ " (if (or (= 0.0 (aref cm n i))
                                                  (= i n))
                                              " "
                                              (aref cm n i))))
              (format f " \\\\ \\hline~%"))
        (format f
                "\\end{tabular}
\\caption{Confusion matrix for ~a}
\\end{center}
\\end{table}
"
                (alg-name a))))

(defun make-accuracy-table (f res algorithms)
  (format f "\\begin{table}~%\\begin{center}~%\\begin{sc}~%\\begin{tabular}{lrr}~%")
  (format f "\\hline~%")
  (format f "Algorithm & Accuracy & Stddev \\\\ \\hline~%")
  (iter (for alg in algorithms)
        (for (baixo alto) in res)
        (format f "~a & ~2,1f & ~2,1f \\\\~%"
                (alg-name alg)
                (* 100 baixo)
                (* 100 alto)))
  (format f "\\hline")
  (format f "\\end{tabular}~%\\end{sc}~%\\end{center}~%\\caption{Accuracies}~%\\end{table}"))

(defun build-confusion-matrixes (confusion-matrix countings matrixes modes)
  (iter (for a in *algorithms*)
        (for c in confusion-matrix)
        (for co in countings)
        (for i from 0)
        (for conf = (make-array (list (length modes) (length modes))
                                :initial-element 0))
        (iter (for ((an ga) count) in-hashtable c)
              (incf (aref conf
                          (position ga modes :test #'equal)
                          (position an modes :test #'equal))
                    (% count (gethash ga co 0.0000000001))))
        (setf (nth i matrixes) conf)))

(defun /0 (a b)
  (if (zerop b) 0 (/ a b)))

(defun precision (m re right ob)
  (declare (ignore re))
  (/0 (gethash m right 0) (+ (gethash m right 0) (gethash m ob 0))))

(defun recall (m re right ob)
  (declare (ignore ob))
  (/0 (gethash m right 0) (+ (gethash m right 0) (gethash m re 0))))

(defun f-measure (m re right ob)
  (sqrt (* (precision m re right ob)
           (recall    m re right ob))))

(defun %make-hash (list)
  (iter (for i in list) (collect (make-hash-table :test #'equal))))

(defun do-counting (analysis algorithms confusion-matrix
                    countings answer obtained correct modes)
  (iter (for anal in analysis)
        (iter (for alg in algorithms)
              (for r in (analysis-results anal))
              (for m in confusion-matrix)
              (for co in countings)
              (for re in answer)
              (for ob in obtained)
              (for right in correct)
              (iter (for an in r)
                    (for ga in (analysis-answer-sheet anal))
                    (let ((ga (if (listp ga) (first ga) ga)))
                      (incf (gethash (answer->mode ga)
                                     co
                                     0))
                      (setf (gethash (answer->mode an) modes) t
                            (gethash (answer->mode ga) modes) t)
                      (incf (gethash (list (answer->mode an) (answer->mode ga)) m 0))
                      (if  (rameau::%compare-answer-sheet an ga)
                           (incf (gethash (answer->mode an) right 0))
                           (progn
                             (incf (gethash (answer->mode ga) re 0))
                             (incf (gethash (answer->mode an) ob 0)))))))))

(defun latex-header (f)
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

"))

(defun output-to-latex (algorithms modes matrixes obtained correct answer res)
  (with-output-file (f (make-analysis-file "tex" "report"))
    (latex-header f)
    (make-confusion-matrixes f algorithms matrixes modes)
    (make-precision-table f "Precision"
                          #'precision
                          algorithms
                          answer
                          correct
                          obtained
                          modes)
    (make-precision-table f "Recall"
                          #'recall
                          algorithms
                          answer
                          correct
                          obtained
                          modes)
    (make-precision-table f "F-measure"
                          #'f-measure
                          algorithms
                          answer
                          correct
                          obtained
                          modes)
    (make-accuracy-table f res algorithms)
    (format f "~%\\end{document}~%")
    (format t "Modes: ~s~%" modes)))

(defun report (options)
  (let* ((functional (if (arg :functional options)
                         :roman-analysis
                         :chord-names))
         (analysis (analyse-files options functional))
         (algorithms (analysis-algorithms (first analysis)))
         (confusion-matrix (iter (for a in algorithms)
                                 (collect (make-hash-table :test #'equal))))
         (countings (iter (for a in algorithms)
                          (collect (make-hash-table :test #'equal))))
         (modes (make-hash-table :test #'equal))
         (matrixes (repeat-list (length algorithms) nil))
         (obtained (%make-hash algorithms))
         (correct (%make-hash algorithms))
         (answer (%make-hash algorithms))
         (res (collect-data analysis)))
    (do-counting analysis algorithms confusion-matrix
                 countings answer obtained correct modes)
    (format t "Done counting...~%")
    (setf modes (iter (for (mode va) in-hashtable modes) (collect mode)))
    (build-confusion-matrixes confusion-matrix countings matrixes modes)
    (format t "Done building confusion matrix...~%")
    (output-to-latex algorithms modes matrixes obtained correct answer res)
    (format t "The tables are in analysis/report.tex~%")))


(register-command :name "report"
                  :action #'report
                  :documentation "Collect precision, recall, f-measure
                  and confusion matrixes for the chord labeling
                  algorithms specified."
                  :options '(("" "functional" "Use functional analysis")))
