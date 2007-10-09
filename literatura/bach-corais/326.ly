
\version "2.10.33"

\header {
  title = "326 - Allein Gott in der Höh sei Ehr"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \major
}

soprano = \relative c {
  \partial 4 a''8 b 
  cis4 d e d 
  cis b cis cis 
  cis b8 cis d cis b4 
  a b a a8 b 
  cis4 d e d 
  cis b cis cis 
  cis b8 cis d cis b4 
  a b a a 
  b cis d cis 
  b cis b b 
  cis d e d 
  cis b cis a 
  b cis d8 cis b4 
  a8 fis gis4 a2 
}


alto = \relative c {
  \partial 4 e'4 
  a a gis fis8 gis 
  a4 gis a e 
  fis fis8 e d e e4 
  e8 a gis fis e4 e 
  a a gis fis8 gis 
  a4 gis a e 
  fis fis8 e d e e4 
  e8 a gis fis e4 e 
  e e d8 e fis4 
  fis8 e e d16 cis d4 e 
  e fis gis fis 
  e d8 fis16 f fis4 fis 
  fis e d e 
  e8 fis e4 e2 
}


tenor = \relative c {
  \partial 4 cis'8 d 
  e4 fis b,8 cis d4 
  e e e a, 
  a2. d8 b 
  e d16 cis d4 cis cis8 d 
  e4 fis b,8 cis d4 
  e e e a, 
  a2. d8 b 
  e d16 cis d4 cis cis 
  gis ais b ais 
  b ais fis b 
  a a b a8 b 
  cis4 fis,8 gis a4 cis 
  fis,8 gis a4 a gis 
  a8 d b4 cis2 
}


baixo = \relative c {
  \partial 4 a4 
  a'8 gis fis4 e b 
  cis8 d e4 a, a'8 gis 
  fis e d cis b a gis4 
  cis8 a e'4 a, a 
  a'8 gis fis4 e b 
  cis8 d e4 a, a'8 gis 
  fis e d cis b a gis4 
  cis8 a e'4 a, a 
  e' d8 cis b4 e8 fis 
  g4 fis b, gis' 
  a8 gis fis4 e fis8 gis 
  a4 b fis fis8 e 
  d4 cis b8 cis d4 
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