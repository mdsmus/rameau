\header {
  objetivo = "dominante secundária"
}
\score {
  <<
    \new Staff {
      \relative c'' {
        \time 4/4
        c c b c
      }
    }
    \new Staff {
      \relative c'' {
        \time 4/4
        g a g g
      }
    }
    \new Staff {
      \relative c' {
        \time 4/4
        e fis f e
      }
    }
    \new Staff {
      \relative c' {
        \time 4/4
        c d g c,
      }
    }
  >>
}