
\version "2.10.33"

\header {
  title = "169 - Jesu, der du selbsten wohl"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \major
}

soprano = \relative c {
  cis''4 a b b 
  cis dis e2 
  b4 cis d cis 
  b2 a 
  b4 b e e 
  d d cis2 
  b4 b a gis 
  fis2 e 
  a4 a d d 
  cis cis b2 
  a4 a a a 
  b2 e, 
  e'4 d cis b 
  a gis fis2 
  b4 a d cis 
  b2 a 
}


alto = \relative c {
  e'4 e fis e 
  e fis gis2 
  gis4 a4. gis8 a4 
  a gis e2 
  gis4 gis gis ais 
  fis fis fis2 
  fis4. e8 e dis e4 
  e dis b2 
  e4 e fis8 gis a b4 a16 gis a4 a gis 
  fis g fis fis 
  fis8 e fis4 b,2 
  cis8 a'4 gis8 a4. gis4 fis f8 fis2 
  fis8 gis a4 a8 gis a4 
  a gis e2 
}


tenor = \relative c {
  a'4 a a gis 
  a a b2 
  e4 e d8 b e4 
  fis8 d b e16 d cis2 
  e4 e e8 d cis2 b4 b ais 
  dis8 cis b4 cis8 a b4 
  cis b8 a gis2 
  a8 b cis b a gis fis e 
  e'4 e e2 
  cis8 d e2 d8 cis 
  b gis a b16 a gis2 
  a8 cis d b e fis b, e16 d 
  cis16*7 b16 a2 
  d4 e d8 b cis e 
  fis d b e16 d cis2 
}


baixo = \relative c {
  a4 cis d e 
  a8 gis fis4 e2 
  e8 d cis4 b a 
  d e a,2 
  e'4 e8 d cis4 fis 
  b,8 cis d e fis2 
  b8 a gis4 fis e 
  a, b e2 
  cis8 b a gis fis e fis gis 
  a b cis d e2 
  fis8 e d cis d e fis e 
  dis e4 dis8 e2 
  a,4 b cis8 d e4 
  fis cis d2 
  d8 e d cis b e a, cis 
  d b e4 a,2 
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