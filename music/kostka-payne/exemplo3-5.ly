\version "2.10.0"
<<
\new Staff \with {
	\remove "Time_signature_engraver"
}

\relative c' {
	 	\clef treble
		\time 4/4
		<f a c>1 \bar " "
		<a c f>1 \bar " "
		<c f a>1 \bar "||"
}
\addlyrics { Posição Primeira Segunda }
\addlyrics { fundamental inversão inversão }
>>

