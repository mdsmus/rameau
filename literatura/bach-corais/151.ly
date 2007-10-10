
\version "2.10.33"

\header {
  title = "151 - Jesus ist mein Aufenthalt"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key g \major
}

soprano = \relative c {
  b''4 b b d 
  c c b2 
  b4 b a b 
  c b a2 
  g1 
  b4 b b d 
  c c b2 
  b4 b a b 
  c b a2 
  g1 
  b4 b a a 
  g g fis2 
  e'4 d c b 
  a a g2 
}


alto = \relative c {
  g''4 g8 a g4 g4. fis16 e fis4 g2 
  g4 g4. fis8 g4 
  a4. g4 fis16 e fis4 
  d1 
  g4 g8 a g4 g4. fis16 e fis4 g2 
  g4 g4. fis8 g4 
  a4. g4 fis16 e fis4 
  d1 
  g4 g g fis2 e4 dis2 
  e8 fis g4. fis8 g4. fis16 e fis4 d2 
}


tenor = \relative c {
  d'4 e8 fis e4 d 
  e8 c a d d2 
  d4 d d d 
  e8 d d4 e8 a, d c 
  b1 
  d4 e8 fis e4 d 
  e8 c a d d2 
  d4 d d d 
  e8 d d4 e8 a, d c 
  b1 
  d4 d d4. c8 
  b4 b b2 
  g'8 a d,4 e8 c d4 
  e8 a, d c b2 
}


baixo = \relative c {
  g'8 fis e dis e d c b 
  a4 d g,2 
  g8 a b c d4 g4. fis8 g b, c4 d 
  g,1 
  g'8 fis e dis e d c b 
  a4 d g,2 
  g8 a b c d4 g4. fis8 g b, c4 d 
  g,1 
  g8 a b c d e fis dis 
  e fis g a b2 
  c,8 c'4 b8 a, a'4 g8 
  c,4 d g,2 
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