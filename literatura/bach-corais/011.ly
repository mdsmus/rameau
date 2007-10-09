
\version "2.10.33"

\header {
  title = "11 - Jesu, nun sei gepreiset"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key c \major
}

soprano = \relative c {
  \partial 4 e''4 
  e c d e 
  f2 d4 d 
  d c c b 
  c2 s4 d 
  d d d e 
  c2 c4 c 
  b c d d 
  c2. e4 
  e c d e 
  f2 d4 d 
  d c c b 
  c2 s4 d 
  d d d e 
  c2 c4 c 
  b c d d 
  c2. b4 
  b b b b 
  c2 c4 b 
  b b b b 
  c2 c4 e 
  \time 3/4
  e d c d2 e4 f2. e2 e4 
  d2 d4 cis2 cis4 d4*5 e4 
  e d c d2 e4 f2. e2 e4 
  d2 d4 cis2 cis4 d2.~ d2 e4 
  \time 4/4
  e c d e 
  f2 d4 d 
  d c c b 
  c2. 
}


alto = \relative c {
  \partial 4 g''4 
  g g g g 
  f8 g a4 ais a 
  g g a g 
  g2 s4 g8 fis 
  g4. fis8 g4 g 
  g f8 e f4 g 
  g8 f e4 a g8 f 
  e2. g4 
  g g g g 
  f8 g a4 ais a 
  g g a g 
  g2 s4 g8 fis 
  g4. fis8 g4 g 
  g f8 e f4 g 
  g8 f e4 a g8 f 
  e2. g4 
  g a g gis 
  a2 a4 a 
  a g d g 
  g2 g4 g 
  g2 g4 g 
  a b c b 
  a g2 c4 
  b a g a 
  ais g f2 
  ais4 a2 a4 
  b2 a4 a2 g4 a2 
  g4 g2 g4 
  f g a g 
  a ais a ais 
  g fis2 a4 
  g g g g 
  a2 g4 g 
  g g g8 a g f 
  e2. 
}


tenor = \relative c {
  \partial 4 c'4 
  c8 d e4 d c 
  c f f a, 
  b c f8 e d4 
  e2 s4 b8 a 
  b a b c d4 c8 ais 
  ais4 a8 g a4 e' 
  d c2 b4 
  g2. c4 
  c8 d e4 d c 
  c f f a, 
  b c f8 e d4 
  e2 s4 b8 a 
  b a b c d4 c8 ais 
  ais4 a8 g a4 e' 
  d c2 b4 
  g2. d'4 
  d8 e fis4 e e 
  e2 e4 f 
  f e8 f g4 f2 e8 d e4 c 
  c d e d2 g4 c,2 
  d4 e2 g4 
  g f e f 
  e2 d 
  e4 f2 c4 
  b e2 a,4 
  b c2 b8 a 
  b4 c2 a4 
  a2 d4 e2 e4 a, d 
  ais a2 c4 
  c c b c 
  c8 e d c b4 b 
  b c8 d e4 d8 g, 
  g2. 
}


baixo = \relative c {
  \partial 4 c4 
  c c' b ais 
  a g8 f ais4 fis 
  g8 f e4 f g 
  c,2 s4 g 
  g'8 fis g a b g c4 
  f,2 f4 e8 f 
  g4 a8 g f4 g8 g, 
  c2. g4 
  c c' b ais 
  a g8 f ais4 fis 
  g8 f e4 f g 
  c,2 s4 g 
  g'8 fis g a b g c4 
  f,2 f4 e8 f 
  g4 a8 g f4 g8 g, 
  c2. g4 
  g'8 fis e dis e d c b 
  a2 a4 d 
  e8 f g a g f e d 
  c2 c4 c 
  c' b a b 
  a g a2 
  b4 c2 c,4 
  g' a ais a 
  g a ais a 
  g d2 a'4 
  gis2 a4 f2 e4 d2 
  g4 c,2 cis4 
  d e f e 
  f g fis g 
  g, d'2 a8 b 
  c d e c f g f e 
  d e f d g a g f 
  e d e f g f g g, 
  <c, c' >2. 
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