\version "2.10.0"
<<
\new Staff \with {
	\remove "Time_signature_engraver"
}

\relative c' {
	 	\clef treble
		\time 4/4
		<e g a cis>1 \bar " "
		<g a cis e>1 \bar " "
		<a cis e g>1 \bar " "
		<cis e g a>1 \bar "||"
}
\addlyrics { \skip1 \skip1 Posição \skip1 }
\addlyrics { \skip1 \skip1 fundamental \skip1 }
>>

