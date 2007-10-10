
\version "2.10.33"

\header {
  title = "32 - Nun danket alle Gott"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \major
}

soprano = \relative c {
  \partial 4 e''4 
  e e fis fis 
  e2 s4 cis 
  d cis b cis8. d16 
  b2 a4 e' 
  e2 fis4 fis 
  e2 s4 cis 
  d cis b cis8. d16 
  b2 a4 b 
  b b cis cis 
  b2 s4 b 
  cis8 dis e4 e dis 
  e2 s4 e 
  fis e d cis 
  d2 s4 cis 
  b cis8. d16 b4. a8 
  a2. 
}


alto = \relative c {
  \partial 4 a''4 
  a a a a 
  a2 s4 a 
  b a gis a 
  a8 fis gis4 e a 
  a a a a 
  a2 s4 a 
  b a gis a 
  a8 fis gis4 e gis8 fis 
  e4 e e e 
  e2 s4 gis 
  a gis fis fis 
  gis2 s4 a 
  a8 b cis4 cis8 b4 ais8 
  b2 s4 a 
  gis a a gis 
  e2. 
}


tenor = \relative c {
  \partial 4 cis'4 
  cis cis d d 
  cis2 s4 fis 
  e e e e 
  e8 d16 cis d4 cis cis 
  cis cis d d 
  cis2 s4 fis 
  e e e e 
  e8 d16 cis d4 cis b8 a 
  gis a b4 b8 a16 gis a4 
  gis2 s4 e' 
  e e cis b 
  b2 s4 cis 
  d cis fis g8 fis 
  fis2 s4 e 
  e e8 fis fis d b8. e16 
  cis2. 
}


baixo = \relative c {
  \partial 4 a4 
  a'8 b cis a d, e fis d 
  a'2 s4 a 
  gis a e8 d cis a 
  e'2 a,4 a 
  a'8 b cis a d, e fis d 
  a'2 s4 a 
  gis a e8 d cis a 
  e'2 a,4 e' 
  e8 fis gis e a, b cis a 
  e2 s4 e' 
  a8 b cis gis a fis b b, 
  e2 s4 a, 
  d8 cis b ais b d e fis 
  b,2 s4 cis8 d 
  e4 a8 fis d b e e, 
  a2. 
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