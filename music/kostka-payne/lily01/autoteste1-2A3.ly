\version "2.10.0"
<<
\new Staff \with {
	\remove "Time_signature_engraver"
	\override Stem #'transparent = ##t
}

\relative c' { \clef treble
		\time 8/4
		\once \override TextScript #'extra-offset = #'( -8.0 . 2.0 )
		\hideNotes
		c^\markup{ Dó\sharp maior }
		c c c c c c c \bar "||"
		\unHideNotes
		\time 1/4
		s4 \bar " "
		\clef bass
		\time 8/4
		\once \override TextScript #'extra-offset = #'( -6.0 . 2.0 )
		\hideNotes
		 c,,^\markup{ Lá maior } e e e e e e e
		\unHideNotes  \bar "||"
}
>>

