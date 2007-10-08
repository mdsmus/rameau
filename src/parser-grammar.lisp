(in-package #:rameau)

(define-parser *expression-parser*
  (:start-symbol start)
  (:terminals (WHITESPACE
               NEW-STAFF
               NEW-SCORE
               NEW-VOICE
               DUR
               NOTE
               OCTAVE
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
   (expression #'parse-lilypond))

  (lilypond-header
   (HEADER |{| expression |}|)
   (HEADER |{| |}|))

  (expression
   (expression-atom #'list)
   (expression-atom expression #'cons))
  
  (expression-atom
   (lilypond-header #'do-nothing)
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
   (variable-block #'identity)
   (relative-block #'identity)
   (chord-block #'identity)
   (scheme-code #'do-nothing)
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
   (|{| |}| #'do-nothing))

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
   (|<| notes |>| dur-expr  #'parse-chord-dur))

  (notes
   (note-expr #'list)
   (note-expr notes #'cons))
  
  (note-expr
   (NOTE octave-expr dur-expr  #'cria-nota)
   (SKIP dur-expr #'cria-skip))

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
   STAFF
   SCORE
   VOICE
   DUR
   OCTAVE
   NUMBER
   scheme-sexp)
) 
