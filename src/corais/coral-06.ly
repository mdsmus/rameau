\header {
  title = "Choral #06"
  composer = "Johann Sebastian Bach"
}

\relative c' {
  \new StaffGroup <<

    <<

      %% "SOPRANO"

      \new Staff {
        \key d \major
        \clef soprano
        \relative c'' {
          \partial 4

          d
          d b8 cis d e fis4
          e e d^\fermata d
          cis b8 cis d4 e8 d
          cis2 b4^\fermata
          \bar":|"
          \partial 4
          e
          fis fis cis8 d e4
          d d cis^\fermata d
          e b8 cis d4 cis
          b b a^\fermata d
          cis b8 cis d4 e8 d
          cis2 b4^\fermata

          \bar "|."
        }
      }



      %% "CONTRALTO"
      \new Staff {
        \key d \major
        \clef alto
        \relative c' {
          \partial 4 

          fis8 g
          a4 g a a
          b a8 g fis4^\fermata gis
          a g fis e8 fis
          g4 fis fis^\fermata
          \bar":|"
          \partial 4
          a
          a a e8 fis g4
          fis gis ais^\fermata b
          b8 a gis4 fis e
          a gis fis^\fermata gis
          a gis8 ais b4 b8 fis
          g4 fis8 e d4^\fermata

          \bar "|."
        }
      }

      %% "TENOR"
      \new Staff {
        \key d \major
        \clef tenor
        \relative c' {
          \partial 4

          d
          d d d d
          d c a^\fermata b
          e e d8 cis b4
          b ais8 e' d4^\fermata
          \bar":|"
          \partial 4
          a
          a a8 b cis4 cis
          d8 cis b4 fis'^\fermata fis
          b, e a,8 b cis4
          fis e8 d cis4^\fermata d
          e e fis b,
          b ais fis^\fermata

          \bar "|."
        }
      }

      %% "BAIXO"
      \new Staff {

        \key d \major
        \clef bass
        \relative c' {
          \partial 4

          b
          fis g fis8 e d4
          gis a d,^\fermata b
          a e' b'8 a g fis
          e4 fis b,^\fermata
          \bar":|"
          \partial 4
          cis
          d8 e fis g a4 ais
          b eis, fis^\fermata b8 a
          gis fis e4 fis8 gis a4
          dis, e a,^\fermata b
          cis8 d e4 b'8 a g fis
          e4 fis b,^\fermata

          \bar "|."
        }
      }
    >>
  >>
}