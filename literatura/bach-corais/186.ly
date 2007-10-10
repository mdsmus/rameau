
\version "2.10.33"

\header {
  title = "186 - Ach Gott, erhör mein Seufzen und Wehklagen"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \minor
}

soprano = \relative c {
  \partial 4 d'4 
  f f g g 
  a a ais a 
  g2 f4 c 
  f f g g 
  a a g f 
  e2 d4 a' 
  f g e a 
  f g e e 
  f f g g 
  a a g f 
  e2 d 
}


alto = \relative c {
  \partial 4 a'4 
  d8 e f4 f e8 d 
  c4 d d8 g4 f e16 d e4 c a8 g 
  f4 d' d c 
  c f f8 e4 d8 
  d4 cis a e'4. d8 d e cis4 e 
  d8 c d4 c c 
  c d d e4. d16 e f4 e4. d8 
  d4 cis a2 
}


tenor = \relative c {
  \partial 4 f4 
  a c d c8 ais 
  a g f4. e8 c'4 
  d8 g, c ais a4 f8 g 
  a4 ais b8 a g4 
  f c' c8. ais16 a4 
  ais a8 g f4 a 
  a ais a a 
  a g g g 
  a a ais4. c16 b 
  a4 d8 c ais4 a 
  ais a8 g fis2 
}


baixo = \relative c {
  \partial 4 d4 
  d a ais c 
  f8 e d4 g, a 
  ais c f, f'8 e 
  d c ais a g f e4 
  f8 g a ais c4 d 
  g, a d, c' 
  d g, a c2 b4 c c8 ais 
  a f d' c ais a g c 
  f e d4. cis8 d4 
  g, a d,2 
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