\version "2.10.0"
<<
\new Staff \with {
	\remove "Time_signature_engraver"
}
\relative c' { \clef treble
		\time 19/1
		\once \override TextScript #'extra-offset = #'( -6.0 . -2.0 )
		c1_\markup{ "C:" }
		e g a f d f g b c g e b' f d c' g e c
		\bar "||"
}
>>
