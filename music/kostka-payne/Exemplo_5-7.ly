\version "2.10.0"
\header {
    title = "Gott, der du selber bist das Licht"
    subtitle = ""
    composer = "Bach"
}
global = { \time 4/4 
	\key bes \major }

cima = { << 
		\relative c'' {
			\partial 4*1 d4
			c bes a g
			\partial 4*3 a2 bes4			}
	\\
		\relative c'' {
			\partial 4*1 bes4
			a d,8 e fis4 g
			\partial 4*3 g4 fis! d			}	>>
}


baixo = { \clef bass
	<<
		\relative c'' {
			\partial 4*1 g4 ~
			g8 fis g4 d8 c bes4
			\partial 4*3 ees8 c a d16 c bes4		}
	\\
	       \relative c {
			\partial 4*1 g4
			a bes8 c d4 ees8 d
			\partial 4*3 c4 d g,		}
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

