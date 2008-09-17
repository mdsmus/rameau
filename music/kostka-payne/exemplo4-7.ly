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
		<c ees g>1^\markup{ 1 }
		<d f aes>1^\markup{ 2 }
		<d f a!>1^\markup{ 2 }
		<ees g bes>1^\markup{ 3 }
		<ees g b!>1^\markup{ 3 }
		<f aes c>1^\markup{ 4 }
		<f a! c>1^\markup{ 4 }
		<g bes d>1^\markup{ 5 }
		<g b! d>1^\markup{ 5 }
		<aes c e>1^\markup{ 6 }
		<a! c e>1^\markup{ 6 }
		<bes d f>1^\markup{ 7 }
		<b d f>1^\markup{ 7 }

		\bar "||"
}
\addlyrics { "i" "ii°" "ii" "III" "III+" "iv" "IV" "v" "V" "VI" "vi°" "VII" "vii°" }
>>

