\version "2.10.0"
<<
\new Staff \with {
	\remove "Time_signature_engraver"
}
\relative c { 	\clef bass
		\key f \major
		\time 19/1
		\once \override TextScript #'extra-offset = #'( -8.0 . -2.0 )
		d1_\markup{ "d:" }
		f g a e cis d f c! f bes, f' a, cis e g f e d
		\bar "||"
}
>>
