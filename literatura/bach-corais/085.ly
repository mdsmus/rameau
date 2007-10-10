
\version "2.10.33"

\header {
  title = "85 - Die Wollust dieser Welt"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key e \major
}

soprano = \relative c {
  \partial 4 b''4 
  gis fis8 e b'4 b 
  cis2 s4 cis 
  fis, fis b a 
  gis fis e b' 
  cis cis b a 
  gis2 s4 fis 
  gis ais b cis 
  dis cis8 b b4 b 
  b b e d 
  cis2 s4 cis 
  cis cis fis e 
  dis2 s4 b 
  cis b cis dis 
  e2 s4 b 
  b a8 gis fis4 fis 
  e2. 
}


alto = \relative c {
  \partial 4 e'4 
  e dis e8 fis gis4 
  a2 s4 fis8 e 
  dis cis dis4 e fis 
  e dis b e 
  e a a8 gis fis4 
  e2 s4 fis 
  fis e fis gis 
  fis2 dis4 fis 
  e e e8 fis gis4 
  a2 s4 a 
  a ais b b8 ais 
  b2 s4 b 
  a b b8 a gis fis 
  e2 s4 fis 
  e e e dis 
  b2. 
}


tenor = \relative c {
  \partial 4 gis'8 a 
  b4 a b e 
  e2 s4 cis 
  b b b b 
  b4. a8 gis4 b 
  a8 cis fis e dis e e dis 
  b2 s4 b 
  b cis fis,8 b b4 
  b ais fis b8 a 
  gis fis gis a b4 e 
  e2 s4 e 
  fis cis dis e 
  fis2 s4 e 
  e e a, b8 a 
  gis2 s4 fis8 gis16 a 
  gis4 a8 b cis4 b8 a 
  gis2. 
}


baixo = \relative c {
  \partial 4 e4 
  e fis gis fis8 e 
  a2 s4 ais 
  b a gis dis 
  e b e gis 
  a fis b b, 
  e2 s4 dis 
  e cis dis e 
  fis2 b,4 dis 
  e8 dis e fis gis4 fis8 e 
  a2 s4 a8 gis 
  fis4 e dis cis 
  b2 s4 gis' 
  a gis fis b, 
  cis2 s4 dis 
  e8 dis cis b a4 b 
  e2. 
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