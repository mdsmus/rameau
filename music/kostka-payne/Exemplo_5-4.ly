\version "2.10.0"
\header {
    title = "Espaçamento"
    subtitle = ""
    composer = ""
}
global = { \time 4/4 
	\key c \major }

cima = { << 
		\relative c'' {
			d1 \bar "||"
			<b d> \bar "||"
			<g d'> \bar "||"
			<g b d> \bar "||"
			d \bar "||"
			}
	\\
		\relative c'' {
			g1 d d d s1
			}	>>
}


baixo = { \clef bass
	<<
		\relative c' {
			b1 g b s1 g
		}
	\\
	       \relative c {
			<g d>1
			g
			g
			g
			<g b d>
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

