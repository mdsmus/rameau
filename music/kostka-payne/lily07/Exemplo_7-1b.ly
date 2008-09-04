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
				<e g c>2
				<e g b>4
				<fis a d>
				<g c e>
				<a c e>
				<g b e>
				<g c e>
				<a c fis>
				<a c e>2.
				\bar "|."
			}
	}


baixo = {
	\clef bass
	\key g \major
	\time 3/4
	       \relative c {
				c2 e4 d c a e' c a a2.
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

