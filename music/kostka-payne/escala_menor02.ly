\version "2.10.0"
<<
\new Staff \with {
	\remove "Time_signature_engraver"
	\override Stem #'transparent = ##t
}
\relative c' { \clef treble
		\key f \major
		\time 7/1
		\once \override TextScript #'extra-offset = #'( -8.0 . 3.0 )
		d1^\markup{ Menor harmônica (eleva o sétimo grau) }
		e f g a bes cis \bar " "
		d cis bes a g f e \bar " "
		\time 1/1
		d \bar "||"
}
>>


