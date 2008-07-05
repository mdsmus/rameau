\header {

  texidoc = "With @code{strict-note-spacing} spacing for grace notes
(even multiple ones), is floating as well."

}

\version "2.10.0"

\paper {
  ragged-right = ##t
  indent = 0
}

\relative c''
{
  \override Score.SpacingSpanner #'strict-note-spacing = ##t 
  \set Score.proportionalNotationDuration = #(ly:make-moment 1 12)
  c8[ \grace { c16[ c] } c8 c8 c8] 
  c2 
}  
