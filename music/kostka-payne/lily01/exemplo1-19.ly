   \score { \relative c' {
		\clef treble
		c^\markup{ "1" }\startGroup
		\once \override TextScript #'extra-offset = #'( 0.0 . 2.5 )
		\hideNotes c^\markup{ "-" } \unHideNotes
		c^\markup{ "1" }\stopGroup
		s |
		c^\markup{ "1" }\startGroup
		\once \override TextScript #'extra-offset = #'( 0.0 . 2.5 )
		\hideNotes c^\markup{ "-" } \unHideNotes
		f^\markup{ "4" }\stopGroup
		s |
		c^\markup{ "1" }\startGroup
		\once \override TextScript #'extra-offset = #'( 0.0 . 2.5 )
		\hideNotes c^\markup{ "-" } \unHideNotes
		\once \override TextScript #'extra-offset = #'( 0.0 . 1.5 )
		g'^\markup{ "5" }\stopGroup
		s |
		c,^\markup{ "1" }\startGroup
		\once \override TextScript #'extra-offset = #'( 0.0 . 2.5 )
		\hideNotes c^\markup{ "-" } \unHideNotes
		c'^\markup{ "1" }\stopGroup
		s \bar "||"
	}
	\addlyrics{ \skip4 "1P" \skip4 \skip4 "4P" \skip4 \skip4 "5P" \skip4 \skip4 "8P"}
       \layout { ragged-right = ##t 
         \context {
           \Staff \consists "Horizontal_bracket_engraver"
		\remove "Time_signature_engraver"
		\override Stem #'transparent = ##t
		\override TextScript #'extra-offset = #'( 0.0 . 2.0 )
     }
   }
}