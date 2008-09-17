\version "2.10.0"
\score {
     \context PianoStaff <<
	\new Staff =  "up" {
		\clef treble
		\time 4/4
		\key ees \major
	<<
		\relative c''' {
			r1 r1 r8 g16 fis g8 c, ees
		}
	   >>
	}
	\new Staff =  "down" {
	        \clef treble
		\key ees \major
	<<
		\relative c'' {
			r8 c16 b c8 g
			\override TextScript #'extra-offset = #'( 0.0 . 1.0 )
			aes^\markup{ 6 }
			c16 b c8 d
			g, c16 b c8 d f,16 g aes8 ~ aes g16 f
			ees c' 
			\override TextScript #'extra-offset = #'( 0.0 . 1.0 )
			b!^\markup{ 7 }
			\override TextScript #'extra-offset = #'( 0.0 . 1.0 )
			a!^\markup{ 6 }
			g f ees d c8
		}
	  >>
	}
    >>
    \layout {
	ragged-right = ##t 
	\context {
	    \Staff
	    \consists Horizontal_bracket_engraver
	}
    }
}
