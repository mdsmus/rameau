(in-package :rameau)

#+sbcl (eval-when (:compile-toplevel :load-toplevel :execute)
         (require 'sb-introspect))

(defun function-name (f)
  (multiple-value-bind (lam closure-p name) (function-lambda-expression f)
    (declare (ignore lam closure-p))
    name))

(defun is-function (f)
  (and (not (listp f))
       (fboundp f)
       (not (listp (function-name (symbol-function f))))))

(defun escape-latex (s)
  (let* ((s (format nil "~a" s))
         (s (cl-ppcre:regex-replace-all "&" s "\\\\&"))
         (s (cl-ppcre:regex-replace-all "#" s "\\\\#"))
         (s (cl-ppcre:regex-replace-all "%" s "\\\\%"))
         (s (cl-ppcre:regex-replace-all "\\$" s "\\\\$")))
    s))

(defun print-function-doc (package f function)
  (let ((name (function-name function)))
    (format f "\\section{~(~a~)}~%\\label{sec:~(~a~)}~%"
            (escape-latex name)
            (escape-latex name))
    #+sbcl (format f "\\texttt{~(~a~)}~%~%"
                   (escape-latex (stringify (cons name (sb-introspect:function-arglist function)))))
    (format f "\\begin{tabular}{rp{30em}}~%")
    #+sbcl (awhen (sb-introspect:definition-source-pathname (sb-introspect:find-definition-source function))
             (format f "Defined in &\\textbf{~a}\\\\~%~%" (escape-latex it)))
    #+sbcl (awhen (remove-if-not #'is-function
                                 (mapcar #'function-name (sb-introspect:FIND-FUNCTION-CALLERS function)))
             (format f "Used by & ~{~a~^, ~}\\\\~%~%" (mapcar #'escape-latex it)))
    (format f "\\end{tabular}~%~%")
    (format f "~a~%" (escape-latex (documentation function t)))))


(defun write-doc-file (pname symbs)
  (with-open-file (f (format nil "~a~a~a.tex" *rameau-path* "rameau-documentation/" pname)
                     :direction :output
                     :if-exists :supersede)
    (format f "
\\documentclass{article}
\\usepackage{graphicx}
\\usepackage{url}
\\usepackage[utf8x]{inputenc}
\\usepackage[T1]{fontenc}
\\usepackage[english]{babel}
\\usepackage{color}
\\usepackage{times}

\\title{Rameau Programmer's Guide---~a}
\\author{Pedro Kroger and Alexandre Passos}

\\newcommand{\\function}[2]{
  \\noindent\\texttt{#1}\\hfill\\textbf{[function]}\\\\
  #2
\\vspace{2em}
}

\\newcommand{\\example}[2]{
  \\par Example: \\texttt{#1} $\\rightarrow$ #2
}

\\begin{document}
\\maketitle
"
            pname)
    (format f "\\begin{abstract}~%~a~%\\end{abstract}~%~%"
            (documentation (find-package pname) t))
    (iter (for s in symbs)
          (when (= 0 (count-subseq "%" (stringify s)))
            (print-function-doc (find-package pname) f (symbol-function s))))
    (format f "~%~%\\end{document}~%")))
    

          
(defun create-documentation-for (&rest packages)
  (iter (for p in (mapcar #'find-package packages))
        (for pname in packages)
        (for symbs = (iter (for symb in-package p :external-only t)
                           (when (is-function symb)
                             (collect symb))))
        (format t "Documenting ~a...~%" pname)
        (write-doc-file pname symbs)))

;; (create-documentation-for :genoslib)
