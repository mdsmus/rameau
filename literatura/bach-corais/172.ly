
\version "2.10.33"

\header {
  title = "172 - Sei gegrüßet, Jesu gütig"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key g \minor
}

soprano = \relative c {
  g''4 a bes bes 
  c bes a a 
  bes c d d 
  ees d8 c c2 
  bes d4 c 
  d d c bes 
  c c c d 
  ees ees d c8 d 
  d2 c 
  g4 a bes bes 
  c c d d 
  d d ees d 
  c bes8 a a2 
  g1 
}


alto = \relative c {
  d'4 d d d 
  g8 fis g4 g fis 
  g f f f 
  ees8 f g4 f2 
  f f4 f 
  f bes bes8 a bes4 
  bes a a g 
  g g g8 f ees4 
  gis g8 f ees2 
  ees4 d d8 ees f4 
  g f f f 
  d g g8 c4 b8 
  c fis, g4 g fis 
  d1 
}


tenor = \relative c {
  bes'4 a4. g16 fis g4 
  g8 a bes g d'4 d 
  d c4. bes16 a bes4 
  bes bes bes a 
  d2 bes4 c2 bes4 g'8 ees f4 
  f f f f 
  ees8 d c4 b c 
  c b g2 
  c4 c bes bes2 a4 bes bes 
  a8 c c bes4 gis16 g f4 
  g8 a bes ees d4. c8 
  b1 
}


baixo = \relative c {
  g'4 fis g4. f8 
  ees4 d8 c d4 d 
  g a bes4. a8 
  g4 ees f f, 
  bes2 bes'4 a 
  bes8 a g f ees c d bes 
  f'4 f, f' b, 
  c8 d ees f g4 gis8 g 
  f4 g c,2 
  c'4 fis, g d 
  ees f bes,2 
  fis4 g c d 
  ees d8 c d4 d, 
  g1 
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