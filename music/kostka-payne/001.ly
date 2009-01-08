\version "2.12.0"

\score {
     \context PianoStaff <<
		\new Staff =  "up" {
		\key ees \major
	    << \relative c'' {
		\once \override TextScript #'extra-offset = #'( -20.0 . -7.0 )
		\partial 4*1 ees^\markup{ \center-align {soprano contralto} }
		d c bes aes8 g
		c4 c bes\fermata } \\
	        \relative c'' {  \partial 4*1 bes
		bes g g f8 ees
		ees4 aes g }
	   >>
	}

	\new Staff =  "down" {
		\clef bass
		\key ees \major
	<<
		\relative c {
		\once \override TextScript #'extra-offset = #'( -20.0 . -9.0 )
		\partial 4*1 g''^\markup{ \center-align { tenor baixo} } 
		f ees d des
		c8 bes c d! ees4 
	    } \\
		 \relative c {  \partial 4*1 ees
		bes' c g bes
		aes aes, ees'\fermata }
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