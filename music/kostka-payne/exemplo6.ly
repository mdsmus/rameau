\version "2.10.0"

\score {
     \context PianoStaff <<
	\new Staff =  "up" {
		\clef treble
	<<
		\relative c' {
		\once \override TextScript #'extra-offset = #'( 0.0 . 1.5 )
\fatText		f^\markup {fá3}
		s4
		\once \override TextScript #'extra-offset = #'( 0.0 . 1.4 )	
\fatText		c^\markup {dó3}
		s4
		\bar " "
		s4
		s4
		\once \override TextScript #'extra-offset = #'( 0.0 . 1.4 )
\fatText		e^\markup {mi4}

		s4
		\bar " "
		s4
		s4
		\once \override TextScript #'extra-offset = #'( 0.0 . 1.0 )
\fatText		a,^\markup {lá2}
		s4
		\bar " "
		s4
		s4
		s4
		}
	   >>
	}

	\new Staff =  "down" {
	        \clef bass
	<<
		\relative c {
		s4
		s4
		s4
		s4
		\once \override TextScript #'extra-offset = #'( 0.0 . -1.7 )
\fatText		c'_\markup {dó3}
		s4
		s4
		s4
		\once \override TextScript #'extra-offset = #'( 0.0 . -1.0 )
\fatText		f,,_\markup {fá1}
		s4
		s4
		s4
		\once \override TextScript #'extra-offset = #'( 0.0 . -2.3 )
\fatText		a'_\markup {lá2}
		s4
		\once \override TextScript #'extra-offset = #'( 0.0 . -2.4 )
\fatText		e'_\markup {mi3}
		}
	  >>
	}
    >>

    \layout {
	ragged-right = ##t 
	\context {
	    \Staff
		\consists Horizontal_bracket_engraver
		\override Stem #'transparent = ##t
	}
    }
}

