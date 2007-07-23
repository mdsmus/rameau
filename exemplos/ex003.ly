\header {
  file = "ex003.ly"
  objetivo = "tonica dominante tonica com inversoes"
}
\score {
  <<
    \new Staff {
      \relative c'' {
        \time 3/4
        e d c
      }
    }
    \new Staff {
      \relative c'' {
        \time 3/4
        c b c
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
        c d e
      }
    }
  >>
}