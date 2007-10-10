
\version "2.10.33"

\header {
  title = "287 - Herr, ich habe mißgehandelt"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \minor
}

soprano = \relative c {
  a''4 e a b 
  c d b2 
  a c4 b 
  a b c d 
  e1 
  a,4 e a b 
  c d b2 
  a c4 b 
  a b c d 
  e1 
  e4 f g c, 
  f e d2 
  c d4 d 
  e a, d c 
  b2 a 
}


alto = \relative c {
  e'4 e e d 
  e a a gis 
  e2 a4 gis 
  a e e a 
  gis1 
  e4 e e d 
  e a a gis 
  e2 a4 gis 
  a e e a 
  gis1 
  a4 a g a 
  a8 gis g4 g4. f8 
  e2 g4 g 
  g fis8 e fis gis a4 
  a gis e2 
}


tenor = \relative c {
  c'4 c c8 a4 b16 a 
  gis4 a e'4. d8 
  c2 e4 d 
  e e8 d c b a4 
  b1 
  c4 c c8 a4 b16 a 
  gis4 a e'4. d8 
  c2 e4 d 
  e e8 d c b a4 
  b1 
  c4 d d8 c c4 
  c8 b c4 c b 
  g2 b4 b 
  c8 g d'4 d e 
  e4. d8 cis2 
}


baixo = \relative c {
  a4 a'8 g fis4 f 
  e f8 d e2 
  a, a'4 b 
  c gis a8 g f4 
  e1 
  a,4 a'8 g fis4 f 
  e f8 d e2 
  a, a'4 b 
  c gis a8 g f4 
  e1 
  a4 g8 f e4 f8 e 
  d4 e8 f g2 
  c, g'8 f e d 
  c e d c b4 a 
  e'2 a, 
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