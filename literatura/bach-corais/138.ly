
\version "2.10.33"

\header {
  title = "138 - Jesu, meine Freude"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key e \minor
}

soprano = \relative c {
  b''4 b a g 
  fis2 e 
  b'4 b cis dis 
  e2 dis 
  e4 g fis4. e8 
  e1 
  b4 b a g 
  fis2 e 
  b'4 b cis dis 
  e2 dis 
  e4 g fis4. e8 
  e1 
  b4 b c b 
  a4. g8 g2 
  b4 cis d b 
  e d cis2 
  b b4 b 
  a g fis2 
  e1 
}


alto = \relative c {
  g''4 g8 fis e4 e 
  e dis b2 
  g'4 g a8 g fis4 
  e fis fis2 
  g8 a b4 b a 
  g1 
  g4 g8 fis e4 e 
  e dis b2 
  g'4 g a8 g fis4 
  e fis fis2 
  g8 a b4 b a 
  g1 
  g8 fis e dis e fis g4 
  g fis d2 
  g4 g fis fis 
  g fis fis4. e8 
  dis2 d8 e f4 
  e8 fis g e e4 dis 
  b1 
}


tenor = \relative c {
  e'4 d c b 
  c b8 a g2 
  e'4 d a8 b c4 
  b cis b2 
  b4 e e dis 
  b1 
  e4 d c b 
  c b8 a g2 
  e'4 d a8 b c4 
  b cis b2 
  b4 e e dis 
  b1 
  e4 b a g 
  e' d b2 
  d4 e ais, b 
  ais b b ais 
  fis2 gis4 gis 
  a8 c b4 cis b8 a 
  gis1 
}


baixo = \relative c {
  e8 fis g4 c,8 d e4 
  a, b e2 
  e8 fis g4 fis8 g a4 
  gis ais b2 
  g8 fis e4 b' b, 
  e1 
  e8 fis g4 c,8 d e4 
  a, b e2 
  e8 fis g4 fis8 g a4 
  gis ais b2 
  g8 fis e4 b' b, 
  e1 
  e8 fis g4 c,8 d e4 
  cis d g,2 
  g'8 fis e4 fis8 e d4 
  cis d8 e fis2 
  b, b8 cis d4 
  cis8 dis e4 ais, b 
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