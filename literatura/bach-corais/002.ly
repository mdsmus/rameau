
\version "2.10.33"

\header {
  title = "2 - Ich dank dir, lieber Herre"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \major
}

soprano = \relative c {
  \partial 4 a''4 
  a a a b 
  g fis e b' 
  cis b a gis8 fis 
  gis4 fis e a 
  a a a b 
  g fis e b' 
  cis b a gis8 fis 
  gis4 fis e e' 
  d cis b a 
  a8 b cis4 b cis 
  d cis b ais 
  b2. e,4 
  a b cis d 
  e d8 cis b4 d 
  cis b e4. d8 
  cis b a b cis4 b 
  a2. 
}


alto = \relative c {
  \partial 4 e'4 
  fis e fis fis 
  e dis b gis' 
  a gis8 fis e2. dis4 b e 
  fis e fis fis 
  e dis b gis' 
  a gis8 fis e2. dis4 b cis'8 b 
  a4 a gis a8 g 
  fis gis a4 gis ais 
  b8 a g4 fis8 e fis4 
  fis2. e8 d 
  cis4 d e fis8 gis 
  a2 e4 b' 
  a8 gis fis4 e fis8 gis 
  a2 a4 gis 
  e2. 
}


tenor = \relative c {
  \partial 4 cis'4 
  cis cis8 b a gis fis4 
  b4. a8 gis4 e' 
  e dis cis2 
  b4. a8 gis4 cis 
  cis cis8 b a gis fis4 
  b4. a8 gis4 e' 
  e dis cis2 
  b4. a8 gis4 gis 
  a8 b cis d e4 e 
  d e e e 
  fis8 b,4 ais8 b4 cis 
  d2. gis,4 
  a gis8 fis e e' d4 
  cis8 d e fis gis4 fis 
  fis8 e d cis b4 cis8 d 
  e4. d8 cis fis b, e16 d 
  cis2. 
}


baixo = \relative c {
  \partial 4 a'8 gis 
  fis4 cis d dis 
  e b e, e' 
  a b cis b8 a 
  b4 b, e a8 gis 
  fis4 cis d dis 
  e b e, e' 
  a b cis b8 a 
  b4 b, e cis 
  fis8 gis a4 e cis8 a 
  d4 cis8 d e4 cis 
  b cis d8 g fis4 
  b,2. cis4 
  fis e8 d cis4 b 
  a8 b cis d e4 b 
  fis'8 gis a4 gis8 e a4. gis8 fis4 e8 d e4 
  a,2. 
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