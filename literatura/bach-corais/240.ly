
\version "2.10.33"

\header {
  title = "240 - Nun sich der Tag geendet hat"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \minor
}

soprano = \relative c {
  \partial 4 e''4 
  a, b c c 
  d d e e 
  d e c c 
  b2 s4 e 
  c b c a 
  gis a b e 
  d c b4. b8 
  a1 
}


alto = \relative c {
  \partial 4 a''4 
  e e e8 f g4 
  a g g g 
  a e e e 
  e2 s4 b'4. a8 gis4 a8 g f4. e8 e fis gis4 a4. gis8 a4 a gis 
  e1 
}


tenor = \relative c {
  \partial 4 c'4 
  c b4. a8 g c4 b16 a b4 c c2 b a gis4 s4 e' 
  e e e d4. b8 c4 b a 
  d e f8 d b e16 d 
  cis1 
}


baixo = \relative c {
  \partial 4 a8 b 
  c b a gis a4 e 
  f g c, c' 
  fis, gis a8 b c d 
  e2 s4 gis, 
  a e'8 d c4 d8 c 
  b e c a e'4 c 
  b a d e 
  a,1 
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