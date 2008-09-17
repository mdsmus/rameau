\version "2.10.0"
<<
\new Staff \with {
	\remove "Time_signature_engraver"
	\override Stem #'transparent = ##t
}

{ 	\clef treble
		\time 1/4
\hideNotes
		\override TextScript #'extra-offset = #'( -1.0 . -2.0 )
		\fatText a'_\markup { Si menor } 
		\bar "||"
		c4
		\bar " "
	\clef bass
		\fatText c_\markup { Ré menor } 
		\bar "||"
		c
		\bar " "
	\clef treble
		\fatText a'_\markup { Sol \sharp menor } 
		\bar "||"
		c
		\bar " "
	\clef bass
		\fatText c_\markup { Dó menor } 
		\bar "||"
		c
		\bar " "
	\clef treble
 		\fatText a'_\markup { Fá \sharp menor } 
		\bar "||"
		c
		\bar " "
	\clef bass
		\fatText c_\markup { Lá menor } 
		\bar "||"
		c
		\bar " "
	\clef treble
		\fatText a'_\markup { Si \flat menor } 
		\bar "||"
		c
		\bar " "
	\clef bass
		\fatText c_\markup { Lá \sharp menor } 
\unHideNotes
		\bar "||"
}

%\addlyrics{ "Si menor" \skip 4 "Ré menor" \skip 4 "Sol \sharp menor" \skip 4 "Dó menor" \skip 4 "Fá \sharp menor" \skip 4 "Lá menor" \skip 4 "Si \flat menor"  \skip 4 "Lá \sharp menor" }

>>


