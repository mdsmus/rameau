\version "2.10.0"
<<
\new Staff \with {
	\remove "Time_signature_engraver"
	\override Stem #'transparent = ##t
}

\relative c' { \clef treble
		\time 8/4
		\once \override TextScript #'extra-offset = #'( -8.0 . 3.0 )
		\hideNotes
		c^\markup{ Mi \flat menor melódica }
		c c c c c c c \bar " "
		e e e e e e e e
		\unHideNotes  \bar "||"
}
>>


