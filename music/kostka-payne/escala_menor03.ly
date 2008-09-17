\version "2.10.0"
<<
\new Staff \with {
	\remove "Time_signature_engraver"
	\override Stem #'transparent = ##t
}
\relative c' { \clef treble
		\key f \major
		\time 6/1
		\once \override TextScript #'extra-offset = #'( -8.0 . 3.0 )
		d1^\markup{ Menor melódica (eleva o sexto e o sétimo grau somente na forma ascendente) }
		e f g a b!  \bar " "
		cis d c! bes! a g   \bar " "
		\time 3/1
		f e d \bar "||"
}
>>


