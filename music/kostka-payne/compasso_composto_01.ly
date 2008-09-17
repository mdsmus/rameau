\version "2.10.0"
<<
\new Staff \with {
	\remove "Clef_engraver"
	\remove "Staff_symbol_engraver"
}
\relative c' { \time 6/8
f8 f8 f8 f8 f8 f8 \bar " "
s4. s4. \bar " "
s4. s4. \bar " "
s4. s4. \bar " "
\time 3/8
\once \override TextScript #'extra-offset = #'( -13.0 . -4.0 )
f8^\markup { \center-align { "lento" "se torna"} } f8
\once \override TextScript #'extra-offset = #'( 2.0 . -3.0 )
f8^\markup { \large { "|" } } | f8 f8 f8 \bar " " 

}
\addlyrics { "1" \skip8  \skip8 "2"  \skip8  \skip8 "1" "2" "3" "1" "2" "3"}
>>

