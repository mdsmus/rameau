\version "2.10.0"
\header {
    title = "Kostka Exemplo 7-1"
    subtitle = ""
    composer = ""
}
cima = {
	\time 3/4
	\key g \major
			\relative c' {
				<d g b>2
				<d a' d>4
				<d g b>
				<c fis a>
				<b d g>
				<g c e>
				<c e a>
				<c d fis>
				<b d g>2.
				\bar "|."
			}
	}


baixo = {
	\clef bass
	\key g \major
	\time 3/4
	       \relative c {
				g2 fis4
				g a b
				c a d
				g2.
				\bar "|."
			}
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

