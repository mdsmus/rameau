
\version "2.10.33"

\header {
  title = "129 - Keinen hat Gott verlassen"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key e \minor
}

soprano = \relative c {
  \partial 4 b''4 
  b b b e 
  d4. c8 b4 b8 c 
  d4 fis, g a 
  b2. b4 
  b b b e 
  d4. c8 b4 b8 c 
  d4 fis, g a 
  b2. a4 
  a a a a 
  b2 a4 a 
  b8 cis d4 d cis 
  d2. d4 
  b b c d 
  e2 b4 b 
  a g8 fis fis4. e8 
  e1 
}


alto = \relative c {
  \partial 4 e'4 
  fis e8 dis e fis g2 fis4 d d 
  d d8 c b4 e 
  dis2. e4 
  fis e8 dis e fis g2 fis4 d d 
  d d8 c b4 e 
  dis2. e4 
  d d8 cis d e fis4 
  g2 fis4 a 
  g a a4. g8 
  fis2. fis4 
  d g g f 
  e2 e4 e 
  e e e dis 
  b1 
}


tenor = \relative c {
  \partial 4 g'4 
  fis8 g a4 g c8 b 
  a g a4 g g 
  a a g8 fis e4 
  fis2. g4 
  fis8 g a4 g c8 b 
  a g a4 g g 
  a a g8 fis e4 
  fis2. e4 
  fis8 e fis g a4 d 
  d2 d4 d 
  d d8 e fis4 e 
  d2. a4 
  g d' e b2 a4 g b 
  e, c' b8 g a4 
  gis1 
}


baixo = \relative c {
  \partial 4 e4 
  dis b e8 d c4 
  d2 g,4 g' 
  fis8 e d4 e8 d c4 
  b2. e4 
  dis b e8 d c4 
  d2 g,4 g' 
  fis8 e d4 e8 d c4 
  b2. cis4 
  d d8 e fis4 d 
  g,8 a b c d4 fis 
  g fis8 g a4 a, 
  d2. d4 
  g8 a g f e f e d 
  c b c d e4 g, 
  c b8 a b4 b 
  e,1 
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