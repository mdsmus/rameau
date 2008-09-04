\version "2.10.0"
<<
\new Staff \with {
	\remove "Time_signature_engraver"
	\override Stem #'transparent = ##t
}

\relative c' { \clef treble
		\time 1/4
		\hideNotes
		c
		\bar "||"
		c4
		\bar " "
		\set Staff.printKeyCancellation = ##f
		\key b \major
		\clef bass
		c
		\bar "||"
		c
		\bar " "
		\set Staff.printKeyCancellation = ##f
		\key g \major
		\clef treble
		c
		\bar "||"
		c
		\bar " "
		\set Staff.printKeyCancellation = ##f
		\key e \major
		\clef bass
		c
		\bar "||"
		c
		\bar " "
		\set Staff.printKeyCancellation = ##f
		\key aes \major
		\clef treble
		c
		\bar "||"
		c
		\bar " "
		\set Staff.printKeyCancellation = ##f
		\key ces \major
		\clef bass
		c
		\bar "||"
		c
		\bar " "
		\set Staff.printKeyCancellation = ##f
		\key fis \major
		\clef treble
		c
		\bar "||"
		c
		\bar " "
		\set Staff.printKeyCancellation = ##f
		\key ges \major
		\clef bass
		c
		\unHideNotes
		\bar "||"
}

\addlyrics{ "Lá menor" \skip 4 "____ menor" \skip 4 "____ menor" \skip 4 "____ menor" \skip 4 "____ menor" \skip 4 "____ menor" \skip 4 "____ menor"  \skip 4 "____ menor" }
\addlyrics{ "ex." \skip 4 "1" \skip 4 "2" \skip 4 "3" \skip 4 "4" \skip 4 "5" \skip 4 "6" \skip 4 "7" }

>>


