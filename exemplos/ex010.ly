\header {
  objetivo = "dominante secundária"
}
\score {
  <<
    \new Staff {
      \relative c'' {
        \time 3/4
        c d d c c b c
      }
    }
    \new Staff {
      \relative c'' {
        \time 3/4
        g a b c a g g
      }
    }
    \new Staff {
      \relative c' {
        \time 3/4
        e f g e fis f e
      }
    }
    \new Staff {
      \relative c' {
        \time 3/4
        c b e a, d g, c
      }
    }
  >>
}