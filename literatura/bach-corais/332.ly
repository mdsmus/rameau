
\version "2.10.33"

\header {
  title = "332 - Von Gott will ich nicht lassen"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \minor
}

soprano = \relative c {
  \partial 4 e'4 
  a b c d 
  b4. a8 g4 g 
  a a b b 
  e,2. e4 
  a b c d8 c 
  b4. a8 g4 g 
  a a b b 
  e,2. e'4 
  d c c b 
  c2. b4 
  c d e e 
  d4. c8 b4 b 
  c b a a 
  b4. a8 g4 g8 f 
  e4 a a8 b gis4 
  a1 
}


alto = \relative c {
  \partial 4 c'8 d 
  e4 e e d 
  d8 e fis4 e e 
  e d d8 f e d 
  c2. b4 
  e fis8 gis a4 a8 g 
  f e d4 e d 
  e e d8 e fis4 
  b,2. c4 
  a' a g g 
  g2. g8 f 
  e4 d c e 
  a8 g a fis g4 g 
  g8 f g e c4 c 
  b8 cis dis4 e d 
  d8 c c d e f e4 
  e1 
}


tenor = \relative c {
  \partial 4 a'8 b 
  c4 b a a 
  b2 b4 c 
  c8 b a4 g8 a b4 
  a2. gis4 
  a d e a,4. gis8 a4 b b 
  a8 b a g fis g a4 
  gis2. a4 
  a d d8 e f d 
  e2. d4 
  c g' g c,8 b 
  a4 d d d 
  g, c c8 b a g 
  fis g a4 b g 
  g a8 b c d b4 
  cis1 
}


baixo = \relative c {
  \partial 4 a4 
  a' gis a8 g fis4 
  g dis e c 
  f fis g gis 
  a2. e8 d 
  c4 b a8 g' f e 
  d e f4 e b 
  c cis d dis 
  e2. a8 g 
  f4 fis g g, 
  c2. g'4 
  a b c8 b a g 
  fis e fis d g4 g8 f 
  e d e c f g f e 
  dis e fis4 e b 
  c f e8 d e e, 
  a1 
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