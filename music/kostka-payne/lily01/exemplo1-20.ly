   \score {
		\relative c' {
		 \time 5/4
		\clef treble
		dis_\markup{ Ré\sharp }
		\hideNotes
			s
		\once \override TextScript #'extra-offset = #'( -1.0 . -4.0 )
			d_\markup{ = }
			d_\markup{ ? }
		\once \override TextScript #'extra-offset = #'( -12.0 . -1.0 )
			d_\markup{ 5P acima }
		\unHideNotes



		d!_\markup{ Ré\natural }
		\hideNotes
			s
		\once \override TextScript #'extra-offset = #'( -1.0 . -4.0 )
			d_\markup{ = }
		\unHideNotes
		\once \override TextScript #'extra-offset = #'( -1.0 . -4.5 )
			a'!_\markup{ Lá\natural }
		\hideNotes
		\once \override TextScript #'extra-offset = #'( -12.0 . -1.2 )
			d,_\markup{ 5P acima }
		\unHideNotes



		dis_\markup{ Ré\sharp }
		\hideNotes
			s
		\once \override TextScript #'extra-offset = #'( -1.0 . -4.0 )
			d_\markup{ = }
		\unHideNotes
		\once \override TextScript #'extra-offset = #'( -1.0 . -4.5 )
			ais'!_\markup{ Lá\sharp }
		\hideNotes
		\once \override TextScript #'extra-offset = #'( -12.0 . -1.8 )
			d_\markup{ 5P acima }
		\unHideNotes 
		\bar "||"
	}
       \layout { ragged-right = ##t 
         \context {
           \Staff \consists "Horizontal_bracket_engraver"
		\remove "Time_signature_engraver"
		\override Stem #'transparent = ##t
		\override TextScript #'extra-offset = #'( -1.0 . -3.5 )
     }
   }
}