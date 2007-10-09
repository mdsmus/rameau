
\version "2.10.33"

\header {
  title = "97 - Nun bitten wir den heiligen Geist"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \major
}

soprano = \relative c {
  \partial 4 a''4 
  b b a4. gis8 
  fis4 e fis gis 
  a2. cis8 d 
  e4 fis e4. d8 
  cis b a gis fis4 gis 
  a2 cis4 cis 
  cis b cis2 
  a4 a b8 cis d4 
  cis8 b cis4 a2 
  b8 cis d4 cis8 b a gis 
  fis4 e a8 b cis4 
  b4. a8 gis4 fis 
  e2 fis4 gis 
  a2 b 
  a1 
}


alto = \relative c {
  \partial 4 e'4 
  e e e e 
  d e d8 fis e4 
  e2. a4 
  a a b8 a gis4 
  a e d8 cis b4 
  cis2 e8 fis gis4 
  gis8 fis f fis f fis4 f8 
  fis4 fis gis8 fis e4 
  e2 d 
  b'8 a gis4 a e 
  d8 cis b4 a8 e' e4 
  fis8*5 e4 dis8 
  b2 d4. d8 
  cis d e4 fis e8 d 
  cis1 
}


tenor = \relative c {
  \partial 4 cis'4 
  b8 a gis4 a8 b cis4 
  a a a8 d cis b 
  cis2. e4 
  e d8 cis b4 e 
  e8 d cis b a4 e 
  e2 a4 gis 
  a b b8 a gis cis 
  cis4 d d8 cis b4 
  a8 g fis e fis2 
  e4 b' a2. gis8 fis e gis a gis 
  fis4 b b cis8 b 
  gis2 b4 b 
  a2. gis4 
  e1 
}


baixo = \relative c {
  \partial 4 a'4 
  gis8 fis e d cis b a4 
  d cis b e 
  a,2. a'8 b 
  cis4 d gis, e 
  a cis, d e 
  a,2 a'4 f 
  fis d cis2 
  fis4 d8 cis b a gis4 
  a2 d 
  gis4 fis8 e a4 cis, 
  d2. cis4 
  dis8 b cis dis e gis, a b 
  e,2 b'4 f 
  fis cis' d e 
  a,1 
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