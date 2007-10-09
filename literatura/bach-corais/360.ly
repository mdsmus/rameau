
\version "2.10.33"

\header {
  title = "360 - Wir Christenleut"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key fis \minor
}

soprano = \relative c {
  \partial 4 fis'8 gis 
  a4 gis fis fis8 gis 
  a4 gis fis cis' 
  b a gis gis 
  a a b b 
  cis cis b a 
  gis2 fis4 cis' 
  b a8 gis gis4 cis 
  b a gis gis 
  a a b b 
  cis cis b a8 gis 
  gis2 fis 
}


alto = \relative c {
  \partial 4 cis'4 
  fis f fis fis 
  fis f cis fis 
  fis8 f fis4 f f 
  fis fis fis8 gis16 a gis4 
  gis8 fis f fis gis4. fis8 
  fis4 f cis fis 
  fis8 f fis4 f fis8 e 
  dis e fis dis e4 gis8 f 
  fis4 a8 fis d4 b'8 gis 
  a g fis4. f8 fis4. f16 dis f4 cis2 
}


tenor = \relative c {
  \partial 4 a'8 b 
  cis4 cis8 b a4 b 
  cis cis8 b a4 a 
  b cis cis cis 
  cis d d8 e16 fis e8 d 
  cis4 b8 a d cis cis d 
  d b gis cis a4 a 
  b8 cis dis4 cis cis 
  fis, b b cis 
  cis8 a d4 d8 b e4 
  e8 cis fis e d cis dis4 
  cis8 gis cis b a2 
}


baixo = \relative c {
  \partial 4 fis4 
  fis16 gis a b cis8 cis, d4 d 
  cis8 b cis4 fis, fis' 
  gis a8 b cis4 cis, 
  fis8 e d cis d b e4 
  a,8 a' gis fis4 f8 fis d 
  b gis cis4 fis, fis'8 e 
  d cis c4 cis a 
  b8 cis dis b e4 f8 cis 
  fis4 fis8 d g4 gis8 e 
  a4 ais8 fis b4 c8 gis 
  cis4 cis, fis2 
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