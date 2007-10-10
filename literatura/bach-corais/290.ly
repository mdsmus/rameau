
\version "2.10.33"

\header {
  title = "290 - Es ist das Heil uns kommen her"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key e \major
}

soprano = \relative c {
  \partial 4 b''4 
  b b b8 cis d4 
  cis b a b8 a 
  gis fis e fis gis4 ais 
  b cis b b 
  b b b8 cis d4 
  cis b a b8 a 
  gis fis e fis gis4 ais 
  b cis b b 
  e dis cis dis 
  e8 dis cis4 b b 
  e b cis gis8 a 
  b4 a gis gis 
  fis8 gis a4 gis fis 
  cis dis e 
}


alto = \relative c {
  \partial 4 gis''4 
  fis8 gis a4 gis8 a b4 
  b8 a d, e fis4 fis 
  e b e cis 
  fis4. e8 dis4 gis 
  fis8 gis a4 gis8 a b4 
  b8 a d, e fis4 fis 
  e b e cis 
  fis4. e8 dis4 e8 fis 
  gis ais b4 ais8 gis fis4 
  b8 gis ais4 fis gis8 a 
  b a gis fis f fis gis cis, 
  cis gis' gis fis fis f f4 
  fis8 e dis cis b cis dis4 
  e b b 
}


tenor = \relative c {
  \partial 4 e'4 
  b fis' e e 
  e8 fis g4 d b 
  b8 a gis4 cis fis, 
  fis8 b ais4 fis e' 
  b fis' e e 
  e8 fis g4 d b 
  b8 a gis4 cis fis, 
  fis8 b ais4 fis gis 
  cis dis8 e fis4 b, 
  b fis'8 e dis4 e 
  b8 cis d4 cis8 dis f fis 
  gis cis, cis4 cis cis 
  cis8 b a4 e' b8 a 
  g4 fis8 a gis4 
}


baixo = \relative c {
  \partial 4 e4 
  e dis e gis, 
  a b8 cis d4 dis 
  e4. dis8 cis dis e fis 
  dis b fis'4 b, e 
  e dis e gis, 
  a b8 cis d4 dis 
  e4. dis8 cis dis e fis 
  dis b fis'4 b, e8 dis 
  cis4 b fis'8 gis a fis 
  gis e fis4 b, e8 fis 
  gis a b4 b8 a gis fis 
  f4 fis cis cis'8 b 
  a gis fis4 gis8 a b4 
  b8 ais b4 e, 
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