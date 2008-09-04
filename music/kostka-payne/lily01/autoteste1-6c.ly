\score { \relative c' {
		\time 3/4
		\clef bass
		s a \hideNotes c_\markup { "5P" } \unHideNotes

		s bes \hideNotes c_\markup { "7m" } \unHideNotes

		s e, \hideNotes c_\markup { "3m" } \unHideNotes

		s f \hideNotes c_\markup { "6M" } \unHideNotes

		s d \hideNotes c_\markup { "4+" } \unHideNotes

		s gis' \hideNotes c_\markup { "7M" } \unHideNotes

		s c \hideNotes c_\markup { "5+" } \unHideNotes

		s fis, \hideNotes c_\markup { "6m" } \unHideNotes

		s des \hideNotes c_\markup { "2M" } \unHideNotes

		s ees \hideNotes 		\override TextScript #'extra-offset = #'( -7.0 . -2.0 ) c_\markup { "7°" } \unHideNotes
		\bar "||"
	}
	\addlyrics{ "_____" \skip4 "_____" \skip4  "_____" \skip4  "_____" \skip4  "_____" \skip4  "_____" \skip4  "_____" \skip4  "_____" \skip4  "_____" \skip4  "_____" }
	\addlyrics{ "1" \skip4 "2" \skip4 "3" \skip4 "4" \skip4 "5" \skip4 "6" \skip4 "7" \skip4 "8" \skip4 "9" \skip4  "10" }       \layout { 
	% ragged-right = ##t 
         \context {
           \Staff
		\remove "Time_signature_engraver"
		\override Stem #'transparent = ##t
		\override TextScript #'extra-offset = #'( -4.0 . -2.0 )
     }
   }
}
