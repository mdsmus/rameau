\version "2.10.0"
<<
\new Staff \with {
	\remove "Time_signature_engraver"
	\override Stem #'transparent = ##t
}

\relative c' { \clef treble
		\time 8/1
		c1^\markup { \center-align { "Menor harmônica" 1 } }
		d^\markup { 2 } ees^\markup { 3 } f^\markup { 4 }
		g^\markup { 5 } aes^\markup { 6 } b^\markup { 7 } c^\markup { 1 }
		\unHideNotes
		\bar "||"
}
>>


