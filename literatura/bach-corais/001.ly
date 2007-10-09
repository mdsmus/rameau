
\version "2.10.33"

\header {
  title = "1 - Aus meines Herzens Grunde"
  composer = "J. S. Bach"
}

global =  {
  \time 3/4 
  \key g \major
}

soprano = \relative c {
  \key g \major
  \partial 4 g''4 g2 d'4 b4. a8 
  g4 g4. a8 b4 
  a2 b4 d2 c4 b a2 g g4 
  g2 d'4 b4. a8 g4 g4. a8 
  b4 a2 b4 
  d2 c4 b 
  a2 g 
  b4 b c d 
  d4. c8 b4 a2 g4 b2 
  c4 d2 c4 
  b2. g2 b4 d2 
  c4 b2 a4 
  g4. a8 b4 a2 b4 d2 
  c4 b a2 
  g 
}


alto = \relative c {
  \key g \major
   \partial 4  d'4 d 
  e d d2 
  b4 e8 d e fis g4 
  fis2 g4 d 
  e fis g2 
  fis4 d2 d4 
  d e d d2 b4 e8 d e fis 
  g4 fis2 g4 
  d e fis g2 fis4 d2 
  g4. fis8 e fis g4. a8 g fis g4 fis2 e4 e fis8 g 
  a4 a g4. fis8 
  g2 f4 e2 g4 a4. g8 
  fis4 g2 fis4 
  fis8 e e fis g4 fis2 g4 a2 
  g8 fis g2 fis4 
  d2 
}


tenor = \relative c {
  \key g \major
   \partial 4 b'4 b 
  c8 b a4 g fis 
  g c8 b c4 d 
  d2 d4 a 
  b c d e 
  d8 c b2 b4 
  b c8 b a4 g 
  fis g c8 b c4 
  d d2 d4 
  a b c d 
  e d8 c b2 
  d4 d c b8 a 
  b c d4 d d2 b4 g b 
  e d2 d4 
  d2. c2 d4 d8 c b4 
  c d2 d8 c 
  b4 c d d2 d4 d2 
  e4 e2 d8 c 
  b2 
}


baixo = \relative c {
  \key g \major
   \partial 4  g4 g' 
  e fis g d 
  e c b8 a g4 
  d'2 g,4 fis 
  g a b c 
  d g,2 g4 
  g' e fis g 
  d e c b8 a 
  g4 d'2 g,4 
  fis g a b 
  c d g,2 
  g4 g a b 
  b4. a8 g4 d'2 e d4 
  c b4. c8 d4 
  g,8 a b4 g c2 g4 fis g 
  a b g d' 
  e8 d c b a g d'2 g fis4 
  e e8 d c4 d 
  g,2 
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