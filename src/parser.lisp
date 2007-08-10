(import 'lexer:deflexer)
(import 'lexer:%0)
(use-package 'yacc)


(defun get-exp (exp)
  (if (atom (car exp)) exp (car exp)))
      
;; (expmerge exp1 exp2) => express�oanova
;; Junta as duas express�es, executando simultaneamente
(defun expmerge (exp1 exp2)
  (merge 'list (get-exp exp1) (get-exp exp2)
         (lambda (x y) (< (evento-inicio x) (evento-inicio y)))))

(defun merge-exprs (exprs)
  (if (second exprs)
      (expmerge (first exprs) (merge-exprs (rest exprs)))
      (car exprs)))

(deflexer string-lexer
  ("[:alpha:][:alpha:]+" (return (values 'VARNAME %0)))
  ("(c|d|e|f|g|a|b)(is|es|isis|eses)?" (return (values 'NOTE %0)))
  ("('|,)+" (return (values 'OCTAVE %0)))
  ("(128|16|32|64|1|2|4|8)" (return (values 'DUR %0)))
  ("(\-|\a|\\^)." (return (values 'ARTICULATION %0)))
  ("([:space:]+)")
  ("\\\\(V|v)oice((O|o)ne|(T|t)wo|(T|t)hree|(F|f)our)")
  ("-+\n")
  ("\\\\clef (bass|treble)")
  ("\\\\(T|t)ime \\d/\\d")
  ("\\\\(H|h)eader" (return (values 'HEADER %0)))
  ("\"[^\"]*\"" (return (values 'STRING %0)))
  ("=" (return (values '= '=)))
  ("\\\\new (s|S)taff" (return (values 'NEW-STAFF %0)))
  ("\\\\new (v|V)oice" (return (values 'NEW-VOICE %0)))
  ("\\\\(R|r)elative" (return (values 'RELATIVE %0)))
  ("\\\\(S|s)core" (return (values 'NEW-SCORE %0)))
  ("<<" (return (values '|<<| '|<<|)))
  (">>" (return (values '|>>| '|>>|)))
  ("<" (return (values '|<| %0)))
  (">" (return (values '|>| %0)))
  ("\\{" (return (values '|{| '|{|)))
  ("\\}" (return (values '|}| '|}|)))
  ("\\\\([:alpha:]+)" (return (values 'VARIABLE %0)))
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

(defun parse-staff-block (a block)
  (declare (ignore a))
  `(STAFF ,@block))

(defun parse-score-block (a block)
  (declare (ignore a))
  `(SCORE ,@block))

(defun parse-variable-block (variable)
  `(VARIABLE ,variable))

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
;; onde a dura��o est� definida e onde o parsing
;; vai acontecer. T�, � feio, mas eu n�o imagino
;; solu��o mais limpa nesse momento.

(defun do-the-parsing (tree)
  (let ((*dur* 1/4)
        (*environment* (make-hash-table :test #'equalp)))
    (declare (special *dur* *environment*))
    (process-tree (ajusta-duracao tree))))

(defun ajusta-duracao (tree)
  "acerta as dura��es por tempo de uma AST"
  (when tree
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

(defun process-trees (trees)
  (remove-if #'null (mapcar #'process-tree trees)))

(defun process-tree (tree)
  (if (listp tree)
      (let ((type (car tree))
            (expr (remove-if #'null (cdr tree))))
        (case type
          (MUSIC-BLOCK
           ;; Se a �rvore � um music block, expr � uma lista
           ;; de express�es que devem ser processadas em sequ�ncia
           ;; e depois juntas
           (let ((seq (process-trees expr)))
             (if (listp (car seq))
                 (coloca-expressoes-em-sequencia seq)
                 (sequencia-eventos seq))))
          (CHORD
           ;; Se a �rvore � um acorde, expr � uma sequ�ncia de notas
           ;; que devem ter a mesma dura��o
           (process-tree expr))
          (SIMULTANEOUS
           ;; Se a �rvore � um simultaneous, expr � uma lista de
           ;; express�es que devem ser executadas ao mesmo tempo,
           ;; mas com dura��es possivelmente diferentes
           (merge-exprs (process-trees expr)))
          (STAFF
           ;; Se a �rvore � um staff, nada mais precisa ser feito
           (process-tree expr))
          (SCORE
           ;; Se a �rvore � um score, nada mais precisa ser feito
           (process-tree expr))
          (VOICE
           ;; Se a �rvore � uma voz, nada precisa ser feito
           (process-tree expr))
          (RELATIVE
           ;; Se a �rvore � um relative, ela precisa ser processada
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
   (assignment #'identity)
   (variable-block #'identity)
   (relative-block #'identity)
   (|<| notes |>| #'parse-chord)
   (|<<| expression |>>| #'parse-simultaneous)
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
  
  (notes
   (note-expr #'list)
   (note-expr notes #'cons))

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
