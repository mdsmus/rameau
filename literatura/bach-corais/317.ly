
\version "2.10.33"

\header {
  title = "317 - Aus tiefer Not schrei ich zu dir 2"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key c \major
}

soprano = \relative c {
  \partial 4 c''4 
  b c d d 
  c d e f 
  e d c b8 a 
  b4 c d2 
  c2. c4 
  b c d d 
  c d e f 
  e d c b8 a 
  b4 c d2 
  c2. c4 
  d8 e f4 e8 d c4 
  d8 c b4 a b 
  g g d' e 
  f8 e d4 c g' 
  e f8 e d4. c8 
  b4 c d2 
  c1 
}


alto = \relative c {
  \partial 4 g''4 
  g4. fis8 g4 gis 
  e8 c g'4 g g 
  g g8 f e4 f8 e 
  d4 g a g8 f 
  e2. g4 
  g4. fis8 g4 gis 
  e8 c g'4 g g 
  g g8 f e4 f8 e 
  d4 g a g8 f 
  e2. g4 
  g a b a 
  a4. g8 fis4 fis 
  e e8 fis g4 e 
  d e e g 
  g f8 g a f g a 
  g4 g g4. f8 
  e1 
}


tenor = \relative c {
  \partial 4 e'4 
  d c b b 
  c8 f b,4 c d 
  c b c8 e d4 
  g c,2 b4 
  g2. e'4 
  d c b b 
  c8 f b,4 c d 
  c b c8 e d4 
  g c,2 b4 
  g2. e'4 
  d c b e 
  d d d b 
  b b8 c d4 a 
  a b a d 
  c c8 b a4 e' 
  d c c b 
  g1 
}


baixo = \relative c {
  \partial 4 c4 
  g' a g8 f e4 
  a g c b 
  c g a8 g f2 e4 fis g 
  c,2. c4 
  g' a g8 f e4 
  a g c b 
  c g a8 g f2 e4 fis g 
  c,2. c'4 
  b a gis a8 g 
  fis4 g d dis 
  e8 fis g a b4 cis 
  d g, a b 
  c8 b a g f d e f 
  g f e c g2 
  c1 
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