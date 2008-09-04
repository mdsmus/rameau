\version "2.10.0"
<<
\new Staff \with {
	\remove "Time_signature_engraver"
	\override Stem #'transparent = ##t
}

\relative c' { \clef treble
%		\once \override TextScript #'extra-offset = #'( -0.0 . 3.0 )
		\time 8/1
		c1^\markup { \center-align { "Menor melódica" 1 } }
		d^\markup { 2 } ees^\markup { 3 } f^\markup { 4 }
		g^\markup { 5 } a^\markup { 6 } b^\markup { 7 } c^\markup { 1 }
		\bar " "
		\time 7/1
		 bes^\markup { 7 } aes^\markup { 6 } g^\markup { 5 }
		f^\markup { 4 }  ees^\markup { 3 } d^\markup { 2 }
		c1^\markup { 1 }
		\unHideNotes
		\bar "||"
}
>>


