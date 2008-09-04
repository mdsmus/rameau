\version "2.10.0"
<<
\new Staff \with {
	\remove "Time_signature_engraver"
	\override Stem #'transparent = ##t
}

\relative c' { \clef tenor
		\time 8/4
		\once \override TextScript #'extra-offset = #'( -8.0 . 2.5 )
		\hideNotes
		c,^\markup{ Si \flat menor natural }
		c c c c c c c \bar "||"
		\unHideNotes
		\time 1/4
		s4 \bar " "
		\clef treble
		\time 8/4
		\once \override TextScript #'extra-offset = #'( -3.0 . 1.0 )
		\hideNotes
		 c^\markup{ Sol \sharp menor harmônica } e e e e e e e
		\unHideNotes  \bar "||"
}
>>


