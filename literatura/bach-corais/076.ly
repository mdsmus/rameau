
\version "2.10.33"

\header {
  title = "76 - Wie nach einer Wasserquelle"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \major
}

soprano = \relative c {
  a''4 b cis b 
  a gis fis2 
  e a4 b 
  cis d cis b 
  a1 
  a4 b cis b 
  a gis fis2 
  e a4 b 
  cis d cis b 
  a1 
  cis4 d e d 
  cis b cis2 
  e4 e fis e 
  d cis b2 
  cis8 d e4 d cis8 b 
  a4 b cis2 
  a cis8 d e4 
  d cis b cis8. d16 
  b2 a 
}


alto = \relative c {
  e'4 e a dis, 
  e8 fis fis e e4 dis 
  b2 fis'4 fis8 e 
  e4 b' b8 a a gis 
  e1 
  e4 e a dis, 
  e8 fis fis e e4 dis 
  b2 fis'4 fis8 e 
  e4 b' b8 a a gis 
  e1 
  a4 a8 g g4 fis8 gis 
  ais4 b8 b, fis'2 
  e4 a8 g fis4 gis 
  a8 e4 fis8 gis2 
  a4 b a gis 
  gis8 fis fis gis a4 gis 
  fis2 ais4 b8 fis 
  fis gis a4 gis a4. gis16 fis gis4 e2 
}


tenor = \relative c {
  cis'4 e e8 fis fis gis 
  cis, b b4 cis b8 a 
  gis2 cis4 b 
  b8 a a gis e'4 e8 d 
  cis1 
  cis4 e e8 fis fis gis 
  cis, b b4 cis b8 a 
  gis2 cis4 b 
  b8 a a gis e'4 e8 d 
  cis1 
  e4 b b8 ais b4 
  fis8 fis'4 e8 ais,2 
  a8 b cis4 cis8 b b cis 
  cis b cis dis e2 
  e4 e a,8 b cis4 
  cis d8 b fis'4. f8 
  cis2 fis4 b,8 cis 
  d4 e e e 
  e4. d8 cis2 
}


baixo = \relative c {
  a'4 gis a b 
  cis8 dis e4 a, b 
  e,2 fis4 gis 
  a b cis8 d e e, 
  a1 
  a4 gis a b 
  cis8 dis e4 a, b 
  e,2 fis4 gis 
  a b cis8 d e e, 
  a1 
  a,4 b cis d8 e 
  fis4 g fis2 
  cis8 b a4 d e 
  fis8 gis a4 e2 
  a4 a8 gis fis4 f 
  fis8 e d4 a'8 b cis4 
  fis,2 fis4 gis8 ais 
  b4 cis8 d e, d cis a 
  e'2 a, 
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