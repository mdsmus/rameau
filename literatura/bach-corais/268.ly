
\version "2.10.33"

\header {
  title = "268 - Nun lob, mein Seel, den Herren"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key c \major
}

soprano = \relative c {
  \partial 4 c''4 
  c b a g 
  c d e e 
  e8 d e4 e d 
  c8 d d4 c c 
  c b a g 
  c d e e 
  e8 d e4 e d 
  c8 d d4 c c 
  c8 d e4 d e 
  c b a a 
  d8 c b4 c8 b a4 
  g g c c 
  d d e8 d e4 
  c c f f 
  e8 d e4 d d 
  e e f f 
  g8 f16 e f8 g c,4 e 
  d8 c b4 c8 b a4 
  g g c b 
  a g d' e 
  d e f e 
  d c8 d e4 d 
  c2. 
}


alto = \relative c {
  \partial 4 g''4 
  a g g8 f e f 
  g4 a8 g g4 g 
  g8 a b4 a4. g8 
  g a g f e4 g 
  a g g8 f e f 
  g4 a8 g g4 g 
  g8 a b4 a4. g8 
  g a g f e4 e 
  f c' g8 f e4 
  e2 e4 e 
  d d g8 e fis4 
  d d g8 f e4 
  a8 f g4 g8 f g4 
  f g f8 g a4 
  ais e f g 
  g a a ais 
  ais a8 g f4 g 
  a g g8 e fis4 
  d d a' d,8 e 
  f4 g a4. b16 c 
  g4 b a g8 a 
  b4 c2 b4 
  g2. 
}


tenor = \relative c {
  \partial 4 e'4 
  e e8 d c4 c 
  c4. b8 c4 c8 d 
  e f e d c4. b8 
  c4 b g e' 
  e e8 d c4 c 
  c4. b8 c4 c8 d 
  e f e d c4. b8 
  c4 b g g 
  a g8 a b4 b 
  b8 a4 gis8 c4 c8 b 
  a4 g g d'8 c 
  b4 b8 a g4 c 
  c b c ais 
  a c d8 e f4 
  g cis, a b 
  c c d d 
  e8 d c ais a4 c8 b 
  a4 d g, d'8 c 
  b4 b e,8 fis g4 
  d' d8 c c b c4 
  b e8 d c d e f 
  g f e f g4. f8 
  e2. 
}


baixo = \relative c {
  \partial 4 c'8 b 
  a4 e f c8 d 
  e4 f8 g c,4 c 
  c' gis a8 g f g 
  e f g4 c, c'8 b 
  a4 e f c8 d 
  e4 f8 g c,4 c 
  c' gis a8 g f g 
  e f g4 c, c 
  f e8 f g4 gis 
  a e a, a'8 g 
  fis4 g8 fis e c d4 
  g, g'8 f e4 a8 g 
  f d g4 c,4. d16 e 
  f4 e d d' 
  g,8 ais a4 d, g 
  c8 b a g f e d4 
  c d8 e f4 c' 
  fis, g e8 c d4 
  g, g a b8 c 
  d4 e f fis 
  g gis a8 b c4 
  f,8 g a4 g8 f g4 
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