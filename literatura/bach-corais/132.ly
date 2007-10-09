
\version "2.10.33"

\header {
  title = "132 - Kyrie, Gott Vater in Ewigkeit"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key c \major
}

soprano = \relative c {
  g''2 a 
  b a4 c 
  c b a a 
  g2 a4 a 
  g f e e 
  d2 d4 a' 
  a g a b 
  c b a2 
  g g4 f8 g 
  a4 g g f 
  e1 
  e2 d 
  g a4 b 
  c c c2 
  c4 c b a 
  g a b b 
  b2 e,4 d 
  g a8 b c4 c 
  c2 c4 c 
  b a g a 
  a g f e 
  d2 d4 a' 
  a g a b 
  c b a2 
  g g4 f8 g 
  a4 g g f 
  e1 
  b'2 c 
  d s4 b 
  d c b a 
  g2 b4 c 
  d b8 c d4 c 
  b a g a 
  a g f e 
  d2 d4 a' 
  a g a b 
  c b a2 
  g g4 f8 g 
  a4 g g f 
  e1. 
}


alto = \relative c {
  e'8 f g4. fis16 e fis4 
  g2 f4 e 
  a g4. fis16 e fis4 
  d2 f8 e d cis 
  d cis d4. cis16 b cis4 
  a2 d4 e 
  f16 e d4 e16 d c8 f4 e8. fis16 g4 g fis16 e fis4 
  d2 e4 d 
  c8 d e4 e d 
  c b8 a b2 
  b4 c8 b a4 b8 c 
  d f e d c d16 e f4 
  e16 f g4 f e16 d e4 
  e16 fis g4 fis e16 d cis b a8 
  d c4 a' g8 fis16 e fis8 
  e2 c4. b8 
  c d16 e f e f8 e4 f4. e16 d e4 e8 a16 gis a4. g4 fis8 d4 f8 
  g 
  a g16 f f8 e4 d cis8 
  a2 a4 d16 e f8 
  f4. e8. d16 e g f e fis a 
  g8 d d g4 fis16 e fis4 
  d2 e4 f8 e 
  f4. e16 d e4. d16 c 
  b8 d c2 b4 
  g'2 g 
  g s4 g 
  g4. a4 g fis8 
  d2 g4 a4. g16 fis g4 g4. fis8 
  b,16 c d8 e d16 c b4 d 
  d8 dis d cis d4. cis8 
  a2 d4 e 
  a,8 fis'4 e8 fis4. e16 dis 
  e8 d4 g fis16 e fis4 
  d2 d8 e d e 
  f e d g cis, a d4 
  cis c b1 
}


tenor = \relative c {
  b'4. c16 d e8 a, d4 
  d2 d4 c8 d 
  e8*5 c8 a d16 c 
  b2 d8 c16 ais a4 
  ais a8 d ais g e a16 g 
  f2 f4 e8 a 
  a d16 c b8 c16 b a8 c d c16 b 
  a8 g16 a b8 c16 d e8 c a d 
  b2 c4. ais8 
  a b c ais a ais4 a8 
  a4 gis8 fis gis2 
  g4 a8 g fis4 g4. d'8 c b a4. g16 f 
  g8 c16 ais a4 g2 
  a4 a b8 g e' d16 c 
  b8 c16 ais a8 d16 c b8 d8. c16 b a 
  g2 g4 g 
  g c8 d g,4 a4. g16 f g4 c8 d e4. d8 e d16 c b4 d4. cis8 d a 
  a4 ais8 a16 g 
  f2 f8 g a d 
  d b g c16 b a4. g16 fis 
  e8 a b e4 c8 a d16 c 
  b2 c4. ais8 
  c16 ais c8 d g, c ais a b16 a 
  gis4 a2 gis4 
  e'2 e 
  b s4 d 
  d e8 d d4 e8 d16 c 
  b2 e4 e 
  d d8 c b4. a4 g fis8 g4 f8 g 
  a c4 ais b8 e, a16 g 
  fis2 b4 cis 
  d4. c16 b c8 fis,4 g16 a 
  g8 a4 g8 e'16 d c4 b16 a 
  b2 b8 ais a g 
  f4. e16 d e8 f16 g a8 b4 a16 gis a4. gis16 fis gis2. 
}


baixo = \relative c {
  e4. d8 c4 d 
  g,2 d'4 a8 b 
  c d e d c a d4 
  g,2 d'8 e f4. e8 f ais g e a a, 
  d2 d4. cis8 
  d f4 e8 f a4 gis8 
  a e4 d8 c a d4 
  g,2 c4 d8 e 
  f4 c cis d 
  e1 
  e8 d c2 b8 a 
  b4 e2 d4 
  e f c2 
  a4 d g,8 g'4 f e8 f fis g b,16 c d8 dis 
  e2 e8 c g' f 
  e4. d8 c b a b 
  c2 a8 b c d 
  e b c d g,4 d'8 e 
  f a, b cis d f, g a 
  d,2 d'8 e f d 
  ais b c4. cis8 d dis 
  e fis g e c a d4 
  g,2 c8 ais a g 
  f a ais b c cis d4. c16 b c8 d e2 
  e,4 e'2 d8 c 
  g'2 s4 g,8 a 
  b4 e,8 fis g b c d 
  g,2 e8 e' d c 
  b b'4 a8 g fis e4. b8 c d g,4 d'8 e 
  f fis g4. gis8 a a, 
  d2 g,8 g'4 fis16 e 
  fis8 b e,4. dis16 cis dis8 b 
  e fis g e c a d4 
  g,2 g'8 cis, d4. c8 b ais a4. gis8 
  a b c d e1 
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