
\version "2.10.33"

\header {
  title = "20 - Ein feste Burg ist unser Gott"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key d \major
}

soprano = \relative c {
  \partial 4 d''4 
  d d a8 b cis4 
  d8 cis b4 a d 
  cis b a b 
  g8 fis e4 d d' 
  d d a8 b cis4 
  d8 cis b4 a d 
  cis b a b 
  g8 fis e4 d d 
  a' b a gis 
  a2 d,4 a' 
  b cis d cis 
  d8 cis b4 a b 
  b a b8 a g4 
  fis d' cis b 
  a b8 a g4 fis 
  e2 d 
}


alto = \relative c {
  \partial 4 a''4 
  d, d8 e fis4 g 
  a gis e b' 
  e, d cis b 
  cis8 d4 cis8 d4 a' 
  d, d8 e fis4 g 
  a gis e b' 
  e, d cis b 
  cis8 d4 cis8 d4 d 
  cis d e8 d b4 
  cis2 d8 e fis4 
  g8 fis e4 fis fis 
  fis16 gis a4 gis8 e4 g 
  g dis8 e fis4 e 
  dis fis fis8 e d e 
  fis e d4 e8 a, d2 cis4 a2 
}


tenor = \relative c {
  \partial 4 fis'4 
  fis b,8 cis d4 e 
  fis4. e16 d cis4 fis,8 gis 
  ais4 b fis'8 e d4 
  e8 a,4 g8 fis4 fis' 
  fis b,8 cis d4 e 
  fis4. e16 d cis4 fis,8 gis 
  ais4 b fis'8 e d4 
  e8 a,4 g8 fis4 fis8 g 
  a4 gis8 fis e fis e4 
  e2 a4 d 
  d a a a 
  b8 e fis e cis4 e 
  d8 e fis4 b, b 
  b b a b8 cis 
  d4 g,8 fis e4 fis16 g a8 
  b4 a8 g fis2 
}


baixo = \relative c {
  \partial 4 d'8 cis 
  b4 a8 g fis4 e 
  d e a, b 
  cis d8 e fis4 g8 fis 
  e d a4 d d'8 cis 
  b4 a8 g fis4 e 
  d e a, b 
  cis d8 e fis4 g8 fis 
  e d a4 d d8 e 
  fis4 e8 d cis d e4 
  a,2 fis'4 e8 d 
  g4 a d, fis 
  b,8 cis d e a,4 e'8 fis 
  g4 fis8 e dis4 e 
  b b fis' g 
  d8 cis b4 cis d 
  g, a d,2 
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