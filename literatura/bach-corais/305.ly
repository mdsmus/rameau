
\version "2.10.33"

\header {
  title = "305 - Wie schön leuchtet der Morgenstern"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key d \major
}

soprano = \relative c {
  \partial 4 d'4 
  a' fis8 e d4 a' 
  b8. cis32 d b4 a a 
  b cis d cis 
  b8 d cis b a4 fis 
  b a g fis 
  e2 d4 d 
  a' fis8 e d4 a' 
  b8. cis32 d b4 a a 
  b cis d cis 
  b8 d cis b a4 fis 
  b a g fis 
  e2 d4 s4 
  a'2 fis 
  a fis 
  fis4 fis e e 
  fis fis e fis 
  g fis e2 
  d d'4 cis 
  b a g fis 
  e2 d4 
}


alto = \relative c {
  \partial 4 a'4 
  a a b cis 
  fis e e fis 
  g g fis e8 a 
  a4 gis e d 
  d d d8 cis d4 
  d cis a a 
  a a b cis 
  fis e e fis 
  g g fis e8 a 
  a4 gis e d 
  d d d8 cis d4 
  d cis a s4 
  e'2 d 
  e d 
  d4 d cis cis 
  d d cis dis 
  e d8 cis b4 cis 
  a2 fis'4 fis8 e 
  d e fis4 fis8 e e d 
  d cis16 b cis4 a 
}


tenor = \relative c {
  \partial 4 fis4 
  e d8 e fis gis a4 
  a gis cis d 
  d e a,8 b cis4 
  fis,8 fis' e d cis4 a 
  g a b8 g a4 
  a4. g8 fis4 fis 
  e d8 e fis gis a4 
  a gis cis d 
  d e a,8 b cis4 
  fis,8 fis' e d cis4 a 
  g a b8 g a4 
  a4. g8 fis4 s4 
  a2 a 
  cis a 
  a4 a a a 
  a a a a 
  b8 cis d4 d8 cis16 b a8 g 
  fis2 fis8 gis ais4 
  b cis d8 e a,4 
  b a8 g fis4 
}


baixo = \relative c {
  \partial 4 d4 
  cis d8 cis b4 fis'8 e 
  d b e4 a, d 
  g fis8 e fis gis a4 
  d, e a, d 
  g fis e d 
  a2 d4 d 
  cis d8 cis b4 fis'8 e 
  d b e4 a, d 
  g fis8 e fis gis a4 
  d, e a, d 
  g fis e d 
  a2 d4 s4 
  cis2 d 
  a d 
  d8 e fis g a b a g 
  fis e fis d a a' g fis 
  e4 b'8 a g4 a 
  d,2 b4 fis 
  g a b8 cis d4 
  g, a d 
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