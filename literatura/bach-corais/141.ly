
\version "2.10.33"

\header {
  title = "141 - Seelenbräutigam, Jesu, Gottes Lamm"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \major
}

soprano = \relative c {
  a''4 a gis a 
  b2 a4 b 
  cis b a2 
  cis4 d e d 
  cis b cis2 
  b a4 b 
  cis b a gis 
  a4. gis8 gis2 
  a4 a gis a 
  b2 a4 b 
  cis b8 a a2 
}


alto = \relative c {
  e'4 e e e8 fis 
  gis2 fis4 e 
  e e e2 
  a4 a a4. b4 a8 gis b4 a16 gis a4 
  gis2 fis4. e8 
  e a fis gis4 fis f8 
  fis f fis2 e4 
  fis e e e 
  e2 cis8 fis e4. a8 gis4 e2 
}


tenor = \relative c {
  cis'4 cis b cis 
  e2 cis8 d cis b4 a gis8 cis2 
  e4 fis e fis8 e 
  e4 e e2 
  e cis4 b 
  a4. gis8 cis c16 cis dis8 cis 
  cis1 
  cis4 cis b a2 gis4 a8 d cis b 
  a e' e8. d16 cis2 
}


baixo = \relative c {
  a8 b cis d e4 a, 
  e'2 fis4 gis 
  a e a,2 
  a'8 gis fis4 cis fis8 gis 
  a4 e8 gis a4 a, 
  e'2 fis4 gis 
  a8 fis dis f fis dis c cis 
  fis, gis a b cis2 
  fis4 cis8 d e4 cis8 a 
  e'2 fis4 gis 
  a e a,2 
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