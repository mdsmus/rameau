\version "2.10.0"

\header {

  texidoc = "Hairpins can have circled tips. A decrescendo del niente
followed by a crescendo al niente should only print one circle."

}

\layout { ragged-right = ##t } 

\relative c'' {
	\override Hairpin #'circled-tip = ##t
	c1\< d\! d\> c\! e\> c\< d\! \break
	c\< \break
	e d\! c\> \break
	e d\!
}

