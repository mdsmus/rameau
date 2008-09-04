\version "2.10.0"
<<
\new Staff \with {
	\remove "Time_signature_engraver"
}

\relative c' {
	 	\clef treble
		\time 4/4
		<e gis b>1 \bar " "
		s1 \bar " "
		<e g b>1 \bar " "
		s1 \bar " "
		<e g bes>1 \bar " "
		s1 \bar " "
		<e gis bis>1 \bar " "
		s1 \bar " "
}
\addlyrics { "M" "m" "°" "+" }
\addlyrics { "E" "Em" "E°" "E+" }
>>

