\version "2.10.0"
<<
\new Staff \with {
	\remove "Time_signature_engraver"
}
\relative c'' { 	\clef treble
			\time 8/4
			\hideNotes
				c8 b c d
			\unHideNotes
			<a cis e gis>1
			\hideNotes
				c8 b c d
			\unHideNotes
		\bar "||"
			\hideNotes
				c8 b c d
			\unHideNotes
			<a cis e g>1
			\hideNotes
				c8 b c d
			\unHideNotes
		\bar "||"
			\hideNotes
				c8 b c d
			\unHideNotes
			<a c e gis>1
			\hideNotes
				c8 b c d
			\unHideNotes
		\bar "||"
}
\addlyrics {  \set stanza =  "Tipo de acorde: "  \skip8 \skip8 \skip8 \skip8 "maior com sétima maior"  \skip8 \skip8 \skip8 \skip8  \skip8 \skip8 \skip8 \skip8 "maior com sétima menor"  \skip8 \skip8 \skip8 \skip8 \skip8  \skip8 \skip8 \skip8  "menor com sétima menor"  \skip8 \skip8  \skip8 \skip8 }

\addlyrics {  \set stanza = " Símbolo: "  \skip8 \skip8 \skip8 \skip8  "7M"   \skip8 \skip8 \skip8 \skip8  \skip8 \skip8 \skip8 \skip8 "7"  \skip8 \skip8 \skip8 \skip8   \skip8 \skip8 \skip8 \skip8 "m7"  \skip8 \skip8 \skip8 \skip8 }

\addlyrics {  \set stanza = " Construção: "  \skip8 \skip8 \skip8 \skip8 "tríade maior"  \skip8 \skip8 \skip8 \skip8  \skip8 \skip8 \skip8 \skip8 "tríade maior" \skip8 \skip8 \skip8 \skip8  \skip8 \skip8 \skip8 \skip8 "tríade menor"  \skip8 \skip8 \skip8 \skip8 }

\addlyrics { \skip8 \skip8 \skip8  \skip8 "sétima maior "  \skip8 \skip8 \skip8 \skip8 \skip8  \skip8 \skip8 \skip8 "sétima menor"   \skip8 \skip8  \skip8 \skip8 \skip8 \skip8 \skip8 \skip8 "sétima menor"  \skip8 \skip8 \skip8 \skip8  \skip8 \skip8 \skip8 \skip8  "tríade menor"  \skip8 \skip8 \skip8 \skip8  }
>>





