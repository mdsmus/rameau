
\version "2.10.33"

\header {
  title = "265 - Was mein Gott will, das g'scheh allzeit"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key b \minor
}

soprano = \relative c {
  \partial 4 fis'4 
  a b a d 
  d cis d d 
  cis b e4. d8 
  cis4 d cis2 
  b2. fis4 
  a b a d 
  d cis d d 
  cis b e4. d8 
  cis4 d cis2 
  b2. b4 
  b b cis4. b8 
  cis4 a a gis 
  a a b cis 
  d cis b2 
  cis2. fis,8 gis 
  a4 b a d 
  d cis d d 
  cis b e4. d8 
  cis4 d cis2 
  b1 
}


alto = \relative c {
  \partial 4 d'4 
  d d d d8 e 
  fis g a4 a a 
  a g g fis 
  fis8*5 g8 fis e 
  d2. d4 
  d d d d8 e 
  fis g a4 a a 
  a g g fis 
  fis8*5 g8 fis e 
  d2. fis4 
  e d cis dis8 f 
  fis4 fis fis e 
  e e e e 
  fis ais b gis 
  ais2. cis,4 
  fis gis fis fis 
  b a a gis 
  a gis ais4. b8 
  cis4 b2 ais4 
  a g fis2 
}


tenor = \relative c {
  \partial 4 b'4 
  a g fis8 g a b 
  a4 e' fis fis 
  e e b b 
  ais b2 ais4 
  fis2. b4 
  a g fis8 g a b 
  a4 e' fis fis 
  e e b b 
  ais b2 ais4 
  fis2. d'8 cis 
  b cis b a g4 a8 b 
  a b cis4 b b 
  cis cis b ais 
  b g' fis f 
  fis2. a,8 b 
  cis4 d8 cis cis4 d 
  e e fis e8 d 
  e4 e e8 fis g4. fis16 e d8 cis16 b fis'8 cis fis e 
  dis4 e dis2 
}


baixo = \relative c {
  \partial 4 b4 
  fis' g d8 e fis g 
  a4 a, d d 
  a' e8 fis g a b4 
  fis8 e d e fis2 
  b,2. b4 
  fis' g d8 e fis g 
  a4 a, d d 
  a' e8 fis g a b4 
  fis8 e d e fis2 
  b,2. b'8 a 
  gis a gis fis f cis fis gis 
  a gis fis e d b e4 
  a, a' gis g 
  fis e d8 cis d b 
  fis'2. fis,4 
  fis' f fis b8 a 
  gis4 a d, b 
  a e'8 d cis d cis b 
  ais g' fis f fis2 
  b,1 
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