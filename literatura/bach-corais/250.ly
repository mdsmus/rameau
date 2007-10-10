
\version "2.10.33"

\header {
  title = "250 - Ein feste Burg ist unser Gott"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key d \major
}

soprano = \relative c {
  \partial 4 d''4 
  d d a8 b cis4 
  d8 cis b4 a d 
  cis b a b8 a 
  g fis e4 d d' 
  d d a8 b cis4 
  d8 cis b4 a d 
  cis b a b8 a 
  g fis e4 d d 
  a' b a gis 
  a d, a' b8 cis 
  d4 cis d8 cis b4 
  a b b a 
  b8 a g4 fis d' 
  cis b a b8 a 
  g fis e4 d2 
}


alto = \relative c {
  \partial 4 a''4 
  a8 g fis g a fis g a 
  fis e d e cis4 fis 
  e8 fis g4 fis8 e d4 
  d cis a a' 
  a8 g fis g a fis g a 
  fis e d e cis4 fis 
  e8 fis g4 fis8 e d4 
  d cis a d 
  cis8 fis e d cis d b4 
  a d d g8 g 
  fis4 fis fis16 gis a8 a gis 
  a4 g g fis 
  fis e dis fis8 gis 
  a4 g g fis8 e 
  d4 cis a2 
}


tenor = \relative c {
  \partial 4 fis'8 e 
  d4 c8 b d4 e 
  a, a8 gis a4 fis8 gis 
  a4 e'8 d cis4 b8 cis 
  d4 a8 g fis4 fis'8 e 
  d4 c8 b d4 e 
  a, a8 gis a4 fis8 gis 
  a4 e'8 d cis4 b8 cis 
  d4 a8 g fis4 fis8 gis 
  a d cis b e fis e d 
  cis4 fis,8 g a4 e'8 e 
  d4 a b8 e fis e 
  cis4 b8 cis d4 d8 c 
  b4 b b b 
  e e e d8 a 
  b4 e,8 a fis2 
}


baixo = \relative c {
  \partial 4 d'8 cis 
  b4 a8 g fis4 e 
  d e a, b 
  cis8 d e4 fis g8 a 
  b g a a, d4 d'8 cis 
  b4 a8 g fis4 e 
  d e a, b 
  cis8 d e4 fis g8 a 
  b g a a, d4 d8 e 
  fis4 gis a8 d, e4 
  a, b fis' e8 a, 
  d4 fis b,8 cis d e 
  a,4 e' b8 cis d4 
  dis e b b 
  cis8 d e d cis a d cis 
  b g a4 d2 
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