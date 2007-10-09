
\version "2.10.33"

\header {
  title = "37 - Wachet doch, erwacht, ihr Schläfer"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \minor
}

soprano = \relative c {
  e''4 e b c 
  d c8 b b4 a 
  c c b a 
  gis a b2 
  e4 e b c 
  d c8 b b4 a 
  c c b a 
  gis a b2 
  b4 c d8 c b4 
  c b8 a a4 g 
  c d e8 d c4 
  f e d c 
  b c d e 
  d c b2 
  a4 b c8 b d4 
  c b8 a a2 
}


alto = \relative c {
  a''8 b c4 b a8 gis 
  a b a4. gis8 e4 
  e a8 g f e4 d8 
  d e16 f e8 fis gis2 
  a8 b c4 b a8 gis 
  a b a4. gis8 e4 
  e a8 g f e4 d8 
  d e16 f e8 fis gis2 
  gis4 a a g 
  g8 fis g4 fis d 
  c g' g a8 g 
  a b c4 b g 
  g f8 e d4 g8 a 
  b4 a gis2 
  a8 g f e e f e d 
  e16*7 d16 cis2 
}


tenor = \relative c {
  c'8 b a4 e' e 
  d8 b c d e4 c 
  c8 b a4. gis8 a4 
  b8 c16 d c8 e16 dis e2 
  c8 b a4 e' e 
  d8 b c d e4 c 
  c8 b a4. gis8 a4 
  b8 c16 d c8 e16 dis e2 
  e4 e d d 
  c8 d e4 d8 c b4 
  e b c8 b a4 
  d g, g'8 f e4 
  d c g'8 f e4 
  f e e2 
  e4 d c8 d gis, a 
  a4 gis e2 
}


baixo = \relative c {
  a4 a' gis fis8 e 
  fis gis a4 e a, 
  a'8 g f e d e f4 
  b, c8 a e'2 
  a,4 a' gis fis8 e 
  fis gis a4 e a, 
  a'8 g f e d e f4 
  b, c8 a e'2 
  e4 a8 g fis d g fis 
  e4 d8 c d4 g, 
  a' g8 f e4 f8 e 
  d4 e8 f g4 c, 
  g' a b c8 b 
  a gis a4 e2 
  c8 b a gis a d e f 
  e d e4 a,2 
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