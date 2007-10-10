
\version "2.10.33"

\header {
  title = "13 - Allein zu dir, Herr Jesu Christ"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key c \major
}

soprano = \relative c {
  \partial 4 c''4 
  g a8 b c d e4 
  d c2 b4 
  c2. e4 
  d c b8 a g4 
  a b8 c d4 c8 b 
  c4 b a c 
  g a8 b c d e4 
  d c2 b4 
  c2. e4 
  d c b8 a g4 
  a b8 c d4 c8 b 
  c4 b a e' 
  f8 e d4 e8 d c4 
  d e a, e' 
  f8 e d4 e8 d c4 
  d e a, c 
  b a g a 
  f8 e f4 e a 
  g c2 b4 
  c g a b 
  c8 d e4 d c 
  b b a 
}


alto = \relative c {
  \partial 4 e'4 
  e8 d c d e f g4 
  g4. fis8 g2 
  g2. g4 
  g8 f e4 e8*5 fis8 gis a b4 a 
  a gis e e 
  e8 d c d e f g4 
  g4. fis8 g2 
  g2. g4 
  g8 f e4 e8*5 fis8 gis a b4 a 
  a gis e a 
  a a gis e 
  a g f e 
  a a8 g g4 g 
  a b e, g 
  g8 fis e4 e8 g f e 
  d cis d4 cis c 
  d g8 f e4 d 
  e e fis gis 
  a e a2. gis4 e 
}


tenor = \relative c {
  \partial 4 a'8 b 
  c b a4 g g8 a 
  b a16 b c8 d e4 d 
  e2. c4 
  b4. a8 g a b4 
  c d8 e f e e4 
  f8 d b c16 d c4 a8 b 
  c b a4 g g8 a 
  b a c d e4 d 
  e2. c4 
  b4. a8 g a b4 
  c d8 e f e e4 
  f8 d b c16 d c4 c 
  c b8 a b4 c8 b 
  a4 a d b 
  c d c c 
  c b c e 
  d e b cis 
  a a a a 
  b8 a g2 g4 
  g e' d d 
  e8 d c b a b c d16 e 
  f4 e8 d cis4 
}


baixo = \relative c {
  \partial 4 a'4 
  e f e8 d c4 
  g' a g g 
  c,2. c4 
  g' a e4. d8 
  c c' b a gis4 a 
  d, e a, a' 
  e f e8 d c4 
  g' a g g 
  c,2. c4 
  g' a e4. d8 
  c c' b a gis4 a 
  d, e a, a' 
  d,8 e f4 e a8 g 
  f e d cis d4 gis 
  a b c e, 
  fis gis a e8 fis 
  g4 cis,8 dis e4 a, 
  d8 f e d a'4 f2 e8 d e f g4 
  c, c' c8 d c b 
  a b a g f4. e8 
  d4 e a, 
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