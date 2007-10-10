
\version "2.10.33"

\header {
  title = "293 - Was Gott tut, das ist wohlgetan"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key g \major
}

soprano = \relative c {
  \partial 4 d'4 
  g a b c 
  d4. c8 b4 e 
  d c b c 
  a2 g4 d 
  g a b c 
  d4. c8 b4 e 
  d c b c 
  a2 g4 d' 
  e e a, a 
  d d g, b 
  a g fis g 
  e2 d4 d' 
  c b a b 
  a2 g 
}


alto = \relative c {
  \partial 4 b'4 
  d d d g 
  g fis d c8 b 
  a4 e' d e 
  d2 d4 b 
  d d d g 
  g fis d c8 b 
  a4 e' d e 
  d2 d4 g 
  g a8 g fis4 fis 
  g4. f8 e4 d 
  cis b a b 
  a2 a4 g 
  g8 a b c d4 d 
  d2 d 
}


tenor = \relative c {
  \partial 4 g'4 
  b a g g8 a 
  b4 a g g 
  fis g8 a b fis g4 
  g fis d g 
  b a g g8 a 
  b4 a g g 
  fis g8 a b fis g4 
  g fis d b' 
  c8 b a4 d d 
  d8 c b d c4 b8 g 
  e4 d d8 fis e d 
  d4 cis fis d 
  e d8 e fis4 g 
  g fis g2 
}


baixo = \relative c {
  \partial 4 g4 
  g' fis g e 
  b d g, c 
  d e8 fis g4 c, 
  d2 g,4 g 
  g' fis g e 
  b d g, c 
  d e8 fis g4 c, 
  d2 g,4 g' 
  c, cis d c 
  b b c g 
  a b8 cis d4 g, 
  a2 d,4 b' 
  e8 fis g4 d8 c b g 
  d2 g 
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