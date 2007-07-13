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

(deflexer string-lexer
  ("(c|d|e|f|g|a|b)(is|es|isis|eses)?" (return (values 'NOTE %0)))
  ("('|,)+" (return (values 'OCTAVE %0)))
  ("(128|16|32|64|1|2|4|8)" (return (values 'DUR %0)))
  ("(\-|\a|\\^)." (return (values 'ARTICULATION %0)))
  ("[:space:]+" ); (return (values 'WHITESPACE %0)))
  ("-+\n")
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
  )




;;; Novas funções de parsing

(defun parse-music-block (a block b)
  (declare (ignore a b))
  (coloca-expressoes-em-sequencia block))

(defun parse-chord (a chord b)
  (declare (ignore a b))
  chord)

(defun parse-simultaneous (a simultaneous b)
  (declare (ignore a b))
  (expmerge simultaneous))

(defun parse-staff-block (a block)
  (declare (ignore a))
  block)

(defun parse-score-block (a block)
  (declare (ignore a))
  block)

(defun parse-voice-block (a block)
  (declare (ignore a))
  block)

(defun parse-relative-block (a relative block)
  (declare (ignore a))
  (relativiza relative block))

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
               |{| |}| |<<| |>>| |<| |>|))

  (lilypond
   (lilypond-header #'identity)
   (music-block #'identity))
  
  (music-block
   (|{| expression |}| #'parse-music-block)
);   (expression-atom #'identity))

  (expression
   (expression-atom #'list)
   (expression-atom expression #'cons))

  (expression-atom
   (music-block #'identity)
   (staff-block #'identity)
   (voice-block #'identity)
   (relative-block #'identity)
   (|<| notes |>| #'parse-chord)
   (note-expr #'identity)
   (|<<| expression |>>| #'parse-simultaneous)
   (score-block #'identity))
   
  (staff-block
   (NEW-STAFF music-block #'parse-staff-block))

  (voice-block
   (NEW-VOICE music-block #'parse-voice-block))
  
  (score-block
   (NEW-SCORE music-block #'parse-score-block))

  (relative-block
   (RELATIVE note-expr music-block #'parse-relative-block))
  
  (notes
   (note-expr #'list)
   (note-expr notes #'cons))


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
