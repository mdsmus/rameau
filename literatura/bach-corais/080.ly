
\version "2.10.33"

\header {
  title = "80 - Herzlich tut mich verlangen"
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
  g fis e a 
  fis1 
}


alto = \relative c {
  \partial 4 d'4 
  d d d8 e e d 
  d4 cis d e 
  d8 e fis4 fis4. e8 
  d2. d4 
  d d d8 e e d 
  d4 cis d e 
  d8 e fis4 fis4. e8 
  d2. fis4 
  e8 g fis e d4 g 
  g fis8 e fis4 fis 
  g fis fis e 
  dis2. e4 
  e e fis8 gis a4 
  a gis a d,8 cis 
  b cis d4 d8 b cis4 
  d1 
}


tenor = \relative c {
  \partial 4 a'4 
  g a b8 a a4 
  b a a ais 
  b b b ais 
  b2. a4 
  g a b8 a a4 
  b a a ais 
  b b b ais 
  b2. b8 a 
  g b d cis b a g a 
  b4 a8 g a4 d 
  d c b b 
  b2. b4 
  a b a8 b cis a 
  fis'4 e e a, 
  g a a a 
  a1 
}


baixo = \relative c {
  \partial 4 d4 
  g fis b,8 cis d4 
  g, a d cis 
  b8 cis d e fis4 fis, 
  b2. d4 
  g fis b,8 cis d4 
  g, a d cis 
  b8 cis d e fis4 fis, 
  b2. b4 
  e fis g8 fis e4 
  d2 d4 d 
  g8 fis e dis e fis g a 
  b2. gis4 
  a gis fis e 
  dis e a, d 
  e fis8 g a4 a, 
  d1 
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