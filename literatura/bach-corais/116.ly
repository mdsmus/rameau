
\version "2.10.33"

\header {
  title = "116 - Nun lob, mein Seel, den Herren"
  composer = "J. S. Bach"
}

global =  {
  \time 3/4 
  \key d \major
}

soprano = \relative c {
  \partial 4 d''4 d2 cis4 b2 
  a4 d e2 
  fis fis4 fis8 e 
  fis2 fis 
  e4 d8 e e2 
  d d4 d2 cis4 b2 
  a4 d e2 
  fis fis4 fis8 e 
  fis2 fis 
  e4 d8 e e2 
  d d4 d 
  e fis e2 
  fis8 e d e cis2 
  b e4 e 
  d cis d8 cis b2 a a4 
  d2 d4 e2 e4 fis e 
  fis d2 d4 
  g2 g4 fis8 e 
  fis2 e 
  e4 fis2 fis4 
  g2 g4 a4. g8 fis e d2 
  fis4 e d cis 
  d8 cis b2 a a4 d2 
  cis4 b2 a4 
  e' fis2 e fis4 g fis 
  e fis8 g e2 
  d 
}


alto = \relative c {
  \partial 4 a''4 b 
  a a a g 
  a8 g fis4 b a 
  a2 a4 a2 cis4 fis, b 
  e, a b a8 e 
  fis2 a4 b 
  a a a g 
  a8 g fis4 b a 
  a2 a4 a2 cis4 fis, b 
  e, a b a8 e 
  fis2 a4 b 
  a a a8 b a g 
  fis4 fis g8 fis e fis 
  d2 e4 e2 e4 a2 
  gis4 e2 e4 
  d8 e fis4 b b 
  a a a1 g4 g8 a 
  b4 a8 g c b a g 
  c4 b8 a g2 
  a4 a b2. a8 g c b a g 
  a2. g4 
  a b2 a4 
  a2 gis4 e2 e4 a8 gis a b 
  e,4 fis cis cis8 d 
  e4 a2 a a4 b a 
  g fis g8 fis e4 
  fis2 
}


tenor = \relative c {
  \partial 4 fis'4 fis2 fis8 e d4 e8 d 
  cis4 d2 cis4 
  d2 d4 d2 cis4 d2 
  cis4 d2 cis4 
  a2 fis'4 fis2 fis8 e d4 e8 d 
  cis4 d2 cis4 
  d2 d4 d2 cis4 d2 
  cis4 d2 cis4 
  a2 d4 g 
  cis, d d cis 
  cis b2 ais4 
  b2 gis8 a b gis 
  a b cis b a4 fis' 
  e8 d cis2 cis8 b 
  a4 d2. 
  cis8 b cis4 d a 
  d b2 b4 
  e2 e4 e2 dis4 b2 
  cis4 d2 d4 
  g, e'2. 
  d4. c8 b2 
  d8 cis b4 e2 
  d8 e fis4 e8 d cis2 cis4 cis b 
  a a gis a 
  a2 d4 cis2 d4 d2 
  a4 d2 cis4 
  a2 
}


baixo = \relative c {
  \partial 4 d'8 cis b4 
  fis2 g8 fis e4 
  fis b8 a g4 a 
  d,2 d4 d'4. cis8 b ais b a g fis 
  g e fis4 g a 
  d,2 d'8 cis b4 
  fis2 g8 fis e4 
  fis b8 a g4 a 
  d,2 d4 d'4. cis8 b ais b a g fis 
  g e fis4 g a 
  d,2 fis4 g8 a 
  g fis e d a'2 
  ais4 b e, fis 
  b,2 cis4 gis'8 e 
  fis gis a gis fis e d4 
  e a,2 a'8 g 
  fis4 b8 a g fis g e 
  a g fis e d e d cis 
  d fis g2 g8 fis 
  e4 fis8 g a b c4 
  a b e,2 
  a4 d8 cis b a g fis 
  e d' c b a g fis g 
  fis e d4 g2 
  d'4 gis,8 e fis gis a gis 
  fis e d4 e a,2 a'8 gis fis e fis gis 
  a4 dis,8 cis dis f fis e 
  d cis d2 a d8 cis b a b d 
  cis e d4 g, a 
  d2 
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