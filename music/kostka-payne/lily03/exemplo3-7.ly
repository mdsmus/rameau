\version "2.10.0"
<<
\new Staff \with {
	\remove "Time_signature_engraver"
}

\relative c' {
	 	\clef treble
		\time 4/4
		<c e g b>1 \bar " "
		<e g b c>1 \bar " "
		<g b c e>1 \bar " "
		<b c e g>1 \bar "||"
}
\addlyrics { Posição Primeira Segunda Terceira }
\addlyrics { fundamental inversão inversão inversão }
>>

