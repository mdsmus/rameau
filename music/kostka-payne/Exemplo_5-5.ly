\version "2.10.0"
\header {
    title = "Old One Hundredth"
    subtitle = "Hino Protestante"
    composer = ""
}
global = { \time 4/4 
	\key g \major }

cima = { << 
		\relative c'' {
			\partial 4*1 g4
			g fis e d
			g a b\fermata b
			b b a g
			\partial 4*3 c b a\fermata
			}
	\\
		\relative c' {
			\partial 4*1 d4
			d d b b
			b d d d
			d g fis g
			\partial 4*3 g g fis
			}	>>
}


baixo = { \clef bass
	<<
		\relative c' {
			\partial 4*1 b4
			b a g fis
			g fis g g
			b d d b
			\partial 4*3 e d d
		}
	\\
	       \relative c {
			\partial 4*1 g'4
			g d e b
			e d g,\fermata g'
			g g d e
			\partial 4*3 c g d'\fermata
		}
	>>
}

\score {
	\context PianoStaff = "piano" <<
		\new Staff = "cima" { \global \cima }
		\new Staff = "baixo" { \global \baixo }
		>>
	\midi {
		\context {
			\Score tempoWholesPerMinute = #(ly:make-moment 60 4)
		}
	}
	\layout {
%		ragged-right = ##t 
		\context {
			\Staff
			\consists Horizontal_bracket_engraver
		}
	}
}

