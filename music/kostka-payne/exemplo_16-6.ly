\version "2.10.33"
sop = \relative c'' { \clef treble \key bes \major
	g2^"pobre" f \bar "||"
	g^"melhor" f  \bar "||"
	e d  \bar "||"
	g f  \bar "||"
	g f  \bar "||"
	g^"inusitado" f  \bar "||"
}

cont = \relative c' { \clef treble \key bes \major
	ees2 d
	ees d
	c bes
	ees d
	c d
	c d
}


ten = \relative c' { \clef bass \key bes \major
	c2 bes
	c d
	g, f
	a bes
	a bes
	a bes
}

bass = \relative c { \clef bass \key bes \major
	a2 bes
	a bes
	a bes
	c d
	ees d
	ees bes
}

\new PianoStaff { <<
	\new Staff { << { \sop } \\ { \cont } >> }
	\new Staff { << { \ten } \\ { \bass } >> }
	>> }