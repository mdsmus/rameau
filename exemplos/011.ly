\header {
  objetivo = "acorde de sexta alema"
}
\score {
  <<
    \new Staff {
      \relative c' {
        d4 dis e e
        e1
        \bar "|."
      }
    }
    \new Staff {
      \relative c' {
        d4 c c b
        c1
        \bar "|."
      }
    }
    \new Staff {
      \relative c' {
        \clef bass
        a4 a a gis
        a1
        \bar "|."
      }
    }
    \new Staff {
      \relative c {
        \clef bass
        f4 f e e
        a,1
        \bar "|."
      }
    }
  >>
}