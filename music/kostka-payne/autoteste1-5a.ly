\score { \relative c {
		\time 3/4
		\clef bass
		d \hideNotes c
		\unHideNotes a'
		
		s <f bes> s

		s <e e> s

		s <a, ees> s

		s <cis cis'> s

		s <g' c> s

		s <des a'> s

		b \hideNotes c
		\unHideNotes e

		s <gis dis'> s

		s <ees ees'> s
		\bar "||"
	}
	\addlyrics{ \skip4 "5___" \skip4 "4___" "1___" "5___" "8___" "4___" "5___" \skip4  "4___" \skip4 "5___"  "8___" }
	\addlyrics{ \skip4 "1" \skip4 "2" "3" "4" "5" "6" "7" \skip4  "8" \skip4 "9"  "10" }       \layout { 
	% ragged-right = ##t 
         \context {
           \Staff
		\remove "Time_signature_engraver"
		\override Stem #'transparent = ##t
     }
   }
}
