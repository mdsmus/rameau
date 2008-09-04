\score { \relative c'' {
		\time 3/4
		\clef treble
		bes \hideNotes c
		\unHideNotes d
		
		s <g, ees'> s

		s <a g'> s

		s <b cis> s

		s <a f'> s

		s <f ges> s

		fis \hideNotes c'
		\unHideNotes a

		s <g fis'> s

		s <fis dis'> s

		s <gis a> s
		\bar "||"
	}
	\addlyrics{ \skip4 "3___" \skip4 "6___" "7___" "2___" "6___" "2___"  \skip4 "3___" \skip4  "7___" "6___"  "2___" }
	\addlyrics{ \skip4 "1" \skip4 "2" "3" "4" "5" "6"  \skip4 "7" \skip4  "8" "9"  "10" }
\layout { 
	% ragged-right = ##t 
         \context {
           \Staff
		\remove "Time_signature_engraver"
		\override Stem #'transparent = ##t
     }
   }
}