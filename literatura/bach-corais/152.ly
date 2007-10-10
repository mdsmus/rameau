
\version "2.10.33"

\header {
  title = "152 - Meinen Jesum laß ich nicht, weil er sich für mich gegeben"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key d \major
}

soprano = \relative c {
  a''4 a b b 
  cis cis d2 
  e4 e d d 
  cis b8 cis16 d b2 
  a a4 a 
  b b a g 
  fis2 a4 a 
  g g fis e8 fis16 g 
  e2 d 
  d'4 d cis cis 
  b b a2 
  a4 a g fis 
  e e d2 
}


alto = \relative c {
  fis'8 g a4 a g 
  g8 e a g fis2 
  a4 a a gis8 fis 
  e4 e fis e 
  e2 fis8 g a4 
  a g g8 fis fis e 
  d2 cis4 fis 
  fis8 e16 d e4. d8 d4 
  d cis a2 
  fis'4 fis fis e 
  fis e e2 
  fis4 fis fis8 e4 d8 
  d cis16 b cis4 a2 
}


tenor = \relative c {
  d'4 d d e 
  e a, a2 
  cis4 cis cis b 
  b8 a a4 a gis 
  cis2 d4 d 
  d e e8 cis d a 
  a2 a4 b 
  b a a b 
  a g fis2 
  b4 b a a 
  a gis cis2 
  cis4 d d8 a a b 
  b g e a fis2 
}


baixo = \relative c {
  d8 e fis d g fis g e 
  a g fis e d2 
  a8 b cis a b cis d b 
  cis d e cis d b e4 
  a,2 d8 e fis d 
  g fis e d cis a b cis 
  d2 fis8 e dis b 
  e d cis a d fis g e 
  a g a a, d2 
  b8 cis d e fis gis a fis 
  dis b e4 a,2 
  fis'8 e d cis b cis d b 
  g e a4 d,2 
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