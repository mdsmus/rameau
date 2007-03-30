\header{
  title = "Choral 04"
  composer = "J.S. Bach"}

\relative c'{
  \new StaffGroup <<
    <<
     % "soprano"
      \new Staff{
        \clef soprano
        \partial 4
        \relative c''{
          c
          c a8 b c d e4
          d8 e16 f d4 c4^\fermata c
          b a8 b c4 d8 c
          b2 a4^\fermata d
          e e b8 c d4
          c c b^\fermata c
          d a8 b c4 b
          a16 b c8 a4 g^\fermata c
          b a8 b c4 d8 c
          b2 a4^\fermata
        \bar "|."
      }}

     % "Contralto"
      \new Staff{
        \clef alto
        \partial 4
        e8 f
        g4 f g g
        a g8 f e4^\fermata fis
        g f e a
        a gis e^\fermata g
        g g d8 e f4
        e a gis^\fermata a
        a8 g fis4 e d8 g
        g e fis4 d^\fermata e
        d8 e fis f e4 a
        a gis e^\fermata 
        \bar "|."
      }

     % "Tenor"
      \new Staff{
        \clef tenor
        \partial 4
        c
        c c c c
        c b g^\fermata a
        d d c8 b a4
        f' e8 d cis4^\fermata b
        c g8 a b4 a8 b
        c d e4 e^\fermata e
        a, d g,8 a b d
        e4 d8 c  b4^\fermata g8 a
        b c d4 c8 b a c
        f d b e cis4^\fermata
        \bar "|."
      }

     % "Baixo"
      \new Staff{
        \clef bass
        \partial 4
        a
        e f e8 d c4
        f g c,^\fermata a'
        g d' a8 g f e
        d4 e a,^\fermata g
        c8 d e f g4 f
        a,8 b c d e4^\fermata a8 g
        fis e d4 e8 fis g4
        c, d g,^\fermata e'8 fis
        g4 fis8 gis a g f e
        d b e4 a,^\fermata
        \bar "|."
      }
      \new ChordNames \with {
        \override BarLine #'bar-size = #0
        voltaOnThisStaff = ##t
        \consists Bar_engraver
        \consists "Volta_engraver"
      }
      {
        \chordmode {
          a4:m
          c/e f c2
          d4:m g8 g:7 c4 fis:dim
          g b:dim/d a:m d:m
          b:dim/d e8 e:7 a4 g
          c c/e g:7 d:m/f
          a:m a:m/c e a
          d/fis d c/e g:7
          c d8 d:7 g4 c8/e fis:dim7
          g4 d8/fis gis:dim7 a4:m d:m/f
          b8:m7.5-/d b:m7.5- e4 a
        }
      }
    >>
  >>
}