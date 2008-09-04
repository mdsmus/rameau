\version "2.10.33"
global = { \key a \major \time 3/4 }
ana = { \partial 4*1 }

sop = \relative c'' { \clef treble 
	a4
	a2 gis4
	fis2 e4
	a4( b2)
	cis\fermata
}

cont = \relative c' { \clef treble
	e4
	fis2 e4
	d cis b
	e fis e
	e2
}


ten = \relative c' { \clef bass
	cis4
	cis2 cis4
	a2 gis4
	a2 gis4
	a2
}

bass = \relative c' { \clef bass
	a4
	fis2 cis4
	d2 d4
	cis d e
	a,2\fermata
}

\header {
	title = "Nun lob', mein' Seel', den Herren"
	composer = "J. S. Bach"
}

\new PianoStaff {
	<<
	\new Staff { \global << {\ana \sop} \\ {\ana \cont} >> }
	\new Staff { \global << {\ana \ten} \\ {\ana \bass} >> }
	>>
}