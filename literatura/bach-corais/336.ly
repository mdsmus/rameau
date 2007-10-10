
\version "2.10.33"

\header {
  title = "336 - Wo Gott, der Herr, nicht bei uns hält"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key b \minor
}

soprano = \relative c {
  \partial 4 d''4 
  d b8 cis d e fis4 
  e e d d 
  cis b8 cis d4 e8 d 
  cis2 b4 d 
  d b8 cis d e fis4 
  e e d d 
  cis b8 cis d4 e8 d 
  cis2 b4 e 
  fis fis cis8 d e4 
  d d cis d 
  e b8 cis d4 cis 
  b b a d 
  cis b8 cis d4 e8 d 
  cis2 b 
}


alto = \relative c {
  \partial 4 fis'8 g 
  a4 g a a 
  b a8 g fis4 gis 
  a g fis e8 fis 
  g4 fis fis fis8 g 
  a4 g a a 
  b a8 g fis4 gis 
  a g fis e8 fis 
  g4 fis fis a 
  a a e8 fis g4 
  fis gis ais b 
  b8 a gis4 fis e 
  a gis e gis 
  a gis8 ais b4 b8 fis 
  g4 fis8 e d2 
}


tenor = \relative c {
  \partial 4 d'4 
  d d d d 
  d cis a b 
  e e d8 cis b4 
  b ais8 e' d4 d 
  d d d d 
  d cis a b 
  e e d8 cis b4 
  b ais8 e' d4 a 
  a a8 b cis4 cis 
  d8 cis b4 fis' fis 
  b, e a,8 b cis4 
  fis e8 d cis4 d 
  e e fis b, 
  b ais fis2 
}


baixo = \relative c {
  \partial 4 b'4 
  fis g fis8 e d4 
  gis a d, b 
  a e' b'8 a g fis 
  e4 fis b, b' 
  fis g fis8 e d4 
  gis a d, b 
  a e' b'8 a g fis 
  e4 fis b, cis 
  d8 e fis g a4 ais 
  b f fis b8 a 
  gis fis e4 fis8 gis a4 
  dis, e a, b 
  cis8 d e4 b'8 a g fis 
  e4 fis b,2 
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