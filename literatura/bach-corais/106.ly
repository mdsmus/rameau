
\version "2.10.33"

\header {
  title = "106 - Jesu Kreuz, Leiden und Pein"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \major
}

soprano = \relative c {
  cis''4 b a b 
  cis dis e2 
  fis4 e d cis8 b 
  b2 a 
  cis4 e d cis 
  b a gis2 
  a4 b cis cis8 d16 e 
  d2 cis 
  cis4 d e d 
  cis b cis2 
  b4 b cis8 dis e4 
  e dis e2 
  e4 cis fis4. e8 
  d4 cis8 b b2 
  cis4 e d cis8 b 
  b2 a 
}


alto = \relative c {
  a''4 gis a gis 
  a8 gis fis4 gis2 
  b4 b gis a 
  a gis e2 
  a4 b a gis 
  fis fis f2 
  cis4 e e e 
  a b a2 
  a4 a a a 
  a gis a2 
  gis4 e a gis 
  fis2 gis 
  g4 g fis8 gis a4 
  a8 gis a4 gis2 
  a4 b a a 
  a gis e2 
}


tenor = \relative c {
  e'4 e e e 
  e b b2 
  d4 b e e 
  fis e8 d cis2 
  e4 e fis cis 
  d d gis,2 
  fis4 gis a b 
  fis' e e2 
  e4 d cis b 
  cis8 d e4 e2 
  e4 b a b 
  cis b b2 
  ais4 a a8 b cis4 
  d e e2 
  e4 e fis fis 
  fis e8 d cis2 
}


baixo = \relative c {
  a'4 e cis e 
  a, b e2 
  b'4 gis e a 
  d, e a,2 
  a'4 gis fis e 
  d cis8 b cis2 
  fis4 e a gis 
  fis gis a2 
  a4 fis cis d 
  e e a,2 
  e'8 fis gis4 fis e 
  a b e,2 
  g4 a d, cis 
  b a e'2 
  a4 gis fis e 
  dis e a,2 
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