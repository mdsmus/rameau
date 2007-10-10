
\version "2.10.33"

\header {
  title = "7 - Nun lob, mein Seel, den Herren"
  composer = "J. S. Bach"
}

global =  {
  \time 3/4 
  \key a \major
}

soprano = \relative c {
  \partial 4 a''4 a2 gis4 fis2 
  e4 a b2 
  cis cis4 cis 
  b cis cis2 
  b4 a b2 
  a a4 a2 gis4 fis2 
  e4 a b2 
  cis cis4 cis 
  b cis cis2 
  b4 a b2 
  a a4 a 
  b cis b2 
  cis4 a gis2 
  fis b4 b 
  a gis a fis2 e e4 
  a2 a4 b2 b4 cis4. b8 
  cis4 a2 a4 
  d2 d4 cis 
  b cis b2 
  b4 cis2 cis4 
  d2 d4 e2. a,2 
  cis4 b a gis 
  a fis2 e e4 a2 
  gis4 fis2 e4 
  b' cis2 b cis4 d2 
  cis4 b a8 gis a b 
  cis4 b2 a 
}


alto = \relative c {
  \partial 4 e'4 fis2 e4 d cis 
  b e fis e 
  e2 e8 fis gis2 f4 fis2 
  gis4 a2 gis4 
  e2 e4 fis2 e4 d cis 
  b e fis e 
  e2 e8 fis gis2 f4 fis2 
  gis4 a2 gis4 
  e2 e4 fis 
  gis a b a 
  gis fis2 f4 
  cis2 fis4 e2 e4 e2 
  dis4 b2 cis4 
  cis2 fis4 e 
  fis gis a2 
  g4 fis2 a4 
  b2 b8 a g ais 
  b4 e, dis2 
  e4 e2 fis4 
  fis2 g4 g 
  fis e d2 
  e4 fis2 e4 
  e2 dis4 b2 cis4 cis dis 
  e dis2 e4 
  fis4. gis8 a4 e2 gis4 a b 
  a gis a2 
  a4 gis2 e 
}


tenor = \relative c {
  \partial 4 cis'4 cis2 cis4 a2 
  gis4 a2 gis4 
  a2 cis4 cis2 b4 a2 
  e'4 e fis e 
  cis2 cis4 cis2 cis4 a2 
  gis4 a2 gis4 
  a2 cis4 cis2 b4 a2 
  e'4 e fis e 
  cis2 cis4 d2 e4 f fis 
  gis cis, d cis 
  a2 a4 gis 
  a b cis2 
  b8 a gis2 gis4 
  a2 d4 b2 e4 e2. d2 e4 
  fis2 b,4 e 
  d8 cis b ais b2 
  gis4 a2 a4 
  b2 b4 b 
  a g fis2 
  a4 fis2 b4 
  cis b a gis2 gis4 a2 
  b4 b a gis 
  d' a2 gis cis4 fis e 
  e e8 d cis4 fis 
  e2 d4 cis2 
}


baixo = \relative c {
  \partial 4 a'4 fis2 cis4 d2 
  d4 cis d e 
  a,2 a'4 f2 cis4 fis e 
  d cis d e 
  a,2 a'4 fis2 cis4 d2 
  d4 cis d e 
  a,2 a'4 f2 cis4 fis e 
  d cis d e 
  a,2 a4 d2 a'4 gis fis 
  f fis b, cis 
  fis,2 dis'4 e2 d4 cis a 
  b e2 cis4 
  fis e fis gis 
  fis e a2 
  a,4 d2 cis4 
  b b'8 a g fis e fis 
  g4 fis b,2 
  e4 a gis fis 
  b a g cis,2. d2 
  a'4 dis,2 e4 
  a, b2 e cis4 fis2 
  e4 b2 cis4 
  d2 dis4 e2 f4 fis gis 
  a e fis d 
  e2. a,2 
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