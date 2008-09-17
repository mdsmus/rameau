\version "2.10.0"
<<
\new Staff \with {
	\remove "Time_signature_engraver"
	\override Stem #'transparent = ##t
}
\relative c { \clef bass
		\time 2/4
		<c c>
		s4 \bar " "
		<c d>
		s4 \bar " "
		<c e>
		s4  \bar " "
		<d f>
		s4 \bar " "
		<d fis>
		s4  \bar " "
		<des fes>
		s  \bar " "
		<b e>
		s  \bar " "
		\time 1/4
		\hideNotes c \unHideNotes \bar "||"
}
\addlyrics{ "1" "2" "3" "3" "3" "3" "4" "(etc.)" }
>>





