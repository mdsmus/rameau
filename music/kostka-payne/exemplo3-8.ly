\version "2.10.0"
cima = \relative c'' {
	\time 3/4
	\key d \major
	}


baixo = \relative c {
	\clef bass
	\key d \major
	\time 3/4
	d8. e16 fis8.[ fis,16 fis8. fis16]
	g4 r8 g'8 g8. g16
	fis4 r8 fis8 fis8. fis16
	e4 r8 e8 e8. e16
	d4
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

