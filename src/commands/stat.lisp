(defpackage :rameau-stat
  (:shadowing-import-from #:rameau-base #:defun #:defmacro #:defgeneric
                          #:defparameter #:defvar #:defstruct #:defclass)
  (:import-from #:arnesi "AIF" "AWHEN" "IT" "LAST1" "ENABLE-SHARP-L-SYNTAX")
  (:use :rameau :genoslib :cl :iterate :cl-lily)
  (:documentation "The correctness statistics commands for \\texttt{rameau}"))

(in-package :rameau-stat)


(defun average :private (r)
  (let ((l (length r)))
    (iter (for n in r)
          (sum (/ n (coerce l 'single-float))))))

(defun stddev :private (r a)
  (sqrt (iter (for n in r)
              (sum (* (- n a) (- n a))))))

(defun count-hits :private (res gab)
  (length (remove-if #'null (mapcar #'compare-answer-sheet res gab))))

(defcommand collect-data (options)
  nil
  "Collect accuracy data on the chord labeling algorithms specified."
  (let* ((analysis (analyse-files options))
         (a (first analysis)))
    (format t "~5a|" " ")
    (iter (for alg in (analysis-algorithms a))
          (format t "~7a|" (alg-name alg)))
    (format t "~%")
    (let ((res (iter (for i in (analysis-algorithms (first analysis))) (collect (list 0)))))
      (iter (for anal in analysis)
            (when (analysis-answer-sheet anal)
              (format t "~5a|" (analysis-file-name anal))
              (iter (for r in (analysis-results anal))
                    (for i from 0)
                    (let ((c (count-hits r (analysis-answer-sheet anal))))
                      (format t "~6,2f%|" (% c (length r)))
                      (apush (% c (length r)) (nth i res))))
              (format t "~%")))
      (format t "Medias:~%~5a|" " ")
      (iter (for r in res)
            (format t "~6,2f%|" (average (butlast r))))
      (format t "~%Desvios:~%~5a|" " ")
      (iter (for r in res)
            (format t "~6,2f |" (stddev (butlast r) (average (butlast r)))))
      (format t "~%"))))


(defun answer->mode (answer)
  (cond ((chord-p answer) (list :chord
                                (make-keyword (chord-mode answer))
                                (make-keyword (chord-7th answer))))
        ((melodic-note-p answer) (list :non-chord-tone))
        ((augmented-sixth-p answer) (list :aug6 (make-keyword (augmented-sixth-type answer))))
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
    (t "")))

(defun make-confusion-matrixes (f algorithms matrixes modes)
  (iter (for a in algorithms)
        (for cm in matrixes)
        (for nmodes = (length modes))
        (format f "\\begin{table}~%\\begin{center}~%\\begin{tabular}{r|~{~a~^|~}}~%"
                (mapcar (lambda (x) (declare (ignore x)) "r") modes))
        (format f "       & ~{~a~^ & ~} \\\\ \\hline~%" (mapcar #'mode->answer modes))
        (iter (for m in modes)
              (for n from 0)
              (format f " ~a " (mode->answer m))
              (iter (for i from 0 below nmodes)
                    (format f "& $~,1f$ " (if (or (= 0.0 (aref cm n i))
                                                  (= i n))
                                              " "
                                              (aref cm n i))))
              (format f " \\\\ \\hline~%"))
        (format f "\\end{tabular}~%\\caption{Confusion matrix for ~a}~%\\end{center}~%\\end{table}~%"
                (alg-name a))))

(defun build-confusion-matrixes (confusion-matrix countings matrixes modes)
  (iter (for a in *algorithms*)
        (for c in confusion-matrix)
        (for co in countings)
        (for i from 0)
        (let ((conf (make-array (list (length modes) (length modes)) :initial-element 0)))
          (iter (for ((an ga) count) in-hashtable c)
                (incf (aref conf (position ga modes :test #'equal) (position an modes :test #'equal))
                      (% count (gethash ga co 0.0000000001))))
          (setf (nth i matrixes) conf))))

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

(defcommand report (options)
  nil
  "Collect precision, recall, f-measure and confusion matrixes for the chord labeling algorithms specified."
  (let* ((analysis (analyse-files options))
         (algorithms (analysis-algorithms (first analysis)))
         (confusion-matrix (iter (for a in algorithms)
                                 (collect (make-hash-table :test #'equal))))
         (countings (iter (for a in algorithms)
                          (collect (make-hash-table :test #'equal))))
         (modes (make-hash-table :test #'equal))
         (matrixes (repeat-list (length algorithms) nil))
         (obtained (iter (for i in algorithms) (collect (make-hash-table :test #'equal))))
         (correct (iter (for i in algorithms) (collect (make-hash-table :test #'equal))))
         (answer (iter (for i in algorithms) (collect (make-hash-table :test #'equal)))))
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
                               (incf (gethash (answer->mode an) ob 0))))))))
    (format t "Done counting...~%")
    (setf modes (iter (for (mode va) in-hashtable modes) (collect mode)))
    (build-confusion-matrixes confusion-matrix countings matrixes modes)
    (format t "Done building confusion matrix...~%")
    (with-open-file (f (concat *rameau-path* "analysis/report.tex")
                       :direction :output
                       :if-exists :supersede)
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

")
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
      (format f "~%\\end{document}~%")
      (format t "Modes: ~s~%" modes))))
