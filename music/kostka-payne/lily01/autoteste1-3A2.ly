\version "2.10.0"
<<
\new Staff \with {
	\remove "Time_signature_engraver"
	\override Stem #'transparent = ##t
}

\relative c' { \clef alto
		\time 8/4
		\once \override TextScript #'extra-offset = #'( -8.0 . 3.0 )
		\hideNotes
		c^\markup{ Fá menor natural }
		c c c c c c c \bar "||"
		\unHideNotes
		\time 1/4
		s4 \bar " "
		\clef bass
		\time 8/4
		\once \override TextScript #'extra-offset = #'( -3.0 . 1.0 )
		\hideNotes
		 c,,^\markup{ Dó \sharp menor harmônica } e e e e e e e
		\unHideNotes  \bar "||"
}
>>


