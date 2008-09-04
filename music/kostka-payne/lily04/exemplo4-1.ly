\version "2.10.0"
<<
\new Staff \with {
	\remove "Time_signature_engraver"
	\override Stem #'transparent = ##t
}

\relative c' { \clef treble
		\time 22/1
		\override TextScript #'extra-offset = #'( 0.0 . 3.0 )
		e1^\markup{ 1 } s4 
		fis1^\markup{ 2 } s4
		g1^\markup{ 3 } s4
		a1^\markup{ 4 } s4
		b1^\markup{ 5 } s4
		c1\glissando
		\once \override TextScript #'extra-offset = #'( 0.0 . -2.0 )
		\hideNotes g''4^\markup{ 6 }\glissando  \unHideNotes
		cis,,1
		d1\glissando
		\once \override TextScript #'extra-offset = #'( 0.0 . -2.0 )
		\hideNotes g'4^\markup{ "7" }\glissando \unHideNotes
		dis,1
		e1^\markup{ 1 } s4
		\bar "||"
}
>>

