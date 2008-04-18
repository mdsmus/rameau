(in-package #:rameau)
(use-package :yacc)
(defparameter *filename* nil)

(defparameter *anacruz* 0)

;; The refactored parser.

;; This parser's purpose is to preserve all the information in the
;; original file, allowing it to be reconstructed entirely in a
;; round-trip, while also extracting the notes and necessary tonal
;; structure necessary.

;; The textual representation of every atomic node will be stored in
;; it. Every ignored structure will be properly round-tripped, except
;; for spaces.

(lexer:deflexer string-lexer
  ("('|,)+" (return (values 'OCTAVE lexer:%0)))
  ("(V|v)oice" (return (values 'VOICE lexer:%0)))
  ("((P|p)iano)?(S|s)taff" (return (values 'STAFF lexer:%0)))
  ("(S|s)core" (return (values 'SCORE lexer:%0)))
  ("-\\\\tenuto" (return (values 'ignore lexer:%0)))
  ("-\\\\staccato" (return (values 'ignore lexer:%0)))
  ("\\\\staccato" (return (values 'ignore lexer:%0)))
  ("(\\[|\\])" (return (values 'ignore lexer:%0)))
  ("(-|\\\\|\\+)[<>]" (return (values 'ignore lexer:%0)))
  ("(\\\\|-|_|\\^|~|\\?|!)(\\.|\\^|\\+|\\||!|_|\\\\<|\\\\>|-|\"[^\"]*\")?" (return (values 'ignore lexer:%0)))
  ("[:alpha:]+"
   (if (or (note? lexer:%0) (rest? lexer:%0))
       (return (values 'NOTE lexer:%0))
       (return (values 'VARNAME lexer:%0))))
  ("\\\\(T|t)imes" (return (values 'TIMES lexer:%0)))
  ("\\d+/\\d+" (return (values 'NUMBER (read-from-string lexer:%0))))
  ("(128|16|32|64|1|2|4|8)" (return (values 'DUR lexer::%0)))
  ("\\\\breve" (return (values 'DUR "1")))
  ("\\\\longa" (return (values 'DUR "1/2")))
  ("\\d+" (return (values 'NUMBER lexer:%0)))
  ("\\*\\d+/\\d+" (return (values 'MULTIPLICA lexer:%0)))
  ("\\*\\d+" (return (values 'MULTIPLICA lexer:%0)))
  ("([:space:]+)" (return (values 'ignore lexer:%0)))
  ("\\\\\\\\" (return (values 'ignore lexer:%0)))
  ("\\\\(set|override)[^=]*=[:space:]+\"[^\"]*\"" (return (values 'ignore lexer:%0)))
  ("\\\\(set|override)[^=]*=[:space:]+[^:space:]*" (return (values 'ignore lexer:%0)))
  ("\\\\(set|override)[^=]*=[:space:]+#(\\+|-)?\\d" (return (values 'ignore lexer:%0)) )
  ("\\\\(V|v)oice((O|o)ne|(T|t)wo|(T|t)hree|(F|f)our)" (return (values 'ignore lexer:%0)))
  ("\\\\partial" (return (values 'PARTIAL lexer:%0)))
  ("\\\\repeat" (return (values 'REPEAT lexer:%0)))
  ("\\\\markup" (return (values 'MARKUP lexer:%0)))
  ("-+\n" (return (values 'ignore lexer:%0)))
  ("\\|" (return (values 'ignore lexer:%0)))
  ("#(t|f)" (return (values 'BOOL lexer:%0)))
  ("#" (return (values 'HASH lexer:%0)))
  ("\\\\[Vv]ersion[:space:]+\"[^\"]*\"" (return (values 'ignore lexer:%0)))
  ("\\\\clef[:space:]+\"?(treble|violin|G|G2|alto|C|tenor|bass|F|french|soprano|mezzosoprano|baritone|varbaritone|subbass)\"?" (return (values 'ignore lexer:%0)))
  ("\\\\(T|t)ime[:space:]+\\d+/\\d+" (setf *current-sig* (last1 (cl-ppcre:split " " lexer:%0))) )
  ("\\\\(T|t)empo[:space:]+\\d+[:space:]+=[:space:]+\\d+" (return (values 'ignore lexer:%0)))
  ("\\\\(T|t)ime[:space:]+\\d+[:space:]+=[:space:]+\\d+" (return (values 'ignore lexer:%0)))
  ("\\\\(B|b)ar[:space:]+\"[^\"]*\"" (return (values 'ignore lexer:%0)))
  ("\\\\(P|p)artial[:space:]+\\d+" (return (values 'ignore lexer:%0)))
  ("\\\\(L|l)ayout" (return (values 'LAYOUT lexer:%0)))
  ;; FIXME: porque sem o foo nao funciona? (wtf!?) [ver regressao 034]
  ;; acho que \minor está sendo pegado por VARIABLE abaixo (comentar e ver)
  ("\\\\key[:space:]+(a|b|c|d|e|f|g)(is|es)*[:space:]+\\\\(minor|major|dim)"
   (setf *current-key* (let ((l (remove-if (lambda (x) (equal x "")) (cl-ppcre:split " " lexer:%0))))
                         (list (string->symbol (second l)) (string->symbol (subseq (third l) 1))))))
  ("%[^\\n]*" (return (values 'ignore lexer:%0)))
  ("\\\\(S|s)kip" (return (values 'SKIP lexer:%0)))
  ("\\\\(C|c)ontext" (return (values 'CONTEXT lexer:%0)))
  ("\\." (return (values 'PONTO lexer:%0)))
  ("\\\\(H|h)eader" (return (values 'HEADER lexer:%0)))
  ("\"[^\"]*\"" (return (values 'STRING lexer:%0)))
  ("=" (return (values '= '=)))
  ("\\\\include" (return (values 'INCLUDE lexer:%0)))
  ("\\\\new[:space:]+(s|S)taffGroup" (return (values 'NEW-STAFF lexer:%0)))
  ("\\\\new[:space:]+(Piano)?(s|S)taff" (return (values 'NEW-STAFF lexer:%0)))
  ("\\\\new[:space:]+(v|V)oice" (return (values 'NEW-VOICE lexer:%0)))
  ("\\\\new" (return (values 'NEW "foobar")))
  ("\\\\(R|r)elative" (return (values 'RELATIVE lexer:%0)))
  ("\\\\(S|s)core" (return (values 'NEW-SCORE lexer:%0)))
  ("\\\\(S|s)imultaneous" (return (values 'SIMULT lexer:%0)))
  ("<<" (return (values '|<<| lexer::start)))
  (">>" (return (values '|>>| '|>>|)))
  ("<" (return (values '|<| lexer::start)))
  (">" (return (values '|>| lexer::start)))
  ("\\{" (return (values '|{| '|{|)))
  ("\\}" (return (values '|}| lexer::start)))
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

(defclass chord-lily (simultaneous) ())

(defclass no-op-node (ast-node) ())

(defclass staff (no-op-node) ())

(defclass score (no-op-node) ())

(defclass voice (no-op-node) ())

(defun parse-music-block (a block b)
  (declare (ignore a b))
  (make-instance 'music-block :expr block))

(defun ignore-middle (a ignore b)
  (declare (ignore ignore))
  (cons a b))

(defun parse-chord-dur (a ig chord ign b igno dur)
  (declare (ignore a b ig ign igno))
  (when dur
      (dolist (i chord)
        (setf (note-sequence-dur i) dur)
        (dolist (j (note-sequence-notas i))
          (setf (event-dur j) dur))))
  (make-instance 'chord-lily :expr chord))

(defun parse-simultaneous (a simultaneous b)
  (declare (ignore a b))
  (make-instance 'simultaneous :expr simultaneous))

(defun parse-simult (a i b simultaneous c)
  (declare (ignore a i b c))
  (make-instance 'simultaneous :expr simultaneous))

(defun parse-staff-block (a ign block)
  (declare (ignore a ign))
  (make-instance 'staff :expr block))

(defun parse-context-staff (a i b ig c ign d igno block)
  (declare (ignore a b c d i ig ign igno))
  (parse-staff-block nil block))

(defun parse-new-staff (a i b ig c ign block)
  (declare (ignore a b c i ig ign))
  (parse-staff-block nil block))

(defun parse-score-block (a ign block)
  (declare (ignore a ign))
  (make-instance 'score :expr block))

(defun parse-context-score (a i b ig c ign block)
  (declare (ignore a b c i ig ign))
  (parse-score-block nil block))

(defun parse-variable-block (variable)
  (make-instance 'read-variable :varname variable))

(defun parse-times-block (a i number ig expr)
  (declare (ignore a i ig))
  (make-instance 'times :times number :expr expr))

(defun parse-voice-block (a ign block)
  (declare (ignore a ign))
  (make-instance 'voice :expr block))

(defun parse-voice-block-string (a i b ig c ign block)
  (declare (ignore a b c i ig ign))
  (make-instance 'voice :expr block))

(defun parse-repeat-block (a i b ig dur ign block)
  (declare (ignore a dur i ig ign b))
  block)

(defun make-anacruz (ign dur igno)
  (declare (ignore ign igno))
  (setf *anacruz* (- dur (read-from-string *current-sig*)))
  nil)
        

(defun parse-dur (dur)
  (/ 1 (parse-integer dur)))

(defun parse-dur-ponto (dur ponto)
  (declare (ignore ponto))
    (+ dur (/ dur 2)))

(defun parse-dur-multiplica (dur mult)
  (* dur (eval (read-from-string (subseq mult 1)))))

(defun parse-include (a b file)
  (declare (ignore a b))
  (let ((notas (parse-file
                (if *filename*
                    (concat (subseq *filename* 0 (search "/" *filename* :from-end t))
                            "/"
                            (read-from-string file))
                    (read-from-string file)))))
    (make-note-sequence :notas notas
                             :start 0
                             :dur (+ (event-start (last1 notas)) (event-dur (last1 notas))))))


(defun parse-context-voice (a i b ig c ign d igno block)
  (declare (ignore a b c d i ig ign igno))
  (parse-voice-block nil block))

(defun parse-relative-block (a ign relative igno block)
  (declare (ignore a ign igno))
  (make-instance 'relative :expr block :start relative))

(defun parse-lilypond (expression)
  (process-ast (correct-durations (parse-music-block nil expression nil))))

(defun empty-octave ()
  "")

(defun do-nothing (&rest args)
  (declare (ignore args))
  (print 'doing-nothing-to)
  (print args)
  nil)

(defun parse-assignment (variable ign equal igna value)
  (declare (ignore equal ign igna))
  (print 'fiz-assign)
  (print value)
  (make-instance 'set-variable :varname variable :value value))

(defgeneric correct-durations (tree) 
    (:documentation "Acerta as durações das notas em uma música"))

(defmethod correct-durations ((tree ast-node))
  (correct-durations (node-expr tree))
  tree)

(defmethod correct-durations ((tree event))
  (if (event-dur tree)
      (setf *dur* (event-dur tree))
      (setf (event-dur tree) *dur*))
  tree)

(defmethod correct-durations ((tree note-sequence))
  (mapcar #'correct-durations (note-sequence-notas tree))
  (setf (note-sequence-dur tree) (event-dur (car (note-sequence-notas tree))))
  tree)

(defmethod correct-durations ((tree list))
  (mapcar #'correct-durations tree)
  tree)

(defmethod correct-durations ((tree set-variable))
  (correct-durations (node-value tree))
  tree)

(defmethod correct-durations (tree) tree)

(defgeneric correct-times (times tree)
  (:documentation "Multiplica um pedaco de música por um tempo especificado"))

(defmethod correct-times (times (tree ast-node))
  (correct-times times (node-expr tree)))

(defmethod correct-times (times (e event))
  (setf (event-dur e) (* times (event-dur e))))

(defmethod correct-times (times (e note-sequence))
  (mapcar #'correct-times (note-sequence-notas e)))

(defmethod correct-times (times (tree set-variable))
  (correct-times times (node-value tree)))

(defmethod correct-times (times tree))

(defgeneric process-ast (astnode)
  (:documentation "Processa um nó na AST e retorna a parte correspondente"))

(defmethod process-ast ((node no-op-node))
  (process-ast (node-expr node)))

(defun process-trees (trees)
  (remove-if
   #'null
   (mapcar #'process-ast trees)))

(defmethod process-ast ((node music-block))
  (let ((seq (process-trees (node-expr node))))
    (sequence-expressions seq)))

(defmethod process-ast ((node simultaneous))
  (merge-exprs (process-trees (node-expr node))))

(defmethod process-ast ((node times))
  (let ((dur (node-times node))
        (expr (node-expr node)))
    (correct-times dur expr)
    (process-ast expr)))

(defmethod process-ast ((node relative))
  (do-relative (node-start node) (process-ast (node-expr node))))

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
        (*dur* 1/4)
        (*current-key* '(c major))
        (*current-sig* 4/4)
        (*anacruz* 0))
    (declare (special *environment* *dur* *current-key* *current-sig*))
    (move-sequence
     (remove-if (lambda (x) (null (event-pitch x)))
                (aif (yacc:parse-with-lexer (string-lexer str) *expression-parser*)
                     (note-sequence-notas it)
                     it))
     *anacruz*)))


(defun parse-file (filename)
  (when (cl-fad:file-exists-p filename)
    (let ((*filename* filename))
      (declare (special *filename*))
      (parse-string (file-string filename)))))


(defun return-second (a b)
  (declare (ignore a))
  ;(print 'retornando-second)
  b)
(defun return-first (a b)
  (declare (ignore b))
  ;(print 'retornando-first)
  a)

(defun parser-list (a)
  ;(print 'listing)
  (list a))

(defun parser-cons (a b)
 ; (print 'consing)
  (cons a b))

(defun parser-ign (a b)
;  (print 'ignoring)
  nil)
(do-not-test
        parse-music-block
    parse-chord-dur
    parse-simultaneous
    parse-simult
    parse-staff-block
    parse-context-staff
    parse-new-staff
    parse-score-block
    parse-context-score
    parse-variable-block
    parse-times-block
    parse-voice-block
    parse-voice-block-string
    parse-repeat-block
    make-anacruz
    parse-dur
    parse-dur-ponto
    parse-dur-multiplica
    parse-include
    parse-context-voice
    parse-relative-block
    parse-lilypond
    parse-assignment
    process-ast
    process-trees
    process-ast
    process-ast
    process-ast
    process-ast
    process-ast
    process-ast
    process-ast
    parse-file
    return-second
)

