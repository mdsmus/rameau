\header {
  texidoc = "Excercise all output functions"
}

\version "2.10.0"

\paper { ragged-right = ##t }

\relative {
  \new StaffGroup \new PianoStaff <<
    \new Staff
      {
	#(set-octavation 1)
	\times 2/3 {  c'8[\< f]( f''\!)  }
	#(set-octavation 0)
	<f,, \5>4

	\override TextScript #'color = #red
	g4^"red"
      }
    
    \new Staff \relative c'' {
      \makeClusters { <g a>8 <e a> <g a>4 }
      
      \override Glissando #'style = #'zigzag
      \slurDashed
      f2( \glissando f')
      \setEasyHeads
      f e 
    }
  >>
}
