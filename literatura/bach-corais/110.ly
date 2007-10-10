
\version "2.10.33"

\header {
  title = "110 - Vater unser im Himmelreich"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key g \minor
}

soprano = \relative c {
  \partial 4 g''4 
  g ees f g8 f 
  ees4 d c g' 
  g f bes g8 f 
  ees4 f g g8 a 
  bes4 c8 d ees4 d 
  c b c c 
  d c bes a 
  g a g c 
  bes a bes8 gis g4 
  g f ees g 
  gis g8 f ees4 f 
  ees d c2 
}


alto = \relative c {
  \partial 4 ees'4 
  d c c8 d ees d 
  c4 b g ees' 
  ees d8 ees f4 ees8 d 
  c b c d b4 ees 
  d ees8 f g4 f 
  ees8 f g4 g f 
  f fis g g8 fis 
  g4 fis d f 
  f ees d ees8 d 
  c4 d bes c 
  f ees8 d c4 d8 c 
  b c c b g2 
}


tenor = \relative c {
  \partial 4 c'4 
  g g c c8 gis 
  g4 g8 f ees4 c' 
  bes bes bes bes 
  c gis d c' 
  bes gis g a8 b 
  c4 d ees a 
  bes c d ees8 d 
  d c c b b4 a 
  bes c f, ees 
  ees bes'8 gis g4 c 
  c b c8 bes bes4 
  g g8 f e2 
}


baixo = \relative c {
  \partial 4 c4 
  b c gis' ees8 f 
  g4 g, c c' 
  g8 gis bes4 d, ees 
  gis gis, g c 
  g' f ees f8 g 
  gis4 g c, f 
  bes a g c,8 d 
  ees4 d g, f'8 ees 
  d4 c bes c8 bes 
  gis4 bes ees e 
  f g gis8 g f4 
  g g, c2 
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