\header {
  objetivo = "tônica dominante com 7 tônica"
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
        g f e
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
