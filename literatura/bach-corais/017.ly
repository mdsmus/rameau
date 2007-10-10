
\version "2.10.33"

\header {
  title = "17 - Am Sabbat früh Marien drei 2"
  composer = "J. S. Bach"
}

global =  {
  \time 3/4 
  \key e \minor
}

soprano = \relative c {
  e'4 e e b'2 cis4 d cis 
  b a2. 
  b4 cis dis e2 b4 d cis2 b b4 
  d c b a 
  g fis g e2 d d4 
  g2 a4 b2 a4 g d'2 b a4 
  g fis2 e2. 
}


alto = \relative c {
  b'4 b cis d 
  e e fis8 gis a4 
  gis e2. 
  e4 e fis g8 a 
  g fis e4 fis g 
  fis dis2 e4 
  d2 d4 e2 d4 d2 
  cis4 a2 b4 
  b e d d8 e 
  fis2 e4 fis8 g 
  a4 g2 fis4 
  e2 dis4 b2. 
}


tenor = \relative c {
  g'8 a b4 a fis 
  b a a fis 
  b cis2. 
  b4 a a b2 b4 b2 
  ais4 fis2 g4 
  a2 g4 e 
  a2 g8 a b4 
  a8 g fis2 fis4 
  g c2 b4 
  b2 b8 c d2 d c4 
  b a8 g a4 gis2. 
}


baixo = \relative c {
  e8 fis g4 a2 
  gis4 a fis d 
  e a,2. 
  gis'4 a fis e8 dis 
  e fis g4 fis e 
  fis b,2 e4 
  fis2 g4 cis,2 d4 b g 
  a d2 b4 
  e2 fis4 g 
  dis2 e4 b' 
  fis g2 a4 
  b b,2 e2. 
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