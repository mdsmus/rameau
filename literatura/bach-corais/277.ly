
\version "2.10.33"

\header {
  title = "277 - Herzlich lieb hab ich dich, o Herr"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key c \major
}

soprano = \relative c {
  \partial 4 c''4 
  b a g8 f e4 
  a a g c 
  b a g8 f e4 
  a a g g 
  a b c8 d e4 
  d2 c4 c 
  b a g8 f e4 
  a a g c 
  b a g8 f e4 
  a a g g 
  a b c8 d e4 
  d2 c4 c 
  c d c a8 b 
  c4. d8 b4 b 
  c d c8 b a b 
  c4. d8 b4 e 
  f8 e d4 e8 d c4 
  c b c b 
  c b a8 b g4 
  g8 a fis4 g e' 
  d c b e 
  f8 e d4 e8 d c b 
  a d b4 c c 
  c c d c 
  c b c2 
}


alto = \relative c {
  \partial 4 g''4 
  g8 f e4 e e8 d 
  c4 f e e8 f 
  g4 f8 e d4 c8 d 
  e dis e fis fis e e4 
  d8 c f4 e a 
  a g8 f e4 g 
  g8 f e4 e e8 d 
  c4 f e e8 f 
  g4 f8 e d4 c8 d 
  e dis e fis fis e e4 
  d8 c f4 e a 
  a g8 f e4 g 
  a b a e 
  e d d g 
  g g g f 
  e4. fis8 gis4 a8 g 
  f4 g g8 f e4 
  a g g g 
  a a8 g g fis fis e 
  e4 d d c 
  d8 e e dis e4 e8 d 
  c e gis a b4 e, 
  e8 d e4 e c'8 ais 
  a g f e d4 e8 g 
  g4. g8 g2 
}


tenor = \relative c {
  \partial 4 e'4 
  d d8 c b4 c8 b 
  a b c4 c c8 d 
  e d c4 d g, 
  c8 b a c b4 c8 b 
  a4 d c8 b c4 
  c b g d' 
  d d8 c b4 c8 b 
  a b c4 c c8 d 
  e d c4 d g, 
  c8 b a c b4 c8 b 
  a4 d c8 b c4 
  c b g e' 
  e8 c f e e4. d8 
  c b a4 g d' 
  e f e a,8 gis 
  a e a4 b a 
  d8 c b4 b c 
  d e8 f e4 d 
  d d8 e e d b c 
  c4 a8 b16 c b4 g8 a 
  b4 a8 fis gis4 c8 b 
  a c d f b,4 c 
  c8 a b gis a4 g 
  c8 ais a4 a8 g g e' 
  d c d4 e2 
}


baixo = \relative c {
  \partial 4 c4 
  g' a e8 d c4 
  f8 g a b c4 a 
  e f b, c8 b 
  a b cis dis e4 c 
  f e8 d a'4. g8 
  f e g4 c, c 
  g' a e8 d c4 
  f8 g a b c4 a 
  e f b, c8 b 
  a b cis dis e4 c 
  f e8 d a'4. g8 
  f e g4 c, c'8 b 
  a4. gis8 a b c b 
  a g fis d g4 g8 f 
  e d c b c4 d 
  a8 b c a e'4 cis 
  d g8 f e4 a8 g 
  f d g4 c, g' 
  g8 fis g e c d e c 
  a4 d g, c 
  g'8 gis a4 e a, 
  a' b8 a gis4 a8 g 
  fis4 gis8 e a4 e 
  f8 g a4 b, e8 c 
  g'4 g, c2 
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