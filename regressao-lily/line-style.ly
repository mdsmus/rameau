\header {
  texidoc = "Cover all line styles available"
  
}
\version "2.11.13"
\paper {
  ragged-right = ##T
}

\relative c'' {
  \override Glissando #'breakable = ##t

  s2
  d2 \glissando d'2
  \once \override Glissando #'dash-fraction = #0.5
  d,2 \glissando d'2
  \override Glissando #'style = #'dotted-line
  d,2 \glissando d'2

  \override Glissando #'style = #'zigzag
  d,2 \glissando d'2
  \override Glissando #'style = #'trill
  d,2 \glissando d'2
}
