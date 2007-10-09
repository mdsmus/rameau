
\version "2.10.33"

\header {
  title = "45 - Kommt her zu mir, spricht Gottes Söhn"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key b \minor
}

soprano = \relative c {
  \partial 4 b''4 
  b b fis' e 
  fis8 e d4 cis b8 cis 
  d4 cis d8 e fis4 
  e d cis d8 cis 
  b4 b e4. d8 
  cis d16 e d8 cis b2 
  a4 a d cis 
  d8 e fis4 e d 
  cis b8 cis d4 cis 
  d8 e fis4 e d 
  cis fis fis fis 
  e4. d8 cis4 d8 e 
  cis2 b 
}


alto = \relative c {
  \partial 4 fis'4 
  g g fis8 gis ais b 
  cis4 b ais b8 ais 
  b4 fis fis fis 
  b8 cis fis, gis ais4 b 
  fis e8 fis gis2 
  a4 a a gis 
  e fis b cis8 ais 
  b4 b b8 cis fis,4 
  fis fis e e 
  fis8 g a4 g fis 
  fis fis8 e d fis b a 
  g fis e2 d8 g 
  g4 fis8 e dis2 
}


tenor = \relative c {
  \partial 4 d'4 
  e e d g 
  fis fis fis fis8 e 
  fis4 fis8 e d cis b d 
  d cis d b cis4 fis8 e 
  d cis b4 b cis8 d 
  e4 a, fis' e8 d 
  cis4 d8 e fis4 fis 
  fis8 e d4 d8 cis cis b 
  ais4 d8 cis b gis a4 
  a d d8 cis cis b 
  ais4 cis cis b 
  b2 a8 g' fis b, 
  b4 ais fis2 
}


baixo = \relative c {
  \partial 4 b4 
  e8 fis g a b d cis b 
  ais fis b b, fis'4 d8 cis 
  b b' ais fis b cis d b 
  gis ais b b, fis'4 b, 
  b'8 a gis fis e d cis b 
  a cis fis e d b e e, 
  a4 d8 cis b b' ais fis 
  b cis d b gis ais b b, 
  fis'4 b8 a gis e a g 
  fis e d cis b ais b4 
  fis ais b8 cis d dis 
  e fis g gis a ais b g 
  e cis fis fis, b2 
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