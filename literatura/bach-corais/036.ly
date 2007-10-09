
\version "2.10.33"

\header {
  title = "36 - Nun bitten wir den heiligen Geist"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \major
}

soprano = \relative c {
  \partial 4 a''4 
  b b a fis 
  e fis8 gis a4 b 
  a2. cis8 d 
  e4 fis e cis 
  a fis8 gis a4 b 
  a2 cis4 cis 
  cis b cis2 
  a s4 a 
  b b cis2 
  a b 
  cis8 b a gis fis4 b 
  b a8 gis fis2 
  e fis4 gis 
  a b a2 
}


alto = \relative c {
  \partial 4 e'4 
  e e e d8 cis 
  b4 cis8 d e4 e 
  e2. a4 
  b8 cis d cis b4 a 
  a d, cis fis8 e 
  cis2 a'4 b 
  a8 gis fis4 fis f 
  cis2 s4 fis 
  gis gis a8 fis g4 
  fis2 fis4 gis 
  a8 gis fis e d4 d 
  cis8 gis' fis e e4 dis 
  b2 d4 d 
  e e8 d cis2 
}


tenor = \relative c {
  \partial 4 cis'4 
  b8 a gis4 a a 
  gis a8 b e, a4 gis8 
  cis2. e2 a,4 b cis8 d 
  e4 a, a4. gis8 
  e2 e'4 gis 
  fis fis,8 gis a4 gis 
  fis2 s4 cis' 
  e e e2 
  d d8 cis b4 
  a8 cis d e a,4 gis8 fis 
  e4 fis8 gis cis4 b8 a 
  gis2 a4 b 
  e,8 a4 gis8 e2 
}


baixo = \relative c {
  \partial 4 a'4 
  gis8 fis e d cis4 d2 cis8 b cis a e'4 
  a,2. a'4 
  gis fis gis a 
  cis, d8 e fis a d, e 
  a,2 a'8 gis fis f 
  fis e d4 cis2 
  fis s4 fis 
  e8 d cis b a2 
  d b4 e 
  a, b8 cis d4 b 
  cis dis8 e a,4 b 
  e2 d4 cis8 b 
  cis a e4 a2 
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