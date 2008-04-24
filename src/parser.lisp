(in-package #:rameau)
(use-package :yacc)
(defparameter *filename* nil)
(defparameter *dur* 0)
(defparameter *environment* nil)


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
  ("\\\\(T|t)ime[:space:]+\\d+/\\d+" (setf *current-sig* (last1 (cl-ppcre:split " " lexer:%0))) (return (values 'ignore lexer:%0)))
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
  ("<<" (return (values '|<<| lexer::%0)))
  (">>" (return (values '|>>| '|>>|)))
  ("<" (return (values '|<| lexer::%0)))
  (">" (return (values '|>| lexer::%0)))
  ("\\{" (return (values '|{| '|{|)))
  ("\\}" (return (values '|}| lexer::%0)))
  ("\\\\([:alpha:]+)" (return (values 'VARIABLE lexer:%0)))
  ("\\(" (return (values 'OPEN-PAREN lexer:%0)))
  ("\\)" (return (values 'CLOSE-PAREN lexer:%0)))
  (":" (return (values 'COLON lexer:%0)))
  )


(defclass ast-node ()
  ((expr :accessor node-expr :initarg :expr :initform nil)
   (textual-representation :accessor node-text :initarg :text :initform nil)))

(defclass times (ast-node)
  ((times :accessor node-times :initarg :times)))

(defclass relative (ast-node)
  ((start :accessor node-start :initarg :start)))

(defclass set-variable (ast-node)
  ((varname :accessor node-varname :initarg :varname)
   (value :accessor node-value :initarg :value)))

(defclass read-variable (ast-node)
  ((varname :accessor node-varname :initarg :varname)))

(defclass dur-node (ast-node)
  ((dur :accessor node-dur :initarg :dur)))

(defclass music-block (ast-node) ())

(defclass music-list (ast-node) ())

(defclass simultaneous (ast-node) ())

(defclass chord-lily (simultaneous) ())

(defclass no-op-node (ast-node) ())

(defclass staff (music-block) ())

(defclass score (music-block) ())

(defclass voice (music-block) ())

(defun parse-music-block (a block b)
  (make-instance 'music-block :expr block :text (list a block b)))

(defun parse-chord-dur (a chord b igno dur)
  (when dur
      (dolist (i chord)
        (setf (note-sequence-dur i) (node-dur dur))
        (dolist (j (note-sequence-notas i))
          (setf (event-dur j) (node-dur dur)))))
  (make-instance 'chord-lily :expr chord :text (list a chord b igno dur)))

(defun parse-simultaneous (a simultaneous b)
  (make-instance 'simultaneous :expr simultaneous :text (list a simultaneous b)))

(defun parse-simult (a i b simultaneous  c)
  (make-instance 'simultaneous :expr simultaneous :text (list a i b simultaneous c)))

(defun parse-staff-block (a ign block)
  (make-instance 'staff :expr block :text (list a ign block)))

(defun parse-context-staff (a i b ig c ign d igno block)
  (let ((blck (parse-staff-block a nil block)))
    (setf (node-text blck)
          (list a i b ig c ign d igno block))
    blck))

(defun parse-new-staff (a i b ig c ign block)
  (let ((blck (parse-staff-block a nil block)))
    (setf (node-text blck)
          (list a i b ig c ign block))
    blck))

(defun parse-score-block (a ign block)
  (make-instance 'score :expr block :text (list a ign block)))

(defun parse-context-score (a i b ig c ign block)
  (let ((blck (parse-score-block a nil block)))
    (setf (node-text blck)
          (list a i b ig c ign block))
    blck))

(defun parse-variable-block (variable)
  (make-instance 'read-variable :varname variable :text variable))

(defun parse-times-block (a i number ig expr)
  (make-instance 'times :times number :expr expr :text (list a i number ig expr)))

(defun parse-voice-block (a ign block)
  (make-instance 'voice :expr block :text (list a ign block)))

(defun parse-voice-block-string (a i b ig c ign block)
  (make-instance 'voice :expr block :text (list a i b ig c ign block)))

(defun parse-repeat-block (a i b ig dur ign block)
  (make-instance 'music-block :expr block :text (list a i b ig dur ign block)))

(defun parse-context-voice (a i b ig c ign d igno block)
  (let ((blck (parse-voice-block a nil block)))
    (setf (node-text blck)
          (list a i b ig c ign d igno block))
    blck))

(defun parse-relative-block (a ign relative igno block)
  (make-instance 'relative :expr block :start relative :text (list a ign relative igno block)))

(defun parse-assignment (variable ign equal igna value)
  (make-instance 'set-variable :varname variable :value value :text (list variable ign equal igna value)))

(defun parse-dur (dur)
  (make-instance 'dur-node :dur (/ 1 (parse-integer dur)) :text (list dur)))

(defun parse-dur-ponto (dur ponto)
  (make-instance 'dur-node :dur (+ (node-dur dur) (/ (node-dur dur) 2)) :text (list dur ponto)))

(defun parse-dur-multiplica (dur mult)
  (make-instance 'dur-node
                 :dur (* (node-dur dur) (eval (read-from-string (subseq mult 1))))
                 :text (list dur mult)))

(defun empty-dur ()
  (make-instance 'dur-node
                 :dur nil
                 :text nil))

(defun make-anacruz (ign igno dur)
  (setf *anacruz* (- (node-dur dur) (read-from-string *current-sig*)))
  (make-instance 'no-op-node :text (list ign igno dur)))

(defun parse-include (a b file)
  (let ((notas (parse-file
                (if *filename*
                    (concat (subseq *filename* 0 (search "/" *filename* :from-end t))
                            "/"
                            (read-from-string file))
                    (read-from-string file)))))
    (make-note-sequence :notas notas
                             :start 0
                             :text-repr (list a b file)
                             :dur (+ (event-start (last1 notas)) (event-dur (last1 notas))))))

(defun empty-octave ()
  "")


;; Funçoes problematicas:

(defun parse-lilypond (expression)
  (let ((musica (parse-music-block nil expression nil)))
    (correct-durations musica)))

(defun do-nothing (&rest args)
  (make-instance 'no-op-node :text args))

(defun return-second (a b &rest rest)
  (make-instance 'music-list :expr (cons b (make-instance 'no-op-node)) :text (append (list a b) rest)))

(defun return-first (a b)
  (make-instance 'music-block :expr (cons a (make-instance 'no-op-node)) :text (list a b)))

(defun parser-list (b)
  (make-instance 'music-list :expr (cons b (make-instance 'no-op-node)) :text (list b)))

(defun parser-cons (a i b)
  (make-instance 'music-list :expr (cons a b) :text (list a i b)))

(defun ignore-middle (a ignore b)
  (make-instance 'music-list :expr (cons a b) :text (list a ignore b)))

(defun parser-ign (a b)
  (make-instance 'no-op-node :text (list a b)))


;; Metodos para processar a ast

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
  (when tree
    (correct-durations (car tree))
    (correct-durations (cdr tree)))
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
  (mapcar (lambda (x) (correct-times times x)) (note-sequence-notas e)))

(defmethod correct-times (times (tree set-variable))
  (correct-times times (node-value tree)))

(defmethod correct-times (times tree))

(defgeneric print-ast (astnode)
  (:documentation "Print the file represented by the ast note \\texttt{astnode}."))

(defmethod print-ast ((node string))
  node)

(defmethod print-ast ((node list))
  (reduce #'concat node :key #'print-ast :from-end t))

(defmethod print-ast ((node ast-node))
  (print-ast (node-text node)))

(defmethod print-ast ((node note-sequence))
  (print-ast (note-sequence-text-repr node)))

(defmethod print-ast (node)
  (format nil "~a" (or node "")))


(defgeneric process-ast (astnode)
  (:documentation "Process an AST node and extract the notes."))

(defmethod process-ast ((node no-op-node))
  (process-ast (node-expr node)))

(defun process-trees (trees)
  (if (listp trees)
      (remove-if
       #'null
       (mapcar #'process-ast trees))
      (list (process-ast trees))))

(defmethod remove-music-list ((node music-list))
  (cons (first (node-expr node))
        (remove-music-list (rest (node-expr node)))))

(defmethod remove-music-list (node)
  node)

(defmethod process-ast ((node music-list))
  (process-ast (remove-music-list node)))

(defmethod process-ast ((node list))
  (when node
    (cons (process-ast (first node))
          (process-ast (rest node)))))

(defmethod process-ast ((node music-block))
  (let ((seq (process-ast (node-expr node))))
    (sequence-expressions
     (if (listp seq)
         (remove-if #'null seq)
         seq))))
    
(defmethod process-ast ((node simultaneous))
  (merge-exprs (remove-if #'null (flatten (process-trees (node-expr node))))))

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

(defun get-ast-string (str)
  (let ((*environment* nil)
        (*dur* 1/4)
        (*current-key* '(c major))
        (*current-sig* 4/4)
        (*anacruz* 0))
    (cons *anacruz* (yacc:parse-with-lexer (string-lexer str) *expression-parser*))))

(defun get-parsed-notes (ast)
  (let ((anacruz (first ast))
         (ast (rest ast)))
    (move-sequence (remove-if (lambda (x) (null (event-pitch x)))
                              (aif (sequence-expressions (remove-if #'null (flatten (process-ast ast))))
                                   (note-sequence-notas it)
                                   it))
                   anacruz)))

(defun get-parsed-notes-string (str)
  (get-parsed-notes (get-ast-string str)))

(defun parse-file (filename)
  (when (cl-fad:file-exists-p filename)
    (let ((*filename* filename))
      (declare (special *filename*))
      (get-parsed-notes-string (file-string filename)))))

(defun file-ast (filename)
  (when (cl-fad:file-exists-p filename)
    (let ((*filename* filename))
      (declare (special *filename*))
      (get-ast-string (file-string filename)))))


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

