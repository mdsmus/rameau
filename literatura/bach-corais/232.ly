
\version "2.10.33"

\header {
  title = "232 - O höchster Gott, o unser lieber Herre"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \minor
}

soprano = \relative c {
  \partial 4 d'4 
  f g a d 
  c4. b8 a b c4 
  b2 a4 d 
  d d cis e 
  d a ais a8 g 
  g2 f4 f 
  e e d a' 
  c c g8 a ais4 
  a a c d 
  a c a g8 f 
  e4. d8 d2 
}


alto = \relative c {
  \partial 4 a'4 
  d4. e8 f4 a 
  a gis a8 gis a4 
  a8 gis16 fis gis4 e a 
  a8 g b4 a a8 g 
  f4 f g f 
  f8 e16 d e4 c d 
  d cis a f'4. e8 f4 e f8 g 
  f4 f f f 
  f g4. f16 e d4 
  d cis a2 
}


tenor = \relative c {
  \partial 4 f4 
  a ais d f 
  e e8. d16 c8 d e f 
  b, e4 d8 cis4 d 
  d8 e f4 e a, 
  a d4. c8 c4 
  d8 ais g c16 ais a4 ais 
  ais a8 g f4 d' 
  c c c8 a d c 
  c4 d c4. ais8 
  c4 c c ais4. g8 e a16 g fis2 
}


baixo = \relative c {
  \partial 4 d4 
  d g, d d' 
  a' e f c8 d 
  e4 e, a f' 
  ais a8 gis a4 cis, 
  d8 e f4. e8 f4 
  ais, c f, ais 
  g a d, d' 
  a8 g a ais c4 d8 e 
  f4 d a ais 
  f e f ais 
  g a d,2 
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