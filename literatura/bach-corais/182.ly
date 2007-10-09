
\version "2.10.33"

\header {
  title = "182 - Wär Gott nicht mit uns diese Zeit"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key g \minor
}

soprano = \relative c {
  \partial 4 g''8 a 
  bes4 b c d 
  c b c c 
  bes8 a g a bes c d4 
  c8 bes c4 bes g8 a 
  bes4 b c d 
  c b c c 
  bes8 a g a bes c d4 
  c8 bes c4 bes c 
  d c8 bes a4 bes 
  c8 bes a4 g g 
  c b c d8 c 
  bes a g4 f f 
  bes c d c8 bes 
  a g a4 g2 
}


alto = \relative c {
  \partial 4 d'4 
  g g g g 
  ees d c g'8 a 
  bes bes,4 c8 d ees f g 
  a bes4 a8 f4 d 
  g g g g 
  ees d c g'8 a 
  bes bes,4 c8 d ees f g 
  a bes4 a8 f4 f8 ees 
  d e f g c,4 f 
  ees a8 d d4 d 
  g8 gis g f ees4 d8 fis 
  g d4 cis8 d4 d 
  d g fis8 d g4 
  g fis d2 
}


tenor = \relative c {
  \partial 4 bes'8 c 
  d4 d ees d 
  g,8 g'4 f8 ees4 ees 
  f g f8 ees d bes 
  f'4 g8 f16 ees d4 bes8 c 
  d4 d ees d 
  g,8 g'4 f8 ees4 ees 
  f g f8 ees d bes 
  f'4 g8 f16 ees d4 c4. bes8 a g f4. g8 
  a g4 fis8 bes4 b 
  c d g,8 a bes a 
  g a bes a a4 bes 
  bes8 a g4 a8 bes16 c d4 
  d4. c8 b2 
}


baixo = \relative c {
  \partial 4 g4 
  g'8 gis g f ees d c b 
  c ees g g, c4 c 
  d ees d8 c bes ees4 d8 ees f bes,4 g 
  g'8 gis g f ees d c b 
  c ees g g, c4 c 
  d ees d8 c bes ees4 d8 ees f bes,4 a 
  bes8 c d e f ees d4 
  c d g, g'8 f 
  ees4 d c g 
  g'8 f e a, d4 bes'8 a 
  g f ees d c bes a g 
  d'4 d, g2 
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