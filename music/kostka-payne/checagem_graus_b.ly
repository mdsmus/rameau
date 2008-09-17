\version "2.10.0"
<<
\new Staff \with {
	\remove "Time_signature_engraver"
}
\relative c'' { \clef treble
		\key g \major
		\time 19/1
		\once \override TextScript #'extra-offset = #'( -8.0 . -4.0 )
		g1_\markup{ "G:" }
		b d e, g b c a d, b' g d' c a fis g d b' g
		\bar "||"
}
>>
