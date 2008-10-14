pizz = ^\markup{\italic{pizz.}}
arco = ^\markup{\italic{arco}}

violoncelo= { 
	\clef bass 		
	\relative c, {
	 	
		
			c8 \p c' c  c c2:8 c2:8
		c2:8 c2:8 \setTextCresc c2:8 \< 
		c2:8 c2:8 c2:8 
		c2:8 c2:8 bes2:8
		aes2:8 aes2:8 \< aes2:8 		
		ees2:8 ees2:8 ees2:8 \! 
	%7
		c4-. \f r \! g'4-. \f r \! r2
		R1 *3/2
		bes4-. \p r f'4-. r r2 \!
		R1 *3/2
		aes,1. \p
		bes1.
		aes1.
		g1.
	%15
		g2 ~ (g4. b8 c2)
		aes4. (c8 f2 aes,4) r
		g2 ~ (g4. b8 c2)
		fis,4. (b8 c2 fis,4) r
		g4. (a8 \setTextDim b2 \> ~ b4. cis8)
		d2 \> ~ d4. e8 \! fis2
		r2 fis r2		
	%22
		g, \< (ees d) \!
		c4. \< (d8 ees4. g8 c4. ees8) \!
 		ees2 \f (fis,4) r8 g (c4. ees8)
		ees2 (aes,4) r8 \setTextCresc a  \< (c4. ees8)
		f2 (a,4) r8 bes (des4. f8)
	%27		
		aes4. c8-. \sf aes4. ees8-. c4. aes'8-. \sf 
		ees4. ces8-. aes4. ees'8-. \sf ces4. aes8-.
		ees4-. r ees'1->
		ges,1.->
		ees4-. \f r4 bes'4-. r4 r2
	%32
		ees,4-. r4 bes'4-. r4 r2
		R1 *3/2
		R1 *3/2 
		\clef tenor bes''1 \p (d,2) 
		bes'2 (c, d) \clef bass
	%37
		ees ges, \< bes 
		des, f aes, \!
		bes \f ces des
		ees f \> f, \!
		bes4 \p (ces'-. r aes-. r f-.)	
	%42
		r bes-. (r ges-. r ees-.)
		r8 des-. des-. g-. g-. fes-. fes-. bes-. bes-. g g des' 
		des4 (ces-.) (r ees-. r ees-.) \clef tenor
		r8 fis \p  fis gis a2 ~ (a8 gis) gis a
		r8 fis fis gis a2 ~ (a8 gis) gis a 
	%47		
		r8 \setTextCresc a \< a a a gis gis a a2:8
		a2:8 \< a2:8 a2:8 \!
		R1 *3/2 \clef bass
		r4 f,,4 (a d cis f)
		e (a,) r f' \< (e a,)
	%52	       
		r f' (e a,) \! r2
		aes \f aes'1
		g2 g, f
		f' g aes 
		bes bes, bes'
	%57
		aes aes,2.. aes'8
		g4. g,8 c,4. c'8 f,4. f'8
	 	bes,4. bes8 ees,4. ees'8 aes,4. aes8
		f4 r8 aes' f4. (c8) aes4. (f8) 
		ces'4. ( \setTextDim f,8) \> ces'4. (f,8) ces'4. (f,8)	
	%62
		c'4. (f,8) \! c'4. (f,8) a4. \p (f8)
		bes4. (f8) c'4. (f,8) bes4. (ees,8)
		a4. (f8) c'4. (f,8) bes4. (ees,8)
		c'4. (f,8) bes4. (ees,8) c'4. \< (c,8)
		ees'4. (d,8) d'4. (g,8) g'4. \! (bes,8)			
	%67
		bes'2-. (c,-.) \p r2
		R1 *3/2
		d2-. (ees-.) r2
		R1 *3/2
		r2  c2-. \< (bes-.) \!
	%72
		a \< (bes) \! c-. \p
		(r2 bes-.) r2 
		bes1. 
		ees,4. \p  \< (f8 ges4. bes8 ees4. ges8) \!
		ges2 \> (a,4) \! r4 r2
	        bes2 \pizz r2 r2		 
	        bes2 r2 r2
	%79
		ees,4. \arco \< (f8 ges4. bes8 ees4. fis8) \!
	     	fis2 \> (fis,4) \! r4 r2
	        g2 \pizz r2 r2		 
	        g2 r2 r2
		fis'2 \p (fis,4) r4 r2
 		f'2 (f,4) r4 r2
		e'1 (c2 ~
		c2) aes1 \key c \major
	%84
		e1. \p 
		f
		d
		e
		e \< 
		\setTextCresc f4. \< (g8 a4. c8 f4. a8)
	%90
		d,,1.
		e4. fis8 gis4. b8 e4 r
		a,4-. \f r r2 r2
		c,1 d2
            %colocar o marc.
		e4 r f'4. e8 d2
		c4 r f'4. e8 d2
	%96		
		r2  c,,4 \pizz \p r4 e r
	   	r2 f4 r4 a4 r4
		b4 r4 r2 r2
		b4 r4 r2 r2 \arco
		e4. \f fis8 g4 r4 r2
	    %colocar o marc.
	%101
		e4. fis8 g4. e8 c4 r4
		b4. g8 e2 fis
		g4 r4 c'4. b8 a2
		r2  g,4 \pizz \p r4 b r
		r2  c4 r4 e r
		fis4 r4 r2 ais4 r4
	%107 
		fis4 r4 r2 r2 
		d,4. \arco \p \< (fis8 b4. d8 fis4. g8 \!)
		g2 \> (b,4 \!) r4 r2
		ees,4. \< g8 c4. ees8 g4. gis8 \! )
	%111
		gis2 \> (bis,4 \!) r4 r2  \key e \major
		e,4. \p ( \setTextCresc fis8 \< gis4. cis8 e4. gis8)
		cis,,1.
		d4. \f (e8 fis4. a8 d4. fis8)
	%115
		gis,1.	
		d4. (e8 fis4. a8 d4. fis8)
		gis,1.	
		fis4. \f gis8 a2 r2
	%119
	
		
		
	 
		
		
	
  
		
		
		
		
		 

  }
}
