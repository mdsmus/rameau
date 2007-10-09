
\version "2.10.33"

\header {
  title = "214 - Mitten wir im Leben sind"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \minor
}

soprano = \relative c {
  g''4 g a b 
  c c b2 
  a b4 c 
  d a g f 
  e1 
  g4 g a b 
  c c b2 
  a b4 c 
  d a g f 
  e1 
  s4 d e f 
  g4. f8 e4 d 
  c2 s4 c 
  g' g a b 
  c c b2 
  a b4 c 
  d a g f 
  e2 s4 a 
  g e f g8. f16 
  e2 s4 a 
  g e f g 
  e2 a4 g 
  a b c b8 a 
  g4 f e d 
  a'2 g4 f 
  e2 a4 g 
  a b c8 b a4 
  g2 c4 b 
  d a g f 
  e2 s4 d 
  a'2 g4 f 
  e1 
}


alto = \relative c {
  e'4 e e e 
  e8 fis16 gis a4 a gis 
  e2 g4 g 
  a8 g f4. e4 d16 c 
  b1 
  e4 e e e 
  e8 fis16 gis a4 a gis 
  e2 g4 g 
  a8 g f4. e4 d16 c 
  b1 
  s4 b c8 b c4 
  d8 e4 d c b8 
  g2 s4 g 
  c4. e8 f4. e8 
  e a16 gis a4. gis16 fis gis4 
  e2 gis4 a4. g8 f4 e4. d8 
  cis2 s4 f8 e 
  d4. c8 d4 d 
  c2 s4 e 
  d4. c16 b a4 d8 b 
  c2 e4 e 
  e e e8 f g f4 e d16 c b4 ais 
  c f4. e4 d8 
  c2 e4. d8 
  c4 d e8 g4 fis8 
  g2 g4 g 
  a8 g f e d e a, d 
  cis2 s4 d 
  d c8 d e4. d16 c 
  b1 
}


tenor = \relative c {
  b'4 b c b 
  a4. e'8 f d b e16 d 
  c2 d4 e 
  f8 e d4. c16 ais a8 b16 a 
  gis1 
  b4 b c b 
  a4. e'8 f d b e16 d 
  c2 d4 e 
  f8 e d4. c16 ais a8 b16 a 
  gis1 
  s4 g g c8 a 
  b4 c8 g g16*7 f16 
  e2 s4 g 
  g c c8 d d4 
  c8 d e4. b8 e d 
  c2 e4 e 
  d4. c8 ais4 a 
  a2 s4 c4. b8 a4 a g8 b 
  c2 s4 c 
  b g f8 e d g 
  g2 c4 b 
  c b a d 
  g,8 c16 b a8 b16 a gis4 g 
  a d4. b8 c g 
  g2 c4 c8 ais 
  a g f4 g8 e' a, d16 c 
  b2 e4 d8 e 
  f e d c b cis d a 
  a2 s4 a8 g 
  f e f4 e8 a a b16 a 
  gis1 
}


baixo = \relative c {
  e4 e8 d c b a gis 
  a4. c8 d b e4 
  a,2 g'8 f e4 
  d8 e f4 b,8 c d4 
  e1 
  e4 e8 d c b a gis 
  a4. c8 d b e4 
  a,2 g'8 f e4 
  d8 e f4 b,8 c d4 
  e1 
  s4 g8 f e4 a 
  g8 g, a b c4 g 
  c,2 s4 e'8 f 
  e d e c f4 gis, 
  a8 b c d e2 
  a, e'4 a8 g 
  f e d4. cis8 d f 
  a2 s4 f, 
  g a d8 c b g 
  a2 s4 a 
  b c d b8 g 
  c2 a8 c e d 
  c b a gis a4 b 
  c d e g 
  f8 e d c b g a b 
  c2 c8 d e4 
  f8 e d4 c d 
  e2 e8 f g4 
  d8 e f4. e8 d f 
  a2 s4 f8 e 
  d4 a8 b c cis d4 
  e1 
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