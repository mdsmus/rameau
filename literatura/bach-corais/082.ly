
\version "2.10.33"

\header {
  title = "82 - O großer Gott von Macht"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key g \minor
}

soprano = \relative c {
  \partial 4 a''4 
  bes c d a8 b 
  c2 s4 g 
  g a bes c 
  a2 s4 f 
  f g a bes 
  c2 s4 d 
  bes8 c d4 c c 
  bes2 s4 d 
  d d c c 
  bes bes a2 
  s4 a bes a 
  g g f f 
  e2 s4 g 
  g a8 bes c4 bes 
  a2 g 
  s4 g g a8 b 
  c4 bes a2 
  a1 
}


alto = \relative c {
  \partial 4 fis'4 
  g f f f 
  g2 s4 ees 
  e fis g a 
  fis2 s4 d 
  d e f ees 
  ees2 s4 d 
  g8 a bes4 bes a 
  f2 s4 f 
  g g g d 
  d e fis2 
  s4 fis g f 
  f e d d 
  c2 s4 d 
  d8 c f4 g8 a d, g 
  g4 fis d2 
  s4 d ees f 
  g g g8 f e4 
  fis1 
}


tenor = \relative c {
  \partial 4 d'4 
  d c bes f' 
  ees2 s4 c 
  c c d ees 
  d2 s4 a 
  bes bes c bes 
  f'2 s4 f 
  ees f f c 
  d2 s4 bes 
  bes bes bes a 
  a g a2 
  s4 d d c 
  d g, a g 
  g2 s4 g 
  g d' c8 a bes g 
  ees'4 a bes2 
  s4 b c f 
  ees d cis8 d4 cis8 
  d1 
}


baixo = \relative c {
  \partial 4 d4 
  g a bes d 
  c2 s4 c 
  bes a g c, 
  d2 s4 d8 c 
  bes bes' a g f4 g 
  a2 s4 bes 
  ees, d8 ees f4 f, 
  bes2 s4 bes'8 a 
  g4 f e fis 
  g g, d'2 
  s4 d g, a 
  b c c b 
  c2 s4 bes 
  ees d e8 fis g4 
  c, d g,2 
  s4 f' ees d 
  c g a2 
  d1 
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