\version "2.10.0"
<<
\new Staff \with {
	\remove "Time_signature_engraver"
	\override Stem #'transparent = ##t
}
\relative c'' { 
	\clef treble
	g s a s \bar " "
	b s c s \bar " "
	d s e s \bar " "
	fis s g s \bar "||"
}
>>


