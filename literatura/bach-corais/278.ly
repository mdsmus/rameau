
\version "2.10.33"

\header {
  title = "278 - Wie schön leuchtet der Morgenstern"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key e \major
}

soprano = \relative c {
  \partial 4 e'4 
  b' gis e b' 
  cis cis b b 
  cis dis e dis 
  cis cis b gis 
  cis b a gis 
  fis2 e4 e 
  b' gis e b' 
  cis cis b b 
  cis dis e dis 
  cis cis b gis 
  cis b a gis 
  fis2 e4 s4 
  b'2 gis 
  b gis 
  a4 gis fis gis 
  a gis fis gis 
  a gis fis2 
  e e'4 dis 
  cis b a gis 
  fis2 e4*5 
}


alto = \relative c {
  \partial 4 b'4 
  b b cis dis 
  gis fis fis gis 
  a a gis fis 
  fis8 gis fis e dis4 e 
  e dis e8 fis gis e 
  e4 dis b b 
  b b cis dis 
  gis fis fis gis 
  a a gis fis 
  fis8 gis fis e dis4 e 
  e dis e8 fis gis e 
  e4 dis b s4 
  fis'2 e 
  fis e 
  fis4 e dis e 
  fis e dis e 
  fis e8 dis cis dis16 e dis4 
  b2 gis'4 g 
  gis gis8 fis e4 e 
  e dis b4*5 
}


tenor = \relative c {
  \partial 4 gis'4 
  fis e8 fis gis ais b4 
  b ais dis e 
  e fis b, b 
  b ais b b 
  a8 gis fis4 cis' b 
  b4. a8 gis4 gis 
  fis e8 fis gis ais b4 
  b ais dis e 
  e fis b, b 
  b ais b b 
  a8 gis fis4 cis' b 
  b4. a8 gis4 s4 
  b2 b 
  dis cis 
  cis4 b b b 
  b b b b 
  cis8 dis e4. cis8 b a 
  gis2 cis8 b ais4 
  gis dis' cis b 
  cis b8 a gis4*5 
}


baixo = \relative c {
  \partial 4 e4 
  dis e cis gis' 
  e fis b, e 
  a gis8 fis gis ais b4 
  fis fis, b e 
  a, b cis8 dis e4 
  b2 e4 e 
  dis e cis gis' 
  e fis b, e 
  a gis8 fis gis ais b4 
  fis fis, b e 
  a, b cis8 dis e4 
  b2 e4 s4 
  dis2 e 
  b cis 
  fis4 gis a8 gis fis e 
  dis4 e b8 b' a gis 
  fis4 cis8 b a4 b 
  e2 cis4 dis 
  f8 g gis4 cis,8 dis e4 
  ais, b e4*5 
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