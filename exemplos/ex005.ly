\header {
  objetivo = "tônica dominante com 7 tônica"
}
\score {
  <<
    \new Staff {
      \relative c'' {
        \time 3/4
        c b c
      }
    }
    \new Staff {
      \relative c'' {
        \time 3/4
        g f e
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
        c g c
      }
    }
  >>
}