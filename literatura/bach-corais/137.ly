
\version "2.10.33"

\header {
  title = "137 - Wer Gott vertraut, hat wohl gebaut"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key g \major
}

soprano = \relative c {
  r4 g'' g a 
  b2 s4 b 
  c b a2 
  s4 a g a 
  b a g2 
  a4 a b a 
  g g fis2 
  g1 
  s4 g g a 
  b2 s4 b 
  c b a2 
  s4 a g a 
  b a g2 
  a4 a b a 
  g g fis2 
  g1 
  s4 b c b 
  a2 s4 a 
  g g fis2 
  s4 fis g fis 
  e e dis2 
  e s4 g 
  g fis g2 
  s4 b c b 
  a2 s4 a 
  g a b a 
  g2 a4 a 
  b a g g 
  fis2 g 
}


alto = \relative c {
  r4 d' e8 g4 fis8 
  g2 s4 g4. fis8 g4 g fis 
  s4 fis4. e4 d8 
  d4 d d cis 
  d d d8 e fis4. e8 d e d2 
  d1 
  s4 d e8 g4 fis8 
  g2 s4 g4. fis8 g4 g fis 
  s4 fis4. e4 d8 
  d4 d d cis 
  d d d8 e fis4. e8 d e d2 
  d1 
  s4 g g8 a4 g fis16 e fis4 s4 fis2 e dis4 
  s4 fis b,8 e dis4 
  e b8 c b2 
  b s4 b8 c 
  d e d4 d2 
  s4 g a4. g8 
  g4 fis s4 fis 
  g d d8 e fis e 
  d c d e fis4 a4. g4 fis e8 d e 
  d2 d 
}


tenor = \relative c {
  r4 b' b d 
  d2 s4 d 
  c d d2 
  s4 d8 c b4 a4. g4 fis8 g b a g 
  fis4 d'8 c b cis d c 
  b4 b8 a a b c4 
  b1 
  s4 b b d 
  d2 s4 d 
  c d d2 
  s4 d8 c b4 a4. g4 fis8 g b a g 
  fis4 d'8 c b cis d c 
  b4 b8 a a b c4 
  b1 
  s4 d e8 d d4 
  d2 s4 b 
  b b b2 
  s4 b8 a g c4 b a8 g fis fis g a4 
  g2 s4 g8 a 
  b a a16 b c8 c4 b 
  s4 d8 e4 d8 d4 
  d2 s4 d 
  d4. c8 b c d4 
  g,8 a b c16 b a4 d 
  d d b4. a8 
  a b c4 b2 
}


baixo = \relative c {
  r4 g'8 fis e4 d 
  g2 s4 g, 
  a b8 c d2 
  s4 d e fis 
  g d e2 
  d4 fis g d 
  e b8 c d2 
  g,1 
  s4 g'8 fis e4 d 
  g2 s4 g, 
  a b8 c d2 
  s4 d e fis 
  g d e2 
  d4 fis g d 
  e b8 c d2 
  g,1 
  s4 g'8 fis e fis g4 
  d2 s4 dis8 b 
  e fis g a b2 
  s4 dis, e b 
  c g8 a b2 
  e s4 e 
  b8 c d4 g,2 
  s4 g'4. fis8 g4 
  d2 s4 c 
  b fis g d'8 c 
  b a g4 d' fis 
  g d e b8 c 
  d2 g, 
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