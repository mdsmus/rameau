
\version "2.10.33"

\header {
  title = "64 - Wie nach einer Wasserquelle"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key g \major
}

soprano = \relative c {
  g''4 a b a 
  g fis e d 
  g a b c 
  b a g2 
  g4 a b a 
  g fis e d 
  g a b c 
  b a g2 
  b4 c d c 
  b a b2 
  d4 d e d 
  c b a2 
  b8 c d4 c b 
  g a b2 
  g b4 d 
  c b a b 
  a2 g 
}


alto = \relative c {
  d'4 d d4. cis8 
  b4 a8 d d cis d4 
  b d d d 
  d d d2 
  d4 d d4. cis8 
  b4 a8 d d cis d4 
  b d d d 
  d d d2 
  g4 g fis e8 fis 
  g4 fis g2 
  g4 g g fis 
  e d d2 
  d4 g8 f e4 d 
  e8 dis e4. dis16 cis dis4 
  b2 e4 f 
  e b8 c d4 d 
  d2 d 
}


tenor = \relative c {
  b'4 fis g8 fis e4 
  d8 e fis8. g16 a8 e fis4 
  g fis g a 
  a8 g g fis b2 
  b4 fis g8 fis e4 
  d8 e fis8. g16 a8 e fis4 
  g fis g a 
  a8 g g fis b2 
  d4 e a,8 b c4 
  d d d2 
  b4 b c a 
  g g fis2 
  g8 a b4. a4 g fis8 e fis g fis16 e fis4 
  e2 g4 g 
  g g fis g4. fis16 e fis4 b2 
}


baixo = \relative c {
  g'4 d g, a 
  b8 cis d4 a d, 
  e' d8 c b a g fis 
  g4 d g2 
  g'4 d g, a 
  b8 cis d4 a d, 
  e' d8 c b a g fis 
  g4 d g2 
  g'8 fis e4 d a 
  b8 c d4 g,2 
  g8 a b g c b c d 
  e fis g4 d2 
  g4 g, a b 
  c c b2 
  e e8 d c b 
  c d e d c b a g 
  d'4 d, g2 
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