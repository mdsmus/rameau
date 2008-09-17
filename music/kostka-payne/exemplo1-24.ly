   \score {
	\relative c' {
	\time 5/4
	\clef bass
	g s \hideNotes g \unHideNotes s s	
	g s \hideNotes g \unHideNotes b s	
	g s \hideNotes g \unHideNotes b, s
	\bar "||"
	}
	\addlyrics { \skip4 "6m desc. = ?"  \skip4 "3M asc. = si2"  \skip4  \skip4  \skip4 "6m desc. = si1" }
       \layout { ragged-right = ##t 
         \context {
           \Staff \consists "Horizontal_bracket_engraver"
		\remove "Time_signature_engraver"
		\override Stem #'transparent = ##t
     }
   }
}