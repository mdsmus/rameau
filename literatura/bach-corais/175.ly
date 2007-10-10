
\version "2.10.33"

\header {
  title = "175 - Jesus, meine Zuversicht"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key c \major
}

soprano = \relative c {
  g''4 e a b 
  c c b2 
  a8 b c4 g e 
  f e d2 
  c1 
  g'4 e a b 
  c c b2 
  a8 b c4 g e 
  f e d2 
  c1 
  e4 fis gis a 
  b b a2 
  b4 c d e 
  d4. c8 c2 
}


alto = \relative c {
  e'4 c8 d e4 e 
  e a2 gis4 
  a g8 e d4. g,8 
  c d4 c8 c4 b 
  g1 
  e'4 c8 d e4 e 
  e a2 gis4 
  a g8 e d4. g,8 
  c d4 c8 c4 b 
  g1 
  c4 d4. f8 e c 
  f d b e16 d c2 
  g'4 g g g 
  a8 f d g16 f e2 
}


tenor = \relative c {
  c'4 g c b 
  a e' e2 
  c4. g4 b8 g e 
  a g g4 a g8 f 
  e1 
  c'4 g c b 
  a e' e2 
  c4. g4 b8 g e 
  a g g4 a g8 f 
  e1 
  g4 a b8 d c a 
  a4. gis8 a2 
  d4 e d c 
  c b g2 
}


baixo = \relative c {
  c4 c8 b a4 gis 
  a8 b c d e2 
  f4 e b8 g c4 
  a8 b c4 f, g 
  c,1 
  c'4 c8 b a4 gis 
  a8 b c d e2 
  f4 e b8 g c4 
  a8 b c4 f, g 
  c,1 
  c'8 c, c'4 b c8 f 
  d b e4 a,2 
  g'8 f e d c b c e 
  f d g4 c,2 
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