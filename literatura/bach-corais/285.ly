
\version "2.10.33"

\header {
  title = "285 - Wo Gott der Herr nicht bei uns hält"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \minor
}

soprano = \relative c {
  \partial 4 c''4 
  c8 b a b c d e4 
  d d c c 
  b a8 b c4 d 
  b2 a4 c 
  c8 b a b c d e4 
  d d c c 
  b a8 b c4 d 
  b2 a4 d 
  e e b8 c d4 
  c c b c 
  d a8 b c4 b 
  a a g c 
  b a8 b c4 d8 c 
  b2 a 
}


alto = \relative c {
  \partial 4 a''4 
  g f e8 d c4 
  d8 e f4 e fis 
  g fis8 gis a4 a8 g 
  f4 e8 d c4 a' 
  g f e8 d c4 
  d8 e f4 e fis 
  g fis8 gis a4 a8 g 
  f4 e8 d c4 g' 
  g g d4. e8 
  fis gis a4 gis a 
  a8 g fis4 e d8 e 
  f4 f e a 
  g a gis8 b a g 
  f4 e8 d cis2 
}


tenor = \relative c {
  \partial 4 e'4 
  e8 d c4 c8 b a g 
  a4 b c c 
  d d e a, 
  a gis a c 
  e8 d c4 c8 b a g 
  a4 b c c 
  d d e a, 
  a gis a g 
  c g8 a b4 a8 b 
  c d e4 e e 
  d d g,8 a b4 
  c8 b c d e4 dis 
  d d e a, 
  a gis e2 
}


baixo = \relative c {
  \partial 4 a'4 
  e f8 g a b c4 
  f, g c, a' 
  g d' a8 g f e 
  d4 e a, a' 
  e f8 g a b c4 
  f, g c, a' 
  g d' a8 g f e 
  d4 e a, b 
  c8 d e f g4 fis8 gis 
  a b c d e4 a,8 g 
  fis e d4 e8 fis g4 
  a8 g a b c4 fis, 
  g f e8 c f e 
  d b e4 a,2 
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