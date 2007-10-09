
\version "2.10.33"

\header {
  title = "57 - O Traurigkeit, o Herzeleid"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \minor
}

soprano = \relative c {
  \partial 4 e''4 
  c8 b c4 b gis 
  a a gis e' 
  e e f e8 d 
  d2 c 
  b4 c d e 
  d c b2 
  a4 b c d8 c 
  b2 a 
}


alto = \relative c {
  \partial 4 gis''4 
  e e8 dis e4 e 
  e d e gis 
  a b a g 
  a g8 f e2 
  g4 f8 e d d' c4 
  b a gis2 
  e4 e e a8 g 
  f4 e8 d c2 
}


tenor = \relative c {
  \partial 4 b'4 
  a8 gis fis4 gis b 
  c b8 a b4 b 
  c b c8 d e c 
  c4 b c2 
  d4 c g' g,8 a 
  b e, e'4 e2 
  e8 d4 c b8 a4 
  a gis e2 
}


baixo = \relative c {
  \partial 4 e4 
  a a, e' d 
  c f e e 
  a gis a8 b c4 
  fis, g c,2 
  g4 a b c 
  gis' a e2 
  fis4 gis a8 g f e 
  d4 e a,2 
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