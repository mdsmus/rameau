\version "2.10.0"
<<
\new Staff \with {
	\remove "Time_signature_engraver"
	\override Stem #'transparent = ##t
}
\relative c' { \clef treble
		\key c \major
		\time 15/1
		c1 s d s e s f s g s a s
		\once \override TextScript #'extra-offset = #'( -2.0 . -3.5 )
		bes^\markup { "(      )" } s b! \bar "||"
}
\addlyrics{ tônica sobretônica mediante subdominante dominante submediante "(subtônica)" sensível }
>>


