
\version "2.10.33"

\header {
  title = "370 - Kommt her zu mir, spricht Gottes Söhn"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \minor
}

soprano = \relative c {
  \partial 4 a''4 
  a a e' d 
  e c b a8 b 
  c4 b c8 d e4 
  d c b c8 b 
  a4 a d8 c b c 
  a2 g4 g 
  c b c8 d e4 
  d c b a8 b 
  c4 b c8 d e4 
  d c b e 
  e e d8 c b c 
  b gis a b b2 
  a1 
}


alto = \relative c {
  \partial 4 e'8 f 
  e4 e8 d e4 f 
  e e e e 
  a gis a g8 a 
  b4 a gis a 
  d,8 e fis4 fis g 
  g fis d e8 f 
  g4 d e8 f g4 
  gis a gis e 
  d d e8 f g4 
  f8 e e4 e gis 
  a g f4. e8 
  f4 e8 f e f e d 
  cis1 
}


tenor = \relative c {
  \partial 4 c'8 d 
  c b a4 a8 c b a 
  b4 a gis a 
  e' e e e 
  e e e e 
  a, d d e 
  d8 c16 b c4 b c 
  g8 a b a g4 c 
  d e e c8 b 
  a4 b8 a g4 c 
  c8 b b a gis4 b 
  c cis d4. e8 
  d4 c8 a gis a4 gis8 
  e1 
}


baixo = \relative c {
  \partial 4 a4 
  a' f c d 
  gis, a e' c8 b 
  a4 e' a8 b c4 
  gis a e a8 g 
  fis e d c b4 e8 c 
  d2 g,4 c8 d 
  e f g f e4 d8 c 
  b4 a e' a8 g 
  fis d g f e d c b 
  a gis a4 e' e 
  a8 g f e f e d c 
  d b c d e d e4 
  a,1 
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