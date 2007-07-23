\header {
  objetivo = "tônica diminuto com setima tônica"
}
global = {
  \time 3/4
}
\score {
  <<
    \new Staff <<
      \global
      \relative c'' {
        c d c
      }
    >>
    \new Staff <<
      \global
      \relative c'' {
        g aes g
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
        c b c
      }
    >>
  >>
}
