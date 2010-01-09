(in-package #:cl-lily)
(use-package :yacc)

(yacc:define-parser *expression-parser*
  (:start-symbol start)
  (:precedence ((:left note-expr notes-list notes expression-atom expression-list expression ignorable)))
  (:muffle-conflicts t)
  (:terminals (NEW-STAFF
               NEW-SCORE
               NEW-VOICE
               NEW-PAPER
               NEW
               DUR
               NOTE
               OCTAVE
               IGNORE
               RELATIVE
               TRANSPOSE
               STRING
               PARTIAL
               REPEAT
               HEADER
               VARNAME
               VARIABLE
               SIMULT
               PONTO
               MARKUP
               OVERRIDE
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
               LYRICMODE
               NEW-WITH
               INCLUDE
               = |{| |}| |<<| |>>| |<| |>|))

  (start
   (lilypond #'identity))

  (lilypond
   (expression #'parse-lilypond))

  (ignorable
   ()
   (ignorable-list))

  (ignorable-list
   (IGNORE #'do-nothing)
   (paper #'do-nothing)
   (with #'do-nothing)
   (ignorable-list IGNORE #'parser-ign))

  (lilypond-header
   (HEADER ignorable |{| expression |}|))

  (paper
   (NEW-PAPER ignorable |{| scheme-list |}|))

  (with
   (NEW-WITH ignorable |{| scheme-list |}|)
   (NEW-WITH ignorable varname ignorable |{| scheme-list |}| )
   (NEW-WITH ignorable varname ignorable scheme-quoted ))

  (expression
   (ignorable expression-list ignorable #'return-second))

  (expression-list
   ()
   (expression-atom ignorable expression-list #'parser-cons))

  (expression-atom
   (lilypond-header #'do-nothing)
   (markup-expr #'do-nothing)
   (OPEN-PAREN #'do-nothing)
   (CLOSE-PAREN #'do-nothing)
   (layout-block #'do-nothing)
   (lyric-block #'do-nothing)
   (override-expr #'do-nothing)
   (music-block #'identity)
   (staff-block #'identity)
   (score-block #'identity)
   (voice-block #'identity)
   (scheme-quoted #'do-nothing)
   (times-block #'identity)
   (assignment #'identity)
   (repeat-block #'identity)
   (variable-block #'identity)
   (relative-block #'identity)
   (transpose-block #'identity)
   (chord-block #'identity)
   (scheme-code #'do-nothing)
   (include ignorable STRING #'parse-include)
   (|<<| expression |>>| #'parse-simultaneous)
   (SIMULT ignorable |{| expression |}| #'parse-simult)
   (note-expr #'identity))

  (assignment
   (VARNAME ignorable = ignorable value #'parse-assignment))

  (value
   (STRING #'identity)
   (scheme-code #'identity)
   (expression-atom #'identity))

  (repeat-block
   (REPEAT ignorable varname ignorable dur-expr ignorable expression-atom #'parse-repeat-block)
   (REPEAT ignorable STRING ignorable dur-expr ignorable expression-atom #'parse-repeat-block)
   (REPEAT ignorable varname ignorable NUMBER ignorable expression-atom #'parse-repeat-block)
   (REPEAT ignorable STRING ignorable NUMBER ignorable expression-atom #'parse-repeat-block))

  (variable-block
   (VARIABLE #'parse-variable-block))

  (music-block
   (|{| ignorable |}| #'do-nothing)
   (|{| expression |}| #'parse-music-block))

  (layout-block
   (LAYOUT ignorable |{| expression |}|))

  (lyric-block
   (LYRICMODE ignorable |{| scheme-list |}|))
  
  (staff-block
   (NEW-STAFF ignorable expression-atom #'parse-staff-block)
   (CONTEXT ignorable STAFF ignorable expression-atom #'parse-context-staff-no-var)
   (CONTEXT ignorable STAFF ignorable = ignorable VARNAME ignorable expression-atom #'parse-context-staff)
   (CONTEXT ignorable STAFF ignorable = ignorable STRING ignorable expression-atom #'parse-context-staff)
   (CONTEXT ignorable |{| ignorable NEW-STAFF ignorable scheme-list |}| #'parse-context-score2)
   (NEW-STAFF ignorable = ignorable VARNAME ignorable expression-atom #'parse-new-staff)
   (NEW-STAFF ignorable = ignorable STRING ignorable expression-atom #'parse-new-staff))

  (score-block
   (NEW-SCORE ignorable expression-atom #'parse-score-block)
   (CONTEXT ignorable |{| ignorable NEW-SCORE ignorable expression |}| #'parse-context-score2)
   (CONTEXT ignorable SCORE ignorable = ignorable VARNAME ignorable expression-atom #'parse-context-score)
   (CONTEXT ignorable SCORE ignorable = ignorable STRING ignorable expression-atom #'parse-context-score))

  (voice-block
   (NEW-VOICE ignorable expression-atom #'parse-voice-block)
   (NEW-VOICE ignorable = ignorable STRING ignorable expression-atom #'parse-voice-block-string)
   (CONTEXT ignorable VOICE ignorable = ignorable VARNAME ignorable expression-atom #'parse-context-voice)
   (CONTEXT ignorable VOICE ignorable = ignorable STRING ignorable expression-atom #'parse-context-voice))

  (relative-block
   (RELATIVE ignorable note-expr ignorable expression-atom #'parse-relative-block))

  (transpose-block
   (TRANSPOSE ignorable note-expr ignorable note-expr ignorable expression-atom #'parse-transpose-block))

  (times-block
   (TIMES ignorable NUMBER ignorable expression-atom #'parse-times-block))

  (chord-block
   (|<| notes |>| ignorable dur-expr  #'parse-chord-dur))

  (notes
   (ignorable notes-list ignorable #'return-second))

  (notes-list
   ()
   (note-expr ignorable notes-list #'parser-cons))

  (note-expr
   (NOTE octave-expr ignorable dur-expr  #'make-note)
   (SKIP ignorable dur-expr #'make-skip)
   (PARTIAL ignorable dur-expr #'make-anacruz))

  (octave-expr
   (#'empty-octave)
   (OCTAVE #'identity))

  (dur-expr
   (#'empty-dur)
   (DUR #'parse-dur)
   (dur-expr PONTO #'parse-dur-ponto)
   (dur-expr MULTIPLICA #'parse-dur-multiplica))

  (scheme-code
   (HASH ignorable scheme-sexp)
   (HASH ignorable scheme-atom)
   scheme-quoted)

  (markup-expr
   (MARKUP ignorable |{| scheme-list |}|))

  (scheme-quoted
   (HASH OCTAVE STRING)
   (HASH OCTAVE VARNAME)
   (HASH OCTAVE scheme-sexp)
   (HASH OCTAVE VARNAME)
   (HASH STRING))

  (override-expr
   (OVERRIDE ignorable scheme-code)
   (OVERRIDE ignorable scheme-quoted)
   (OVERRIDE ignorable = ignorable VARNAME)
   (OVERRIDE ignorable VARNAME ignorable scheme-quoted ignorable = ignorable scheme-quoted)
   (OVERRIDE ignorable VARNAME PONTO VARNAME ignorable scheme-quoted ignorable = ignorable scheme-quoted)
   (OVERRIDE ignorable VARNAME ignorable scheme-quoted ignorable VARNAME ignorable = ignorable scheme-quoted)
   (OVERRIDE ignorable = ignorable string))
   
  
  (scheme-sexp
   (OPEN-PAREN scheme-list CLOSE-PAREN))

  (scheme-list
   ()
   (scheme-list scheme-atom))

  (scheme-atom
   VARNAME
   VARIABLE
   note-expr
   ignorable
   STRING
   (|{| scheme-list |}|)
   BOOL
   COLON
   STAFF
   NEW-WITH
   SCORE
   VOICE
   DUR
   OCTAVE
   override-expr
   markup-expr
   NUMBER
   PONTO
   HASH
   MULTIPLICA
   =
   scheme-sexp)
  
  )