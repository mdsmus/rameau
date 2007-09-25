(in-package #:rameau)

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

;; RAMEAU::%
;; RAMEAU::*DUR*
;; REGEX::*END*
;; RAMEAU::*ENVIRONMENT*
;; RAMEAU::*EXPRESSION-PARSER*
;; RAMEAU::*MAIN-DIR*

(lexer:deflexer string-lexer
  ("('|,)+" (return (values 'OCTAVE lexer:%0)))
  ("(V|v)oice" (return (values 'VOICE lexer:%0)))
  ("(S|s)taff" (return (values 'STAFF lexer:%0)))
  ("(S|s)core" (return (values 'SCORE %)))
  ("-\\\\tenuto")
  ("-\\\\staccato")
  ("(-|_|\\^|~|\\?)(\\.|\\^|\\+|\\||>|_|-|\"[^\"]*\")?")
  ("[:alpha:]+"
   (if (or (note? lexer:%0) (rest? lexer:%0))
       (return (values 'NOTE lexer:%0))
       (return (values 'VARNAME lexer:%0))))
  ("\\\\(T|t)imes" (return (values 'TIMES lexer:%0)))
  ("\\d/\\d" (return (values 'NUMBER (read-from-string lexer:%0))))
  ("(128|16|32|64|1|2|4|8)" (return (values 'DUR lexer:%0)))
  ("\\d+" (return (values 'NUMBER lexer:%0)))
  ("\\*\\d+/\\d+" (return (values 'MULTIPLICA lexer:%0)))
  ("\\*\\d+" (return (values 'MULTIPLICA lexer:%0)))
  ("([:space:]+)")
  ("\\\\\\\\") ; contar isso é uma maravilha. Devem ser oito
  ("\\\\(set|override)[^=]*=[:space:]+[^:space:]*") ; pra ignorar set e override
  ("\\\\(V|v)oice((O|o)ne|(T|t)wo|(T|t)hree|(F|f)our)")
  ("-+\n")
  ("\\|")
  ("#(t|f)" (return (values 'BOOL lexer:%0)))
  ("#" (return (values 'HASH lexer:%0)))
  ("\\\\[Vv]ersion[:space:]+\"[^\"]*\"")
  ("\\\\clef[:space:]+\"?(treble|violin|G|G2|alto|C|tenor|bass|F|french|soprano|mezzosoprano|baritone|varbaritone|subbass)\"?")
  ("\\\\(T|t)ime[:space:]+\\d+/\\d+")
  ("\\\\(T|t)empo[:space:]+\\d+[:space:]+=[:space:]+\\d+")
  ("\\\\(T|t)ime[:space:]+\\d+[:space:]+=[:space:]+\\d+")
  ("\\\\(B|b)ar[:space:]+\"[^\"]*\"")
  ("\\\\(P|p)artial[:space:]+\\d+")
  ("\\\\(L|l)ayout" (return (values 'LAYOUT lexer:%0)))
  ;; FIXME: porque sem o foo nao funciona? (wtf!?) [ver regressao 034]
  ;; acho que \minor está sendo pegado por VARIABLE abaixo (comentar e ver)
  ("\\\\key[:space:]+(a|b|c|d|e|f|g)(is|es)*[:space:]+\\\\(minor|major|dim)")
  ("%[^\\n]*")
  ("\\\\(S|s)kip" (return (values 'SKIP lexer:%0)))
  ("\\\\(C|c)ontext" (return (values 'CONTEXT lexer:%0)))
  ("\\." (return (values 'PONTO lexer:%0)))
  ("\\\\(H|h)eader" (return (values 'HEADER lexer:%0)))
  ("\"[^\"]*\"" (return (values 'STRING lexer:%0)))
  ("=" (return (values '= '=)))
  ("\\\\include" (return (values 'INCLUDE lexer:%0)))
  ("\\\\new[:space:]+(Piano)?(s|S)taff" (return (values 'NEW-STAFF lexer:%0)))
  ("\\\\new[:space:]+(v|V)oice" (return (values 'NEW-VOICE lexer:%0)))
  ("\\\\(R|r)elative" (return (values 'RELATIVE lexer:%0)))
  ("\\\\(S|s)core" (return (values 'NEW-SCORE lexer:%0)))
  ("\\\\(S|s)imultaneous" (return (values 'SIMULT lexer:%0)))
  ("<<" (return (values '|<<| '|<<|)))
  (">>" (return (values '|>>| '|>>|)))
  ("<" (return (values '|<| lexer:%0)))
  (">" (return (values '|>| lexer:%0)))
  ("\\{" (return (values '|{| '|{|)))
  ("\\}" (return (values '|}| '|}|)))
  ("\\\\([:alpha:]+)" (return (values 'VARIABLE lexer:%0)))
  ("\\(" (return (values 'OPEN-PAREN lexer:%0)))
  ("\\)" (return (values 'CLOSE-PAREN lexer:%0)))
  (":" (return (values 'COLON lexer:%0)))
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

(defun do-the-parsing (tree)
  (process-ast (ajusta-duracao tree)))

(defun parse-chord-dur (a chord b dur)
  (declare (ignore a b))
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
  (declare (ignore a))
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

(defun parse-lilypond (lilypond atom)
  (coloca-expressoes-em-sequencia
   (remove-if #'null (list lilypond
                           (rameau:do-the-parsing atom)))))

(defun empty-octave ()
  "")

(defun do-nothing (&rest args)
  (declare (ignore args))
  nil)


(defun parse-assignment (variable equal value)
  (declare (ignore equal))
  (make-instance 'set-variable :varname variable :value value))

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
  (acerta-times times (node-expr tree)))

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
    (process-ast expr)))

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
