
\version "2.10.0"

\header {
  texidoc = "Note heads are flipped on the stem to prevent collisions.
It also works for whole heads that have invisible stems.
"

}

\layout { ragged-right= ##t }

\relative c''
\context Voice {
  <g a c>4
  <c d g a>
  <c d e >
  <c c g>
  <c d f g>1
}

