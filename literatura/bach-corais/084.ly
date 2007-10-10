
\version "2.10.33"

\header {
  title = "84 - Nun bitten wir den heiligen Geist"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \major
}

soprano = \relative c {
  \partial 4 a''4 
  b b a gis8 fis 
  e4 fis8 gis a4 b 
  a2. cis8 d 
  e4 fis e4. d8 
  cis b a gis fis4 gis 
  a2 cis4 cis 
  cis b cis2 
  a4 a b8 cis d4 
  cis4. b8 a2 
  b8 cis d4 cis8 b a gis 
  fis4 gis8 a b4. a8 
  gis4 fis e2 
  fis4 gis a2. gis4 a2 
}


alto = \relative c {
  \partial 4 e'4 
  e e e d8 cis 
  b cis a d cis4 fis8 e 
  e2. a4 
  b8 cis d cis b a gis fis 
  gis f cis4 d d 
  cis2 e4 e 
  e8 fis gis fis f fis4 f8 
  fis4 fis gis8 a b4 
  b a8 g fis2 
  fis8 gis a b a gis fis e 
  dis4 e8 fis gis4. fis4 e dis8 b2 
  d4 e e8 cis fis4 
  e2 e 
}


tenor = \relative c {
  \partial 4 cis'4 
  b8 a gis4 a b8 a 
  gis a fis b e, a4 gis8 
  cis2. e4 
  e a, b8 cis d4 
  gis, a a b 
  e,2 a4 a 
  gis8 a b4 b8 a gis cis 
  cis4 cis b8 a4 gis16 fis 
  e4 a a2 
  d8 cis4 b8 cis dis e4 
  b b b8 cis16 dis e8 b 
  b4. a8 gis2 
  a4 b8 d cis4 c 
  b8 a b d cis2 
}


baixo = \relative c {
  \partial 4 a'4 
  gis8 fis e d cis a d4. cis8 d b cis fis d e 
  a,2. a'4 
  a8 gis fis4 gis8 a b4 
  f8 cis fis e d cis b4 
  a2 a8 b cis d 
  e4. d8 cis2 
  fis4 fis8 e d cis b e 
  a, b cis4 d2 
  d8 e fis gis a b cis a 
  b a gis fis e dis cis dis 
  e gis b b, e2 
  d8 cis d b cis fis e dis 
  e4 e, a2 
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