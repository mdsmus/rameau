
\version "2.10.33"

\header {
  title = "31 - Wo Gott der Herr nicht bei uns hält"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \minor
}

soprano = \relative c {
  \partial 4 c''4 
  c a8 b c d e4 
  d8 e16 f d4 c c 
  b a8 b c4 d8 c 
  b2 a4 c 
  c a8 b c d e4 
  d8 e16 f d4 c c 
  b a8 b c4 d8 c 
  b2 a4 d 
  e e b8 c d4 
  c c b c 
  d a8 b c4 b 
  a16 b c8 a4 g c 
  b a8 b c4 d8 c 
  b2 a 
}


alto = \relative c {
  \partial 4 e'8 f 
  g4 f g g 
  a g8 f e4 fis 
  g f e a 
  a gis e e8 f 
  g4 f g g 
  a g8 f e4 fis 
  g f e a 
  a gis e g 
  g g d8 e f4 
  e a gis a 
  a8 g fis4 e d8 g 
  g e fis4 d e 
  d8 e fis f e4 a2 gis4 e2 
}


tenor = \relative c {
  \partial 4 c'4 
  c c c c 
  c b g a 
  d d c8 b a4 
  f' e8 d cis4 c 
  c c c c 
  c b g a 
  d d c8 b a4 
  f' e8 d cis4 b 
  c g8 a b4 a8 b 
  c d e4 e e 
  a, d g,8 a b d 
  e4 d8 c b4 g8 a 
  b c d4 c8 b a c 
  f d b e cis2 
}


baixo = \relative c {
  \partial 4 a'4 
  e f e8 d c4 
  f g c, a' 
  g d' a8 g f e 
  d4 e a, a' 
  e f e8 d c4 
  f g c, a' 
  g d' a8 g f e 
  d4 e a, g 
  c8 d e f g4 f 
  a,8 b c d e4 a8 g 
  fis e d4 e8 fis g4 
  c, d g, e'8 fis 
  g4 fis8 gis a g f e 
  d b e4 a,2 
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