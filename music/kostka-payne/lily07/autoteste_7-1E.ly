\new PianoStaff {
	<<
	\new Staff {
		\relative c'{
			\time 4/4
			\key g \major
			s1 s s
		}
	}
	\new Staff {
		\relative c{
			\time 4/4
			\key g \major
			\clef bass
			g'4 b e, a d, g c, d g2 r2
		}
	}
	>>
}