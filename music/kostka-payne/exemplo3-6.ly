\version "2.10.0"
cima = \relative c'' {
	\time 4/4
	\key c \major
		<a c f>1
		<f c' f>1
		<f c' f a>1
		<c' f'>1
	}


baixo = \relative c' {
	\clef bass
	\key c \major
	\time 4/4
		s1
		a1
		<a, f' c'> 1
		<a'>1
	}

\score {
	\context PianoStaff = "piano" <<
		\new Staff = "cima" { \cima }
		\new Staff = "baixo" { \baixo }
		>>
	\layout {
		ragged-right = ##t 
		\context {
			\Staff
			\consists Horizontal_bracket_engraver
		}
	}
}

