\score { \relative c {
		\time 3/4
		\clef bass
		s ees \hideNotes c_\markup { "3M" } \unHideNotes

		s fis \hideNotes c_\markup { "5P" } \unHideNotes

		s c \hideNotes c_\markup { "7m" } \unHideNotes

		s b \hideNotes c_\markup { "2m" } \unHideNotes

		s des \hideNotes c_\markup { "6M" } \unHideNotes

		s aes \hideNotes c_\markup { "5P" } \unHideNotes

		s b \hideNotes c_\markup { "8P" } \unHideNotes

		s e \hideNotes c_\markup { "7M" } \unHideNotes

		s g' \hideNotes c,_\markup { "3M" } \unHideNotes

		s a \hideNotes 		\override TextScript #'extra-offset = #'( -7.0 . -2.0 ) c_\markup { "7m" } \unHideNotes
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
