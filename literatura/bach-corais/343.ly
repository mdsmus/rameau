
\version "2.10.33"

\header {
  title = "343 - Ermuntre dich, mein schwacher Geist"
  composer = "J. S. Bach"
}

global =  {
  \time 3/4 
  \key d \major
}

soprano = \relative c {
  d'4 d e fis4. gis8 a4 a2 
  gis4 a2 fis4 
  g2 fis4 e2 d4 e2. d 
  d4 d e fis4. gis8 a4 a2 
  gis4 a2 fis4 
  g2 fis4 e2 d4 e2. d 
  e4 e fis g2 g4 fis4. e8 
  fis4 e2. 
  fis4 fis fis g4. a8 b4 b2 
  ais4 b2 cis4 
  d fis,2 g fis4 e e 
  a b4. a8 g4 
  fis8 e e4. d8 d2. 
}


alto = \relative c {
  a'4 d d8 cis d2 cis8 a fis'4 e2 e d8 cis 
  b cis d8*5 cis16 b 
  cis4 d2 cis8 b 
  cis4 a2. 
  a4 d d8 cis d2 cis8 a fis'4 e2 e d8 cis 
  b cis d8*5 cis16 b 
  cis4 d2 cis8 b 
  cis4 a2. 
  cis8 b cis4. dis8 e4 
  b e2 dis8 cis 
  dis4 b2. 
  dis4 b dis e 
  b b g'8 fis e d 
  e4 d2 fis4 
  fis8 e d2 cis8 d 
  e4 d d8 b cis4 
  d d g8 fis fis e 
  d4 d8 b cis4 a2. 
}


tenor = \relative c {
  fis4 fis8 d a'4 a8 fis 
  b4 a b b8 cis 
  d4 cis2 a4 
  g a8 g a2 
  a8 g fis4 b a4. g8 fis2. 
  fis4 fis8 d a'4 a8 fis 
  b4 a b b8 cis 
  d4 cis2 a4 
  g a8 g a8*5 g8 fis4 b a4. g8 fis2. 
  a8 gis a4 a b8 a 
  g2 c4 b4. a8 g2. 
  b4 fis8 g a b g fis 
  e4 e'8 d cis4. b8 
  cis4 b2 ais4 
  b4. fis8 b a g fis 
  e a4 gis8 a4 a 
  a g8 a b cis d a 
  a b a4 g fis2. 
}


baixo = \relative c {
  d8 cis b4 a d4. e8 fis4 d8 b e2 a, d4 
  e fis4. g8 a g 
  fis4 b8 a g e a4 
  a, d2. 
  d8 cis b4 a d4. e8 fis4 d8 b e2 a, d4 
  e fis4. g8 a g 
  fis4 b8 a g e a4 
  a, d2. 
  a4 a'8 g fis4 e4. d8 c b a fis b4 
  b e2. 
  b8 cis dis4 b e4. fis8 g fis e d cis4 
  fis b,2 fis'4 
  b4. a8 g fis e d 
  cis4 d a' a, 
  fis' g4. a8 b cis, 
  d g, a2 d2. 
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