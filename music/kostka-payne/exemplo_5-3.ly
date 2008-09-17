\version "2.10.33"
global = { \key c \major \time 4/4 }

sop = \relative c'' { \clef treble
	\fatText
	a2^"bom" s \bar "||"
	f^\markup{ \center-align { "não, exceto se" "houver cruzamento" } } s \bar "||"
	g e^"bom" \bar "||"
	g e^"não" \bar "||"
	g e^"não" \bar "||"
}

cont = \relative c' { \clef treble
	f2 s
	a s
	d, c
	d s
	d c
}

ten = \relative c' { \clef bass
	c2 s
	c s
	b c
	b s
	b s
}

bass = \relative c { \clef bass
	f2 s
	f s
	g c,
	g' c,
	g' c,
}

\header {
	title = "Exemplo 5-3"
}

\new PianoStaff {
	<<
	\new Staff { \global << {\sop} \\ {\cont} >> }
	\new Staff { \global << {\ten} \\ {\bass} >> }
	>>
}
