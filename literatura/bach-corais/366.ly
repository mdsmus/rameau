
\version "2.10.33"

\header {
  title = "366 - O Welt, ich muß dich lassen"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \major
}

soprano = \relative c {
  \partial 4 cis''8 b 
  a4 b cis8 d e4 
  d2 cis4 cis8 d 
  e4 e b cis8 b 
  a2 gis4 e 
  a b cis8 b cis d 
  b2 s4 cis8 b 
  a4 b cis8 d e4 
  d2 cis4 cis8 d 
  e4 e b cis8 b 
  a2 gis4 e 
  a b cis8 d e d 
  cis4 b a2 
}


alto = \relative c {
  \partial 4 a''8 gis 
  fis4. gis8 a4. e8 
  fis4 e e a 
  a8 gis a b gis fis e4 
  e dis e b 
  e8 fis gis4 a8 gis a b 
  gis2 s4 gis 
  fis e e8 d cis4 
  cis8 b16 a b4 a a' 
  b8 cis b a gis fis gis4 
  gis8 fis16 e fis4 e e8 d 
  cis d cis b a4 a' 
  e8 fis b, e cis2 
}


tenor = \relative c {
  \partial 4 e'4 
  fis8 e d4 e a, 
  a gis a e' 
  e e e8 d cis4 
  cis b b gis 
  a d e8 d e fis 
  e2 s4 f 
  cis8 d cis b a4 a 
  a8 fis'4 e8 e4 fis 
  e b b8 a gis fis 
  e cis'4 b8 b4 cis8 b 
  a4 gis8 fis e4. fis8 
  gis a4 gis8 e2 
}


baixo = \relative c {
  \partial 4 a'4 
  d8 cis b4 a cis, 
  b e a, a'8 b 
  cis4 cis,8 d e4 a8 gis 
  fis4 b, e e8 d 
  cis d cis b a4 a'8 d, 
  e2 s4 cis 
  fis gis a8 b a gis 
  fis4 gis a fis 
  gis8 a gis fis e fis e dis 
  cis4 dis e cis 
  fis e8 d cis b cis d 
  e d e4 a,2 
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