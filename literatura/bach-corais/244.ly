
\version "2.10.33"

\header {
  title = "244 - Jesu, Jesu, du bist mein"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key g \minor
}

soprano = \relative c {
  g''4. c8 b4 c 
  d ees8 d d2 
  ees4 c f ees 
  d d8. ees16 c4 c 
  g g c bes 
  gis g8 f f2 
  bes4 g c8 d ees4 
  g, f8 ees ees4 ees 
  g4. a8 b4 b 
  c d b b 
  c d ees c 
  f ees d d 
  c g gis g 
  g4. f8 g2 
  c4 g gis8 g f ees16 d 
  ees4 d8 c c2 
}


alto = \relative c {
  ees'4 g f g 
  g g g2 
  g4 g f8 g gis4. d8 g f ees4 ees 
  ees8 f g4 c,8 d ees4 
  f ees d2 
  f4. ees8 ees f g f 
  ees4 d bes bes 
  ees ees f g 
  g gis g g 
  g g g g 
  f g g g 
  g g4. f4 ees8 
  ees d c4 d2 
  g8 f g ees f4 c 
  c b g2 
}


tenor = \relative c {
  c'4 c d ees 
  d c c b 
  c ees8 d c4 c 
  c b g g 
  c d ees bes 
  bes bes bes2 
  bes4 bes c8 bes4 c8 
  bes4 bes8. gis16 g4 g 
  bes c8 ees d4 d 
  ees f d d 
  ees d c8 d ees d 
  c4 c c b 
  c ees c b 
  c8 b c4 b2 
  c4 c c gis 
  g g8. f16 e2 
}


baixo = \relative c {
  c4 ees d c 
  b c g2 
  c4 c'8 bes gis4. g8 
  f4 g c,2 
  c'4 bes gis g8 f 
  ees d ees4 bes2 
  d8 bes ees4 gis, g8 gis 
  bes gis bes4 ees,2 
  ees'8 d ees c d gis g f 
  ees c f, f' g g, g' f 
  ees d c b c g' c bes 
  gis4 g8 f g4 g, 
  ees' c f g 
  gis2 g 
  ees8 d ees c f g gis f 
  g4 g, c2 
}


\score {
  <<
    \new Staff {
      <<
        \global
        \new Voice = "1" { \voiceOne \soprano }
        \new Voice = "2" { \voiceTwo \alto }
      >>
    }
    \new Staff {
      <<
        \global
        \clef "bass"
        \new Voice = "1" {\voiceOne \tenor }
        \new Voice = "2" { \voiceTwo \baixo \bar "|."}
      >>
    }
  >>
}