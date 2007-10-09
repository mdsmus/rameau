
\version "2.10.33"

\header {
  title = "115 - Was mein Gott will, das g'scheh allzeit"
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
  b b cis8 b a4 
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
  fis g a4 a gis 
  a g8 a b4 b 
  b ais fis d 
  d d d d8 e 
  fis g a4 a gis 
  a g8 a b4 b 
  b ais fis fis 
  e8 fis gis4 gis fis 
  fis e e fis 
  fis8 e e d d4 e 
  fis gis8 f fis4 fis 
  fis fis8 f fis4 fis 
  e fis8 g fis4 fis 
  e8 fis gis ais b4 b 
  b ais fis2 
}


tenor = \relative c {
  \partial 4 b'4 
  a g fis8 g a b 
  a4 e' fis e8 d 
  e fis g4 g fis 
  g fis8 e d4 b 
  a g fis8 g a b 
  a4 e' fis e8 d 
  e fis g4 g fis 
  g fis8 e d4 d8 cis 
  b4 e8 d cis4 cis 
  b cis8 d cis4 d 
  d8 cis cis b b ais ais gis 
  fis b d gis, ais4 d 
  cis d8 b cis4 d8 cis 
  b4 a a a8 b 
  cis dis e4 b8 cis d4 
  gis, cis dis2 
}


baixo = \relative c {
  \partial 4 b'4 
  fis g d8 e fis g 
  a4 a, d b 
  a e'8 fis g a b4 
  e, fis b, b' 
  fis g d8 e fis g 
  a4 a, d b 
  a e'8 fis g a b4 
  e, fis b, b'8 a 
  gis fis e4 f fis8 e 
  dis4 e a, d 
  gis, ais b cis 
  d b fis' b 
  a gis fis b8 a 
  gis4 a d, fis8 gis 
  a4 gis g fis 
  f fis b,2 
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