\header {
  objetivo = "tônica dominante tonica"
}
global = {
  \time 3/4
}
\score {
  <<
    \new Staff <<
      \global
      \relative c'' {
        c b c
      }
    >>
    \new Staff <<
      \global
      \relative c'' {
        g g g
      }
    >>
    \new Staff <<
      \global
      \relative c' {
        e d e
      }
    >>
    \new Staff <<
      \global
      \relative c' {
        c g c
      }
    >>
  >>
}
