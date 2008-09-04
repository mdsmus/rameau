\score { \relative c'' {
		\time 4/4
		\clef treble	
		s <b c> s <c b'>
		s <a c> s <c a'>
		s <g c> s <c g'>
		s <f, c'> s <c' f>
		s <e, c'> s <c' e>
		s <d, c'> s <c' d>
		\bar "||"
	}
	\addlyrics{ "2" "7"  "3"  "6"  "4"  "5"  "5"  "4"  "6"  "3"  "7" "2"  }
\layout { 
	% ragged-right = ##t 
         \context {
           \Staff
		\remove "Time_signature_engraver"
		\override Stem #'transparent = ##t
     }
   }
}
