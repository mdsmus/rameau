
\version "2.10.33"

\header {
  title = "297 - Wachet doch, erwacht, ihr Schläfer"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key g \minor
}

soprano = \relative c {
  d''4 d a bes 
  c bes8 a a4 g 
  bes bes a g 
  fis g a2 
  d4 d a bes 
  c bes8 a a4 g 
  bes bes a g 
  fis g a2 
  a4 bes c a 
  bes a8 g g4 f 
  bes c d d 
  ees d8 c c4 bes 
  d d c d 
  bes c d2 
  d4 d c bes 
  a a g2 
}


alto = \relative c {
  g''4 g a g 
  g g fis d 
  d ees ees8 d d c 
  c4 d d2 
  d4 g fis g 
  g g fis d 
  d ees ees8 d d c 
  c4 d d2 
  fis4 g g f 
  f f e c 
  f g8 a bes4 bes 
  bes bes a f 
  f f f8 ees d4 
  d g fis2 
  g4 g a g 
  g fis d2 
}


tenor = \relative c {
  bes'8 c d4 d d 
  c8 d ees4 d8 c bes4 
  g g g8 fis g4 
  a bes fis2 
  bes8 c d4 d d 
  c8 d ees4 d8 c bes4 
  g g g8 fis g4 
  a bes fis2 
  d'4 d c c 
  bes8 c d4 c8 bes a4 
  bes ees f f 
  ees8 f g4 f8 ees d4 
  bes bes a a 
  g8 bes a g a2 
  bes8 c d4 ees d 
  ees d8 c b2 
}


baixo = \relative c {
  g'8 a bes4 fis g 
  ees c d g, 
  g'8 f ees d c d ees4 
  a g d'2 
  g,8 a bes c d4 g 
  ees c d g, 
  g'8 f ees d c d ees4 
  a g d'2 
  d4 g8 f e4 f8 ees 
  d c bes4 c f 
  d c bes bes'8 a 
  g4 ees f bes, 
  bes8 c d ees f4 fis 
  g8 f ees4 d2 
  g8 a bes4 fis g 
  c, d g,2 
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