
\version "2.10.33"

\header {
  title = "58 - Herzlich lieb hab ich dich, o Herr"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key d \major
}

soprano = \relative c {
  \partial 4 d''4 
  cis b a g8 fis 
  b4 b a d 
  cis b a g8 fis 
  b4 b a a 
  b cis d8 e fis4 
  e8 d e4 d d 
  cis b a g8 fis 
  b4 b a d 
  cis b a g8 fis 
  b4 b a a 
  b cis d8 e fis4 
  e8 d e4 d d 
  d e d b8 cis 
  d4 d cis cis 
  d e d b8 cis 
  d4 d cis fis 
  g8 fis e4 fis8 e d4 
  d cis d cis 
  d cis b a 
  a gis a fis' 
  e d cis fis 
  g8 fis e4 fis8 e d4 
  d cis d d 
  d d e d 
  d cis d2 
}


alto = \relative c {
  \partial 4 fis'4 
  e8 fis g fis e4 d 
  d d d fis8 f 
  fis e d e fis e d fis 
  fis4 f fis fis8 e 
  d b' a g fis g a b 
  e, fis g4 fis fis 
  e8 fis g fis e4 d 
  d d d fis8 f 
  fis e d e fis e d fis 
  fis4 f fis fis8 e 
  d b' a g fis g a b 
  e, fis g4 fis a 
  a8 g4 fis8 fis4 e 
  e e e e 
  fis g fis e 
  d8 e fis4 fis fis 
  e e a8 g fis4 
  e e fis g 
  fis e8 fis gis4 fis 
  fis e e d' 
  ais b ais cis 
  b b8 a a4 a 
  e fis fis a 
  a g8 fis g4 fis 
  e8 d e4 fis2 
}


tenor = \relative c {
  \partial 4 a'8 b 
  cis4 d e8 a, a4 
  a g fis fis8 gis 
  a4 b cis d8 cis 
  b4 cis cis d8 cis 
  b g' fis e d4 d 
  d cis a a8 b 
  cis4 d e8 a, a4 
  a g fis fis8 gis 
  a4 b cis d8 cis 
  b4 cis cis d8 cis 
  b g' fis e d4 d 
  d cis a fis'8 e 
  d4 cis b8 cis d4 
  gis,8 a b4 a a 
  a a a g 
  fis b ais b 
  b cis cis d8 cis 
  b4 a a e' 
  a,8 b cis4 d cis 
  b b cis a8 b 
  cis4 fis, fis' fis8 e 
  d4 e d d8 cis 
  b4 cis b d8 c 
  b4 b b8 a a4 
  a a a2 
}


baixo = \relative c {
  \partial 4 d4 
  a b cis d 
  g,8 a b cis d4 b 
  fis' g a b8 a 
  gis4 cis, fis d 
  g a b a8 g 
  a4 a, d d 
  a b cis d 
  g,8 a b cis d4 b 
  fis' g a b8 a 
  gis4 cis, fis d 
  g a b a8 g 
  a4 a, d d'8 cis 
  b4 ais b8 a gis fis 
  e fis gis e a4 a8 g 
  fis e d cis d4 e 
  b8 cis d e fis4 dis 
  e a8 g fis4 b8 a 
  gis4 a d, e 
  fis8 gis a4 f fis8 f 
  dis4 e a, d 
  cis b fis' ais 
  b cis d fis, 
  gis ais b fis 
  g8 a b4 cis, d 
  a' a, d2 
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