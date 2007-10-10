
\version "2.10.33"

\header {
  title = "315 - O Gott, du frommer Gott"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key e \minor
}

soprano = \relative c {
  \partial 4 b''4 
  b e d c16 b c8 
  b2. b8 c 
  d4 g, a b 
  a2 g4 b 
  b e d c16 b c8 
  b2. b8 c 
  d4 g, a b 
  a2 g4 a 
  a b c8 e d c 
  b2. b4 
  a d8 e16 fis e4 d8 cis 
  d2. d4 
  d b c d 
  e2. a,4 
  b8 c16 d c8 b b4 a8 g 
  g1 
}


alto = \relative c {
  \partial 4 g''4 
  fis g8 fis g4 fis 
  g2. g4 
  g8 fis e fis16 g fis4 g4. e8 fis4 d g 
  fis g8 fis g4 fis 
  g2. g4 
  g8 fis e fis16 g fis4 g4. e8 fis4 d e 
  d fis g a 
  g2. g8 fis 
  e d16 cis d4 g8 b a g 
  fis2. a4 
  g g g g 
  g2. fis4 
  g g g fis 
  d1 
}


tenor = \relative c {
  \partial 4 g'8 a 
  b4. a8 b e d4 
  d2. d8 c 
  b a g4 d' d 
  d4. c8 b4 g8 a 
  b4. a8 b e d4 
  d2. d8 c 
  b a g4 d' d 
  d4. c8 b4 cis 
  d d c8 b a d 
  d2. d4 
  cis8 a g fis b g' fis e 
  d2. fis4 
  g d e f 
  e2. d4 
  d d8 e d4 c 
  b1 
}


baixo = \relative c {
  \partial 4 e4. d4 c8 b c d4 
  g,2. g8 a 
  b4 c4. b8 a g 
  d'2 g,4 e'4. d4 c8 b c d4 
  g,2. g8 a 
  b4 c4. b8 a g 
  d'2 g,4 g'4. fis8 e d e4 fis 
  g2. g,4 
  g'8 fis b a g e a4 
  d,2. d'8 c 
  b a g f e d c b 
  c2. d4 
  g,8 a b c d4 d 
  g,1 
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