\score { \relative c' {
		\time 3/4
		\clef treble
		s e \hideNotes c_\markup { "2m" } \unHideNotes

		s c' \hideNotes c,_\markup { "4P" } \unHideNotes

		s b' \hideNotes c,_\markup { "6M" } \unHideNotes

		s c' \hideNotes c,_\markup { "3m" } \unHideNotes

		s d \hideNotes c_\markup { "5P" } \unHideNotes

		s a' \hideNotes c,_\markup { "6m" } \unHideNotes

		s ees \hideNotes c_\markup { "8P" } \unHideNotes

		s g' \hideNotes c,_\markup { "2M" } \unHideNotes

		s aes' \hideNotes c,_\markup { "7M" } \unHideNotes

		s e \hideNotes \override TextScript #'extra-offset = #'( -7.0 . -2.0 ) c_\markup { "4P" } \unHideNotes
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
