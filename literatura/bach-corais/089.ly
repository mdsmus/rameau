
\version "2.10.33"

\header {
  title = "89 - Herzlich tut mich verlangen"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key b \minor
}

soprano = \relative c {
  \partial 4 fis'4 
  b a g fis 
  e2 fis4 cis' 
  d cis8 d16 e d4 cis8 b 
  b2. fis4 
  b a g fis 
  e2 fis4 cis' 
  d cis8 d16 e d4 cis8 b 
  b2. d4 
  cis8 b a4 b cis 
  d2 d4 a 
  b a b8 a g4 
  fis2. d'4 
  cis8 d e4 d cis 
  b2 cis4 fis, 
  g fis e a8 g 
  fis1 
}


alto = \relative c {
  \partial 4 d'4 
  d8 e fis4 b,8 cis d4 
  d cis d fis 
  fis g fis e8 d 
  d2. d4 
  d8 e fis4 b,8 cis d4 
  d cis d fis 
  fis g fis e8 d 
  d2. fis4 
  gis fis g g 
  a g fis fis 
  fis8 e dis e fis4. e8 
  e4 dis2 b'4 
  a a a8 b cis a 
  a4 gis a d, 
  e d e fis8 e 
  e4 d cis2 
}


tenor = \relative c {
  \partial 4 b'4 
  b8 cis d4 e a, 
  b a a cis 
  b b b ais 
  fis2. b4 
  b8 cis d4 e a, 
  b a a cis 
  b b b ais 
  fis2. b8 a 
  gis4 cis d e 
  d8 c4 ais8 a4 d8 c 
  b4 c b b 
  b2. e4 
  e e8 fis16 g fis4 e 
  fis e e a, 
  a a a8 b c4 
  cis b ais2 
}


baixo = \relative c {
  \partial 4 b'8 a 
  g4 fis e d 
  gis, a d ais 
  b e fis fis, 
  b2. b'8 a 
  g4 fis e d 
  gis, a d ais 
  b e fis fis, 
  b2. b'4 
  f fis f e 
  fis g d d 
  g fis8 e dis4 e 
  b2. gis'4 
  a8 b cis4 fis,8 gis a4 
  dis, e a, d 
  cis d c8 b a4 
  ais b fis2 
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