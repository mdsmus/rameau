\version "2.10.0"
<<
\new Staff \with {
	\remove "Time_signature_engraver"
	defaultBarType = #" "
	}
\relative c' {	\cadenzaOn
			\once \override TextScript #'extra-offset = #'( -6.0 . -02.0 )

c1_"C:"  e g a f d f g b c g e b' f d c' g e c 
\cadenzaOff
\bar "||"	
}
>>


