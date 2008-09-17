\version "2.10.0"
\relative c'' { 
		\clef treble
		\time 2/4
		\key g \major
		\once \override TextScript #'extra-offset = #'( -8.0 . 3.0 )
		b8^\markup{ "Jingle Bells" }
		b b4 b8 b8 b4 b8 d8 g,8. a16 b2
}
