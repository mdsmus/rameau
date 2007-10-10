
\version "2.10.33"

\header {
  title = "239 - Den Vater dort oben"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key c \major
}

soprano = \relative c {
  g''4 g a b 
  c2 c 
  e4 d c b 
  a2 g 
  g4 g a b 
  c g g2 
  a4 g f e 
  d d c2 
  c'4 d c b 
  a2 g 
  g4 g a b 
  c g g2 
  a4 g f e 
  d2 c 
}


alto = \relative c {
  e'4 d e8 fis g4 
  g f2 e4 
  g fis8 g16 fis e8 a d, c16 d 
  e8 c a d16 c b2 
  e4 e e8 fis g4 
  g8 f4 e16 d e2 
  f8 e d e16 d c8 b c2 c8 b g2 
  g'4 g4. fis8 g4 
  g fis g2 
  e8 f g4. f16 e f4 
  f8 e d4 c2 
  c8 f4 e d8 c4. b16 a b4 g2 
}


tenor = \relative c {
  c'4 g c d 
  c8 ais a4 g2 
  c8 b a b16 a g8 fis g8*5 fis8 d2 
  b'4 b c d 
  c d8 g, c2 
  c4 b8 c16 b a8 d g, f16 g 
  a8 f d g16 f e2 
  e'4 d g,8 a b c16 d 
  e8 c a d16 c b2 
  c4 c c d 
  g, g8. f16 e2 
  f4 g8 c16 ais a4 a 
  a8 d, d g16 f e2 
}


baixo = \relative c {
  c4. b8 a4 g8 f 
  e4 f c2 
  c'4. b4 a8 g a16 b 
  c8 a d4 g,2 
  e8 e'4 d8 c4 b 
  a b c2 
  f4. e4 d8 c d16 e 
  f8 d g g, c2 
  c4. b8 e4 d 
  c d g,2 
  c8 d e4 f8 e d4 
  c4. b8 c2 
  f4 c d a8 g 
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