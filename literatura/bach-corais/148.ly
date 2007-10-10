
\version "2.10.33"

\header {
  title = "148 - Danket dem Herrn, heuf und allzeit"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key g \major
}

soprano = \relative c {
  \partial 4 b''4 
  b8 c d4 b g 
  a b c b 
  a g g4. a8 
  b4 b a8 g a4 
  g2. b4 
  b8 c d4 b g 
  a b c b 
  a g g4. a8 
  b4 b a8 g a4 
  g2. b4 
  a b g e 
  fis g a b 
  g g g4. a8 
  b4 b a8 g a4 
  g2. 
}


alto = \relative c {
  \partial 4 g''4 
  g a g g 
  f8 e d4 e d4. c8 b4 e2 
  d4 d d4. c8 
  b2. g'4 
  g a g g 
  f8 e d4 e d4. c8 b4 e2 
  d4 d d4. c8 
  b2. g'4 
  fis fis e8 d cis4 
  d4. cis8 d4 dis 
  b e d e8 fis 
  g4 d d4. c8 
  b2. 
}


tenor = \relative c {
  \partial 4 d'4 
  d d d d8 c 
  c4 g g g 
  fis g c2 
  b8 a g4 g fis 
  d2. d'4 
  d d d d8 c 
  c4 g g g 
  fis g c2 
  b8 a g4 g fis 
  d2. d'4 
  d8 c b4 b a 
  a g fis fis 
  g c b8 c b a 
  g4 g2 fis4 
  d2. 
}


baixo = \relative c {
  \partial 4 g4 
  g' fis g e 
  f g c, g 
  d' e8 d c d e fis 
  g4 b,8 c d4 d 
  g,2. g4 
  g' fis g e 
  f g c, g 
  d' e8 d c d e fis 
  g4 b,8 c d4 d 
  g,2. g4 
  d' dis e a8 g 
  fis4 e d b 
  e8 d e fis g a g fis 
  e4 b8 c d2 
  g,2. 
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