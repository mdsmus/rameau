\version "2.10.0"
<<
\new Staff \with {
	\remove "Time_signature_engraver"
	\override Stem #'transparent = ##t
}
\relative c' { \clef treble
		\key f \major
		\time 15/1
		\once \override TextScript #'extra-offset = #'( -8.0 . 3.0 )
		f1^\markup{ Escala de Fá maior }
		g a bes c d e f e d c bes a g f \bar "||"
}
>>


