\version "2.10.0"
<<
\new Staff \with {
	\remove "Time_signature_engraver"
}

\relative c'' { 	\clef treble
			\time 12/4
			\hideNotes
				c8 b c d c8 b c d
			\unHideNotes
			\once \override TextScript #'extra-offset = #'( -0.0 . -5.7 )
			<a c ees g>1_\markup { \small { "/"} }
			\hideNotes
				c8 b c d c8 b c d
			\unHideNotes
		\bar "||"
			\hideNotes
				c8 b c d c8 b c d
			\unHideNotes
			<a c ees ges>1
			\hideNotes
				c8 b c d c8 b c d
			\unHideNotes
		\bar "||"
}
\addlyrics {  \set stanza =  "Tipo de acorde: "  \skip8 \skip8 \skip8 \skip8 \skip8 \skip8 \skip8 \skip8 "meio diminuto" \skip8 \skip8 \skip8 \skip8 \skip8 \skip8 \skip8 \skip8  \skip8 \skip8 \skip8 \skip8 \skip8 \skip8 \skip8 \skip8 "diminuto com sétima" \skip8 \skip8 \skip8 \skip8  \skip8 \skip8 \skip8 \skip8 }

\addlyrics {  \set stanza = " Símbolo: "   \skip8 \skip8 \skip8 \skip8 \skip8 \skip8 \skip8 \skip8 "°7"  \skip8 \skip8 \skip8 \skip8  \skip8 \skip8 \skip8 \skip8 \skip8 \skip8 \skip8 \skip8  \skip8 \skip8 \skip8 \skip8 "°7"  \skip8 \skip8 \skip8 \skip8  \skip8 \skip8 \skip8 \skip8 }

\addlyrics {  \set stanza = " Construção: "   \skip8 \skip8 \skip8 \skip8 \skip8 \skip8 \skip8 \skip8 "tríade diminuta"  \skip8 \skip8 \skip8 \skip8 \skip8 \skip8 \skip8  \skip8  \skip8 \skip8 \skip8 \skip8  \skip8 \skip8 \skip8 \skip8 "tríade diminuta"  \skip8 \skip8 \skip8 \skip8  \skip8 \skip8 \skip8 \skip8 }

\addlyrics {   \skip8 \skip8 \skip8 \skip8 \skip8 \skip8 \skip8 \skip8 " sétima menor"  \skip8 \skip8 \skip8 \skip8  \skip8 \skip8 \skip8 \skip8 \skip8 \skip8 \skip8 \skip8  \skip8 \skip8 \skip8 \skip8 "sétima diminuta"  \skip8 \skip8 \skip8 \skip8  \skip8 \skip8 \skip8 \skip8 }
>>





