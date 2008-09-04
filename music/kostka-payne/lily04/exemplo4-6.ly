\version "2.10.0"
<<
\new Staff \with {
	\remove "Time_signature_engraver"
	\override Stem #'transparent = ##t
}

\relative c' { \clef treble
		\time 14/1
		\override TextScript #'extra-offset = #'( 0.0 . 2.0 )
		<c e g>1^\markup{ 1 } 
		<d f a>1^\markup{ 2 } 
		<e g b>1^\markup{ 3 } 
		<f a c>1^\markup{ 4 } 
		<g b d>1^\markup{ 5 } 
		<a c e>1^\markup{ 6 } 
		<b d f>1^\markup{ 7 } 

		\bar "||"
}
\addlyrics { "I" "ii" "iii" "IV" "V" "vi" "vii°" }
>>

