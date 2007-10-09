
\version "2.10.33"

\header {
  title = "81 - Christus, der uns selig macht"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \minor
}

soprano = \relative c {
  e''4 e e e 
  d c b2 
  c4 d e e 
  d c b2 
  a4 b c a 
  a8 g f4 e2 
  f4 g a a 
  g f e2 
  a4 gis a b 
  c b a2 
  c4 d e e 
  d c b2 
  a4 b c a 
  a8 g f4 e2 
  f4 g a a 
  g f e1. 
}

alto = \relative c {
  gis''4 gis a b 
  a a gis2 
  e8 fis g4 g f8 e 
  f4 e e2 
  e4 e e f 
  e d cis2 
  d4 e dis d 
  d2 cis 
  dis4 e e fis8 gis 
  a4 g fis2 
  g4 g g f 
  f e8 fis g2 
  a4 e e e 
  a, d cis2 
  d4 e f f 
  e d2 c4 
  b1 
}

tenor = \relative c {
  b'4 b c b8 c 
  d e f4 b,2 
  a4 ais ais a 
  a2 gis 
  c4 b a8 b c d 
  e4 a, a2 
  a4 c c c 
  ais8 c d4 a2 
  a4 b c d 
  e d d2 
  c4 ais a a 
  a8 b c4 d2 
  d8 c b4 a8 b c d 
  e4 a, a2 
  a4 c c c 
  c8 b a4 gis a 
  gis1 
}

baixo = \relative c {
  e4 e a g 
  f e8 d e2 
  a4 g cis, cis 
  d a e'2 
  a4 gis a f 
  cis d a2 
  d4 c f, fis 
  g gis a2 
  f'4 e8 d c4 b 
  a b8 c d2 
  dis4 d cis d8 e 
  f g a4 g2 
  fis4 gis a a,8 b 
  cis4 d a2 
  d4 c f,8 g a b 
  c4 d e1. 
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