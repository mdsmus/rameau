\version "2.10.0"
\header {
    title = "Kostka Workbook"
    subtitle = "Exercicio 7-1 G 2"
    composer = ""
}
cima = { <<
				\relative c'' {
					fis2 e4 e4 d2 d2 e2 cis4 cis4 d1
				 } \\
				 \relative c'' {
					b2 g fis g g fis2 fis1
				 }
			>> }

baixo = { <<
			\relative c' {
%				\skip1 \skip1 \skip1 \skip1
				d2 b b b cis ais b1
			 } \\
			\relative c {
				b2 e b g' cis, fis b,1
			 }
			>> }

Cima = { <<
				\relative c'' {
					fis2 e4 e4 d2 d2 e2 cis4 cis4 d1
				 } \\
				 \relative c' {
					fis8 a g a e fis g e fis2 g2 g8 e fis g a4 g4 fis1
				 }
			>>
	}


Baixo = { <<
			\relative c' {
				a2 cis2 d8 b cis a b cis b a g4 b4 a2 a1
			 } \\
			\relative c {
				d2 a'2 b2 g2 e2 a8 g fis e d1
			 }
			>> }


\score {
	\context PianoStaff = "piano" <<
		\new Staff = "cima" {
			\key d \major \time 2/2
			\cima
%			\Cima
		}
		\new Staff = "baixo" {
			\clef bass \key d \major \time 2/2
			\baixo 
%			\Baixo 
			\bar "|."
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