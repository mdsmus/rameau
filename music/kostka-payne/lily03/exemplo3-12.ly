\version "2.10.0"
<<
\new Staff \with {
	\remove "Time_signature_engraver"
}

\relative c' {
	 	\clef treble
		\time 4/4
		<bes d g>1 \bar " "
		<d g bes>1 \bar " "
		<g bes d>1 \bar "||"
}
\addlyrics { \skip1 \skip1 Posição }
\addlyrics { \skip1 \skip1 fundamental }
>>

