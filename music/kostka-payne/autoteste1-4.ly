\score {
     \context PianoStaff <<
	\new Staff =  "up" {
		\clef treble
	<<
		\relative c'' {
		s4 s
		s s \bar " "
		<a f'> s
		<f f> s \bar " "
		s s
		<b e> s \bar " "
		<d, d'> s
		s s \bar " "
		s s
		<f g> s \bar " "
		<a f> s
		s s \bar " "
		s s
		<c e> s \bar " "
		<e, b'> s \bar "||"
		} 
	   >>
	}

	\new Staff =  "down" {
	        \clef bass
	<<
		\relative c {
		<c d> s
		<d a> s
		\hideNotes a \unHideNotes s
		\hideNotes a \unHideNotes s
		<g b> s
		\hideNotes a \unHideNotes s
		\hideNotes a \unHideNotes s
		<b g'> s
		<c f> s
		\hideNotes a \unHideNotes s
		\hideNotes a \unHideNotes s
		<e d'> s
		<g g'> s
		\hideNotes a \unHideNotes s
		\hideNotes a \unHideNotes s
		}
		\addlyrics {
		"___" "___" "___" "___" "___" "___" "___" "___" "___" "___" "___" "___" "___" "___" "___"
		}
		\addlyrics {
		"1" "2" "3" "4" "5" "6" "7" "8" "9" "10" "11" "12" "13" "14" "15"
		}
	  >>
	}
    >>

    \layout {
%	ragged-right = ##t 
	\context {
	    \Staff
		\consists Horizontal_bracket_engraver
		\override Stem #'transparent = ##t
	}
    }
}

