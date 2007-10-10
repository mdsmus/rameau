
\version "2.10.33"

\header {
  title = "345 - Herzlich tut mich verlangen"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \minor
}

soprano = \relative c {
  \partial 4 e'4 
  a g f e 
  d2 e4 b' 
  c c b8 c16 d b4 
  a2. e4 
  a g f e 
  d2 e4 b' 
  c c b8 c16 d b4 
  a2. c4 
  b8 a g4 a b 
  c2 c4 g 
  a g f8 e f4 
  e2. c'4 
  b8 c d4 c b 
  a2 b4 e, 
  f e d g8 f 
  e1 
}


alto = \relative c {
  \partial 4 e'8 d 
  c d d e e d d c 
  c4 b8 a b4 e 
  e a a gis 
  e2. e8 d 
  c d d e e d d c 
  c4 b8 a b4 e 
  e a a gis 
  e2. a8 g 
  f4 e8 d c4 f 
  f e8 d e4 e 
  f ais,8 a a g a d 
  cis2. d4 
  d g g8 fis g4 
  g fis g g 
  c,8 d c4 f, d' 
  d c b2 
}


tenor = \relative c {
  \partial 4 gis'4 
  a b c8 d g,4 
  a8 gis a4 gis gis 
  a8 b c4 f e8 d 
  c2. gis4 
  a b c8 d g,4 
  a8 gis a4 gis gis 
  a8 b c4 f e8 d 
  c2. e4 
  d8 c b4 a8 g f g 
  a4 g8 f g4 c 
  c8 d e4 d8 cis d gis, 
  a2. a4 
  g8 a b4 c8 d e4 
  e d d c 
  c8 b b a a4 g8 a 
  b4 a gis2 
}


baixo = \relative c {
  \partial 4 e4 
  f g a8 b c4 
  f,2 e4 e 
  a8 g f e d b e4 
  a,2. e'4 
  f g a8 b c4 
  f,2 e4 e 
  a8 g f e d b e4 
  a,2. a'4 
  d, e f8 e d4 
  a8 b c4 c c 
  f8 e d cis d4 d 
  a2. fis'4 
  g g8 fis e4. d8 
  c a d4 g, c8 b 
  a b c4. b4 a8 
  gis4 a e'2 
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