
\version "2.10.33"

\header {
  title = "273 - Ein feste Burg ist unser Gott"
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
  a2 d,4 a' 
  b cis d cis 
  d cis b2 
  a4 b b a 
  b8 a g4 fis d' 
  cis b a b8 a 
  g fis e4 d2 
}


alto = \relative c {
  \partial 4 a''4 
  a8 g fis e d4 e 
  a,8 a'4 gis8 e4 b' 
  e,8 fis g4 fis8 e d cis 
  b4 cis a a' 
  a8 g fis e d4 e 
  a,8 a'4 gis8 e4 b' 
  e,8 fis g4 fis8 e d cis 
  b4 cis a d 
  cis8 fis e4 e8 fis e4 
  e2 d4 d8 c 
  b d g4 fis fis 
  fis e8 a fis4 e8 d 
  cis4 e d8 e fis4 
  fis fis8 e dis4 fis 
  e d8 g g fis16 e fis4 
  g8 b, cis4 a2 
}


tenor = \relative c {
  \partial 4 fis'8 e 
  d e fis g a4 g 
  fis b,8 e cis4 fis,8 gis 
  a4 e'8 d cis4 b8 cis 
  d4 a8 g fis4 fis'8 e 
  d e fis g a4 g 
  fis b,8 e cis4 fis,8 gis 
  a4 e'8 d cis4 b8 cis 
  d4 a8 g fis4 fis8 g 
  a d cis b cis4 b 
  cis2 fis,8 g a4 
  d e a, a 
  a8 gis a4 a gis 
  e g8 a b cis d c 
  b4 b b b8 a 
  g a b4 e8 cis d4 
  d a8 g fis2 
}


baixo = \relative c {
  \partial 4 d'8 cis 
  b4 a8 g fis g fis e 
  d4 e a, b 
  cis8 d e4 fis g8 a 
  b g a a, d4 d'8 cis 
  b4 a8 g fis g fis e 
  d4 e a, b 
  cis8 d e4 fis g8 a 
  b g a a, d4 d8 e 
  fis4 gis a8 d, e4 
  a,2 b4 fis' 
  g e d fis 
  b, cis d e 
  a, e'8 fis g4 d 
  dis e b b 
  e8 fis g e cis a d cis 
  b g a4 d,2 
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