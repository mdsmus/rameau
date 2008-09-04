\version "2.10.0"
<<
\new Staff \with {
	\remove "Time_signature_engraver"
	\override Stem #'transparent = ##t
}

\relative c' { \clef treble
		\time 8/4
		\once \override TextScript #'extra-offset = #'( -8.0 . 3.0 )
		c^\markup{ Dó menor natural }
		d
		\once \override TextScript #'extra-offset = #'( -1.4 . -6.7 )
		ees^\markup{ \fontsize #13 { \circle { " " } } }
		f g
		\once \override TextScript #'extra-offset = #'( -1.4 . -6.1 )
		aes^\markup{ \fontsize #13 { \circle { " " } } }
		\once \override TextScript #'extra-offset = #'( -1.4 . -4.7 )
		bes^\markup{ \fontsize #13 { \circle { " " } } }
		c \bar "||"
		\time 1/4
		s4 \bar " "
		\clef bass
		\time 8/4
		\once \override TextScript #'extra-offset = #'( -3.0 . 3.0 )
		\hideNotes
		 e,,,^\markup{ Lá menor harmônica } e e e e e e e
		\unHideNotes  \bar "||"
}
>>


