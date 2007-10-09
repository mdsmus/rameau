
\version "2.10.33"

\header {
  title = "127 - Dies sind die heiligen zehn Gebot"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key c \major
}

soprano = \relative c {
  \partial 4 g''4 
  g g g g 
  g8 a b4 c c 
  d d c g 
  g8 a b4 c c 
  d d c g 
  a g f g 
  a b c2 
  ais8 a g a ais4 a 
  g g g1 
}


alto = \relative c {
  \partial 4 d'4 
  e f e e 
  d4. e16 f e4 f8 g 
  a g f4 f4. e8 
  d4 g8 f e4 f 
  f f f e 
  e8 f e4 d e 
  f f8 e e2 
  fis4 g8 d d4 f 
  f e d1 
}


tenor = \relative c {
  \partial 4 b'4 
  c d d c 
  b8 a g4 g a8 c 
  f4 a,8 b c4 c 
  b8 a g4 g a 
  a d g, c8 ais 
  a4 ais8 a a4 c 
  c8 d d4 c2 
  d8 c ais a g4 a 
  d4. c8 c b16 a b2. 
}


baixo = \relative c {
  \partial 4 g'8 f 
  e d c b c d e f 
  g4 g, c f8 e 
  d e f g a b c4 
  g8 f e d c4 f8 e 
  d c4 b8 c d e d 
  cis d4 cis8 d4 c8 b 
  a a'4 gis8 a2 
  d,4 e8 fis g4 d8 c 
  b g c4 g1 
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