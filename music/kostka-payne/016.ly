\version "2.10.33"

sop = \relative c'' { \time 2/2 
	c1( d f e)
}

cont = \relative c' { \time 2/2
	e8 c' e, c' e, c' e, c'
	f, c' f, c' f, c' f, c'
	g b g b g b g b
	a c a c a c a c
}

\new ChoirStaff { <<
	\new Staff { \sop }
	\new Staff { \cont }

>> }