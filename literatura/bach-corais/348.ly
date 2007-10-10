
\version "2.10.33"

\header {
  title = "348 - Meinen Jesum laß ich nicht, weil er sich für mich gegeben"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key c \major
}

soprano = \relative c {
  g''4 g a a 
  b b c2 
  d4 d c c 
  b a8 b16 c a2 
  g g4 g 
  a a g f 
  e2 g4 g 
  f f e d8 e16 f 
  d2 c 
  c'4 c b b 
  a a g2 
  g4 g f e 
  d d c2 
}


alto = \relative c {
  e'4 e f f 
  f8 e d4 e2 
  g4 g g fis 
  d c8 d16 e fis2 
  d e8 d c4 
  c d d8 e f d 
  c2 b4 e 
  d d c8 ais a4 
  g2 g 
  e'8 d c4 g'8*5 a16 g fis e fis8 b,2 
  e4 e d c8 b 
  a4 b g2 
}


tenor = \relative c {
  c'4 c c d 
  d g, g2 
  d'4 b a a 
  g8 fis e c' c b a4 
  b2 c4 g 
  f f g c8 g 
  g2 g4 a 
  a g g4. f4 e8 d4 e2 
  g4. fis8 d'4 d 
  d c8 a e'2 
  cis4 a a8*5 d,8 g f e2 
}


baixo = \relative c {
  c'8 ais a g f e d4 
  g g, c2 
  b8 c d e a, b c d 
  g,4 c d2 
  g, c8 d e c 
  f e d c b c a b 
  c2 e8 d cis a 
  d c b g c4 f, 
  g2 c 
  c8 b a4 g8 a b c 
  d4 dis e2 
  a,8 b cis a d4 a8 g 
  f4 g c,2 
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