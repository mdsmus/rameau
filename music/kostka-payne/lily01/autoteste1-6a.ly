\score { \relative c' {
		\time 3/4
		\clef treble
		s <f cis'> s

		s <a ges'> s

		s <bes d> s

		s <e, aes> s

		s <bes' cis> s

		s <fis e'> s

		s <dis' a'> s

		s <a ces> s

		s <ees cis'> s

		s <bes' e> s

		\bar "||"
	}
	\addlyrics{ "_____" "_____" "_____" "_____" "_____" "_____" "_____" "_____" "_____" "_____"  }
	\addlyrics{ "1"  "2" "3" "4" "5" "6" "7" "8"  "9"  "10" }
       \layout { 
	% ragged-right = ##t 
         \context {
           \Staff
		\remove "Time_signature_engraver"
		\override Stem #'transparent = ##t
     }
   }
}
