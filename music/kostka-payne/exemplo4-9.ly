\version "2.10.0"
<<
\new Staff \with {
	\remove "Time_signature_engraver"
	\override Stem #'transparent = ##t
}
\relative c' { \clef treble
		\time 14/1
		\key ees \major
		\override TextScript #'extra-offset = #'( 0.0 . 2.0 )
		<c ees g bes>1^\markup{ 1 }
		\once \override TextScript #'extra-offset = #'( 4.5 . -1.9 )
		\hideNotes e4_\markup { \small { "/"} } \unHideNotes
		<d f aes c>1^\markup{ 2 }
		\hideNotes e4 \unHideNotes
		<ees g bes d>1^\markup{ 3 }
		\hideNotes e4 \unHideNotes
		<f aes c ees>1^\markup{ 4 }
		\hideNotes e4 \unHideNotes
		<g b! d f>1^\markup{ 5 }
		\hideNotes e4 \unHideNotes
		<aes c e g>1^\markup{ 6 }
		\hideNotes a4 \unHideNotes
		<b! d f aes>1^\markup{ 7 }

		\bar "||"
}
\addlyrics { "i7" \skip4 "ii°" \skip4 "III7M" \skip4 "iv7" \skip4 "V7" \skip4 "VI7M" \skip4 "vii°7" \skip4 }
>>

