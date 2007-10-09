
\version "2.10.33"

\header {
  title = "10 - Aus tiefer Not schrei ich zu dir 1"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \minor
}

soprano = \relative c {
  b''2 e,4 b' 
  c b8 a g4 a 
  b2 b 
  c4 d c8 b a4 
  g f e2 
  b' e,4 b' 
  c b8 a g4 a 
  b2 b 
  c4 d c8 b a4 
  g f e2 
  a g4 c 
  b a d8 c b4 
  a2 c 
  b4 c d g, 
  b a g2 
  g c4 b 
  a e g f 
  e1 
}


alto = \relative c {
  e'2 e4 gis 
  a g8 fis e4 fis 
  gis2 gis 
  a4 b c f, 
  e d8 c b2 
  e e4 gis 
  a g8 fis e4 fis 
  gis2 gis 
  a4 b c f, 
  e d8 c b2 
  e d4 e8 fis 
  g4 a b8 a gis4 
  e2 a 
  g4 g g8 f e4 
  d c b2 
  e e4 e8 d 
  c4 c d2. c4 b2 
}


tenor = \relative c {
  gis'2 a4 d 
  e d e8 d c4 
  b2 e 
  e4 f g c, 
  c8 b a4 gis2 
  gis a4 d 
  e d e8 d c4 
  b2 e 
  e4 f g c, 
  c8 b a4 gis2 
  a b4 c 
  d d8 e f4 b, 
  c2 e 
  e4 e d c 
  fis,8 g4 fis8 g2 
  g a4 gis 
  a g g a 
  b a gis2 
}


baixo = \relative c {
  d2 c4 b 
  a b c8 b a4 
  e'2 e 
  a4 g8 f e4 f 
  c d e2 
  d c4 b 
  a b c8 b a4 
  e'2 e 
  a4 g8 f e4 f 
  c d e2 
  c' b4 a 
  g f8 e d4 e 
  a,2 a' 
  e4 d8 c b4 c 
  d d g,2 
  c a4 e' 
  f c ais a 
  gis a e2 
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