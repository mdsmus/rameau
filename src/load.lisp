(asdf:oos 'asdf:load-op 'lexer)
(asdf:oos 'asdf:load-op 'yacc)

(defparameter *main-dir* 
  (if (string= (machine-instance) "phoenix")
      "/home/kroger/doc/pesquisa/analise-harmonica/src/"
      "path/do/top"))

(defun load-all (&rest files)
  (loop for file in files do
       (load (concatenate 'string *main-dir* file))))

(load-all "formato.lisp"
          "parser.lisp"
          "lisp-unit.lisp"
          "ly-parser-teste.lisp")
