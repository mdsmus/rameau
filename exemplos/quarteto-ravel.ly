\header {
  title = "Quarteto em Fá maior"
  subtitle = "fragmento"
  composer = "Maurice Ravel"
  objetivo = "testar notação simplificada: sem articulação, dinâmica, etc."
}
\score {
  <<
    \new Staff {
      \relative c''' {
        \key f \major
        a4 g8 a e4 d
        a8 f c' e d2
        f4 e8 a g4 f8 e
        d a' c2.
      }
    }
    \new Staff {
      \relative c' {
        \key f \major
        a4 bes c d
        e f g a
        bes c d e
        f g d8 a' g4
      }
    }
    \new Staff {
      \relative c {
        \clef alto
        \key f \major
        c2 g'4 f
        bes1
        d2 f4 bes
        bes1
      }
    }
    \new Staff {
      \relative c, {
        \clef bass
        \key f \major
        f4 g a bes
        c d e f
        g a bes c
        d e f e
      }
    }
  >>
}