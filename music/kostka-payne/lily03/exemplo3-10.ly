% \version "2.6.0"
 \version "2.10.0"
     melody = \relative c' {
	 	\clef treble
		\time 4/4
		\key g \major
		\partial 4 * 3 e fis g 
		c1 ~ 
		c4 d, e fis
		b2 b2 ~ 
	\break
		b4 c, d e
		a1 ~
		a4 b, cis dis
		g1
     }
     
     text = \lyricmode {
The fall ing leaves drift by the win dow the au tumn leaves, of red and gold
     }
     
     harmonies = \chordmode {
        \skip4 \skip2 a1:m7 d:7 g:7+ c:7+ fis:m7.5- b:7 e:m
     }
     
     \score {
        <<
           \context ChordNames {
              \set chordChanges = ##t
              \harmonies
           }
        \context Voice = one {
           \autoBeamOff
           \melody
        }
        \lyricsto "one" \new Lyrics \text
        >>
        \layout { }
        \midi { tempoWholesPerMinute = #(ly:make-moment 60 4)  }
     }
