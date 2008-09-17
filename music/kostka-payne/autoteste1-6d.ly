\version "2.10.0"
<<
\new Staff \with {
	\remove "Time_signature_engraver"
}
\relative c'' { \clef treble
		\key c \major
		\time 4/4
			e2 ~ e8
		\once \override TextScript #'extra-offset = #'( -2.0 . 3.0 )
			cis4^\markup { 1 }
		\once \override TextScript #'extra-offset = #'( -2.0 . 3.0 )
			cis8^\markup { 2 }
		\once \override TextScript #'extra-offset = #'( -3.0 . 1.5 )
			a'2^\markup { 3 } ~ a8
		\once \override TextScript #'extra-offset = #'( -2.0 . 3.0 )
			a,^\markup { 4 }
		\once \override TextScript #'extra-offset = #'( -3.0 . 3.0 )
			cis8.^\markup { 5 }
		\once \override TextScript #'extra-offset = #'( -3.0 . 2.6 )
			fis16^\markup { 6 } 
		\once \override TextScript #'extra-offset = #'( -2.0 . 1.5 )
			a4^\markup { 7 } ~ a8 r8 r2
		\once \override TextScript #'extra-offset = #'( -2.0 . 3.0 )
			 r8^\markup { 8 } r16 dis,16
		\once \override TextScript #'extra-offset = #'( -2.0 . 3.0 )
			e8^\markup { 9 }
		\once \override TextScript #'extra-offset = #'( -3.0 . 3.0 )
			ees8^\markup { 10 }
		\once \override TextScript #'extra-offset = #'( -3.0 . 1.5 )
			d8^\markup { 11 }
		\once \override TextScript #'extra-offset = #'( -2.0 . 3.0 )
			ees,8^\markup { 12 } r4
		\bar "||"
}
>>


