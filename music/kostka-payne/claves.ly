\version "2.10.0"
<<
\new Staff \with {
	\remove "Time_signature_engraver"
	\override Stem #'transparent = ##t
}
{
\clef treble
\once \override TextScript #'extra-offset = #'( -20.0 . 3.0 )
c'^\markup{ \column { \line {Nome Genérico} \line  {Nome Específico} } }

\fatText \once \override TextScript #'extra-offset = #'( -5.0 . 3.0 )
s4^\markup{ \column { \line {Clave de Sol} \line  {Clave de Soprano} } } s s  \bar" "
\clef bass

\fatText \once \override TextScript #'extra-offset = #'( -5.0 . 2.0 )
c'^\markup{ \column { \line {Clave de Fá} \line  {Clave de Baixo} } } s s s \bar " "
\clef alto

\fatText \once \override TextScript #'extra-offset = #'( -5.0 . 3.0 )
c'^\markup{ \column { \line {Clave de Dó} \line  {Clave de Contralto} } } s s s \bar " "
\clef tenor

\fatText \once \override TextScript #'extra-offset = #'( -5.0 . 3.0 )
c'^\markup{ \column { \line {Clave de Dó} \line  {Clave de Tenor} } } s s s \bar " "
}

\addlyrics { "C3" "C3" "C3" "C3" } 
>>


