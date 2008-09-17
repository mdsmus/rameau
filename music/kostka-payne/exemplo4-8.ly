\version "2.10.0"
<<
\new Staff \with {
	\remove "Time_signature_engraver"
	\override Stem #'transparent = ##t
}

\relative c' { \clef treble
		\time 14/1
		\override TextScript #'extra-offset = #'( 0.0 . 2.0 )
		<c e g b>1^\markup{ 1 } 
		\hideNotes e4 \unHideNotes
		<d f a c>1^\markup{ 2 } 
		\hideNotes e4 \unHideNotes
		<e g b d>1^\markup{ 3 } 
		\hideNotes e4 \unHideNotes
		<f a c e>1^\markup{ 4 } 
		\hideNotes e4 \unHideNotes
		<g b d f>1^\markup{ 5 } 
		\hideNotes e4 \unHideNotes
		<a c e g>1^\markup{ 6 } 
		\hideNotes a4 \unHideNotes
		<b d f a>1^\markup{ 7 } 
		\hideNotes a4 \unHideNotes

		\bar "||"
}
\addlyrics { "I7M" \skip1 "ii7" \skip1  "iii7"  \skip1 "IV7M"  \skip1 "V7" \skip1  "vi7"  \skip1 "vii°" \skip1  }
>>

