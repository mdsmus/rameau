
\version "2.10.33"

\header {
  title = "312 - Die Wollust dieser Welt"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key d \major
}

soprano = \relative c {
  \partial 4 a''4 
  fis d a' a 
  b2 s4 b 
  e, e a g 
  fis e d a' 
  b b a g 
  fis2 s4 e 
  fis gis a b8 cis16 d 
  cis4 b a a 
  a a d c8 b 
  b2 s4 b 
  b b e d8 cis 
  cis2 s4 a 
  b a b cis 
  d2 s4 a 
  b8 a g fis e4 e 
  d1 
}


alto = \relative c {
  \partial 4 d'4 
  d d8 e fis4 d 
  d2 s4 d 
  cis cis d e 
  d cis a fis' 
  g g8 fis e d e4 
  d2 s4 cis 
  d e e fis 
  e4. d8 cis4 cis 
  d d d d 
  d2 s4 g 
  g8 fis g a b a b gis 
  a2 s4 d, 
  g fis fis fis 
  fis2 s4 fis8 e 
  d4 d cis cis 
  a1 
}


tenor = \relative c {
  \partial 4 fis4 
  a a d a 
  g2 s4 b 
  a a a a 
  a4. g8 fis4 d' 
  d g, a a 
  a2 s4 a 
  a b a a 
  a gis e e 
  fis8 e fis g a g a fis 
  g2 s4 d' 
  e e b e 
  e2 s4 d 
  d d d cis 
  b2 s4 d8 cis 
  b4 b8 d a4. g8 
  fis1 
}


baixo = \relative c {
  \partial 4 d4 
  d8 e fis g fis e fis d 
  g2 s4 g 
  a8 g fis e fis e d cis 
  d4 a d d 
  g8 fis e d cis b cis a 
  d2 s4 a 
  d8 cis d b cis4 d 
  e8 d e4 a, a 
  d8 cis d e fis e fis d 
  g2 s4 g8 fis 
  e dis e fis gis fis gis e 
  a2 s4 fis 
  g8 b d e d cis b ais 
  b,2 s4 fis' 
  g8 a b g a4 a, 
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