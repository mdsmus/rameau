
\version "2.10.33"

\header {
  title = "298 - Wie nach einer Wasserquelle"
  composer = "J. S. Bach"
}

global =  {
  \time 3/4 
  \key c \major
}

soprano = \relative c {
  c''2 d4 e2 d4 c2 
  b4 a2. 
  g c2 d4 e2 
  f4 e d2 
  c2. c2 d4 e2 
  d4 c2 b4 
  a2. g c2 
  d4 e2 f4 
  e d2 c2. e2 
  f4 g2 f4 
  e d2 e2. g4 g2 a g4 
  f e2 d2. e2 
  g4 f2 e4 
  c d2 e2. c e2 g4 
  f2 e4 d2 e4 d2. c 
}


alto = \relative c {
  g''2 g4 g2 fis4 g a 
  g e fis2 
  d2. c2 g'4 g2 
  a4 e a g 
  g2. g2 g4 g2 
  fis4 g a g 
  e fis2 d2. c2 
  g'4 g2 a4 
  e a g g2. g2 
  a4 ais2 a4 
  e a g g2. c4 ais2 a4 b c 
  c g2 g2. g2 
  g4 a2 g4 
  f d g g2. f g2 g4 
  g2 g4 f 
  d g g2. g 
}


tenor = \relative c {
  e'2 b4 c 
  b a e' d 
  d c a2 
  b2. g2 b4 c2 
  c4 c2 b4 
  g2. e'2 b4 c b 
  a e' d d 
  c a2 b2. g2 
  b4 c2 c4 
  c2 b4 g2. c2 
  c4 g2 c4 
  c2 b4 g2. e'4 e2 c4 d e 
  c2 c4 b2. c2 
  c4 c2 b4 
  c b2 c ais4 a2. c2 e4 
  d2 c4 a 
  g2 g8 d' f e 
  f4 e2. 
}


baixo = \relative c {
  c'2 g4 c,2 d4 e fis 
  g c, d2 
  g,2. e'2 g4 c b 
  a g f g 
  c,2. c'2 g4 c,2 
  d4 e fis g 
  c, d2 g,2. e'2 
  g4 c b a 
  g f g c,2. c'2 
  a4 e2 f4 
  g f g c,2. c4 c'8 ais 
  a g f2 e4 
  a8 b c4 c, g'2. c2 
  e,4 f2 g4 
  a b g c2 c,4 f2. c2 c'4 
  c b c f, 
  g c, g2. c 
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