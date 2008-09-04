\version "2.10.0"
\header {
    title = "Kostka Workbook"
    subtitle = "Exercicio 7-1 G 1"
    composer = ""
}
cima = {
	\time 3/4
	\key g \major
			{ <<
				\relative c'' {
				g2 a4 b2 b4 c4 a2 g2.
				 } \\
				 \relative c' {
				d2 fis4 g2 g4 e2 fis4 g2.
				 }
			>> }
	}


baixo = {
	\clef bass
	\key g \major
	\time 3/4
			{ <<
			\relative c' {
%			\skip2. \skip2. \skip2. \skip2.
			b2 a4 g2 g4 a4 c2 b2.
			 } \\
			\relative c' {
			g2 d4 g2 e4 a2 d,4 g2. \bar "|."
			 }
			>> }
	}



cimA = {
	\time 3/4
	\key g \major
			{ <<
				\relative c'' {
				g2 a4 b2 b4 c4 a2 g2.
				 } \\
				 \relative c' {
				d8 e fis g fis e d2 g4 e2 fis4 g2.
				 }
			>> }
	}


baixO = {
	\clef bass
	\key g \major
	\time 3/4
			{ <<
			\relative c' {
			b2 a4 g8 a b c b g a4 c2 b2.
			 } \\
			\relative c' {
			g2 d4 g2 e4 a8 g fis e d4 g2. \bar "|."
			 }
			>> }
	}


\score {
	\context PianoStaff = "piano" <<
		\new Staff = "cima" { \cima 
								\cimA 
								}
		\new Staff = "baixo" { \baixo 
								\baixO 
								}
		>>
	\midi {
		\context {
			\Score tempoWholesPerMinute = #(ly:make-moment 100 4)
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