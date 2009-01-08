\version "2.12.0"
\header {
  title = "Unsere Vater hofften auf dich, Op 109"
  composer = "Brahms"
}
sopA = \relative c' { \clef treble \key f \major
	r1
	r4 f g a
	d1
	c1
}

contA = \relative c' { \clef treble \key f \major
	r2 r4 f
	c'2 c
	r4 f,4 g2
	a1
}


tenA = \relative c' { \clef bass \key f \major
	c1
	c4 r r a
	bes2 g4 g'
	c,1
}

bassA = \relative c { \clef bass \key f \major
	f4. e8 d2
	f2 c4 c
	d2 bes
	f'1
}

sopB = \relative c'' { \clef treble \key f \major
	r1
	r2 r4 c4
	c2 bes2
	a1
}

contB = \relative c' { \clef treble \key f \major
	r4 c c2
	c4. d8 e4 f
	r4 d4 e2
	f1
}


tenB = \relative c' { \clef bass \key f \major
	g2 f4 bes
	a2 g4 f
	f2 bes
	c1
}

bassB = \relative c { \clef bass \key f \major
	c1
	c2. f,4
	bes1
	f1 \bar "||"
}


<<
\new PianoStaff { <<
        \set Score.currentBarNumber = #48
        \bar ""
	\new Staff { << { \sopA } \\ { \contA } >> }
	\new Staff { << { \tenA } \\ { \bassA } >> }
	>> }

\new PianoStaff { <<
	\new Staff { << { \sopB } \\ { \contB } >> }
	\new Staff { << { \tenB } \\ { \bassB } >> }
	>> }
>>

