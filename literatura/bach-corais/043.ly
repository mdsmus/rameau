
\version "2.10.33"

\header {
  title = "43 - Liebster Gott, wann werd ich sterben"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key e \major
}

soprano = \relative c {
  r4 b''8 b e4 b 
  cis b a4. b16 a 
  gis4 fis s4 b8 a 
  gis4 cis8 b ais fis b2 ais4 b2 
  s4 b8 b e4 b 
  cis b a4. b16 a 
  gis4 fis s4 b8 a 
  gis4 cis8 b ais fis b2 ais4 b2 
  s4 fis8 gis a4 gis 
  cis4. dis8 c2 
  s4 cis8 b ais4 b 
  b ais b fis8 fis 
  b4. a8 gis4 cis 
  c cis2 c4 
  cis2 s4 e8 b 
  cis4 gis8 a b4. a8 
  gis4 fis8 e dis4 e2 dis4 e2 
}


alto = \relative c {
  r2 r4 gis''8 gis 
  a4 a8 gis gis fis16 e fis8 fis 
  e4 dis s2. gis8 gis fis4 fis 
  fis fis fis2 
  s2. gis8 gis 
  a4 a8 gis gis fis16 e fis8 fis 
  e4 dis s2. gis8 gis fis4 fis 
  fis fis fis2 
  s4 dis8 e fis4 e8 fis 
  gis fis gis a gis2 
  s4 gis8 gis fis4 fis 
  fis fis fis s2 fis e4 
  fis8 gis ais ais gis2 
  gis4 gis8 dis e2. e4 dis8 e fis4. e8 dis e b4 cis 
  b2 b 
}


tenor = \relative c {
  r2 r4 e'8 e 
  e4 e cis b 
  b b s2. e8 dis cis4 dis 
  cis cis dis2 
  s2. e8 e 
  e4 e cis b 
  b b s2. e8 dis cis4 dis 
  cis cis dis2 
  s2. e8 dis 
  cis a' gis fis dis2 
  s4 e8 dis cis4 dis 
  cis8 b cis4 dis s2 dis8 dis b4 cis 
  dis e dis2 
  e4 e8 c cis4. d8 
  cis2 b2. c4 fis, g 
  fis8 e fis4 gis2 
}


baixo = \relative c {
  r2 r4 e8 e 
  a4 e fis dis 
  e b s2. e4. dis8 cis b 
  fis' e fis4 b,2 
  s2. e8 e 
  a4 e fis dis 
  e b s2. e4. dis8 cis b 
  fis' e fis4 b,2 
  s2. cis8 dis 
  e dis e fis gis,4 gis'8 fis 
  e2. dis8 e 
  fis4 fis, b s2 b8 b e dis cis b 
  a gis g4 gis2 
  cis s4 cis'8 gis 
  a b cis4 gis dis 
  e a,2 ais4 
  b2 e, 
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