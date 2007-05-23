(import 'lexer:deflexer)
(import 'lexer:%0)
(use-package 'yacc)

;; (ignore-first a b) => b
;; Ignora o primeiro argumento
(defun ignore-first (a b)
  (declare (ignore a))
  b)

(defun ignore-first-second-third-fifth-sixth (a b c d e f)
  (declare (ignore a b c e f))
  d)

(defun get-exp (exp)
  (if (atom (car exp)) exp (car exp)))
      
;; (expmerge exp1 exp2) => expressãoanova
;; Junta as duas expressões, executando simultaneamente
(defun expmerge (exp1 exp2)
  (merge 'list (get-exp exp1) (get-exp exp2)
         (lambda (x y) (< (evento-inicio x) (evento-inicio y)))))

(deflexer string-lexer
  ("(c|d|e|f|g|a|b)(is|es|isis|eses)?" (return (values 'NOTE %0)))
  ("('|,)+" (return (values 'OCTAVE %0)))
  ("(128|16|32|64|1|2|4|8)" (return (values 'DUR %0)))
  ("(\-|\a|\\^)." (return (values 'ARTICULATION %0)))
  ("[:space:]+" ); (return (values 'WHITESPACE %0)))
  ("-+\n")
  ("\\\\new (s|S)taff" (return (values 'NEW-STAFF %0)))
  ("\\\\(R|r)elative" (return (values 'RELATIVE %0)))
  ("\\\\(S|s)core" (return (values 'NEW-SCORE %0)))
  ("<<" (return (values '|<<| '|<<|)))
  (">>" (return (values '|>>| '|>>|)))
  ("<" (return (values '|<| %0)))
  (">" (return (values '|>| %0)))
  ("\\{" (return (values '|{| '|{|)))
  ("\\}" (return (values '|}| '|}|)))
  )

;; (parse-standalone-music-expression expr)
; trata uma music expression como se ela estivesse fora de <<>>
(defun parse-standalone-expression (expr)
  (if (cdr expr)
      (if (not (evento-p (car expr)))
          (reduce #'concatena-sequencias expr :initial-value nil)
          expr)
      expr))

;; (parse-simultaneous-music-expression a exprs b)
; Ignora a e b e processa uma music expression como dentro de <<>>
(defun parse-chord (a exprs b)
  (declare (ignore a b))
  ;exprs)
  (reduce #'expmerge (cdr exprs) :initial-value (car exprs)))

;; (parse-staff-block1 ign expr1 expr2
; Contrói um staff block a partir de expr1 e expr2.
; FIXME: tem como dois staff blocks em sequência não soarem simultaneamente?
(defun parse-staff-block1 (ign expr1 expr2)
  (declare (ignore ign))
  (expmerge expr1 expr2))

;; (parse-staff-block2 ign staff)
; retorna staff
(defun parse-staff-block2 (ign staff)
  (declare (ignore ign))
  (parse-standalone-music-expression staff))

;; (parse-notes-expression a notes b expr)
; processa uma music expression que é uma sequência de notas e
; outra music expression ignorando delimitadores
(defun parse-notes-expression (a notes b expr)
  (declare (ignore a b))
  (append (list (emite-sequencia notes))
          expr))

;; (parse-notes a notes b)
; processa uma music expression que é uma sequência de notas
(defun parse-notes (a notes b)
  (declare (ignore a b))
  (emite-sequencia notes))

;; (parse-note-sequence note note-expr)
; processa uma sequência de notas
(defun parse-note-sequence (note note-expr)
  (append note (list note-expr)))

;; processa uma sequência de notas dentro de um \relative
(defun parse-relative (a nota expr)
  (declare (ignore a))
  (relativiza nota (emite-sequencia expr)))
  

(define-parser *expression-parser*
  (:start-symbol music-block)
  (:terminals (WHITESPACE
               NEW-STAFF
               NEW-SCORE
               DUR
               NOTE
               OCTAVE
               ARTICULATION
               RELATIVE
               |{| |}| |<<| |>>| |<| |>|))

  (music-block
   (NEW-SCORE |{| |<<| staff-block |>>| |}| #'ignore-first-second-third-fifth-sixth)
   (expression #'identity)
   (note-expr #'identity))

  (staff-block
   (NEW-STAFF expression staff-block #'parse-staff-block1)
   (NEW-STAFF expression #'ignore-first))
  
  (notes
   (note-expr #'list)
   (notes note-expr #'parse-note-sequence))

  (expression
   (|{| subexpr |}| #'parse-notes)
   (|{| subexpr |}| expression #'parse-notes-expression)
   (RELATIVE note-expr expression #'parse-relative)
   (|<| notes |>| #'parse-chord))

  (subexpr
   (notes #'identity)
   (expression #'identity))
  
  (note-expr
   (NOTE #'cria-nota)
   (NOTE OCTAVE #'cria-nota)
   (NOTE DUR #'cria-nota-com-duracao)
   (NOTE DUR articulation-expr #'cria-nota-com-duracao-articulacao)
   (NOTE articulation-expr #'cria-nota-com-articulacao))

  (articulation-expr
   ARTICULATION
   (articulation-expr ARTICULATION))
  )

(defun parse-string (str)
  (parse-with-lexer (string-lexer str) *expression-parser*))

(defun file-string (path)
  "Sucks up an entire file from PATH into a freshly-allocated string,
      returning two values: the string and the number of bytes read."
  (with-open-file (s path)
    (let* ((len (file-length s))
           (data (make-string len)))
      (values data (read-sequence data s)))))

(defun parse-file (filename)
  (parse-string (file-string filename)))
