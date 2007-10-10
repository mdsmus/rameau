
\version "2.10.33"

\header {
  title = "282 - Wie nach einer Wasserquelle"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key c \major
}

soprano = \relative c {
  c''4 d e d 
  c b a g 
  c d e d8 e16 f 
  e4 d8. c16 c2 
  c4 d e d 
  c b a g 
  c d e d8 e16 f 
  e4 d8. c16 c2 
  e4 f g f 
  e d e2 
  g4 g a g 
  f e d2 
  e4 g f e8 d 
  c4 d e2 
  c e4 g 
  f e d c 
  d2 c 
}


alto = \relative c {
  g''4 g g g 
  a d, d d 
  g a8 b c g g4 
  g g g2 
  g4 g g g 
  a d, d d 
  g a8 b c g g4 
  g g g2 
  g4 a8 ais16 c ais4 a 
  g f8 a16 gis a2 
  g4 c c b 
  a g8 fis g2 
  g4 c8 b a b c4 
  a a b e, 
  e2 g8 a ais4 
  a8 b c4 g g 
  g2 g 
}


tenor = \relative c {
  e'4 b c d 
  e8 fis g4 g8 fis b,4 
  c f g8 c, d4. c8 c b e2 
  e4 b c d 
  e8 fis g4 g8 fis b,4 
  c f g8 c, d4. c8 c b e2 
  c4 c c c8 d 
  e a, a b cis2 
  c8 d e4 f8 e d4 
  c c b2 
  c8 d e4 f g8 g, 
  a e' d c b2 
  a ais4 e 
  f g8 a b4 c 
  c b e2 
}


baixo = \relative c {
  c4 g' c b 
  a g d g 
  e d c b 
  c g c2 
  c4 g' c b 
  a g d g 
  e d c b 
  c g c2 
  c'4 a e f 
  cis d a2 
  e'4 c f g 
  a8 b c4 g2 
  c4 c, d e 
  f fis g gis 
  a2 g4 c, 
  d e8 f g f e c 
  g2 c 
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