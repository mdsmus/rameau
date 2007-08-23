(import 'lexer:deflexer)
(import 'lexer:%0)
(use-package 'yacc)


(defun get-exp (exp)
  (if (atom (car exp)) exp (car exp)))
      
;; (expmerge exp1 exp2) => expressãoanova
;; Junta as duas expressões, executando simultaneamente
(defun expmerge (exp1 exp2)
  (merge 'list (get-exp exp1) (get-exp exp2)
         (lambda (x y) (< (evento-inicio x) (evento-inicio y)))))

(defun merge-exprs (exprs)
  (if (second exprs)
      (expmerge (first exprs) (merge-exprs (rest exprs)))
      (car exprs)))

(deflexer string-lexer
  ("('|,)+" (return (values 'OCTAVE %0)))
  ("[:alpha:]+"
   (if (notap %0)
       (return (values 'NOTE %0))
       (return (values 'VARNAME %0))))
  ("(\-|\a|\\^)." (return (values 'ARTICULATION %0)))
  ("\\\\(T|t)imes" (return (values 'TIMES %0)))
  ("\\d/\\d" (return (values 'NUMBER (read-from-string %0))))
  ("(128|16|32|64|1|2|4|8)" (return (values 'DUR %0)))
  ("([:space:]+)")
  ("\\\\(V|v)oice((O|o)ne|(T|t)wo|(T|t)hree|(F|f)our)")
  ("-+\n")
  ("\\|")
  ("\\\\clef \"?(treble|violin|G|G2|alto|C|tenor|bass|F|french|soprano|mezzosoprano|baritone|varbaritone|subbass)\"?")
  ("\\\\(T|t)ime \\d/\\d")
  ;; FIXME: porque sem o foo nao funciona? (wtf!?) [ver regressao 034]
  ;; acho que \minor está sendo pegado por VARIABLE abaixo (comentar e ver)
  ("\\\\key[:space:]+(|a|b|c|d|e|f|g|h)+(is|es)*[:space:]+\\\\(minor|major|foo)+")
  ("\\\\[Vv]ersion[:space:]+\"[^\"]*\"")
  ("%[^\\n]*")
  ("\\." (return (values 'PONTO %0)))
  ("\\\\(H|h)eader" (return (values 'HEADER %0)))
  ("\"[^\"]*\"" (return (values 'STRING %0)))
  ("=" (return (values '= '=)))
  ("\\\\new[:space:]+(s|S)taff" (return (values 'NEW-STAFF %0)))
  ("\\\\new[:space:]+(v|V)oice" (return (values 'NEW-VOICE %0)))
  ("\\\\(R|r)elative" (return (values 'RELATIVE %0)))
  ("\\\\(S|s)core" (return (values 'NEW-SCORE %0)))
  ("\\\\(S|s)imultaneous" (return (values 'SIMULT %0)))
  ("<<" (return (values '|<<| '|<<|)))
  (">>" (return (values '|>>| '|>>|)))
  ("<" (return (values '|<| %0)))
  (">" (return (values '|>| %0)))
  ("\\{" (return (values '|{| '|{|)))
  ("\\}" (return (values '|}| '|}|)))
  ;;("\\\\([:alpha:]+)" (return (values 'VARIABLE %0)))
  )

(defun parse-music-block (a block b)
  (declare (ignore a b))
  `(MUSIC-BLOCK ,@block))

(defun parse-empty-block (a b)
  (declare (ignore a b))
  nil)

(defun parse-chord (a chord b)
  (declare (ignore a b))
  `(CHORD ,@chord))

(defun parse-simultaneous (a simultaneous b)
  (declare (ignore a b))
  `(SIMULTANEOUS ,@simultaneous))

(defun parse-simult (a b simultaneous c)
  (declare (ignore a b c))
  `(SIMULTANEOUS ,@simultaneous))

(defun parse-staff-block (a block)
  (declare (ignore a))
  `(STAFF ,@block))

(defun parse-score-block (a block)
  (declare (ignore a))
  `(SCORE ,@block))

(defun parse-variable-block (variable)
  `(VARIABLE ,variable))

(defun parse-times-block (a number expr)
  `(TIMES ,number ,@expr))

(defun parse-voice-block (a block)
  (declare (ignore a))
  `(VOICE ,@block))

(defun parse-relative-block (a relative block)
  (declare (ignore a))
  `(RELATIVE ,relative ,@block))

(defun parse-expression-atom (atom)
  (cons atom nil))

(defun parse-expression (atom expression)
  (cons atom expression))

(defun parse-lilypond-header (header expression)
  (declare (ignore header))
  (do-the-parsing expression))

(defun parse-lilypond (lilypond atom)
  (coloca-expressoes-em-sequencia
   (remove-if #'null (list lilypond
                               (do-the-parsing atom)))))

(defun parse-assignment (variable equal value)
  (declare (ignore equal))
  `(SET ,variable ,value))

;; do-the-parsing estabelece o ambiente global
;; onde a duração está definida e onde o parsing
;; vai acontecer. Tá, é feio, mas eu não imagino
;; solução mais limpa nesse momento.

(defun do-the-parsing (tree)
  (let ((*dur* 1/4)
        (*environment* (make-hash-table :test #'equalp)))
    (declare (special *dur* *environment*))
    (process-tree (ajusta-duracao tree))))

(defun ajusta-duracao (tree)
  "acerta as durações por tempo de uma AST"
  (when (and (listp tree) tree)
    (let ((prim (car tree))
          (rest (cdr tree)))
      (when (evento-p prim)
        (if (evento-dur prim)
            (setf *dur* (evento-dur prim))
            (setf (evento-dur prim) *dur*)))
      (when (listp prim)
        (ajusta-duracao prim))
      (when rest
        (ajusta-duracao rest))
      tree)))

(defun acerta-times (times tree)
  "acerta as durações por tempo de uma AST"
  (when (and (listp tree) tree)
    (let ((prim (car tree))
          (rest (cdr tree)))
      (when (evento-p prim)
            (setf (evento-dur prim) (* times (evento-dur prim))))
      (when (listp prim)
        (acerta-times times prim))
      (when rest
        (acerta-times times rest)))))

(defun process-trees (trees)
  (remove-if #'null (mapcar #'process-tree trees)))

(defun process-tree (tree)
  (if (listp tree)
      (let ((type (car tree))
            (expr (remove-if #'null (cdr tree))))
        (case type
          (MUSIC-BLOCK
           ;; Se a árvore é um music block, expr é uma lista
           ;; de expressões que devem ser processadas em sequência
           ;; e depois juntas
           (let ((seq (process-trees expr)))
             (if (listp (car seq))
                 (coloca-expressoes-em-sequencia seq)
                 (sequencia-eventos seq))))
          (CHORD
           ;; Se a árvore é um acorde, expr é uma sequência de notas
           ;; que devem ter a mesma duração
           (process-tree expr))
          (SIMULTANEOUS
           ;; Se a árvore é um simultaneous, expr é uma lista de
           ;; expressões que devem ser executadas ao mesmo tempo,
           ;; mas com durações possivelmente diferentes
           (merge-exprs (process-trees expr)))
          (STAFF
           ;; Se a árvore é um staff, nada mais precisa ser feito
           (process-tree expr))
          (TIMES
           (let ((dur (car expr))
                 (expr (cdr expr)))
             (acerta-times dur expr)
             (process-tree expr)))
          (SCORE
           ;; Se a árvore é um score, nada mais precisa ser feito
           (process-tree expr))
          (VOICE
           ;; Se a árvore é uma voz, nada precisa ser feito
           (process-tree expr))
          (RELATIVE
           ;; Se a árvore é um relative, ela precisa ser processada
           ;; para relativizar as oitavas
           (relativiza (car expr) (process-tree (rest expr))))
          (EXPRESSION
           expr)
          (SET
           (setf (gethash (first expr) *environment*) (second expr))
           nil)
          (VARIABLE
           (process-tree (gethash (subseq (first expr) 1) *environment*)))
          (t tree)))
      tree))

(define-parser *expression-parser*
  (:start-symbol lilypond)
  (:terminals (WHITESPACE
               NEW-STAFF
               NEW-SCORE
               NEW-VOICE
               DUR
               NOTE
               OCTAVE
               ARTICULATION
               RELATIVE
               STRING
               HEADER
               VARNAME
               VARIABLE
               SIMULT
               PONTO
               TIMES
               NUMBER
               = |{| |}| |<<| |>>| |<| |>|))

  (lilypond
   (lilypond-header expression-atom #'parse-lilypond-header)
   (expression-atom #'do-the-parsing)
   (lilypond expression-atom #'parse-lilypond))

  (lilypond-header
   (HEADER |{| expression |}|))

  (expression
   (expression-atom #'parse-expression-atom)
   (expression-atom expression #'parse-expression))
  
  (expression-atom
   (music-block #'identity)
   (empty-block #'identity)
   (staff-block #'identity)
   (score-block #'identity)
   (voice-block #'identity)
   (times-block #'identity)
   (assignment #'identity)
   (variable-block #'identity)
   (relative-block #'identity)
   (|<| notes |>| #'parse-chord)
   (|<<| expression |>>| #'parse-simultaneous)
   (SIMULT { expression } #'parse-simult)
   (note-expr #'identity))

  (assignment
   (VARNAME = value #'parse-assignment))

  (value
   (STRING #'identity)
   (expression-atom #'identity))

  (variable-block
   (VARIABLE #'parse-variable-block))
   
  (music-block
   (|{| expression |}| #'parse-music-block))

  (empty-block
   (|{| |}| #'parse-empty-block))

  (staff-block
   (NEW-STAFF expression-atom #'parse-staff-block))

  (score-block
   (NEW-SCORE expression-atom #'parse-score-block))

  (voice-block
   (NEW-VOICE expression-atom #'parse-voice-block))
  
  (relative-block
   (RELATIVE note-expr expression-atom #'parse-relative-block))

  (times-block
   (TIMES NUMBER expression-atom #'parse-times-block))
  
  (notes
   (note-expr #'list)
   (note-expr notes #'cons))

  (note-expr
   (NOTE #'cria-nota)
   (NOTE OCTAVE #'cria-nota)
   (NOTE OCTAVE DUR #'cria-nota)
   (NOTE OCTAVE DUR PONTO #'cria-nota-com-oitava-duracao-ponto)
   (NOTE DUR PONTO #'cria-nota-com-duracao-ponto)
   (NOTE DUR PONTO articulation-expr #'cria-nota-com-duracao-articulacao-ponto)
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

;;(parse-file "/home/top/programas/analise-harmonica/exemplos/quarteto-ravel.ly")