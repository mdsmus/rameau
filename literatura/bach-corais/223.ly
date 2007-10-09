
\version "2.10.33"

\header {
  title = "223 - Ich dank dir Gott für alle Wohltat"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key c \major
}

soprano = \relative c {
  \partial 4 g''4 
  e fis g g 
  e d c c 
  g' g a b 
  c b a a 
  g2 s4 g 
  a b c g 
  a g f f 
  e2 s4 c' 
  a b c a 
  g f e g 
  e fis g c 
  b a g g 
  e8 f g4 a g 
  f e d d 
  c1 
}


alto = \relative c {
  \partial 4 c'4 
  c c b d4. c4 b8 g4 g 
  d' e4. fis8 g4. fis8 g8*5 fis8 
  d2 s4 e4. d4 e8 e4 c4. b8 c cis d cis d2 cis4 s4 g'4. f16 e 
  f4 e f 
  e4. d4 cis8 d4 
  e b b g'8 a4 g fis8 d4 d 
  c c c8 f4 e8 
  d4. c4 b16 a b4 
  g1 
}


tenor = \relative c {
  \partial 4 e8 f 
  g4 a d, g 
  g16*7 f16 e4 e 
  g c c d 
  c d e d8. c16 
  b2 s4 c 
  c b a e 
  f g a a 
  a2 s4 c 
  c d g, d'8 c 
  ais4 a a g4. a4 g16 fis e4 e'8 d 
  d4 d8. c16 b4 g 
  g c8 ais a8. b16 c8. ais16 
  a8 g g4 a8 d, g f 
  e1 
}


baixo = \relative c {
  \partial 4 c4 
  ais a g b 
  c g c, c' 
  b c8 b a4 g 
  e' d c d 
  g,2 s4 e' 
  f gis, a c 
  f4. e8 d e f d 
  a'2 s4 e 
  f8 e d4 c d4. cis8 d4 a b 
  cis dis e e8 fis 
  g4 d g, b 
  c8 d e c f4 c4. b8 c4 f, g 
  c,1 
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