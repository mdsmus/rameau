
\version "2.10.33"

\header {
  title = "44 - Mach's mit mir, Gott, nach deiner Güt"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key d \major
}

soprano = \relative c {
  \partial 4 d'8 e 
  fis4 g a a 
  g fis e a 
  b cis d cis 
  b2 a4 d,8 e 
  fis4 g a a 
  g fis e a 
  b cis d cis 
  b2 a4 a 
  d cis b a 
  g fis e a 
  g fis e8 fis g4 
  fis e d2 
}


alto = \relative c {
  \partial 4 a'4 
  d d e d8 cis 
  b cis d4 cis e 
  fis8 gis a4 b a2 gis4 e a, 
  d d e d8 cis 
  b cis d4 cis e 
  fis8 gis a4 b a2 gis4 e e 
  fis e d8 e fis4 
  e a,8 b cis4 fis8 e 
  d e4 d cis8 d4 
  d cis a2 
}


tenor = \relative c {
  \partial 4 fis8 g 
  a4 g8 fis e4 fis 
  g a a a 
  d e e e 
  fis e8 d cis4 fis,8 g 
  a4 g8 fis e4 fis 
  g a2 cis4 
  d e e e 
  fis e8 d cis4 cis8 b 
  a fis g a b4 b 
  b8 cis d4 a cis 
  b8 a a4 a g 
  a4. g8 fis2 
}


baixo = \relative c {
  \partial 4 d4 
  d8 cis b4 cis d 
  e fis8 g a4 cis 
  b a gis a 
  d, e a, d 
  d8 cis b4 cis d 
  e fis8 g a4 cis 
  b a gis a 
  d, e a, a'8 g 
  fis d e fis g fis e dis 
  e4 fis8 gis a4 fis 
  b,8 cis d4 a b 
  a8 g a4 d,2 
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