\version "2.10.33"
\score
  \relative c' {
  \key c \minor
  \time 3/2

		c4. \p \< (d8 ees4. g8 c4. ees8) \!
 		ees2 (fis,4) r8 \setTextCresc g \< (c4. ees8)
		ees2 (aes,4) r8 a (c4. ees8)
		f2 (a,4) r8 bes (des4. f8)
		aes4. c,8 \! ees4. \< aes8 c4. ees,8 
		aes4. c8 ees4. aes,8 c4. ees8 \!
	%7	
		aes4-. \f r4 \! g-. \f r4 r2 \! 
		r1 s2
		<bes,,,-. ges'-.>4 \p r4 <a f'>4 r4 r2 \!
		r1 s2
		f''2 (des c)
		f2 ~ \times 2/3 {f4 \< e f \!} \times 2/3 {bes4 \> f des \!}
		f2 (des c)
		f2 ~ \times 2/3 {f4 \< e f \!} \times 2/3 {d'4 \> b f \!}	%15
		e1. \p 
		(f1.
		e1. 
		ees1. 
		d2) r2 r2
		r1 s2 
		r1 s2
	%22
		r2 r2 r8 aes, g b
		c \< d ees fis g b c d ees g b c \!
		ees-. \f ees,-. ees-. ees'-. ees ees, ees ees' ees ees, ees ees'
		ees ees, ees ees' ees ees, ees ees' \setTextCresc ees \< ees, ees ees'
		des des, des des' des des, des des' des des, des des'
	%27 
		c ees, ees c' c ees, ees c' c ees, ees c' 
		ces ees, ees ces' ces ees, ees ces' ces ees, ees ces' 
		<ces-. ees,>4 r8 g, bes4. ees8 g4. bes,8
		ees4. ges8 bes4. ees,8 ges4. bes8 
		ees4-. \f r4 d4-. r4 r4 r8 bes
	%32	
		ges'4-. r4 f-. r4 r2
		r1 s2
		r4 \! bes,-. \p (r4 ges-. r4 ees-.)
		r8 d d ees f2 \< \! ~ (f8 \> ges \!) ges f 
		r8 ees ees f ges2 \< \!~ (ges8 \> bes \!) bes aes
	%37	
		r4 ges \< (bes ees des ges) 
		f (ees des ees des ces) \!
		bes \f (ges) ees (ces) bes' (ges) 
		ees (ces) bes' \> \((f) ees (c)\) \!
		bes8-. \p (aes-.) aes-. d-. d-. ces-. ces-. f-. f-. d-. d-. aes'-.
	%42
		aes d, d ges ges ees ees bes' bes ges ges ees'
		ees4 (fes-.) (r des-. r bes-.)
		r ees-. (r ces-. r aes-.)
		r8  \! a \p a gis fis2 ~ (fis8 eis) eis fis
		r8 a a gis fis2 ~ (fis8 eis) eis fis
	%47
		r8 \! \setTextCresc cis'\< cis b a2 ~ a8 gis gis a \!		
		r8 \< cis cis b b a a gis gis a a gis \!
		gis-. \f a-. a-. gis-. gis a a gis gis a a gis
		gis a a gis gis a a gis gis a a gis
		gis a a gis gis a a gis \! gis \< a a gis
	%52
		gis a a gis gis a a gis gis a a bes \!
		<< {<bes bes,>2. d,,8 f f bes bes d} \\ \stemUp {d,4 \f} >> \stemNeutral
         	d'8 f f bes bes4. (ees,8)  aes4. (ees8)
		aes4. (d,8) g4. (ees8) ces4. (aes8)
		g4. (bes8) ges4. (bes8) f bes bes d
	%57		
		d f f bes bes4 d,,8 f f bes bes d 
		d f f bes bes4 ees4.-> (c8) aes4 ~
		(aes8 f) d'4. (bes8) g4. (ees8) c'4 ~
		(c8 aes) c4. (aes8) f4. (c8) aes4 ~ 
		(aes8 f) ees4 r2 r2
	%62
		r2 r2 \! c' \p 
		(bes2. a4 bes) ees
		(c bes2 a4 bes4) ees ~
		(ees8 d ees a,) ~ a bes (ees g ~ g \! fis \< g) d ~
		d ees (a c ~ c) a (bes ees ~ ees cis d) g ~ \!
	%67
		g e (f d ees \> c aes ees c aes ees c) \! 
		b \p (c d c ees aes c ees) d (ees f ees 
		bes' g aes f ges ees c a ges ees d c)
		bes (a gis a c ees ges c) bes (a gis a
		ees' g, ees g) f' (ees d ees g ees g, ees)
	%72
		f (ees d ees ees' g, ees) g (f' ees d ees 
		g ees g, ees) \! f \< (ees d ees bes'2) ~ \!
 		bes4 \> (aes g2 \! f2) 
		ees r2 r2 
		r1 s2
		r2 r2 bes'\< ~ 
		(bes4 \! \>  a g2 \! f)
	%79
		ees r2 r2 
		r1 s2
		r2 r g ~ 
		(g4 f ees2 d)
		r2 r aes' \p ~
		aes2. (b4 c2 ~ 
		c4 d e2. gis4
		a2. b4 c2) ~ \! \key c \major
	%84	
		c8 \p (a c a \repeat "tremolo" 2 {c8 a8} \repeat "tremolo" 2 {c8 a8)} 
	 	\repeat "tremolo" 2 {c8 a8} \repeat "tremolo" 2 {c8 a8} \repeat "tremolo" 2 {c8 a8)} 
		\repeat "tremolo" 2 {d8 (bes8)} \repeat "tremolo" 2 {bes8 (f8)} \repeat "tremolo" 2 {f8 (d8)}
		\repeat "tremolo" 2 {f8 (d8} \repeat "tremolo" 2 {e8 c8} \repeat "tremolo" 2 {d8 b8)}
		a4. \< (b8 c4. e8 a4. c8) \!
		\setTextCresc c2 \< (ees,4) r4 r2
	%90	       
		bes4. (c8 d4. f8 bes4. d8) 
		f2-. e-. <gis,-. b, e,> 
		<a-. c, e,>4 \! \f r e4. c8 a4 r4     
	    %adicionar o marc.
		a'4. b8 c4 r a,4. b8 
		c4 r4 r2 r2 
		<g'-. c, e,>4. e8 c2 << {<b f'>2} \\ \stemUp {d,4} >> \stemNeutral
	%96
		r e'4-. \p (r des-. r bes-.)
		r a'4-. (r f-. r e-.)
		r8 dis dis  \< e fis2 \! \> ~ (fis8 c) \! c  b
		r8 a a  \< b c2 \! \> ~ (c8 a) \! a  fis
		r2 b4. \f g8 e4 r4
	     %adicionar o marc.
	%101
		g'1  \f a2 
		b4 r r2 r
		d4. b8 g2 c
		r4 b4-. \p (r aes-. r f-.)
		r e'4-. (r c-. r b-.) 
		r8 ais ais  \< b cis2 \! \> ~ (cis8 g) \! g  fis
	%107		
		r8 e e  \< fis g2 \! \> ~ (g8 e) \! e  cis
		R1 *3/2
		r8 f f  \< g aes2 \! \> ~ (aes8 f) \! f  d
		R1 *3/2
	%111
		r8 fis fis  \< gis a2 \! \> ~ (a8 fis) \! fis  dis \key e \major
		R1 *3/2	
		a4. \p (\setTextCresc b8 \< cis4. e8 a4. cis8)
		r8 fis \f fis   gis a2 ~ (a8 fis)  fis  d 
	%115		
		r8 bis bis cis dis2   ~ (dis8 a)  a  gis 
		r8 fis fis gis a2   ~ (a8 fis)  fis  d
 		r8 bis bis cis dis2   ~ (dis8 a)  a  gis 
		r8 cis \f  cis bis r8 gis' gis fis fis d d cis
	%119 
	
}
