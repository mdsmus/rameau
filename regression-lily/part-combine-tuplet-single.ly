
\header {
  texidoc = "Tuplets in combined parts only print one bracket."
  }

\paper { ragged-right = ##T }

\version "2.10.10"

\score {
  <<
    \new Staff {
      \partcombine
      \relative c'' {
        \times 2/3 { d4 d d ~ } d2
      }
      \relative c'' {
        \times 2/3 { b4 a g ~ } g2
      }
    }
  >>
}
