
\version "2.10.33"

\header {
  title = "310 - Mach's mit mir, Gott, nach deiner Güt"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key e \major
}

soprano = \relative c {
  \partial 4 e'8 fis 
  gis4 a b b 
  a gis fis b 
  cis dis e dis8 cis 
  cis2 b4 e,8 fis 
  gis4 a b b 
  a gis fis b 
  cis dis e dis8 cis 
  cis2 b4 b 
  e dis8 cis cis4 b 
  a gis8 fis fis4 b 
  a gis fis8 gis a4 
  gis fis e2 
}


alto = \relative c {
  \partial 4 b'4 
  e e e e 
  e8 dis e4 dis fis 
  fis ais b8 fis fis gis 
  gis4 ais fis b, 
  e e e e 
  e8 dis e4 dis fis 
  fis ais b8 fis fis gis 
  gis4 ais fis gis 
  cis b4. a4 gis fis8 e4 dis d 
  c b a8 b c4 
  b8 e4 dis8 b2 
}


tenor = \relative c {
  \partial 4 gis'8 a 
  b4 cis d cis8 b 
  cis4 b b dis 
  cis fis b,8 cis dis e 
  e dis cis4 dis gis,8 a 
  b4 cis d cis8 b 
  cis4 b b dis 
  cis fis b,8 cis dis e 
  e dis cis4 dis e 
  gis gis gis8 fis fis dis 
  e b b4 b gis8 fis 
  e4 f fis fis 
  gis8. a16 b8 fis gis2 
}


baixo = \relative c {
  \partial 4 e,4 
  e' cis gis cis 
  fis, gis8 a b4 b' 
  ais gis8 fis gis ais b4 
  e, fis b, e, 
  e' cis gis cis 
  fis, gis8 a b4 b' 
  ais gis8 fis gis ais b4 
  e, fis b, e8 dis 
  cis4 gis a b 
  cis8 dis e4 b b 
  c cis d dis 
  e b e,2 
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