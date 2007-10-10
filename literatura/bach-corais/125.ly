
\version "2.10.33"

\header {
  title = "125 - Allein Gott in der Höh sei Ehr"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key g \major
}

soprano = \relative c {
  \partial 4 g''8 a 
  b4 c d c 
  b a b b 
  b a8 b c b a4 
  g a g g8 a 
  b4 c d c 
  b a b b 
  b a8 b c b a4 
  g a g g 
  a b c b 
  a b a a 
  b c d c 
  b a b g 
  a b c8 b a4 
  g8 e fis4 g2 
}


alto = \relative c {
  \partial 4 d'4 
  g g fis e8 fis 
  g4 fis g d 
  e e8 d c d d4 
  d8 g fis e d4 d 
  g g fis e8 fis 
  g4 fis g d 
  e e8 d c d d4 
  d8 g fis e d4 d 
  d d c8 d e4 
  e8 d d c16 b c4 d 
  d e fis e 
  d c8 e16 dis e4 e 
  e d c d 
  d8 e d4 d2 
}


tenor = \relative c {
  \partial 4 b'8 c 
  d4 e a,8 b c4 
  d d d g, 
  g2. c8 a 
  d c16 b c4 b b8 c 
  d4 e a,8 b c4 
  d d d g, 
  g2. c8 a 
  d c16 b c4 b b 
  fis gis a gis 
  a gis e a 
  g g a g8 a 
  b4 e,8 fis g4 b 
  e,8 fis g4 g fis 
  g8 c a4 b2 
}


baixo = \relative c {
  \partial 4 g4 
  g'8 fis e4 d a 
  b8 c d4 g, g'8 fis 
  e d c b a g fis4 
  b8 g d'4 g, g 
  g'8 fis e4 d a 
  b8 c d4 g, g'8 fis 
  e d c b a g fis4 
  b8 g d'4 g, g 
  d' c8 b a4 d8 e 
  f4 e a, fis' 
  g8 fis e4 d e8 fis 
  g4 a e e8 d 
  c4 b a8 b c4 
  b8 c d4 g,2 
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