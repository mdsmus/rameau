\version "2.12.0"
global = { \key g \major \time 4/4 }

sop = \relative c'' { \clef treble 
	b2 c
	d c
	b a
	b1\fermata
	d2 d
	e d
	c b
	a1\fermata
}

cont = \relative c'' { \clef treble
	g2 fis
	g fis
	g g4( fis)
	g1
	g2 g
	g g
	fis g
	fis1
}


ten = \relative c' { \clef bass
	d2 c
	b c
	d e4( d)
	d1
	b2 d
	c d
	d d
	d1
}

bass = \relative c' { \clef bass
	g2 a
	b a
	g c4( d)
	g,1\fermata
	g2 b
	c b
	a g
	d1\fermata
}

\header {
	title = "Chorale"
	subtitle = "Op. 68, N°4"
	composer = "Schumann"
}

\new PianoStaff {
	<<
	\new Staff { \global << {\sop} \\ {\cont} >> }
	\new Staff { \global << {\ten} \\ {\bass} >> }
	>>
}