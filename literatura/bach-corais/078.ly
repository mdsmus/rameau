
\version "2.10.33"

\header {
  title = "78 - Herzliebster Jesu, was hast du verbrochen"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key b \minor
}

soprano = \relative c {
  \partial 4 b''4 
  b b ais8 gis fis4 
  b cis d d 
  e d cis cis 
  d e fis8 e d4 
  g g fis8 e fis4 
  e2 d4 d 
  cis b a fis8 g 
  a4 a b a 
  g2 fis4 fis' 
  e d cis2 
  b1 
}


alto = \relative c {
  \partial 4 fis'4 
  g d8 e fis4 cis 
  fis fis fis fis 
  fis2 fis4 fis 
  fis a a b8 a 
  g4 a a d8 cis 
  b4 a8 g fis4 fis 
  e d e d8 e 
  fis4 fis g fis 
  fis8 dis e4 e d 
  g fis fis4. e8 
  dis1 
}


tenor = \relative c {
  \partial 4 d'4 
  e b cis8 b ais4 
  b ais b8 cis d4 
  cis b ais ais 
  b cis d8 cis b cis 
  d4 e e d 
  d cis a b8 a 
  g4 g8 fis e a a4 
  d d d c 
  b4. ais16 b cis4 b 
  b8 ais b4 b ais 
  fis1 
}


baixo = \relative c {
  \partial 4 b'4 
  e,8 fis g4 fis fis8 e 
  d4 fis b, b' 
  ais b fis fis 
  b a d, g8 a 
  b4 cis d8 cis b a 
  g4 a d, b 
  e8 fis g4 cis, d 
  d'8 c b a g fis e dis 
  e2 ais,4 b 
  cis d8 e fis4 fis, 
  b1 
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