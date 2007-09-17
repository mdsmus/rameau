(import 'lexer:deflexer)
(import 'lexer:%0)
(use-package 'yacc)

(defparameter *filename* nil)

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
  ("(V|v)oice" (return (values 'VOICE %0)))
  ("(S|s)taff" (return (values 'STAFF %0)))
  ("(S|s)core" (return (values 'SCORE %)))
  ("-\\\\tenuto")
  ("-\\\\staccato")
  ("(-|_|\\^|~|\\?)(\\.|\\^|\\+|\\||>|_|-|\"[^\"]*\")?" (return (values 'ARTICULATION LEXER::START)))
  ("[:alpha:]+"
   (if (or (note? %0) (rest? %0))
       (return (values 'NOTE %0))
       (return (values 'VARNAME %0))))
  ("\\\\(T|t)imes" (return (values 'TIMES %0)))
  ("\\d/\\d" (return (values 'NUMBER (read-from-string %0))))
  ("(128|16|32|64|1|2|4|8)" (return (values 'DUR %0)))
  ("\\d+" (return (values 'NUMBER %0)))
  ("\\*\\d+/\\d+" (return (values 'MULTIPLICA %0)))
  ("\\*\\d+" (return (values 'MULTIPLICA %0)))
  ("([:space:]+)")
  ("\\\\\\\\") ; contar isso é uma maravilha. Devem ser oito
  ("\\\\(set|override)[^=]*=[:space:]+[^:space:]*") ; pra ignorar set e override
  ("\\\\(V|v)oice((O|o)ne|(T|t)wo|(T|t)hree|(F|f)our)")
  ("-+\n")
  ("\\|")
  ("#(t|f)" (return (values 'BOOL %0)))
  ("#" (return (values 'HASH %0)))
  ("\\\\[Vv]ersion[:space:]+\"[^\"]*\"")
  ("\\\\clef[:space:]+\"?(treble|violin|G|G2|alto|C|tenor|bass|F|french|soprano|mezzosoprano|baritone|varbaritone|subbass)\"?")
  ("\\\\(T|t)ime[:space:]+\\d+/\\d+")
  ("\\\\(T|t)empo[:space:]+\\d+[:space:]+=[:space:]+\\d+")
  ("\\\\(T|t)ime[:space:]+\\d+[:space:]+=[:space:]+\\d+")
  ("\\\\(B|b)ar[:space:]+\"[^\"]*\"")
  ("\\\\(P|p)artial[:space:]+\\d+")
  ("\\\\(L|l)ayout" (return (values 'LAYOUT %0)))
  ;; FIXME: porque sem o foo nao funciona? (wtf!?) [ver regressao 034]
  ;; acho que \minor está sendo pegado por VARIABLE abaixo (comentar e ver)
  ("\\\\key[:space:]+(a|b|c|d|e|f|g)(is|es)*[:space:]+\\\\(minor|major|dim)")
  ("%[^\\n]*")
  ("\\\\(S|s)kip" (return (values 'SKIP %0)))
  ("\\\\(C|c)ontext" (return (values 'CONTEXT %0)))
  ("\\." (return (values 'PONTO %0)))
  ("\\\\(H|h)eader" (return (values 'HEADER %0)))
  ("\"[^\"]*\"" (return (values 'STRING %0)))
  ("=" (return (values '= '=)))
  ("\\\\include" (return (values 'INCLUDE %0)))
  ("\\\\new[:space:]+(Piano)?(s|S)taff" (return (values 'NEW-STAFF %0)))
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
  ("\\\\([:alpha:]+)" (return (values 'VARIABLE %0)))
  ("\\(" (return (values 'OPEN-PAREN %0)))
  ("\\)" (return (values 'CLOSE-PAREN %0)))
  (":" (return (values 'COLON %0)))
  )

(defclass ast-node ()
  ((expr :accessor node-expr :initarg :expr :initform nil)))

(defclass times (ast-node)
  ((times :accessor node-times :initarg :times)))

(defclass relative (ast-node)
  ((start :accessor node-start :initarg :start)))

(defclass set-variable (ast-node)
  ((varname :accessor node-varname :initarg :varname)
   (value :accessor node-value :initarg :value)))

(defclass read-variable (ast-node)
  ((varname :accessor node-varname :initarg :varname)))

(defclass music-block (ast-node) ())

(defclass simultaneous (ast-node) ())

(defclass chord (simultaneous) ())

(defclass no-op-node (ast-node) ())

(defclass staff (no-op-node) ())

(defclass score (no-op-node) ())

(defclass voice (no-op-node) ())

(defun parse-music-block (a block b)
  (declare (ignore a b))
  (make-instance 'music-block :expr block))

(defun parse-empty-block (a b)
  (declare (ignore a b))
  nil)

(defun parse-chord-dur (a chord b dur c)
  (declare (ignore a b c))
  (when dur
      (dolist (i chord)
        (setf (evento-dur i) dur)))
  (make-instance 'chord :expr chord))

(defun parse-simultaneous (a simultaneous b)
  (declare (ignore a b))
  (make-instance 'simultaneous :expr simultaneous))

(defun parse-simult (a b simultaneous c)
  (declare (ignore a b c))
  (make-instance 'simultaneous :expr simultaneous))

(defun parse-staff-block (a block)
  (declare (ignore a))
  (make-instance 'staff :expr block))

(defun parse-context-staff (a b c d block)
  (declare (ignore a b c d))
  (parse-staff-block nil block))

(defun parse-score-block (a block)
  (declare (ignore a))
  (make-instance 'score :expr block))

(defun parse-context-score (a b c block)
  (declare (ignore a b c))
  (parse-score-block nil block))

(defun parse-variable-block (variable)
  (make-instance 'read-variable :varname variable))

(defun parse-times-block (a number expr)
  (make-instance 'times :times number :expr expr))

(defun parse-voice-block (a block)
  (declare (ignore a))
  (make-instance 'voice :expr block))

(defun parse-voice-block-string (a b c block)
  (declare (ignore a b c))
  (make-instance 'voice :expr block))

(defun parse-dur (dur)
  (parse-integer dur))

(defun parse-dur-ponto (dur ponto)
  (declare (ignore ponto))
    (+ dur (/ dur 2)))

(defun parse-dur-multiplica (dur mult)
  (* dur (eval (read-from-string (subseq mult 1)))))

(defun parse-include (a file)
  (declare (ignore a))
  (parse-file
   (if *filename*
       (concatenate 'string
                    (subseq *filename* 0 (search "/" *filename* :from-end t))
                    "/"
                    (read-from-string file))
       (read-from-string file))))


(defun parse-context-voice (a b c d block)
  (declare (ignore a b c d))
  (parse-voice-block nil block))

(defun parse-relative-block (a relative block)
  (declare (ignore a))
  (make-instance 'relative :expr block :start relative))


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

(defun empty-octave ()
  "")

(defun empty-dur ()
  nil)

(defun ignora (a)
  (declare (ignore a)))

(defun ignore-second (a b)
  (declare (ignore b))
  a)

(defun parse-assignment (variable equal value)
  (declare (ignore equal))
  (make-instance 'set-variable :varname variable :value value))

;; do-the-parsing estabelece o ambiente global
;; onde a duração está definida e onde o parsing
;; vai acontecer. Tá, é feio, mas eu não imagino
;; solução mais limpa nesse momento.

(defun do-the-parsing (tree)
  (process-ast (ajusta-duracao tree)))

(defgeneric ajusta-duracao (tree) 
    (:documentation "Acerta as durações das notas em uma música"))

(defmethod ajusta-duracao ((tree ast-node))
  (ajusta-duracao (node-expr tree))
  tree)

(defmethod ajusta-duracao ((tree evento))
  (if (evento-dur tree)
      (setf *dur* (evento-dur tree))
      (setf (evento-dur tree) *dur*))
  tree)

(defmethod ajusta-duracao ((tree list))
  (mapcar #'ajusta-duracao tree)
  tree)

(defmethod ajusta-duracao ((tree set-variable))
  (ajusta-duracao (node-value tree))
  tree)

(defmethod ajusta-duracao (tree) tree)

(defgeneric acerta-times (times tree)
  (:documentation "Multiplica um pedaco de música por um tempo especificado"))

(defmethod acerta-times (times (tree ast-node))
  (mapcar (lambda (x) (acerta-times times x)) (node-expr tree)))

(defmethod acerta-times (times (e evento))
  (setf (evento-dur e) (* times (evento-dur e))))

(defmethod acerta-times (times (tree set-variable))
  (acerta-times times (node-value tree)))

(defmethod acerta-times (times tree))


(defgeneric process-ast (astnode)
  (:documentation "Processa um nó na AST e retorna a parte correspondente"))

(defmethod process-ast ((node no-op-node))
  (process-ast (node-expr node)))

(defun process-trees (trees)
  (remove-if
   #'null
   (mapcar
    (lambda (x)
      (let ((s (process-ast x)))
        (if (listp s)
             s
            (list s))))
    trees)))

(defmethod process-ast ((node music-block))
  (let ((seq (process-trees (node-expr node))))
    (coloca-expressoes-em-sequencia seq)))

(defmethod process-ast ((node simultaneous))
  (merge-exprs (process-trees (node-expr node))))

(defmethod process-ast ((node times))
  (let ((dur (node-times node))
        (expr (node-expr node)))
    (acerta-times dur expr)
    (process-tree expr)))

(defmethod process-ast ((node relative))
  (relativiza (node-start node) (process-ast (node-expr node))))

(defmethod process-ast ((node set-variable))
  (push (cons (node-varname node) (node-value node)) *environment*)
  nil)

(defmethod process-ast ((node read-variable))
  (process-ast (rest (assoc (subseq (node-varname node) 1) *environment* :test #'equalp))))

(defmethod process-ast (node)
  (if (listp node)
      (remove-if #'null node)
      node))
      
(define-parser *expression-parser*
  (:start-symbol start)
  (:muffle-conflicts t)
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
               VOICE
               STAFF
               SCORE
               CONTEXT
               MULTIPLICA
               SKIP
               HASH
               OPEN-PAREN
               CLOSE-PAREN
               BOOL
               COLON
               LAYOUT
               NUMBER
               INCLUDE
               = |{| |}| |<<| |>>| |<| |>|))

  (start
   ()
   (lilypond #'identity))
  
  (lilypond
   (expression-atom #'do-the-parsing)
   (lilypond expression-atom #'parse-lilypond))

  (lilypond-header
   (HEADER |{| expression |}|)
   (HEADER |{| |}|))

  (expression
   (expression-atom #'parse-expression-atom)
   (expression-atom expression #'parse-expression))
  
  (expression-atom
   (lilypond-header #'ignora)
   (OPEN-PAREN #'ignora)
   (CLOSE-PAREN #'ignora)
   (layout-block #'ignora)
   (music-block #'identity)
   (empty-block #'identity)
   (staff-block #'identity)
   (score-block #'identity)
   (voice-block #'identity)
   (times-block #'identity)
   (assignment #'identity)
   (variable-block #'identity)
   (relative-block #'identity)
   (chord-block #'identity)
   (scheme-code #'ignora)
   (include STRING #'parse-include)
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

  (layout-block
   (LAYOUT |{| |}|)
   (LAYOUT |{| expression |}|))

  (staff-block
   (NEW-STAFF expression-atom #'parse-staff-block)
   (CONTEXT STAFF = VARNAME expression-atom #'parse-context-staff)
   (CONTEXT STAFF = STRING expression-atom #'parse-context-staff))

  (score-block
   (NEW-SCORE expression-atom #'parse-score-block)
   (CONTEXT SCORE = VARNAME expression-atom #'parse-context-score)
   (CONTEXT SCORE = STRING expression-atom #'parse-context-score))

  (voice-block
   (NEW-VOICE expression-atom #'parse-voice-block)
   (NEW-VOICE = STRING expression-atom #'parse-voice-block-string)
   (CONTEXT VOICE = VARNAME expression-atom #'parse-context-voice)
   (CONTEXT VOICE = STRING expression-atom #'parse-context-voice))
  
  (relative-block
   (RELATIVE note-expr expression-atom #'parse-relative-block))

  (times-block
   (TIMES NUMBER expression-atom #'parse-times-block))

  (chord-block
   (|<| notes |>| dur-expr articulation-expr #'parse-chord-dur))

  (notes
   (note-expr #'list)
   (note-expr notes #'cons))
  
  (note-expr
   (NOTE octave-expr dur-expr articulation-expr dur-expr #'cria-nota)
   (SKIP dur-expr #'cria-skip))

  (articulation-expr
   ()
   (articulation-expr ARTICULATION)
   (articulation-expr string))

  (octave-expr
   (#'empty-octave)
   (OCTAVE #'identity))

  (dur-expr
   (#'empty-dur)
   (DUR #'parse-dur)
   (dur-expr PONTO #'parse-dur-ponto)
   (dur-expr MULTIPLICA #'parse-dur-multiplica))
  

  (scheme-code
   (HASH scheme-sexp))

  (scheme-sexp
   (OPEN-PAREN scheme-list CLOSE-PAREN))

  (scheme-list
   ()
   (scheme-list scheme-atom))

  (scheme-atom
   VARNAME
   STRING
   BOOL
   COLON
   ARTICULATION
   STAFF
   SCORE
   VOICE
   DUR
   OCTAVE
   NUMBER
   scheme-sexp)
   
) 

(defun parse-string (str)
  (let ((*environment* nil)
        (*dur* 1/4))
    (declare (special *environment* *dur*))
    (remove-if (lambda (x) (null (evento-pitch x)))
               (parse-with-lexer (string-lexer str) *expression-parser*))))

(defun file-string (path)
  "Sucks up an entire file from PATH into a freshly-allocated string,
      returning two values: the string and the number of bytes read."
  (with-open-file (s path)
    (let* ((len (file-length s))
           (data (make-string len :initial-element #\Space)))
      (values data (read-sequence data s)))))

(defun parse-file (filename)
  (let ((*filename* filename))
    (declare (special *filename*))
    (parse-string (file-string filename))))

;; (file-string "/home/top/programas/analise-harmonica/exemplos/001.ly")
;;(parse-file "/home/top/programas/analise-harmonica/literatura/bach-corais/002.ly")
;; (parse-file "/home/top/programas/analise-harmonica/literatura/kostka-payne/ex30a.ly")
;;(setf token (string-lexer (file-string "/home/top/programas/analise-harmonica/literatura/kostka-payne/ex30a.ly")))
;; (funcall token)
;; (parse-string "\\header { } { a b c }")