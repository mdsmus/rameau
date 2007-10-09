
\version "2.10.33"

\header {
  title = "363 - O Welt, ich muß dich lassen"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \major
}

soprano = \relative c {
  \partial 4 cis''4 
  a b cis8 d e4 
  d2 cis4 cis8 d 
  e4 e b cis8 b 
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
  cis b8 a gis4 fis 
  e a gis gis 
  gis8 fis e dis e4 b 
  e fis8 gis a b16 cis b8 a 
  gis2. gis4 
  fis4. e8 e4 fis 
  fis f fis fis 
  e a8 gis fis4 e8 dis16 cis 
  fis2 e4 b 
  e fis8 gis a2. gis4 e2 
}


tenor = \relative c {
  \partial 4 e'4 
  d d e8 d cis b 
  a4 b cis a 
  a e' e f 
  cis b b gis 
  a d e fis 
  b,2. gis4 
  cis b a8 b cis4 
  b gis ais a 
  a a a gis 
  cis b b gis 
  a d e4. fis8 
  e4 d cis2 
}


baixo = \relative c {
  \partial 4 a'4 
  d cis8 b a4. g8 
  fis4 gis8 fis f4 fis 
  cis8 b cis d e d cis4 
  fis b, e d 
  cis b a d 
  e2. f4 
  fis gis a ais 
  b2 fis4 fis 
  cis8 b cis4 dis e 
  e dis e d 
  cis b a8 b cis d 
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