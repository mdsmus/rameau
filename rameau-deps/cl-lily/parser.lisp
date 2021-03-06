(in-package #:cl-lily)

(defparameter *filename* nil)
(defparameter *dur* 0)
(defparameter *environment* nil)
(defparameter *expression-parser* nil)

(defparameter *anacruz* 0)

(enable-sharp-l-syntax)

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
  ("-[123456789]" (return (values 'ignore lexer:%0)))
  ("_[123456789]" (return (values 'ignore lexer:%0)))
  ("(V|v)oice" (return (values 'VOICE lexer:%0)))
  ("(((P|p)iano)|((C|c)hoir))?(S|s)taff" (return (values 'STAFF lexer:%0)))
  ("(S|s)core" (return (values 'SCORE lexer:%0)))
  ("-\\\\tenuto" (return (values 'ignore lexer:%0)))
  ("-\\\\staccato" (return (values 'ignore lexer:%0)))
  ("\\\\staccato" (return (values 'ignore lexer:%0)))
  ("(\\[|\\])" (return (values 'ignore lexer:%0)))
  ("(-|\\\\|\\+)[<>]" (return (values 'ignore lexer:%0)))
  ("_>" (return (values 'ignore lexer:%0)))
  ("(\\\\|-|_|\\^|~|\\?|!)(\\.|\\^|\\+|\\||!|_|\\\\<|\\\\>|-|\"[^\"]*\")?"
   (return (values 'ignore lexer:%0)))
  ("[:alpha:]+((-|_)[:alpha:]+)*"
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
  ("/" (return (values 'ignore lexer:%0)))
  ("•" (return (values 'ignore lexer:%0)))
  ("©" (return (values 'ignore lexer:%0)))
  ("\\\\(set|override)[^=]*=[:space:]+\"[^\"]*\"" (return (values 'ignore lexer:%0)))
  ("\\\\(set|override)[^=]*=[:space:]+#\\([^\\)]*\\)" (return (values 'ignore lexer:%0)))
  ("\\\\(set|override)[^=]*=[:space:]+[^:space:]*" (return (values 'ignore lexer:%0)))
  ("\\\\(set|override)[^=]*=[:space:]+#(\\+|-)?\\d" (return (values 'ignore lexer:%0)))
  ("\\\\override" (return (values 'OVERRIDE lexer:%0)))
  ("\\\\(V|v)oice((O|o)ne|(T|t)wo|(T|t)hree|(F|f)our)" (return (values 'ignore lexer:%0)))
  ("\\\\partial" (return (values 'PARTIAL lexer:%0)))
  ("\\\\repeat" (return (values 'REPEAT lexer:%0)))
  ("\\\\markup" (return (values 'MARKUP lexer:%0)))
  ("-+\n" (return (values 'ignore lexer:%0)))
  ("\\|" (return (values 'ignore lexer:%0)))
  ("#(t|f)" (return (values 'BOOL lexer:%0)))
  ("#" (return (values 'HASH lexer:%0)))
  ("\\\\[Vv]ersion[:space:]+\"[^\"]*\"" (return (values 'ignore lexer:%0)))
  ("\\\\clef[:space:]+\"?(treble|violin|G|G2|alto|C|tenor|bass|F|french|soprano|mezzosoprano|baritone|varbaritone|subbass)(_8)?\"?" (return (values 'ignore lexer:%0)))
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
                         (list (make-keyword (second l)) (make-keyword (subseq (third l) 1)))))
   (return (values 'ignore lexer:%0)))
  ("%\\{[^%]*%\\}" (return (values 'ignore lexer:%0)))
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
  ("\\\\new[:space:]+(Choir)?(s|S)taff" (return (values 'NEW-STAFF lexer:%0)))
  ("\\\\new[:space:]+(v|V)oice" (return (values 'NEW-VOICE lexer:%0)))
  ("\\\\new" (return (values 'NEW "foobar")))
  ("\\\\(R|r)elative" (return (values 'RELATIVE lexer:%0)))
  ("\\\\(T|t)ranspose" (return (values 'TRANSPOSE lexer:%0)))
  ("\\\\(S|s)core" (return (values 'NEW-SCORE lexer:%0)))
  ("\\\\(S|s)taff" (return (values 'NEW-STAFF lexer:%0)))
  ("\\\\(P|p)paper" (return (values 'NEW-PAPER lexer:%0)))
  ("\\\\(W|w)ith" (return (values 'NEW-WITH lexer:%0)))
  ("\\\\(S|s)imultaneous" (return (values 'SIMULT lexer:%0)))
  ("\\\\(L|l)yricmode" (return (values 'LYRICMODE lexer:%0)))
  ("\\\\add(L|l)yrics" (return (values 'LYRICMODE lexer:%0)))
  ("<<" (return (values '|<<| '|<<|)))
  (">>" (return (values '|>>| '|>>|)))
  ("<" (return (values '|<| '|<|)))
  (">" (return (values '|>| '|>|)))
  ("\\{" (return (values '|{| '|{|)))
  ("\\}" (return (values '|}| '|}|)))
  ("\\\\(([:alpha:]|_)+)" (return (values 'VARIABLE lexer:%0)))
  ("\\(" (return (values 'OPEN-PAREN lexer:%0)))
  ("\\)" (return (values 'CLOSE-PAREN lexer:%0)))
  (":" (return (values 'COLON lexer:%0)))
  (";" (return (values 'ignore lexer:%0)))
  )

(defclass ast-node ()
  ((expr :accessor node-expr :initarg :expr :initform nil)
   (textual-representation :accessor node-text :initarg :text :initform nil)))

(defclass times (ast-node)
  ((times :accessor node-times :initarg :times)))

(defclass relative (ast-node)
  ((start :accessor node-start :initarg :start)))

(defclass transpose (ast-node)
  ((from :accessor node-from :initarg :from)
   (to :accessor node-to :initarg :to)))

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

(defclass voice (music-block)
  ((name :accessor voice-name :initarg :name)))

(defgeneric ast-repr (ast-list)
  (:documentation "Prints the ast in @var{ast-list} in a lisp-friendly way."))

(defmethod ast-repr ((ast-list list))
  (remove-if #'null (mapcar #'ast-repr ast-list)))

(defmethod ast-repr ((ast-list string))
  ast-list)

(defmethod ast-repr ((ast-list ast-node))
  (cons (make-keyword (type-of ast-list)) (ast-repr (node-text ast-list))))

(defmethod ast-repr ((ast-list transpose))
  (append (list :transpose
                :from (print-pitch (first-pitch (node-from ast-list)))
                :to (print-pitch (first-pitch (node-to ast-list))))
          (ast-repr (node-expr ast-list))))

(defmethod ast-repr ((ast-list note-sequence))
  (remove-if #'null
             (mapcar #'ast-repr (note-sequence-notas ast-list))))

(defmethod ast-repr ((ast-list event))
  (if (event-pitch ast-list)
      (format nil "~a~a~a"
              (print-event-note ast-list)
              (repeat-string (abs (event-octave ast-list))
                             (if (< 0 (event-octave ast-list))
                                 "'"
                                 ","))
              (if (= 0 (event-dur ast-list))
                  ""
                  (/ 1 (event-dur ast-list)))))
  (format nil "r~a"
          (if (= 0 (event-dur ast-list))
              ""
              (/ 1 (event-dur ast-list)))))

(defmethod ast-repr ((ast-list symbol))
  (unless (or (eql ast-list '|{|)
              (eql ast-list '|}|))
    ast-list))

(defmethod ast-repr (ast-list)
  (format t "Tipo estranho ~a~%" (type-of ast-list))
  (error ""))

(defun parse-music-block :private (a block b)
  "[NOTEST]"
  (make-instance 'music-block :expr block :text (list a block b)))

(defun parse-chord-dur :private (a chord b igno dur)
  "[NOTEST]"
  (when dur
    (dolist (i (butlast (remove-if #'null (expand-if-list chord))))
      (setf (note-sequence-dur i) (node-dur dur))
      (dolist (j (note-sequence-notas i))
        (setf (event-dur j) (node-dur dur)))))
  (make-instance 'chord-lily :expr chord :text (list a chord b igno dur)))

(defun parse-simultaneous :private (a simultaneous b)
  "[NOTEST]"
  (make-instance 'simultaneous :expr simultaneous :text (list a simultaneous b)))

(defun parse-simult :private (a i b simultaneous  c)
  "[NOTEST]"
  (make-instance 'simultaneous :expr simultaneous :text (list a i b simultaneous c)))

(defun parse-staff-block :private (a ign block)
  "[NOTEST]"
  (make-instance 'staff :expr block :text (list a ign block)))

(defun parse-context-staff :private (a i b ig c ign d igno block)
  "[NOTEST]"
  (let ((blck (parse-staff-block a nil block)))
    (setf (node-text blck)
          (list a i b ig c ign d igno block))
    blck))

(defun parse-context-staff-no-var :private (a i b igno block)
  "[NOTEST]"
  (let ((blck (parse-staff-block a nil block)))
    (setf (node-text blck)
          (list a i b igno block))
    blck))

(defun parse-new-staff :private (a i b ig c ign block)
  "[NOTEST]"
  (let ((blck (parse-staff-block a nil block)))
    (setf (node-text blck)
          (list a i b ig c ign block))
    blck))

(defun parse-score-block :private (a ign block)
  "[NOTEST]"
  (make-instance 'score :expr block :text (list a ign block)))

(defun parse-context-score :private (a i b ig c ign block)
  "[NOTEST]"
  (let ((blck (parse-score-block a nil block)))
    (setf (node-text blck)
          (list a i b ig c ign block))
    blck))

(defun parse-context-score2 :private (a i ob ig c ign block cb)
  "[NOTEST]"
  (let ((blck (parse-score-block a nil block)))
    (setf (node-text blck)
          (list a i ob ig c ign block cb))
    blck))


(defun parse-variable-block :private (variable)
  "[NOTEST]"
  (make-instance 'read-variable :varname variable :text variable))

(defun parse-times-block :private (a i number ig expr)
  "[NOTEST]"
  (make-instance 'times :times number :expr expr :text (list a i number ig expr)))

(defun parse-voice-block :private (a ign block)
  "[NOTEST]"
  (make-instance 'voice :name "" :expr block :text (list a ign block)))

(defun parse-voice-block-string :private (a i b ig c ign block)
  "[NOTEST]"
  (make-instance 'voice :name (read-from-string c) :expr block :text (list a i b ig c ign block)))

(defun parse-repeat-block :private (a i b ig dur ign block)
  "[NOTEST]

Parse a @var{repeat} block using lilypond syntax.
"
  (make-instance 'music-block :expr block :text (list a i b ig dur ign block)))

(defun parse-context-voice :private (a i b ig c ign d igno block)
  "[NOTEST]"
  (let ((blck (parse-voice-block-string a nil b nil d nil block)))
    (setf (node-text blck)
          (list a i b ig c ign d igno block))
    blck))

(defun parse-relative-block :private (a ign relative igno block)
  "[NOTEST]

Parse a lilypond relative block.
"
  (make-instance 'relative :expr block :start relative :text (list a ign relative igno block)))

(defun parse-transpose-block :private (a ig from ign to igno block)
  "[NOTEST]

Parse a lilypond relative block.
"
  (make-instance 'transpose :expr block :from from :to to :text (list a ig from ign to igno block)))

(defgeneric copy-things (foo))

(defmethod copy-things ((ns note-sequence))
  (make-note-sequence :notas (copy-things (note-sequence-notas ns))
                      :start (note-sequence-start ns)
                      :text-repr (note-sequence-text-repr ns)
                      :dur (note-sequence-dur ns)))

(defmethod copy-things ((ls list))
  (mapcar #'copy-things ls))

(defmethod copy-things ((ev event))
  (make-event :pitch (event-pitch ev)
              :voice-name (event-voice-name ev)
              :text-repr (event-text-repr ev)
              :dur (event-dur ev)
              :octave (event-octave ev)
              :start (event-start ev)
              :key (event-key ev)
              :original-event  (event-original-event ev)
              :time-sig (event-time-sig ev)))

(defmethod copy-things (n) n)

(defun parse-assignment :private  (variable ign equal igna value)
  "[NOTEST]"
  (make-instance 'set-variable
                 :varname variable
                 :value value
                 :text (list variable ign equal igna value)))

(defun parse-dur :private (dur)
  "[NOTEST]"
  (make-instance 'dur-node
                 :dur (/ 1 (parse-integer dur))
                 :text (list dur)))

(defun parse-dur-ponto :private (dur ponto)
  "[NOTEST]

Parse the length of a dotted note."
  (make-instance 'dur-node
                 :dur (+ (node-dur dur) (/ (node-dur dur) 2))
                 :text (list dur ponto)))

(defun parse-dur-multiplica :private (dur mult)
  "[NOTEST]"
  (make-instance 'dur-node
                 :dur (* (node-dur dur) (eval (read-from-string (subseq mult 1))))
                 :text (list dur mult)))

(defun empty-dur :private ()
  "[NOTEST]

Parse an empty duration.
"
  (make-instance 'dur-node
                 :dur 0
                 :text nil))

(defun make-anacruz :private (ign igno dur)
  "[NOTEST]"
  (setf *anacruz* (- (node-dur dur) (read-from-string *current-sig*)))
  (make-instance 'no-op-node :text (list ign igno dur)))

(defun parse-include :private (a b file)
  "[NOTEST]"
  (let ((notas (parse-file
                (if *filename*
                    (concat (subseq *filename* 0 (search "/" *filename* :from-end t))
                            "/"
                            (read-from-string file))
                    (read-from-string file)))))
    (when notas
      (make-note-sequence :notas notas
                          :start 0
                          :text-repr (list a b file)
                          :dur (+ (event-start (last1 notas)) (event-dur (last1 notas)))))))

(defun empty-octave :private ()
  "[NOTEST]"
  "")

;; Funçoes problematicas:

(defun parse-lilypond :private (expression)
  "[NOTEST]

Parse an entire lilypond file.
"
  (let ((musica (parse-music-block nil expression nil)))
    (correct-durations musica)))

(defun do-nothing :private (&rest args)
  "[NOTEST]"
  (make-instance 'no-op-node :text args))

(defun return-second :private (a b &rest rest)
  "[NOTEST]"
  (make-instance 'music-list :expr (cons b (make-instance 'no-op-node)) :text (append (list a b) rest)))

(defun return-first :private (a b)
  "[NOTEST]"
  (make-instance 'music-block :expr (cons a (make-instance 'no-op-node)) :text (list a b)))

(defun parser-list :private (b)
  "[NOTEST]"
  (make-instance 'music-list :expr (cons b (make-instance 'no-op-node)) :text (list b)))

(defun parser-cons :private (a i b)
  "[NOTEST]"
  (make-instance 'music-list :expr (cons a b) :text (list a i b)))

(defun ignore-middle :private (a ignore b)
  "[NOTEST]

Ignore the middle argument, @var{ignore}, and make a music-list
with the other ones.
"
  (make-instance 'music-list :expr (cons a b) :text (list a ignore b)))

(defun parser-ign :private (a b)
  "[NOTEST]"
  (make-instance 'no-op-node :text (list a b)))

;; Metodos para processar a ast

(defgeneric correct-durations (tree) 
  (:documentation "Acerta as durações das notas em uma música"))

(defmethod correct-durations ((tree ast-node))
  (correct-durations (node-expr tree))
  tree)

(defmethod correct-durations ((tree event))
  (if (/= 0 (event-dur tree))
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
  (:documentation "Print the file represented by the ast note @var{astnode}."))

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

(defgeneric first-child (node)
  (:documentation "The first child of an AST node"))

(defmethod first-child ((node ast-node))
  (first-child (node-expr node)))

(defmethod first-child ((node music-list))
  (car (node-expr node)))

(defmethod first-child ((node list))
  (when node
    (first node)))

(defmethod first-child (node)
  node)

(defgeneric children (node)
  (:documentation "List the immediate childs of @var{node}"))

(defmethod children ((node ast-node))
  (expand-if-list (node-expr node)))

(defmethod children ((node music-list))
  (cons (car (node-expr node)) (children (cdr (node-expr node)))))

(defmethod children ((node list))
  (when node
    (cons (car node) (children (cdr node)))))

(defmethod children (node)
  node)

(defgeneric expand-if-list (node)
  (:documentation "Expand a music list if and only if it is a music list"))

(defmethod expand-if-list (node) (list node))
(defmethod expand-if-list ((node music-list))
  (nconc (expand-if-list (car (node-expr node))) (expand-if-list (cdr (node-expr node)))))

(defgeneric %get-children-by-type (node type)
  (:documentation "List the childs of \\textt{node} that are of type @var{type}"))

(defmethod %get-children-by-type ((node ast-node) type)
  (if (typep node type)
      (list node)
      (%get-children-by-type (node-expr node) type)))

(defmethod %get-children-by-type ((node list) type)
  (when node
    (mapcan (lambda (x) (get-children-by-type x type)) node)))

(defmethod %get-children-by-type ((node music-list) type)
  (cons (%get-children-by-type (first (node-expr node)) type)
        (%get-children-by-type (rest (node-expr node)) type)))

(defmethod %get-children-by-type (node type))

(defun get-children-by-type (ast type)
  "The child nodes of @var{ast} having type @var{type}."
  (if (and (listp ast) (numberp (car ast)))
      (remove-if #'null (flatten (%get-children-by-type (cdr ast) type)))
      (remove-if #'null (flatten (%get-children-by-type ast type)))))

(defgeneric process-ast (astnode)
  (:documentation "Process an AST node and extract the notes. [NOTEST]"))

(defmethod process-ast ((node no-op-node))
  (process-ast (node-expr node)))

(defun process-trees :private (trees)
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

(defmethod process-ast :around ((node voice))
  (let ((notes (sequence-expressions (call-next-method))))
    (loop for n in (note-sequence-notas notes)
          do (setf (event-voice-name n) (voice-name node)))
    notes))

(defmethod process-ast ((node simultaneous))
  (merge-exprs (alexandria:flatten (process-trees (node-expr node)))))

(defmethod process-ast ((node times))
  (let ((dur (node-times node))
        (expr (node-expr node)))
    (correct-times dur expr)
    (process-ast expr)))

(defmethod process-ast ((node relative))
  (do-relative (node-start node) (process-ast (node-expr node))))

(defmethod process-ast ((node transpose))
  ;(format t "Text: ~s~%" (ast-repr node))
  ;(format t "E: ~a~%" (print-ast (list 0 node)))
  ;(format t "Env: ~a~%" *environment*)
  (let* ((seq (sequence-expressions (process-ast (node-expr node))))
         (notes (note-sequence-notas seq)))
    (setf (note-sequence-notas seq)
          (first (transpose-segmentos
                  (list (remove-if #L(null (event-pitch !1)) notes))
                  (interval (first-pitch (node-to node))
                            (first-pitch (node-from node))))))
    seq))

(defmethod process-ast ((node set-variable))
  (let ((end (process-ast (node-value node))))
    (push (cons (node-varname node) end)
          *environment*))
  nil)

(defmethod process-ast ((node read-variable))
  ;(format t "Reading ~a~%" (node-varname node))
  (process-ast (copy-things (rest (assoc (subseq (node-varname node) 1)
                                         *environment*
                                         :test #'equalp)))))

(defmethod process-ast (node)
  (if (listp node)
      (remove-if #'null node)
      node))

(defun get-ast-string (str)
  "Get the ast from string @var{str}."
  (let ((*environment* nil)
        (*dur* 1/4)
        (*current-key* '(c major))
        (*current-sig* "4/4")
        (*anacruz* 0))
    (cons *anacruz* (yacc:parse-with-lexer (string-lexer str) *expression-parser*))))

(defun get-parsed-notes (ast)
  "Get the notes in the ast @var{ast}."
  (let ((anacruz (first ast))
        (ast (rest ast)))
    (move-sequence
     (remove-if (lambda (x) (null (event-pitch x)))
                (aif (sequence-expressions (alexandria:flatten (process-ast ast)))
                     (note-sequence-notas it)
                     it))
     anacruz)))

(defun get-parsed-notes-string (str)
  "Get the notes from the music in @var{str}."
  (get-parsed-notes (get-ast-string str)))

(defun parse-file (filename)
  "[NOTEST]

Parse lilypond file @var{filename} as a sequence of notes.
"
  (when (cl-fad:file-exists-p filename)
    (let ((*filename* filename))
      (declare (special *filename*))
      (get-parsed-notes-string (file-string filename)))))

(defun file-ast (filename)
  "[NOTEST]

Parse lilypond file @var{filename} as an ast.
"
  (when (cl-fad:file-exists-p filename)
    (let ((*filename* filename))
      (declare (special *filename*))
      (get-ast-string (file-string filename)))))
