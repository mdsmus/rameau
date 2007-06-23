\header {
  objetivo = "tônica dominante tônica com inversão"
}
\score {
  <<
    \new Staff {
      \relative c'' {
        \time 3/4
        c g c
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
        e d e
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