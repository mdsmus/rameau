
\version "2.10.33"

\header {
  title = "111 - Herzliebster Jesu, was hast du verbrochen"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \minor
}

soprano = \relative c {
  \partial 4 a''4 
  a a gis e 
  a b c c 
  d c16 b c8 b4 b 
  c d8 e16 f e4 c 
  f f e8 d c d 
  d2 c4 c 
  b a g8 fis e fis 
  g4 g a g 
  f2 e4 e' 
  d c8 b b2 
  a1 
}


alto = \relative c {
  \partial 4 c'8 d 
  e4 e e b 
  e8 fis gis4 a a 
  a2 gis4 gis 
  a g g f 
  a a a e 
  a g g a 
  a8 g g fis e4 e 
  e8 d cis d e4 e 
  e d cis a' 
  a8 b e, d f4 e8 d 
  cis1 
}


tenor = \relative c {
  \partial 4 a'8 b 
  c4 c b gis 
  a d e e 
  f a, e' e 
  e b c a 
  d d c c 
  c b e e 
  fis8 e c4 b b 
  b ais a a 
  a2 a4 c 
  c8 b a4 a gis 
  e1 
}


baixo = \relative c {
  \partial 4 a'4 
  a,8 b c d e f e d 
  c d c b a e' a g 
  f e f d e4 e 
  a8 g f g c, d e f 
  d e f g a b a g 
  f e f g c,4 a' 
  dis,8 e fis dis e fis g fis 
  e f e d cis a b cis 
  d e f g a4 a8 g 
  fis gis a f d b e4 
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