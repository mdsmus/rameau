
\version "2.10.33"

\header {
  title = "269 - Wachet doch, erwacht, ihr Schläfer"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key g \minor
}

soprano = \relative c {
  d''4 d a bes 
  c bes8 a a2 
  g bes4 bes 
  a g fis g 
  a1 
  d4 d a bes 
  c bes8 a a2 
  g bes4 bes 
  a g fis g 
  a1 
  a4 bes c a 
  bes a8 g g2 
  f bes4 c 
  d bes ees d 
  c2 bes 
  a4 bes c d 
  c bes a2 
  g4 a bes c8 bes 
  a4. g8 g2 
}


alto = \relative c {
  g''8 fis g4 fis g 
  g8 fis g4 g fis 
  d2 g4 g8 f 
  ees d d c c4 d 
  d1 
  g8 fis g4 fis g 
  g8 fis g4 g fis 
  d2 g4 g8 f 
  ees d d c c4 d 
  d1 
  fis4 g g f 
  f f f e 
  c2 f4 f 
  f8 ees f d g4 g 
  g f8 ees d2 
  f4 ees8 d c4 f8 g 
  a4 g fis2 
  g4 d g g 
  g fis d2 
}


tenor = \relative c {
  bes'8 c d4 d d 
  c d ees d8 c 
  bes2 d4 g, 
  g8 fis g4 a8 c bes g 
  fis1 
  bes8 c d4 d d 
  c d ees d8 c 
  bes2 d4 g, 
  g8 fis g4 a8 c bes g 
  fis1 
  d'4 d c c 
  bes8 c d4 c4. bes8 
  a2 d4 a 
  bes bes bes8 c d bes 
  g ees' a4 bes2 
  c4 bes f'8 ees d4 
  d d d2 
  d4 d d c8 d 
  ees c a d b2 
}


baixo = \relative c {
  g'8 a bes c d4 c8 bes 
  a4 g c, d 
  g,2 g'8 f ees d 
  c d ees4 a g 
  d'1 
  g8 a bes c d4 c8 bes 
  a4 g c, d 
  g,2 g'8 f ees d 
  c d ees4 a g 
  d'1 
  d4 g8 f e4 f8 e 
  d4 c8 bes c2 
  f, d'4 f 
  bes8 c d bes g a bes g 
  ees c f4 bes,2 
  f'4 g a bes8 a 
  g fis g4 d2 
  bes'8 a g fis g f ees d 
  c a d4 g,2 
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