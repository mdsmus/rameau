\version "2.10.0"
<<
\new Staff \with {
	\remove "Time_signature_engraver"
	\override Stem #'transparent = ##t
}

\relative c' { \clef treble
		\time 4/4
		\once \override TextScript #'extra-offset = #'( -8.0 . 3.0 )
		c^\markup{ Dó maior }\glissando
		\override TextScript #'extra-offset = #'( 0.0 . -2.0 )
		\hideNotes c''^\markup{ 1 }\glissando \unHideNotes
		d,,\glissando  \hideNotes d''^\markup{ 1 }\glissando  \unHideNotes \bar " "
		\once \override TextScript #'extra-offset = #'( -1.0 . -2.0 )
		e,,\glissando
			\hideNotes
				\once \override TextScript #'extra-offset = #'( -1.0 . -2.0 )
				e''^\markup{ \fontsize #-2 {"1/2"} }\glissando
			\unHideNotes
		f,,\glissando  \hideNotes f''^\markup{ 1 }\glissando  \unHideNotes  \bar " "
		g,,\glissando  \hideNotes g''^\markup{ 1 }\glissando  \unHideNotes
		a,,\glissando  \hideNotes a''^\markup{ 1 }\glissando  \unHideNotes  \bar " "
		b,,\glissando  
			\hideNotes
				\once \override TextScript #'extra-offset = #'( -1.0 . -2.0 )
				b''^\markup{ \fontsize #-2 {"1/2"} }\glissando
			\unHideNotes
		c,,
			\bar "||"



		\time 1/4
		s4 \bar " "
		\clef bass
		\time 2/2
		\once \override TextScript #'extra-offset = #'( -6.0 . 3.0 )
		\hideNotes
		e,,,^\markup{ Mi maior } e e e \bar " "
		e e e e  \bar " "
		e e e e  \bar " "
		e e e e  \bar " "
		\unHideNotes  \bar "||"
}
>>





