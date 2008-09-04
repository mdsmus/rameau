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
		\fatText a'_\markup { Lá maior } 
		\bar "||"
		c4
		\bar " "
	\clef bass
		\fatText c_\markup { Ré\flat maior } 
		\bar "||"
		c
		\bar " "
	\clef treble
		\fatText a'_\markup { Fá\sharp maior } 
		\bar "||"
		c
		\bar " "
	\clef bass
		\fatText c_\markup { Si\flat maior } 
		\bar "||"
		c
		\bar " "
	\clef treble
 		\fatText a'_\markup { Si maior } 
		\bar "||"
		c
		\bar " "
	\clef bass
		\fatText c_\markup { Dó\flat maior } 
		\bar "||"
		c
		\bar " "
	\clef treble
		\fatText a'_\markup { Ré maior } 
		\bar "||"
		c
		\bar " "
	\clef bass
		\fatText c_\markup { Dó menor } 
\unHideNotes
		\bar "||"
}

%\addlyrics{ "Si menor" \skip 4 "Ré menor" \skip 4 "Sol \sharp menor" \skip 4 "Dó menor" \skip 4 "Fá \sharp menor" \skip 4 "Lá menor" \skip 4 "Si \flat menor"  \skip 4 "Lá \sharp menor" }

>>


