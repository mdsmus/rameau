(in-package :rameau)

#+sbcl (eval-when (:compile-toplevel :load-toplevel :execute)
         (require 'sb-introspect))

(defun function-name :private (f)
  (multiple-value-bind (lam closure-p name) (function-lambda-expression f)
    (declare (ignore lam closure-p))
    name))

(defun is-function :private (f)
  (and f
       (not (listp f))
       (fboundp f)
       (not (listp (function-name (symbol-function f))))))

(defun escape-latex :private (s)
  (let* ((s (format nil "~a" s))
         (s (cl-ppcre:regex-replace-all "&" s "\\\\&"))
         (s (cl-ppcre:regex-replace-all "#" s "\\\\#"))
         (s (cl-ppcre:regex-replace-all "%" s "\\\\%"))
         (s (cl-ppcre:regex-replace-all "\\$" s "\\\\$")))
    s))

(defun escape-label :private (s)
  (let* ((s (format nil "~a" s))
         (s (cl-ppcre:regex-replace-all "&" s "-and-"))
         (s (cl-ppcre:regex-replace-all "#" s "-pound-"))
         (s (cl-ppcre:regex-replace-all "%" s "percent-"))
         (s (cl-ppcre:regex-replace-all "\\$" s "-dollar-"))
         (s (cl-ppcre:regex-replace-all "\\>" s "to-")))
    s))

(defun add-ref :private (s)
  (format nil "\\hyperref{~a}{~a (}{)}{sec:~(~a~)}" (escape-latex s) (escape-latex s) (escape-label s)))

(defun print-function-doc :private (f function)
  (let ((name (function-name function)))
    (format f "\\section{~(~a~)}~%\\label{sec:~(~a~)}~%"
            (escape-latex name)
            (escape-label name))
    #+sbcl (format f "Syntax: \\texttt{~(~a~)}~%~%"
                   (escape-latex (stringify (cons name (sb-introspect:function-arglist function)))))
    (format f "~a~%~%" (escape-latex (documentation function t)))
    (format f "\\begin{tabular}{p{10em}p{30em}}~%")
    #+sbcl (awhen (sb-introspect:definition-source-pathname (sb-introspect:find-definition-source function))
             (format f "Defined in &\\textbf{~a.lisp}\\\\~%~%" (escape-latex (pathname-name it))))
    #+sbcl (awhen (remove-if-not #'is-function
                                 (mapcar #'function-name (sb-introspect:FIND-FUNCTION-CALLERS function)))
             (format f "Used by & ~{~a~^, ~}\\\\~%~%" (mapcar #'add-ref it)))
    #+sbcl (awhen (remove-if-not #'is-function
                                 (mapcar #'function-name (handler-case (sb-introspect:FIND-FUNCTION-CALLEES function)
                                                           (t nil))))
             (format f "Uses & ~{~a~^, ~}\\\\~%~%" (mapcar #'add-ref it)))
    (format f "\\end{tabular}~%~%")
    ))


(defun write-doc-package :private (f pname symbs)
    (format f "~%\\chapter{~a}~%\\label{sec:~a}~%" pname pname)
    (format f "\\begin{quote}~%~a~%\\end{quote}~%~%"
            (documentation (find-package pname) t))
    (iter (for s in symbs)
          (when (= 0 (count-subseq "%" (stringify s)))
            (print-function-doc f (symbol-function s)))))
    

          
(defun create-documentation-for (&rest packages)
  "Create a file named \\texttt{rameau.tex} with the documentation for
  packages \\texttt{packages}."
  (with-open-file (f (concat *rameau-path* "/rameau-documentation/rameau.tex")
                     :direction :output
                     :if-exists :supersede)
    (format f "
\\documentclass{book}
\\usepackage{graphicx}
\\usepackage{url}
\\usepackage[utf8x]{inputenc}
\\usepackage[T1]{fontenc}
\\usepackage[english]{babel}
\\usepackage{color}
\\usepackage{times}
\\usepackage{html}

\\title{Rameau Programmer's Guide}
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
\\tableofcontents
")
    (iter (for p in (mapcar #'find-package packages))
          (for pname in packages)
          (for symbs = (iter (for symb in-package p :external-only t)
                             (when (is-function symb)
                               (collect symb))))
          (format t "Documenting ~a...~%" pname)
          (write-doc-package f pname (sorted symbs #'string-lessp :key #'stringify)))
    (format f "~%\\end{document}~%")))

;; (create-documentation-for :genoslib)
