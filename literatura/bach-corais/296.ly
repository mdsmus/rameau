
\version "2.10.33"

\header {
  title = "296 - Nun lob, mein Seel, den Herren"
  composer = "J. S. Bach"
}

global =  {
  \time 3/4 
  \key c \major
}

soprano = \relative c {
  \partial 4 c''4 c2 b4 a2 
  g4 c d2 
  e e4 e2 e4 e2 
  d4 c8 d d4. c8 
  c2 c4 c2 b4 a2 
  g4 c d2 
  e e4 e2 e4 e2 
  d4 c8 d d4. c8 
  c2 c4 c 
  d e d2 
  e4 c b8 a b4 
  a2 a4 d 
  c b c a2 g g4 
  c2 c4 d 
  e f e d 
  e c2 c4 
  f2 f4 e 
  d e d2 
  d4 e2 e4 
  f2 f4 g4. f8 e d c2 
  e4 d c b 
  c a2 g g4 c2 
  b4 a2 g4 
  d' e4. d8 d2 e4 f e 
  d c8 d d4. c8 
  c2. 
}


alto = \relative c {
  \partial 4 g''4 a2 g4 c, d 
  e8 f g4 a g 
  g2 g4 b 
  a gis a e8 f 
  g4 g a g 
  e2 g4 a2 g4 c, d 
  e8 f g4 a g 
  g2 g4 b 
  a gis a e8 f 
  g4 g a g 
  e2 e4 f2 e4 gis a 
  b a2 gis4 
  a2 f8 e d2 d4 e d 
  c b2 e4 
  d2 a'4 g2 g4 g f 
  e e2 a4 
  a2 a4 ais 
  f g f2 
  g4 g2 a4 
  f a2 g2. a2 
  g4 a2 g4 
  g2 fis4 d2 d4 e f 
  g c, d e 
  f e8 d e fis g2 g4 f g2 g4 a g 
  e2. 
}


tenor = \relative c {
  \partial 4 e'4 e 
  f g f2 
  e4 c2 b4 
  c2 c4 b 
  c d c2 
  b4 c2 b4 
  g2 e'4 e 
  f g f2 
  e4 c2 b4 
  c2 c4 b 
  c d c2 
  b4 c2 b4 
  g2 g4 a 
  b c d8 e f4 
  e e2 d4 
  c2 c4 a2 g4 g fis2 g b4 
  c d e d 
  c b c2 
  b4 c2 f4 
  a,2 d4 d2 cis4 a2 
  b4 c2 c4 
  a2 d4 d 
  b c c2 
  c8 b a2 d4 
  c e d8 c b2 b4 g d' 
  d a b c 
  b c a b2 c4 c2 
  b4 c2 b4 
  g2. 
}


baixo = \relative c {
  \partial 4 c'4 a2 e4 f2 
  c4 e f g 
  c,2 c'4 gis 
  fis e a g 
  f e f g 
  c,2 c'4 a2 e4 f2 
  c4 e f g 
  c,2 c'4 gis 
  fis e a g 
  f e f g 
  c,2 c4 f2 c'4 b a 
  gis a e2 
  f f4 fis2 g4 c, d2 g, e'4 
  a b c b 
  a g c2 
  gis4 a2 f4 
  d e f g 
  a2 d, 
  g4 c, b a 
  d c b e 
  d c f2 
  c'4 fis,2 g4 
  e c d g,2 g'8 f e4 d 
  c f2 e4 
  d c2 g' c4 a g 
  f e f g 
  c,2. 
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