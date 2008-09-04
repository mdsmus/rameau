\version "2.10.0"
\paper{
  indent=0\mm
  line-width=120\mm
  oddFooterMarkup=##f
  oddHeaderMarkup=##f
  bookTitleMarkup = ##f
  scoreTitleMarkup = ##f
}
<<
\new Staff \with {
	\remove "Time_signature_engraver"
	defaultBarType = #" "
	}
\relative c { 	\cadenzaOn 
			\key f \major
			\clef bass
			\once \override TextScript #'extra-offset = #'( -8.0 . -02.0 )

d1_"d:" f g a e cis d f c f bes, f' a, cis e g f e d

\cadenzaOff  \bar "||"	
}
>>


