(defun asdf-all (packages)
  (dolist (package packages) (asdf:oos 'asdf:load-op package :verbose nil)))

(asdf-all '(lexer yacc cl-fad cl-ppcre))

(defparameter *main-dir*
  (if (string= (machine-instance) "phoenix")
      "/home/kroger/doc/pesquisa/analise-harmonica/"
      "/home/top/programas/analise-harmonica/"))

(defun load-all (files)
  (loop for file in files do (load (concatenate 'string *main-dir* (format nil "src/~(~a~).lisp" file)))))

(load-all '(formato utils musiclib lisp-unit  parser segmento pardo ly-parser-teste))

