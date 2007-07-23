\header {
  objetivo = "tônica dominante com 7 tônica com inversões"
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
        e f e
      }
    >>
    \new Staff <<
      \global
      \relative c' {
        e d c
      }
    >>
  >>
}
