
\version "2.10.33"

\header {
  title = "191 - Von Gott will ich nicht lassen"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \minor
}

soprano = \relative c {
  \partial 4 e'4 
  a b c d 
  b2 g4 g 
  a a b b 
  e,2. e4 
  a b c d 
  b2 g4 g 
  a a b b 
  e,2. e'4 
  d c c b 
  c2. b4 
  c d e e 
  d2 b4 b 
  c b a a 
  b a g f 
  e a a gis 
  a1 
}


alto = \relative c {
  \partial 4 c'4 
  e e e d 
  d8 e fis4 e e 
  c d d8 f e d 
  c2. c4 
  e e e d 
  d8 e fis4 e e 
  c d d8 f e d 
  c2. a'4 
  a a g g 
  g2. g4 
  g f g a8 g 
  fis e fis4 d g 
  g e c f4. e8 fis4 e d 
  c d e e 
  e1 
}


tenor = \relative c {
  \partial 4 a'4 
  c b a a 
  g fis b c 
  a f e e 
  a2. a4 
  c b a a 
  g fis b c 
  a f e e 
  a2. c4 
  d f e d 
  e2. d4 
  c4. b4 g8 c2 b8 a g4 d' 
  c g a8 b c4 
  d c b g 
  g a8 b c b16 a b8 b 
  cis1 
}


baixo = \relative c {
  \partial 4 a4 
  a' gis a fis 
  g dis e c 
  f d gis, gis 
  a2. a4 
  a' gis a fis 
  g dis e c 
  f d gis, gis 
  a2. a'4 
  f d g g, 
  c2. g'4 
  e d c a 
  d2 g,4 g' 
  e c f e 
  d dis e b 
  c f e e, 
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