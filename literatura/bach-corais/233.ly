
\version "2.10.33"

\header {
  title = "233 - Werde munter, mein Gemüte"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \major
}

soprano = \relative c {
  cis''4 d e e 
  d cis b b 
  cis d e cis 
  b b a2 
  cis4 d e e 
  d cis b b 
  cis d e cis 
  b b a2 
  b4 cis d d 
  cis cis b b 
  d e fis fis 
  e e d d 
  cis d e e 
  d cis b2 
  cis4 d e8 d cis4 
  b b a2 
}


alto = \relative c {
  a''4 a gis a 
  a8 gis a4 gis gis 
  a a b a 
  a gis e2 
  a4 a gis a 
  a8 gis a4 gis gis 
  a a b a 
  a gis e2 
  gis4 ais b b 
  b ais fis fis 
  fis a a a 
  a8 e a g fis4 fis 
  e a e8 fis gis4 
  a a gis2 
  a4 a a8 gis a4 
  a gis e2 
}


tenor = \relative c {
  e'4 fis e8 d cis4 
  d e e e 
  e fis b, cis8 d 
  e b e d cis2 
  e4 fis e8 d cis4 
  d e e e 
  e fis b, cis8 d 
  e b e d cis2 
  e4 e fis fis 
  fis8 cis fis e d4 d 
  d cis d d 
  d cis a a 
  a8 b cis4 b e 
  fis e e2 
  e4 fis e e 
  e8 b e d cis2 
}


baixo = \relative c {
  a'4 fis cis fis 
  b, cis8 d e4 e 
  a8 gis fis4 gis a 
  e e a,2 
  a'4 fis cis fis 
  b, cis8 d e4 e 
  a8 gis fis4 gis a 
  e e a,2 
  e'4 d8 cis b cis d e 
  fis4 fis b, b 
  b' a8 g fis e d4 
  a' a, d d 
  a'8 gis fis4 gis cis 
  fis,8 gis a4 e2 
  a8 fis e d cis b a4 
  e' e a,2 
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