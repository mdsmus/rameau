
\version "2.10.33"

\header {
  title = "320 - Meine Seel erhebt den Herren"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key fis \minor
}

soprano = \relative c {
  cis''2 e 
  cis4 cis cis cis 
  d2 cis 
  b1 
  a 
  cis2 e 
  b4 b b b 
  b2 fis4 gis 
  a2 gis 
  fis1*2 
}


alto = \relative c {
  fis'2 e 
  e4 f fis gis 
  fis e2 fis4 
  fis2 e 
  e1 
  e 
  e4 gis fis a 
  gis2 fis 
  fis2. f4 
  cis2 d1 cis2 
}


tenor = \relative c {
  a'2 b 
  cis4 b a gis 
  a b2 a4 
  a2 gis 
  a1 
  a2 a 
  gis4 b a fis' 
  e2 b 
  cis b 
  ais b1 ais2 
}


baixo = \relative c {
  fis2 gis 
  a4 gis fis f 
  fis gis a fis 
  d b e2 
  a,1 
  a4 b cis d 
  e2 dis 
  e d 
  cis1 
  fis,4 e' d b 
  fis1 
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