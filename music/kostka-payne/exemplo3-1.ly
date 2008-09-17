\version "2.10.0"
<<
\new Staff \with {
	\remove "Time_signature_engraver"
}

\relative c'' { 	\clef treble
			\time 8/4
			s4 s4 <g b dis>1 s4 s4
		\bar "||"
			s4 s4 <g b d>1 s4 s4
		\bar "||"
			s4 s4 <g bes d>1 s4 s4
		\bar "||"
			s4 s4 <g bes des>1 s4 s4
		\bar "||"
}
\addlyrics { "aumentada" "maior" "menor" "diminuta" }
\addlyrics { "( + )" "( M )" "( m )" "( ° )" }
>>

