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
\relative c'' { 	\cadenzaOn 
			\key g \major
			\once \override TextScript #'extra-offset = #'( -7.0 . -02.0 )

g1_"G:" b d e, g b c a d b g d' c a fis g d b' g

\cadenzaOff  \bar "||"	
}
>>


