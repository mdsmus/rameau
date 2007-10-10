
\version "2.10.33"

\header {
  title = "63 - O Welt, ich muß dich lassen"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \major
}

soprano = \relative c {
  \partial 4 cis''4 
  a b cis8 d e4 
  d2 cis4 cis 
  e e b d8 cis 
  a2 gis4 e 
  a b cis8 d16 e d8 cis 
  b2. cis4 
  a b cis8 d e4 
  d2 cis4 cis8 d 
  e4 e b cis 
  a2 gis4 e 
  a b cis8 d e d 
  cis4 b a2 
}


alto = \relative c {
  \partial 4 a''4 
  fis gis a8 b cis4 
  cis b8 a gis4 a 
  a a gis b8 a 
  fis2 e4 b 
  e fis8 gis a b16 cis b8 a 
  gis2. gis4 
  fis e e fis 
  fis f fis fis 
  e a8 gis fis4 e8 dis16 cis 
  fis2 e4 e 
  e d cis8 e a4 
  a gis e2 
}


tenor = \relative c {
  \partial 4 e'4 
  d d e a, 
  a b cis fis 
  e e e e 
  e dis gis, gis 
  a d e8 a, gis a 
  e'2. cis4 
  cis b a8 b cis4 
  b gis ais a 
  a a a gis 
  cis b b cis 
  cis b e4. fis8 
  e4 d cis2 
}


baixo = \relative c {
  \partial 4 a'4 
  d cis8 b a4. g8 
  fis2 f4 fis 
  cis8 b cis d e4 a, 
  b c cis d 
  cis b a d 
  e2. f4 
  fis gis a ais 
  b2 fis4 fis 
  cis8 b cis4 dis e 
  e dis e cis 
  fis8 e fis gis a4 cis,8 d 
  e4 e a,2 
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