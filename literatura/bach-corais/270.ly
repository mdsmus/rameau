
\version "2.10.33"

\header {
  title = "270 - Herzlich tut mich verlangen"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \minor
}

soprano = \relative c {
  \partial 4 e'4 
  a g f e 
  d2 e4 b' 
  c c b b 
  a2. e4 
  a g f e 
  d2 e4 b' 
  c c b b 
  a2. c4 
  b8 c16 d g,4 a b 
  c2 c4 g 
  a g a f 
  e2 r4 c' 
  b d c b 
  a2 b4 e, 
  f e d g 
  e2.
}


alto = \relative c {
  \partial 4 e'4 
  e8 d d4 d c8 b 
  a2 b4 e 
  e f f e8 d 
  cis4 d4. c8 e4 
  e8 d d4 d c8 b 
  a2 b4 e 
  e f f e8 d 
  cis4 d4. c8 a' g 
  f4 e e8 c f4 
  g4. f8 e4 c 
  c c8 ais a4 a 
  a2 r4 e' 
  e d e8 fis g gis 
  a4 a, e' e8 cis 
  a b c4 d d8 c 
  b4. b16 a b4
}


tenor = \relative c {
  \partial 4 g'8 b 
  a c b4 c8 g g4 
  a8 f d d' d b gis4 
  a4. c8 d d, g f 
  e4 f8. g16 a4 g8 b 
  a c b4 c8 g g4 
  a8 f d d' d b gis4 
  a4. c8 d d, g f 
  e4 f8. g16 a4 e' 
  d d8 c c4 d 
  g, a8 b c4 c 
  f, g e f8 g 
  a2 r4 a 
  b b b8 a e' d 
  c cis d4 g, a8 g 
  f g a4 a b 
  b8 gis e c' b4
}


baixo = \relative c {
  \partial 4 e4 
  f g a,8 b c4 
  f2 e4 e 
  a8 g f e d b e4 
  a,2. e'4 
  f g a,8 b c4 
  f2 e4 e 
  a8 g f e d b e4 
  a,2. a'4 
  d, e f d 
  c2 c4 e 
  f c cis d 
  a2 r4 a 
  e' b c8 d e4 
  f2 e4 a 
  d, a8 g f fis g4 
  gis a e'4
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