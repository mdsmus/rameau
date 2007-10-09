
\version "2.10.33"

\header {
  title = "144 - Aus tiefer Not schrei ich zu dir 2"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \major
}

soprano = \relative c {
  r4 a'' gis a 
  b b a b 
  cis2 r4 d 
  cis b a gis8 a 
  b2 a 
  r4 a gis a 
  b b a b 
  cis2 r4 d 
  cis b a gis8 a 
  b2 a 
  r4 a b8 cis d4 
  cis8 b a4 b8 a gis4 
  fis2 r4 gis 
  e e b' cis 
  d8 cis b4 a2 
  r4 e' cis cis 
  b a gis a 
  b2 a 
}


alto = \relative c {
  r4 e' d e 
  fis cis cis fis 
  f2 r4 fis 
  e8 cis dis f fis4 e 
  fis e8 d cis2 
  r4 e d e 
  fis cis cis fis 
  f2 r4 fis 
  e8 cis dis f fis4 e 
  fis e8 d cis2 
  r4 e fis f8 fis 
  gis4 cis, fis4. f8 
  cis2 r4 dis 
  e8 d4 cis8 dis e e4 
  d8 fis g2 fis4 
  r4 b4. a16 gis a4. gis16 fis e4 e e 
  e4. d8 cis2 
}


tenor = \relative c {
  r4 cis' b a2 gis4 a gis8 fis 
  gis2 r4 a 
  a b cis b8 a 
  a4 gis e2 
  r4 cis' b a2 gis4 a gis8 fis 
  gis2 r4 a 
  a b cis b8 a 
  a4 gis e2 
  r4 cis' d8 cis b a 
  gis4 a8 gis fis4 cis'8 b 
  a2 r4 gis 
  gis a fis8 gis g fis 
  fis d d'4 d2 
  r4 e e cis8 d16 e 
  fis8 e a,4 d8 b a2 gis4 e2 
}


baixo = \relative c {
  r4 a b cis 
  dis f fis8 e d4 
  cis2 r4 fis8 gis 
  a4. gis8 fis e d cis 
  d b e4 a,2 
  r4 a b cis 
  dis f fis8 e d4 
  cis2 r4 fis8 gis 
  a4. gis8 fis e d cis 
  d b e4 a,2 
  r4 a'2 gis8 fis 
  f4 fis8 e d b cis4 
  fis,2 r4 c' 
  cis8 b a4. gis8 ais4 
  b4. cis8 d2 
  r4 gis, a8 cis fis e 
  d4. cis8 b e cis a 
  e'4 e, a2 
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