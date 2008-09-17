\version "2.10.0"
<<
\new Staff \with {
	\remove "Time_signature_engraver"
	\override Stem #'transparent = ##t
}
{
\time 3/4
\clef treble
\fatText \override TextScript #'extra-offset = #'( 0.0 . -2.0 )
f'_\markup{ fá3 }
\hideNotes
f'_\markup{ si4 }
f'_\markup{ lá3 }
\unHideNotes
\bar " "

\clef bass
\fatText
\hideNotes
a,_\markup{ lá2 }
a,_\markup{ sol2 }
a,_\markup{ ré4 }
\unHideNotes
\bar " "

\clef alto
\fatText
\hideNotes
g_\markup{ dó3 }
g_\markup{ sol2 }
g_\markup{ si3 }
\unHideNotes
\bar " "

\clef tenor
\fatText
\hideNotes
e_\markup{ dó3 }
e_\markup{ ré2 }
e_\markup{ fá3 }
\unHideNotes
\bar "| | "

}
>>


