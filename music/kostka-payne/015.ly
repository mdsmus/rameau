\version "2.12.0"

sop = \relative c'' { \clef treble \key f \major
	f2 f4 e? \bar "||"
	f2 e?  \bar "||"
	f2 e?  \bar "||"
	f2 e?  \bar "||"
	f,2 e?  \bar "||"
	d2 c  \bar "||"
}

cont = \relative c'' { \clef treble \key f \major
	bes2 a4 g
	g2 g
	<g bes>2 <g bes>
	<g d'>2 <g c>
	bes,2 bes
	bes2 bes
}


ten = \relative c' { \clef bass \key f \major
	d2 c
	d2 c
	s2 s2
	s2 s2
	g2 g
	g2 g
}

bass = \relative c' { \clef bass \key f \major
	g2 c
	bes2 c
	g g
	bes bes
	d, c
	f e?
}

\new PianoStaff { <<
	\new Staff { << { \sop } \\ { \cont } >> }
	\new Staff { << { \ten } \\ { \bass } >> }
	>> }