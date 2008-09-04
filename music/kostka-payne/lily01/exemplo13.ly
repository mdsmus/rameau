\version "2.10.0"

\score {
     \context PianoStaff <<
	\new Staff =  "up" {
	        \clef alto
	        \key cis \major
	<<
		\relative c' {
	        \hideNotes 
		a1  \bar "||"
		\unHideNotes
		 \set Staff.printKeyCancellation = ##f
	        \key ces \major
	        \hideNotes 
		a1 \bar "||"
		\unHideNotes
		}
	   >>
	}

	\new Staff =  "down" {
	        \clef tenor
	        \key cis \major
	<<
		\relative c {
	        \hideNotes 
		a1 \bar "||"
		\unHideNotes
		 \set Staff.printKeyCancellation = ##f
		\key ces \major
	        \hideNotes 
		a1 \bar "||"
		\unHideNotes
		}
	  >>
	}
    >>

    \layout {
	ragged-right = ##t 
	\context {
	    \Staff
		\consists Horizontal_bracket_engraver
		\remove "Time_signature_engraver"
	}
    }
}

