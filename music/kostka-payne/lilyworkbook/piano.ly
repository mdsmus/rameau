\version "2.10.0"
\header {
    title = ""
    subtitle = ""
    composer = ""
}
global = { \time 4/4 
	\key c \major }

cima = { << 
		\relative c'' {			}
	\\
		\relative c' {
			}	>>
}


baixo = { \clef bass
	<<
		\relative c' {		}
	\\
	       \relative c {
		}
	>>
}

\score {
	\context PianoStaff = "piano" <<
		\new Staff = "cima" { \cima }
		\new Staff = "baixo" { \baixo }
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

