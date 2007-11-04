
\version "2.10.33"

\header {
  title = "16 - Es woll uns Gott genädig sein 2"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key b \minor
}

soprano = \relative c {
  \partial 4 cis''4 
  d cis b cis8 d 
  e4 fis e d 
  cis2 s4 e 
  d cis d b 
  a fis8 g a4 g 
  fis2. cis'4 
  d cis b cis8 d 
  e4 fis e d 
  cis2 s4 e 
  d cis d b 
  a fis8 g a4 g 
  fis2. a4 
  g fis e fis 
  d e fis cis' 
  d cis b cis8 d 
  e4 d cis fis 
  e8 d cis d e4 b 
  a g fis e 
  a b cis8 d e4 
  d cis b d 
  cis b a8 g fis g 
  a4 g fis1. 
}


alto = \relative c {
  \partial 4 fis'4 
  fis fis g a 
  g fis8 gis ais4 b 
  ais2 s4 cis 
  b8 a g4 a g8 fis 
  e4 d8 e fis4 e8 d 
  cis2. fis4 
  fis fis g a 
  g fis8 gis ais4 b 
  ais2 s4 cis 
  b8 a g4 a g8 fis 
  e4 d8 e fis4 e8 d 
  cis2. cis4 
  d d cis cis 
  d8 cis b4 cis fis 
  fis8 gis ais4 b ais8 b 
  cis fis, fis4 fis a 
  gis a e e 
  e8 d e cis d4 cis 
  cis8 dis e4 e8 fis g fis 
  fis gis a4 gis fis 
  e8 fis g4 fis8 e d4 
  e2. d2 cis8 b cis2 
}


tenor = \relative c {
  \partial 4 ais'4 
  b cis8 d e4 a, 
  b8 cis d4 e fis 
  fis2 s4 fis 
  fis e d d 
  e a,8 b c4 b 
  ais2. ais4 
  b cis8 d e4 a, 
  b8 cis d4 e fis 
  fis2 s4 fis 
  fis e d d 
  e a,8 b c4 b 
  ais2. a4 
  b a a8 g fis4 
  fis b ais ais 
  b e fis e8 d 
  cis4 b ais b 
  b a b8 a gis4 
  a a a a 
  a gis ais8 b cis4. b8 e4 e a,8 b 
  cis4 d d a 
  a b cis b2 ais8 gis ais2 
}


baixo = \relative c {
  \partial 4 fis4 
  b a g fis 
  e d cis b 
  fis'2 s4 ais 
  b e, fis g 
  cis, d dis e 
  fis2. fis4 
  b a g fis 
  e d cis b 
  fis'2 s4 ais 
  b e, fis g 
  cis, d dis e 
  fis2. fis4 
  b,8 cis d4 a ais 
  b g fis fis' 
  b cis d cis8 b 
  ais4 b fis dis 
  e fis gis8 fis e d 
  cis b cis a d4 a'8 gis 
  fis4 e8 d cis b ais4 
  b cis8 dis e4 fis8 gis 
  a4 b8 cis d4 d, 
  c b ais b 
  fis1 
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