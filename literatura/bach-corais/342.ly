
\version "2.10.33"

\header {
  title = "342 - Kommt her, ihr lieben Schwesterlein"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \major
}

soprano = \relative c {
  \partial 4 a''4 
  e' e e e 
  fis e8 d cis4 b 
  cis8 dis e4 e8 fis dis4 
  e2. e4 
  e e e8 d cis d 
  e4 d8 cis b4 e 
  d cis b b8 cis 
  a b cis d e4 e 
  d cis b b 
  a1 
}


alto = \relative c {
  \partial 4 e'4 
  e8 fis gis4 a a 
  a gis e e 
  e8 fis gis4 fis gis8 a 
  gis2. gis4 
  a gis8 fis e4 e8 d 
  cis a fis'4 gis cis8 b 
  a4. gis8 fis4 gis 
  fis8 gis a b cis4 fis, 
  fis8 gis a4 a gis 
  e1 
}


tenor = \relative c {
  \partial 4 cis'4 
  b e8 d cis d e4 
  d8 cis b4 a gis 
  a b b b 
  b2. b4 
  cis b8 a b4 a 
  a a e' gis, 
  a8 b cis a d4. cis8 
  cis4 fis, gis cis 
  d8 e fis4 fis e8 d 
  cis1 
}


baixo = \relative c {
  \partial 4 a'4 
  gis e a8 b cis a 
  d,4 e a, e' 
  a gis8 a b4 b, 
  e2. e8 d 
  cis d e fis gis e a4 
  cis, d e cis 
  fis8 gis a4. gis8 fis f 
  fis4 e8 d cis4 ais' 
  b fis8 e d b e4 
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