\version "2.10.0"

\score {
     \context PianoStaff <<
		\new Staff =  "up" {
		<<
			\relative { s4 s4 s4 s4 s4 s4 s4 s4 s4 s4 s4 s4 s4 s4 s4 
			}
		>>
	}
	\new Staff =  "down" {
		\clef bass
		<<
			\relative c {
			\hideNotes 
				g4 g4 g4 g4  \bar " "
				g4 g4 g4 g4  \bar " "
				g4 g4 g4 g4  \bar " "
				\partial 4*3 g4 g4 g4 \bar "||"
			\unHideNotes
			}
		\addlyrics{ "E3" "A1" "F2" "C5" "B2" "G3" "B1" "E4" "D2" "C3" "B-1" "G2" "D4" "F1" "D3" }
		  >>
		}
	>>
    \layout {
%	ragged-right = ##t 
	\context {
	    \Staff
	    \consists Horizontal_bracket_engraver
		\remove "Time_signature_engraver"
	}
    }
}

