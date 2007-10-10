
\version "2.10.33"

\header {
  title = "286 - Herzlich tut mich verlangen"
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
  d d cis8 b cis4 
  b2. fis4 
  b a g fis 
  e2 fis4 cis' 
  d d cis8 b cis4 
  b2. d4 
  cis8 b a4 b cis 
  d2 d4 a 
  b a g8 fis g4 
  fis2. d'4 
  cis8 d e4 d cis 
  b2 cis4 fis, 
  g fis e a 
  fis1 
}


alto = \relative c {
  \partial 4 d'4 
  d8 e fis4 b,8 cis d4 
  d cis8 b cis4 fis 
  fis fis fis4. e8 
  d2. d4 
  d8 e fis4 b,8 cis d4 
  d cis8 b cis4 fis 
  fis fis fis4. e8 
  d2. fis4 
  e e8 d cis4 g' 
  a g fis fis 
  fis8 e e dis e4 e 
  dis2. e4 
  e e fis8 e4 gis8 
  fis4 e e d 
  d d e e 
  e d cis2 
}


tenor = \relative c {
  \partial 4 b'4 
  b8 cis d4 d8 cis cis b 
  b ais b4 ais ais 
  b b b ais 
  fis2. b4 
  b8 cis d4 d8 cis cis b 
  b ais b4 ais ais 
  b b b ais 
  fis2. b8 a 
  g4 a g8 b e4 
  d8 c b4 a d8 c 
  b4 c8 b b4 b 
  b2. b4 
  a4. gis8 a b cis4 
  d8 b gis4 a a 
  b a a cis 
  cis8 ais b gis ais2 
}


baixo = \relative c {
  \partial 4 b'8 a 
  g4 fis e d 
  g2 fis4 fis 
  b,8 cis d e fis4 fis 
  b,2. b'8 a 
  g4 fis e d 
  g2 fis4 fis 
  b,8 cis d e fis4 fis 
  b,2. b'4 
  e, fis g fis8 e 
  fis4 g d d 
  g fis e8 g fis e 
  b'2. gis4 
  a8 b cis4 fis,8 gis a4 
  d, e a, d8 cis 
  b cis d4. cis8 b cis 
  d cis b4 fis'2 
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