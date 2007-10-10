
\version "2.10.33"

\header {
  title = "275 - O Welt, ich muß dich lassen"
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
  e4 e b cis 
  a2 gis4 e 
  a b cis8 d16 e d8 cis 
  b2. cis4 
  a b cis8 d e4 
  d2 cis4 cis8 d 
  e4 e b cis 
  a2 gis4 e 
  a b cis d 
  cis b a2 
}


alto = \relative c {
  \partial 4 gis''4 
  fis e e e 
  fis e e a 
  a8 gis a4 gis8 fis4 e8 
  e4 dis e e8 d 
  cis4 e e a 
  gis2. gis4. fis4 e8 e4 fis 
  fis2 fis4 e 
  e8 fis gis4 fis e 
  fis2 e4 gis 
  a4. gis8 a4 a 
  a4. gis8 e2 
}


tenor = \relative c {
  \partial 4 cis'4 
  cis b a a 
  a gis a e' 
  e e e gis, 
  fis8 gis a4 b gis 
  cis b a fis' 
  b,2. gis4 
  cis b a8 b cis4 
  cis b ais a 
  b b b8 a gis4 
  cis b b b 
  e d e d 
  e8 fis b,16 cis d8 cis2 
}


baixo = \relative c {
  \partial 4 f4 
  fis gis a cis, 
  b e a, a' 
  cis, cis8 d e4 cis 
  fis2 e4 e 
  fis gis a d, 
  e2. f4 
  fis gis a ais 
  b2 fis4 a 
  gis fis8 e dis4 e 
  e dis e e8 d 
  cis4 b a8 g'4 fis8 
  e dis e4 a,2 
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