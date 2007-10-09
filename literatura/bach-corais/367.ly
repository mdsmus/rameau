
\version "2.10.33"

\header {
  title = "367 - Herzlich tut mich verlangen"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key d \major
}

soprano = \relative c {
  \partial 4 fis'4 
  b a g fis 
  e2 fis4 cis' 
  d d cis8 b cis4 
  b2. fis4 
  b a g fis 
  e2 fis4 cis' 
  d d cis8 b cis4 
  b2. d4 
  cis8 b a4 b cis 
  d2 d4 a 
  b a g g 
  fis2. d'4 
  cis8 d e4 d cis 
  b2 cis4 fis, 
  g fis e a8 g 
  fis1 
}


alto = \relative c {
  \partial 4 d'4 
  d d e a, 
  b a a fis' 
  fis fis fis fis8 e 
  d2. d4 
  d d e a, 
  b a a fis' 
  fis fis fis fis8 e 
  d2. fis4 
  g fis8 e d4 g 
  g fis8 e fis4 fis 
  g fis fis e 
  dis2. e4 
  e a8 gis fis gis a4 
  a gis a a, 
  e' a,8 b cis d e4. cis8 d4 cis2 
}


tenor = \relative c {
  \partial 4 a'4 
  g a b8 cis d4 
  d cis d cis2 b4 b ais 
  b2. a4 
  g a b8 cis d4 
  d cis d cis2 b4 b ais 
  b2. b8 a 
  g4 d'8 cis b a g a 
  b4 a8 g a4 d 
  d c b b 
  b2. b4 
  a8 b cis4 d e 
  fis e e d8 cis 
  b cis d4 a8 b cis4. fis,8 b4 ais2 
}


baixo = \relative c {
  \partial 4 d4 
  g fis e d 
  g, a d ais 
  b8 cis d e fis4 fis, 
  b2. d4 
  g fis e d 
  g, a d ais 
  b8 cis d e fis4 fis, 
  b2. b'4 
  e, fis g8 fis e4 
  d2 d4 d 
  g8 fis e dis e fis g e 
  b'2. gis4 
  a a, b cis 
  d e a, d 
  e fis8 g a g fis e 
  d4 cis8 b fis'2 
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