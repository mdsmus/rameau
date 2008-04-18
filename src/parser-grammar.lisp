(in-package #:rameau)
(use-package :yacc)

(yacc:define-parser *expression-parser*
  (:start-symbol start)
  (:terminals (WHITESPACE
               NEW-STAFF
               NEW-SCORE
               NEW-VOICE
               NEW
               DUR
               NOTE
               OCTAVE
               IGNORE
               RELATIVE
               STRING
               PARTIAL
               REPEAT
               HEADER
               VARNAME
               VARIABLE
               SIMULT
               PONTO
               MARKUP
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
   (ignorable start #'return-second)
   (lilypond #'identity))
  
  (lilypond
   (expression #'parse-lilypond))

  (ignorable
   ()
   (IGNORE ignorable #'parser-ign))
  
  (lilypond-header
   (HEADER ignorable |{| expression |}|)
   (HEADER ignorable |{| |}|))

  (expression
   (expression-atom #'parser-list)
   (expression-atom expression #'parser-cons)
   (expression ignorable #'return-first)
   (ignorable expression #'return-second))
  
  (expression-atom
   (lilypond-header #'do-nothing)
   (markup-expr #'do-nothing)
   (OPEN-PAREN #'do-nothing)
   (CLOSE-PAREN #'do-nothing)
   (layout-block #'do-nothing)
   (music-block #'identity)
   (empty-block #'identity)
   (staff-block #'identity)
   (score-block #'identity)
   (voice-block #'identity)
   (times-block #'identity)
   (assignment #'identity)
   (repeat-block #'identity)
   (variable-block #'identity)
   (relative-block #'identity)
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
   (expression-atom #'identity))

  (repeat-block
   (REPEAT ignorable varname ignorable dur-expr ignorable expression-atom #'parse-repeat-block))

  (variable-block
   (VARIABLE #'parse-variable-block))
   
  (music-block
   (|{| expression |}| #'parse-music-block))

  (empty-block
   (|{| |}| #'do-nothing))

  (layout-block
   (LAYOUT ignorable |{| |}|)
   (LAYOUT ignorable |{| expression |}|))

  (staff-block
   (NEW-STAFF ignorable expression-atom #'parse-staff-block)
   (CONTEXT ignorable STAFF ignorable = ignorable VARNAME ignorable expression-atom #'parse-context-staff)
   (CONTEXT ignorable STAFF ignorable = ignorable STRING ignorable expression-atom #'parse-context-staff)
   (NEW-STAFF ignorable = ignorable VARNAME ignorable expression-atom #'parse-new-staff)
   (NEW-STAFF ignorable = ignorable STRING ignorable expression-atom #'parse-new-staff))

  (score-block
   (NEW-SCORE ignorable expression-atom #'parse-score-block)
   (CONTEXT ignorable SCORE ignorable = ignorable VARNAME ignorable expression-atom #'parse-context-score)
   (CONTEXT ignorable SCORE ignorable = ignorable STRING ignorable expression-atom #'parse-context-score))

  (voice-block
   (NEW-VOICE ignorable expression-atom #'parse-voice-block)
   (NEW-VOICE ignorable = ignorable STRING ignorable expression-atom #'parse-voice-block-string)
   (CONTEXT ignorable VOICE ignorable = ignorable VARNAME ignorable expression-atom #'parse-context-voice)
   (CONTEXT ignorable VOICE ignorable = ignorable STRING ignorable expression-atom #'parse-context-voice))
  
  (relative-block
   (RELATIVE ignorable note-expr ignorable expression-atom #'parse-relative-block))

  (times-block
   (TIMES ignorable NUMBER ignorable expression-atom #'parse-times-block))

  (chord-block
   (|<| ignorable notes ignorable |>| ignorable dur-expr  #'parse-chord-dur))

  (notes
   (note-expr #'list)
   (note-expr ignorable notes #'ignore-middle))
  
  (note-expr
   (NOTE octave-expr dur-expr ignorable  #'make-note)
   (SKIP dur-expr ignorable #'make-skip)
   (PARTIAL dur-expr ignorable #'make-anacruz))

  (octave-expr
   (#'empty-octave)
   (OCTAVE #'identity))

  (dur-expr
   (#'do-nothing)
   (DUR #'parse-dur)
   (dur-expr PONTO #'parse-dur-ponto)
   (dur-expr MULTIPLICA #'parse-dur-multiplica))
  

  (scheme-code
   (HASH scheme-sexp))

  (markup-expr
   (MARKUP ignorable |{| scheme-list |}|))

  (scheme-sexp
   (OPEN-PAREN scheme-list CLOSE-PAREN))

  (scheme-list
   ()
   (scheme-list scheme-atom))

  (scheme-atom
   VARNAME
   VARIABLE
   ignorable
   STRING
   BOOL
   COLON
   STAFF
   SCORE
   VOICE
   DUR
   OCTAVE
   NUMBER
   scheme-sexp)
) 

(print (parse-string "<c d> <e f>"))
(print (parse-string "\\score { <c d> <e f> }"))
