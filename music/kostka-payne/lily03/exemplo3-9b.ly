\version "2.10.0"
<<
\new Staff \with {
	\remove "Time_signature_engraver"
}

\relative c' {
	 	\clef treble
		\time 4/4
		<e gis b dis>1 \bar " "
		s1  \bar " "
		<e gis b d>1 \bar " "
		s1  \bar " "
		<e g b d>1 \bar " "
		s1  \bar " "
		\once \override TextScript #'extra-offset = #'( -0.0 . -1.9 )
		<e g bes d>1_\markup { \small { "/"} } \bar " "
		s1  \bar " "
		<e gis bis des>1  \bar " "
		s1  \bar " "
}
\addlyrics { "M7M" "M7m" "m7" "°7" "°7" }
\addlyrics { "E7M" "E7" "Em7" "Em7b5" "E°7" }
>>

