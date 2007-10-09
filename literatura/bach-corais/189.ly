
\version "2.10.33"

\header {
  title = "189 - Herr Jesu Christ, wahr' Mensch und Gott"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \major
}

soprano = \relative c {
  \partial 4 a''4 
  a a fis b 
  a a gis cis 
  cis cis fis e 
  e dis e cis 
  cis cis d cis 
  b ais b cis 
  cis cis b a 
  a gis a2 
}


alto = \relative c {
  \partial 4 e'4 
  e8 d cis b a4 fis'8 gis4 fis16 e fis4 e e 
  a a a gis 
  gis fis8 a a gis gis4 
  fis e fis g 
  fis8 g fis e4 d8 a'4 
  a a4. gis4 fis8 
  e fis4 e8 e2 
}


tenor = \relative c {
  \partial 4 cis'8 d 
  e4 e d dis 
  e b b a 
  e' fis b, b 
  b b b cis8 b 
  a gis ais4. b4 ais8 
  b e cis4 b e 
  e fis fis8 cis cis4 
  cis8 b b cis16 d cis2 
}


baixo = \relative c {
  \partial 4 a8 b 
  cis b a4 d8 cis b4 
  cis dis e a4. gis8 fis e dis4 e8 fis 
  gis a b4 e, f 
  fis gis fis e 
  d8 e fis4 b, a 
  a'8 gis fis e dis f fis4 
  cis8 d e4 a,2 
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