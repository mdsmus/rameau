
\version "2.10.33"

\header {
  title = "294 - Wenn mein Stündlein vorhanden ist 2"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key b \minor
}

soprano = \relative c {
  \partial 4 b''4 
  b ais b cis 
  d cis b b 
  cis cis fis e 
  d2 cis4 b 
  b ais b cis 
  d cis b b 
  cis cis fis e 
  d2 cis4 fis 
  e d cis8 d e4 
  d cis b d 
  cis b a8 gis fis gis 
  a b b4 cis cis 
  d e fis4. e8 
  d4 e cis2 
  b2. 
}


alto = \relative c {
  \partial 4 fis'4 
  e fis fis gis8 ais 
  b4 ais fis fis8 gis 
  a4 a8 g fis4 gis8 ais 
  b2 ais4 fis 
  e fis fis gis8 ais 
  b4 ais fis fis8 gis 
  a4 a8 g fis4 gis8 ais 
  b2 ais4 a 
  a8 g fis gis ais b cis4 
  b ais fis fis8 gis 
  a4. gis8 fis e fis4 
  cis fis8 e e4 fis 
  fis8 b a g fis4 gis8 a 
  b a g4 fis2 
  fis2. 
}


tenor = \relative c {
  \partial 4 d'4 
  cis8 b cis4 d e 
  fis4. e8 d4 d 
  e a, d8 cis b cis 
  d e fis4 fis d 
  cis8 b cis4 d e 
  fis4. e8 d4 d 
  e a, d8 cis b cis 
  d e fis4 fis a,8 b 
  cis4 d8 e fis4 g 
  g cis,8 e d4 d 
  e8 e, fis gis a b a gis 
  fis4. gis8 a4 cis 
  b8 fis' e4 d4. cis8 
  b4 cis8 b ais cis e4 
  dis2. 
}


baixo = \relative c {
  \partial 4 b'8 a 
  g4 fis8 e d4 cis 
  b fis b b' 
  a8 g fis e d4. cis8 
  b cis d e fis4 b8 a 
  g4 fis8 e d4 cis 
  b fis b b' 
  a8 g fis e d4. cis8 
  b cis d e fis4 d 
  a' b fis e8 fis 
  g e fis4 b, b' 
  a dis,8 f fis4 fis, 
  fis'8 e d e a,4 ais 
  b cis d e8 fis 
  g fis e4 fis fis, 
  b2. 
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