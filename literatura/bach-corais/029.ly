
\version "2.10.33"

\header {
  title = "29 - Wie nach einer Wasserquelle"
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
  b4 d c b8 a 
  g4 a b2 
  g b8 c d4 
  c b a b 
  a2 g 
}


alto = \relative c {
  d'4 d d d 
  d8 cis d4 cis a 
  e' d d a' 
  d, d d2 
  d4 d d d 
  d8 cis d4 cis a 
  e' d d a' 
  d, d d2 
  g4 g fis g 
  g g8 fis g2 
  g4 g g g8 fis 
  e4 d8 e fis2 
  g4 g8 fis e fis g fis 
  e4 fis g2 
  e g4 a 
  g d8 e fis4 g 
  g fis d2 
}


tenor = \relative c {
  b'4 a g g8 fis 
  g4 a a8 g fis4 
  b a g8 fis e fis 
  g4 g8 fis b2 
  b4 a g g8 fis 
  g4 a a8 g fis4 
  b a g8 fis e fis 
  g4 g8 fis b2 
  d4 e a, e' 
  d d d2 
  b4 b c8 b a4 
  g8 a b cis d2 
  d8 c b4 c d 
  e8 d c4 d2 
  c d4 d 
  g,8 a b c d4 d 
  d4. c8 b2 
}


baixo = \relative c {
  g'4 fis g d 
  e fis8 g a4 d, 
  e fis g a 
  b8 c d4 g,2 
  g4 fis g d 
  e fis8 g a4 d, 
  e fis g a 
  b8 c d4 g,2 
  g8 fis e4 d e8 fis 
  g4 d g,2 
  g'8 f e d c4 d 
  e8 fis g4 d2 
  g4 g, a b 
  c8 b a4 g8 a b g 
  c2 g'4 fis 
  e8 fis g4 c, b8 c 
  d4 d, g2 
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