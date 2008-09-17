\version "2.10.0"
cima = \relative c' {
	\time 2/4
	\key c \major
		<d g d'>8[ s8
		<d g d'>8 ] s8 \bar "||"
	}


baixo = \relative c {
	\clef bass
	\key c \major
	\time 4/4
		<bes g'>8[ s8
		<bes g'>8 ] s8
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
			\remove Time_signature_engraver
		}
	}
}

