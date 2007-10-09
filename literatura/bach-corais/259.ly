
\version "2.10.33"

\header {
  title = "259 - Verleih uns Frieden gnädiglich (beginning)"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key fis \minor
}

soprano = \relative c {
  \partial 4 fis'4 
  fis fis f fis8 gis 
  a4 gis fis a 
  b b cis8 b a4 
  b2 cis4 cis 
  cis b cis8 b a4 
  b8 a gis4 fis fis8 gis 
  a4 a b a8 gis 
  fis2 fis4 b 
  cis b fis8 gis a4 
  gis8 fis gis4 fis fis 
  fis e a b 
  cis8 b a4 b b 
  cis2 d 
  cis4 b8 cis16 d b4. a8 
  a2. cis4 
  cis8 b a4 b8 cis d4 
  cis2 e4 cis 
  d cis8 b cis4 cis 
  d cis8 d e d cis4 
  b2 a 
  cis4 cis a b 
  a gis fis2 
  e4 fis8 gis a4 fis 
  fis2. e4 
  fis gis a gis 
  fis2. f4 
  fis2. 
}


alto = \relative c {
  \partial 4 cis'4 
  d d cis8*5 fis8 fis f cis4 fis 
  e8 fis gis4 a8*5 gis16 fis gis4 a a 
  a f8 fis gis4 fis 
  fis e dis dis8 f 
  fis4 fis gis8 fis f4 
  fis8 e d4 cis e 
  e e d8 e fis4 
  fis f cis cis 
  cis cis d d 
  cis cis fis e 
  e2 b' 
  e,4 fis e e 
  e2. gis4 
  a8 gis fis4 fis fis8 f 
  fis2 gis8 b b a 
  a gis a gis a b cis4 
  cis8 b a4 e e 
  fis e8 d cis2 
  e4 e fis fis 
  fis e e d 
  cis d e d 
  d2. cis1 d8 e 
  fis4 gis8 a d,4 cis 
  cis2. 
}


tenor = \relative c {
  \partial 4 a'4 
  a a gis8 b a gis 
  fis4 cis'8 b a4 cis 
  b e e4. d16 cis 
  b4 e e e 
  e8 d d4 cis cis 
  b b b b 
  cis d d cis8 b 
  a ais b4 a gis 
  a b8 cis d4 cis 
  cis4. b8 a4 a 
  a gis fis gis 
  a8 gis a4 a gis 
  a2 gis 
  a4 a a8 fis gis d' 
  cis2. cis4 
  fis4. e8 d cis b gis 
  a2 b4 e 
  e e8 d cis b a gis 
  fis gis a4 b a 
  a gis e2 
  a4 a a d 
  cis b b2 
  gis4 a8 b cis4 b 
  a2. a8 gis 
  fis4 b a b 
  a gis8 fis gis a b4 
  ais2. 
}


baixo = \relative c {
  \partial 4 fis8 e 
  d4 cis8 b cis4 dis8 f 
  fis b, cis4 fis fis 
  gis fis8 e a gis fis e 
  d4 e a, a'8 gis 
  fis4 gis8 fis f4 fis8 e 
  dis4 e b b' 
  fis8 e d cis b4 cis 
  d cis8 b fis'4 e 
  a gis8 a b4 a8 b 
  cis4 cis, fis fis8 gis 
  a b cis4 cis8 d cis b 
  a f fis cis d b e4 
  a,2 b 
  cis4 d e e 
  a,2. f'4 
  fis4. fis8 gis ais b4 
  fis2 e4 e 
  e e8 e e4 e 
  e fis gis a 
  d, e a,2 
  a8 b cis a d cis d e 
  fis4 gis8 a b2 
  cis,4. b8 a4 b8 cis 
  d2. a'4. gis8 fis f fis4 b,8 cis 
  d cis b a b4 cis 
  fis2. 
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