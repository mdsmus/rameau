
\version "2.10.33"

\header {
  title = "263 - Jesu, meine Freude"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key e \minor
}

soprano = \relative c {
  b''4 b a g 
  fis2 e 
  b'4 cis d b 
  e2 dis 
  e8 fis g4 fis4. fis8 
  e1 
  b4 b a g 
  fis2 e 
  b'4 cis d b 
  e2 dis 
  e8 fis g4 fis4. fis8 
  e1 
  b4 b c b 
  a4. a8 g2 
  b4 cis d b 
  e d8 cis cis2 
  b b4 b 
  a g8 fis fis2 
  e1 
}


alto = \relative c {
  g''4 fis e8 dis e4 
  e dis b2 
  g'8 fis e4 d d 
  g8 a b4 b2 
  g8 a b4 b4. a8 
  g1 
  g4 fis e8 dis e4 
  e dis b2 
  g'8 fis e4 d d 
  g8 a b4 b2 
  g8 a b4 b4. a8 
  g1 
  g4 g a g 
  g fis d2 
  g4 g a g8 a 
  b4 b b ais 
  fis2 g4 fis 
  e e e dis 
  b1 
}


tenor = \relative c {
  e'4 b c8 fis, g4 
  c b8 a g2 
  e'8 d cis b a4 g8 a 
  b4 g' fis2 
  e4 e e dis 
  b1 
  e4 b c8 fis, g4 
  c b8 a g2 
  e'8 d cis b a4 g8 a 
  b4 g' fis2 
  e4 e e dis 
  b1 
  e4 d d d 
  e d8 c b2 
  d4 e d d 
  g fis g fis8 e 
  dis2 e4 fis8 g 
  a a, b4 c b8 a 
  gis1 
}


baixo = \relative c {
  e4 d c4. b8 
  a4 b e2 
  e4 a8 g fis4 g8 fis 
  e fis g a b2 
  c4 b8 a b4 b, 
  e1 
  e4 d c4. b8 
  a4 b e2 
  e4 a8 g fis4 g8 fis 
  e fis g a b2 
  c4 b8 a b4 b, 
  e1 
  e8 fis g4 fis g 
  c, d g,2 
  g'4 fis8 e fis4 g8 fis 
  e4 b e fis 
  b,2 e4 d 
  c b a b 
  e1 
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