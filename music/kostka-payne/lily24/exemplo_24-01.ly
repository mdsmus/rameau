\new ChoirStaff {
	<<
	\new Staff \relative c''{
		\time 6/4
		\key bes \major
		r2. c2 cis4
		d2 bes4 d2( c!4)
		\partial 4*5 bes2.\> ~ bes2\!
		\bar "|."
	}
	\addlyrics { bitt für uns, Ma- ri- a! }
	
	\new Staff \relative c''{
		\key bes \major
		r2. g2 ges4
		f2 d4 a'!2.
		f4\> ( g e f2\! )
	}
	
	\new Staff \relative c'{
		\key bes \major
		\clef "G_8"
		r2. bes2 bes4 bes( d) f f2( ees4)
		d\> ( f c d2\!)
	}
	\addlyrics { bitt für uns, Ma- ri- a! }
	\new Staff \relative c{
		\clef bass \key bes \major
		r2. ees2 e4
		f2 f4 f2.
		bes2.\> ~ bes2\!
	}
	>>
}