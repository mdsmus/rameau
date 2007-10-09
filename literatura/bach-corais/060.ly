
\version "2.10.33"

\header {
  title = "60 - O stilles Gotteslamm"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key d \major
}

soprano = \relative c {
  \partial 4 fis'8 g 
  a4 b a g8 fis 
  fis2 s4 a 
  b cis d d8 cis 
  cis2 b4 fis8 g 
  a4 b a g8 fis 
  fis2 s4 a 
  b cis d d8 cis 
  cis2 b4 e8 d 
  cis4 d8 cis b4. a8 
  a2. a4 
  b cis d4. d8 
  cis2. a4 
  a b a g8 fis 
  fis2 s4 a 
  b8 cis d4 d cis 
  d1 
}


alto = \relative c {
  \partial 4 d'8 cis 
  d4 d d8 cis16 b cis4 
  d2 s4 fis 
  gis ais b gis 
  fis4. e8 d4 d8 cis 
  d4 d d8 cis16 b cis4 
  d2 s4 fis 
  gis ais b gis 
  fis4. e8 d4 e 
  e fis fis8 d e4 
  e2. e4 
  e8 fis gis4 a e 
  e2. e4 
  fis g8 fis e4 e 
  d2 s4 d 
  d e e8 fis g4 
  fis1 
}


tenor = \relative c {
  \partial 4 a'4 
  a g a a 
  a2 s4 a 
  e' e fis b, 
  b ais b a 
  a g a a 
  a2 s4 a 
  e' e fis b, 
  b ais b b 
  a a a gis 
  cis2. cis4 
  b e d8 cis b4 
  a2. cis4 
  d g, a8 b cis4 
  b2 s4 a 
  g8 a b4 a a 
  a1 
}


baixo = \relative c {
  \partial 4 d8 e 
  fis4 g a a, 
  d2 s4 d 
  d cis b8 cis d e 
  fis2 b,4 d8 e 
  fis4 g a a, 
  d2 s4 d 
  d cis b8 cis d e 
  fis2 b,4 gis' 
  a8 gis fis e d b e4 
  a,2. a'4 
  gis e fis gis 
  a2. g4 
  fis e8 d cis4 a 
  b2 s4 fis' 
  g gis a a, 
  d1 
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