\header {
  file = "ex006.ly"
  objetivo = "tônica dominante com 7 tônica com inversões"
}
\score {
  <<
    \new Staff {
      \relative c'' {
        \time 3/4
        c d c
      }
    }
    \new Staff {
      \relative c'' {
        \time 3/4
        g g g
      }
    }
    \new Staff {
      \relative c' {
        \time 3/4
        e f e
      }
    }
    \new Staff {
      \relative c' {
        \time 3/4
        c b c
      }
    }
  >>
}