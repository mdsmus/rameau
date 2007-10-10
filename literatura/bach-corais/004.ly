
\version "2.10.33"

\header {
  title = "4 - Es ist das Heil uns kommen her"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key e \major
}

soprano = \relative c {
  \partial 4 b''4 
  b b b d 
  cis b a b 
  gis e8 fis gis4 ais 
  b cis b b 
  b b b d 
  cis b a b 
  gis e8 fis gis4 ais 
  b cis b b 
  e dis cis dis 
  e8 dis cis4 b b 
  e b cis gis8 a 
  b4 a gis gis 
  fis a gis fis 
  cis dis e 
}


alto = \relative c {
  \partial 4 gis''4 
  fis8 gis a4 gis fis 
  e8 a a gis e4 fis 
  e e8 dis e4 cis 
  fis8 e16 dis e4 dis gis 
  fis8 gis a4 gis fis 
  e8 a a gis e4 fis 
  e e8 dis e4 cis 
  fis8 e16 dis e4 dis e8 fis 
  gis ais b4 ais b 
  b fis fis gis 
  e8 fis gis4 a e8 fis 
  gis4 fis f e 
  dis cis b b 
  cis b b 
}


tenor = \relative c {
  \partial 4 e'4 
  fis e8 dis e4 a,8 b 
  cis16 d e4 d8 cis4 b 
  b b8 a gis4 fis 
  fis8 b4 ais8 fis4 e' 
  fis e8 dis e4 a,8 b 
  cis16 d e4 d8 cis4 b 
  b b8 a gis4 fis 
  fis8 b4 ais8 fis4 gis 
  cis fis, fis' fis 
  b, ais dis e 
  b e e cis 
  d cis cis b 
  b e e dis8 b 
  fis2 gis4 
}


baixo = \relative c {
  \partial 4 e4 
  dis b e fis8 gis 
  a4 e a, dis 
  e8 fis gis4 cis, fis8 e 
  dis cis16 b fis'4 b, e 
  dis b e fis8 gis 
  a4 e a, dis 
  e8 fis gis4 cis, fis8 e 
  dis cis16 b fis'4 b, e 
  cis dis8 e fis4 b 
  gis8 e fis4 b, e 
  gis e a8 b cis4 
  f, fis cis e 
  b cis8 dis e4 b 
  ais b e, 
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