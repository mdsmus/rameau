   \score { \relative c'' {
		\clef treble
		g\startGroup \hideNotes c,
		\unHideNotes a'\stopGroup s \bar " "
		
		g\startGroup \hideNotes c,
		\unHideNotes aes'\stopGroup s \bar " "

		f\startGroup \hideNotes c
		\unHideNotes a'\stopGroup s \bar " "
		
		fis\startGroup \hideNotes c
		\unHideNotes a'\stopGroup s \bar " "
		
		f\startGroup \hideNotes c
		\unHideNotes d'\stopGroup s \bar " "

		f,\startGroup \hideNotes c
		\unHideNotes des'\stopGroup s \bar " "

		g,\startGroup \hideNotes c,
		\unHideNotes fis'\stopGroup s \bar " "

		gis,\startGroup \hideNotes c,
		\unHideNotes fis'\stopGroup s
		\bar "||"
	}
	\addlyrics{ \skip4 "2M" \skip4 \skip4 "2m" \skip4 \skip4 "3M" \skip4 \skip4 "3m" \skip4 \skip4 "6M" \skip4 \skip4 "6m" \skip4 \skip4 "7M" \skip4 \skip4 "7m" }
       \layout { ragged-right = ##t 
         \context {
           \Staff \consists "Horizontal_bracket_engraver"
		\remove "Time_signature_engraver"
		\override Stem #'transparent = ##t
		\override TextScript #'extra-offset = #'( 0.0 . 2.0 )
     }
   }
}