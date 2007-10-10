
\version "2.10.33"

\header {
  title = "120 - Was mein Gott will, das g'scheh allzeit"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key b \minor
}

soprano = \relative c {
  \partial 4 fis'8 g 
  a4 b a d 
  d cis d d 
  cis b e d8 cis 
  cis2 b4 fis8 g 
  a4 b a d 
  d cis d d 
  cis b e d8 cis 
  cis2 b4 b 
  b b8 cis16 d cis8 b a4 
  a gis a a 
  b cis d cis 
  b2 cis4 fis,8 g 
  a4 b a d 
  d cis d d 
  cis b e d8 cis 
  cis2 b 
}


alto = \relative c {
  \partial 4 d'4 
  d d d d8 e 
  fis g e4 fis fis 
  fis8 e d4 g fis8 gis 
  ais b4 ais8 fis4 d 
  d d d d8 e 
  fis g e4 fis fis 
  fis8 e d4 g fis8 gis 
  ais b4 ais8 fis4 fis 
  e8 fis gis4 a e 
  e e e fis 
  fis fis fis e 
  d cis8 b fis'4 d8 e 
  fis4 g d8 e fis g 
  a e fis g fis4 b 
  e,8 fis g a b a16 g fis4 
  fis8 g fis e dis2 
}


tenor = \relative c {
  \partial 4 b'4 
  a g fis8 g a b 
  a4 a a b 
  ais b b8 cis d e 
  fis cis fis e d4 b 
  a g fis8 g a b 
  a4 a a b 
  ais b b8 cis d e 
  fis cis fis e d4 d8 cis 
  b4 e e8 d cis4 
  b cis8 d cis4 d8 cis 
  b4 e d8 cis b ais 
  fis'4 e ais, b 
  cis d8 e fis4 a, 
  a8 b a4 a a8 gis 
  a4 b b8 cis d gis, 
  ais b4 ais8 fis2 
}


baixo = \relative c {
  \partial 4 b'4 
  fis g d8 e fis g 
  a4 a, d b 
  fis' g8 fis e4 b' 
  fis2 b,4 b' 
  fis g d8 e fis g 
  a4 a, d b 
  fis' g8 fis e4 b' 
  fis2 b,4 b'8 a 
  gis fis e4 a,8 b cis d 
  e d e4 a, d8 e 
  d cis b ais b4 cis 
  d g fis b 
  a g fis e8 d 
  a' g a4 d, b 
  a e'8 fis g a b4 
  fis8 e fis4 b,2 
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