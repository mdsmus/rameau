\header {
  texidoc = "Rests under beams moved by whole staff spaces."
}

\layout {
  ragged-right = ##t
}

\version "2.10.0"

fig =   \relative c' {
  <a c e>8[
    r <c e a> r <e a c> r <a c e>]
    r |
}

\relative c' \new Staff {
  \transpose c c,  \fig
}
