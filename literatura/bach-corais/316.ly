
\version "2.10.33"

\header {
  title = "316 - Christus, der ist mein Leben"
  composer = "J. S. Bach"
}

global =  {
  \time 3/4 
  \key g \major
}

soprano = \relative c {
  \partial 4 g''4 b2 a4 b2 
  c4 d2. 
  b2 s4 e1. d c8*7 b8 c4 
  s4 b e8 c a4 
  b2 d4 e2 fis4 g2 
  fis4 e2. 
  d2 b4 a2 g4 g2 
  fis4 g2. 
}


alto = \relative c {
  \partial 4 d'4 g2 fis4 g2 
  g4 g4. fis16 e fis4 
  d2 s1 f4*9 e2. fis4 fis 
  s4 g8 fis e4 fis8 e 
  dis2 g4 g2 a4 b2 
  a4 b8 a g4. a16 g 
  fis2 g4 g 
  fis e e d2 d2. 
}


tenor = \relative c {
  \partial 4 b'4 d2 d4 d2 
  c4 b4. a16 g a4 
  g2 s4*7 gis1. a1 a4 
  s4 g8 b b a16 b c4 
  fis,2 d'4 c2 c4 d2 
  d4 d4. cis16 b cis4 
  a2 e'4 e 
  b b c8 b a b 
  c4 b2. 
}


baixo = \relative c {
  \partial 4 g'4 g2 d4 g fis 
  e b8 c d4 d 
  g,2 s2*5 c8*9 b8 c a d4 d 
  s4 e8 d c4 c 
  b2 b'4 b2 a4 g b 
  d g,8 fis e4 a 
  d,2 e8 d cis4 
  dis e c d2 g,2. 
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