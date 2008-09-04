   \score { \relative c'' {
		\clef treble
		\time 11/4
		\once \override TextScript #'extra-offset = #'( -7.0 . -2.0 )
		 \arpeggioBracket
		<a e'>_\markup{ "Intervalos harmônicos" }\arpeggio
		s4
		 \arpeggioBracket
		<f a>\arpeggio
		s4
		e'\startGroup s
		\once \override TextScript #'extra-offset = #'( 0.0 . -3.5 )
		a,_\markup{ "Intervalos melódicos" }\stopGroup s
		f\startGroup s a\stopGroup
		\bar "||"       }
       \layout { ragged-right = ##t 
         \context {
           \Staff \consists "Horizontal_bracket_engraver"
		\remove "Time_signature_engraver"
		\override Stem #'transparent = ##t
     }
   }
}