\version "2.10.33"
global = { \key d \major \time 4/2 }
ana = { \partial 2*1 }
Ana = { \partial 2*3 }

letra = \lyricmode { Ach lie -- ber Her -- re Je -- su Christ, weil du ein Kind ge -- we -- sen bist, so gib auch die -- sem Kin -- de -- lein dein Gnad und auch den Se -- gen dein; ach Je -- sus, Her -- re mein, be -- hüt dies Kin -- de -- lein. } 


sop = \relative c'' { \clef treble 
	d2
	cis b cis d
	b a a d
	cis b fis a
	g fis fis e
	fis g g fis
	e d d a'
	a b cis d
	a fis fis e
	g fis d( fis
	g) fis fis e
	g fis d( fis
	\Ana g) fis fis 
}

cont = \relative c'' { \clef treble
	b2
	a g a a
	g e e fis 
	fis d cis fis
	d d d cis
	d d d d 
	b b b cis
	e g g a
	e d d cis
	d cis b( cis
	d) d d cis
	e cis b( cis
	\Ana d) d d
}


ten = \relative c' { \clef "G_8"
	b2 
	e d e fis
	d cis cis a
	a b cis cis
	b a a a 
	a b b a
	g fis fis a
	cis d e fis
	e a, a a 
	b cis d( cis
	b) a a a 
	b a d( cis 
	\Ana b) a a
}

bass = \relative c' { \clef bass
	g2
	a b a fis
	g a a d,
	fis g a fis
	g d d a'
	d, g b, d
	e b b a
	a' g e d
	cis d d a'
	g a b( a
	g) d d a'
	e fis b( a
	\Ana g) d d
}

\header {
	title = "Ach lieber Herre Jesu Christ"
	composer = "Brahms"
}

\new ChoirStaff {
	<<
	\new Staff { \global \ana \sop \bar "|." }
	\addlyrics { \letra }
	\new Staff { \global \ana \cont }
	\new Staff { \global \ana \ten }
	\addlyrics { \letra }
	\new Staff { \global \ana \bass }
	>>
}