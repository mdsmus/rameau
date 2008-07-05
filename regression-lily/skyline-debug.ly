\header {
  texidoc = "@code{-ddebug-skyline} draws the outline of the skyline used."
  }
\version "2.11.10"

#(set-default-paper-size "a6" )

\header {
  tagline = ##f
}

#(ly:set-option 'debug-skylines #t)
\book {
  \score {
    {
      a,,1 | a'4 b' c'' d'' \break
      \repeat unfold 2 {a' b' c'' d''} | b''''1
    }
  }
}
