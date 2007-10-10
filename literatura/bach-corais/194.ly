
\version "2.10.33"

\header {
  title = "194 - Liebster Immanuel, Herzog der Frommen"
  composer = "J. S. Bach"
}

global =  {
  \time 3/2 
  \key b \minor
}

soprano = \relative c {
  d''2 d 
  d cis2. b4 a2 
  b g 
  fis4 e e1 d2 
  a' a 
  fis b2. cis4 d2 
  d,4 e e2. fis4 fis1. d'2 d 
  d cis2. b4 a2 
  b g 
  fis4 e e1 d2 
  a' a 
  fis b2. cis4 d2 
  d,4 e e2. fis4 fis1. fis2 fis 
  g a 
  fis1 
  b2 ais 
  b cis 
  ais1 
  d2 cis 
  b ais2. fis4 b2 
  cis4 d ais2. b4 b1. 
}


alto = \relative c {
  fis'2 fis 
  f4 fis gis2 
  f fis 
  g e 
  d d 
  cis a 
  d e 
  d d 
  g fis 
  fis e4 d 
  cis b cis1. fis2 fis 
  f4 fis gis2 
  f fis 
  g e 
  d d 
  cis a 
  d e 
  d d 
  g fis 
  fis e4 d 
  cis b cis1. d2 d 
  d e 
  d1 
  fis2 e 
  fis fis 
  fis1 
  fis2 g 
  e fis2. fis4 fis2 
  g fis 
  fis fis1. 
}


tenor = \relative c {
  b'2 b 
  b4 a gis2 
  cis cis 
  d e4 a, 
  a2 a2. g4 fis2 
  a a 
  a g4 a 
  b2 b 
  b b 
  e ais,1. b2 b 
  b4 a gis2 
  cis cis 
  d e4 a, 
  a2 a2. g4 fis2 
  a a 
  a g4 a 
  b2 b 
  b b 
  e ais,1. b2 b 
  b a 
  a1 
  b2 cis 
  d ais 
  cis1 
  b2 ais 
  b cis2. cis4 b2 
  e4 d cis2 
  cis dis1. 
}


baixo = \relative c {
  b2 b'4 a 
  gis fis f2 
  cis fis 
  b, cis 
  d a' 
  a, d 
  fis cis 
  d g 
  e b 
  a g 
  g' fis1. b,2 b'4 a 
  gis fis f2 
  cis fis 
  b, cis 
  d a' 
  a, d 
  fis cis 
  d g 
  e b 
  a g 
  g' fis1. b,2 d 
  e cis 
  d1 
  d2 cis 
  b fis' 
  fis1 
  b2 e, 
  g fis 
  e d 
  e fis 
  fis, b1. 
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