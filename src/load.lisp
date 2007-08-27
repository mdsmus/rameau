(defun asdf-all (packages)
  (dolist (package packages) (asdf:oos 'asdf:load-op package :verbose nil)))

(asdf-all '(lexer yacc cl-fad))

(defparameter *main-dir* 
  (if (string= (machine-instance) "phoenix")
      "/home/kroger/doc/pesquisa/analise-harmonica/"
      "/home/top/programas/analise-harmonica/"))

(defun load-all (files)
  (loop for file in files do (load (format nil "src/~(~a~)" file))))

(load-all '(lisp-unit formato parser segmento pardo ly-parser-teste))
