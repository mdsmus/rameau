\version "2.10.0"
\score {
     \context PianoStaff <<
	\new Staff =  "up" {
		\set Score.currentBarNumber = #28
		\override Score.BarNumber 
			#'break-visibility = #end-of-line-invisible
		\clef treble
		\time 3/2
	<<
		\relative c' {
		\once \override TextScript #'extra-offset = #'( 0.0 . 3.0 )
		r2 <c e g c>^\markup { "sonore sans dureté" }( <d f a d> 
		<g b d g>2. <f a c f>4 <e g b e> <d f a d>
		<d f a d>2 <a c e a> <e' g b e> ~ 
		<e g b e>4 <f a c f>  <d f a d>2. <c e g c>4
		<c e g c>1)
		}
	   >>
	}

	\new Staff =  "down" {
	        \clef bass
		\time 3/2
	<<
		\relative c {
		r2 <g c e g> <a d f a>
		<d g b d>2. <c f a c>4 <b e g b> <a d f a>
		<a d f a>2 <e a c e> <b' e g b> ~
		<b e g b>4 <c f a c> <a d f a>2. <g c e g>4
		<g c e g>1
		    } \\
		 \relative c, {
		c1.-^_\markup { "8va bassa" } ~
		c1. ~ c1. ~ c1. ~ c2
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
