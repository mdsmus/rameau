
\version "2.10.33"

\header {
  title = "65 - Was Gott tut, das ist wohlgetan"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key g \major
}

soprano = \relative c {
  \partial 4 d'4 
  g a b e 
  d4. c8 b4 e 
  d c b c8 d 
  a2 g4 d 
  g a b e 
  d4. c8 b4 e 
  d c b c8 d 
  a2 g4 d' 
  e e a, a 
  d d g, b 
  a g fis g8 fis 
  e2 d4 d' 
  c b a b8 c 
  a2 g 
}


alto = \relative c {
  \partial 4 b'8 c 
  d4 d d e8 fis 
  g4 fis g g 
  fis g8 a b a g4 
  g fis d b8 c 
  d4 d d e8 fis 
  g4 fis g g 
  fis g8 a b a g4 
  g fis d g 
  g g fis fis8 g 
  a g fis4 e e 
  e d8 cis d4 d 
  d cis d g8 fis 
  e4 d8 e fis4 g 
  g fis d2 
}


tenor = \relative c {
  \partial 4 g'8 a 
  b4 a g g8 a 
  b4 a8 d d4 c8 b 
  a4 e' d e 
  e d8 c b4 g8 a 
  b4 a g g8 a 
  b4 a8 d d4 c8 b 
  a4 e' d e 
  e d8 c b4 b 
  c8 b a4 d d 
  a b b g 
  a a a g8 a 
  b4 a8 g fis4 g 
  g8 a b c d4 d 
  d8 c16 b c8 a b2 
}


baixo = \relative c {
  \partial 4 g4 
  g' fis g c, 
  b8 c d4 g, c 
  d e8 fis g fis e d 
  c4 d g, g 
  g' fis g c, 
  b8 c d4 g, c 
  d e8 fis g fis e d 
  c4 d g, g' 
  c, cis d d8 e 
  fis4 b, e e8 d 
  cis b a4 d8 cis b a 
  g4 a d b 
  e8 fis g4 d8 c b g 
  d'2 g, 
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