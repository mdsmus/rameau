
\version "2.10.33"

\header {
  title = "12 - Puer natus in Bethlehem"
  composer = "J. S. Bach"
}

global =  {
  \time 3/4 
  \key c \major
}

soprano = \relative c {
  \partial 4 a''4 a2 a4 b2 
  b4 c b a 
  g2. c2 d4 c2 
  b4 c2 c4 
  c2 c4 b2 a4 a b 
  gis a2 a4 
  g2 a4 b2 b4 c2 
  b4 a2 gis4 
  a2 
}


alto = \relative c {
  \partial 4 e'4 e2 a4 g2 
  g4 g2 f4 
  e2. g2 gis4 a2 
  g4 g2 g4 
  a2 fis4 g2 g4 g fis 
  e e2 d4 
  d e d d2 f4 e f 
  g2 fis4 e 
  e2 
}


tenor = \relative c {
  \partial 4 c'4 c2 d4 d2 
  d4 c e c 
  c2. e2 e4 e d2 e e4 
  e d d d 
  e e d b 
  b c2 a4 
  b c a g 
  b d c d2 c b4 
  cis2 
}


baixo = \relative c {
  \partial 4 a4 a' 
  g fis g d 
  f e c f 
  c2. c4 
  c' b a fis 
  g c,2 c'4 
  a fis d g 
  e cis d dis 
  e a,2 f'4 
  f e fis g 
  fis gis a d, 
  e f dis e 
  a,2 
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