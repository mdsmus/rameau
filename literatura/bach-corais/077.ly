
\version "2.10.33"

\header {
  title = "77 - In dich hab ich gehoffet, Herr 1"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \major
}

soprano = \relative c {
  \partial 4 a''4 
  a e' e d8 cis 
  b4 cis d8 cis b4 
  a2 s4 a 
  b cis d b 
  e fis e cis 
  cis8 d e4 d cis8 b 
  a b cis4 b cis 
  a b8 cis d4 cis 
  b cis d cis 
  b a e'4. d8 
  cis4 d8 cis b2 
  a1 
}


alto = \relative c {
  \partial 4 fis'4 
  e8 fis gis a b4 e, 
  dis e d8 a' gis4 
  e2 s4 fis 
  fis e8 cis gis' fis e dis 
  e fis16 gis a8 fis gis4 a 
  a ais b8 a gis fis 
  e fis16 gis a8 fis gis4 a8 gis 
  fis4. gis16 ais b4 ais 
  b8 a g4 fis e8 a4 gis fis8 gis a b4. e,8 a2 gis4 
  e1 
}


tenor = \relative c {
  \partial 4 cis'8 d 
  e4 d8 cis b4 a 
  b a8 g a4 e'8 d 
  cis2 s4 a 
  a gis b8 a b4 
  b8 e4 dis8 e4 e 
  fis fis fis e 
  e8 d cis dis e4 e 
  d8 cis d e fis4 fis8 e 
  d4 e a, a 
  b cis8 dis e2 
  e8 cis a cis fis d b e 
  cis1 
}


baixo = \relative c {
  \partial 4 fis4 
  cis' b8 a gis4 a4. g8 fis e fis d e4 
  a,2 s4 d 
  dis8 e4 f fis8 gis a 
  gis e b' b, e4 a8 gis 
  fis e d cis b4 e8 d 
  cis b a4 e' a, 
  d8 e d cis b4 fis' 
  g8 fis e4 d a 
  e'8*5 fis8 gis e 
  a gis fis e d b e4 
  a,1 
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