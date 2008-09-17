   \score { \relative c' {
		\clef treble
		c^\markup{ "1" }\startGroup
		\once \override TextScript #'extra-offset = #'( 0.0 . 2.5 )
		\hideNotes c^\markup{ "-" } \unHideNotes
		d^\markup{ "2" }\stopGroup
		s |

		c^\markup{ "1" }\startGroup
		\once \override TextScript #'extra-offset = #'( 0.5 . 2.5 )
		\hideNotes c^\markup{ "-" } \unHideNotes
		e^\markup{ "3" }\stopGroup
		s |

		c^\markup{ "1" }\startGroup
		\once \override TextScript #'extra-offset = #'( 0.5 . 2.5 )
		\hideNotes c^\markup{ "-" } \unHideNotes
		\once \override TextScript #'extra-offset = #'( 0.0 . 1.0 )
		a'^\markup{ "6" }\stopGroup
		s |

		c,^\markup{ "1" }\startGroup
		\once \override TextScript #'extra-offset = #'( 1.0 . 2.5 )
		\hideNotes c^\markup{ "-" } \unHideNotes
		b'^\markup{ "7" }\stopGroup
		s \bar "||"

	}
	\addlyrics{ \skip4 "2M" \skip4 \skip4 "3M" \skip4 \skip4 "6M" \skip4 \skip4 "7M"}
       \layout { ragged-right = ##t 
         \context {
           \Staff \consists "Horizontal_bracket_engraver"
		\remove "Time_signature_engraver"
		\override Stem #'transparent = ##t
		\override TextScript #'extra-offset = #'( 0.0 . 2.0 )
     }
   }
}