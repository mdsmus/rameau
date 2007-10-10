
\version "2.10.33"

\header {
  title = "30 - Jesus Christus, unser Heiland, der von uns den Gottes Zorn wandt"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key e \minor
}

soprano = \relative c {
  e'4 b' b a 
  b e,8 fis g4 g 
  g fis e2 
  g4 g g e 
  g a b a 
  g fis e2 
  g4 g g e 
  g a b a 
  g2 s4 d' 
  e d8 c b a g a 
  b4 a g fis 
  e1 
}


alto = \relative c {
  b'4 b e8 dis e4 
  dis e8 dis e4 e 
  e4. dis8 b2 
  e4 e d c 
  d e8 fis g4. fis4 e dis8 b2 
  e4 g8 fis e4 c 
  e8 d e fis g4. fis8 
  d2 s4 g8 f 
  e4 fis g8 dis e d4 g fis e dis8 
  b1 
}


tenor = \relative c {
  g'4 fis g fis8 e 
  fis4 b8 a b4 e8 dis 
  cis4 fis,8 b16 a g2 
  b4 c g g 
  g8 a16 b c4 d8 e16 d c b c8 
  b4 b8. a16 g2 
  b8 c d4 c g 
  g c d d8. c16 
  b2 s4 d 
  c8 b a4 g8 c b a 
  g d' e b b4 c8 b16 a 
  gis1 
}


baixo = \relative c {
  e4. d8 c2 
  b8 a' g fis e d c b 
  ais4 b e,2 
  e'8 d c4 b c4. b8 a4 g a 
  b2 e 
  e4 b c8 d e d 
  c b a4 g d' 
  g,2 s4 b 
  c d e4. fis8 
  g b, cis dis e g, a b 
  e,1 
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