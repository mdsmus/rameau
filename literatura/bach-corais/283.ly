
\version "2.10.33"

\header {
  title = "283 - Jesu, meine Freude"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key e \minor
}

soprano = \relative c {
  b''4 b a g 
  fis2 e 
  b'4 cis d b 
  e2 dis 
  e8 fis g4 fis4. fis8 
  e1 
  b4 b a g 
  fis2 e 
  b'4 cis d b 
  e2 dis 
  e8 fis g4 fis4. fis8 
  e1 
  b4 b c b 
  a a g2 
  b4 cis d b 
  e d cis2 
  b b4 b 
  a g fis2 
  e1 
}


alto = \relative c {
  r8 g'' b g g fis4 e8 
  e dis16 cis dis4 e8 dis e fis 
  g16 fis g8 r8 e a4. g16 fis 
  g8 a16 b a4 b r8 c 
  b a g b c a fis4 
  b8 gis e a gis2 
  r8 g b g g fis4 e8 
  e dis16 cis dis4 e8 dis e fis 
  g16 fis g8 r8 e a4. g16 fis 
  g8 a16 b a4 b r8 c 
  b a g b c a fis4 
  b8 gis e a gis2 
  g8 a a g g a a g 
  g4 fis g8 d e fis 
  g d g4 r8 a4 g16 fis 
  e8 g fis b b4 ais 
  b8 fis b a g8*5 fis4 e8 e d16 cis d4 
  d8 e16 d c b c8 b2 
}


tenor = \relative c {
  r8 b' e b e dis e g, 
  c b16 a b8 a g a g fis 
  e e r4. fis8 d' a 
  b a16 g e' dis e8 fis4 r4. dis8 e4. e8 d2 c16 b c8 b2 
  r8 b e b e dis e g, 
  c b16 a b8 a g a g fis 
  e e r4. fis8 d' a 
  b a16 g e' dis e8 fis4 r4. dis8 e4. e8 d2 c16 b c8 b2 
  e8 fis fis e e d d e 
  e4 d8 c c b c a 
  g b e a,4 g16 fis d'4. cis8 d e16 fis g8 cis, fis e 
  dis4 r8 b e e16 dis e4. dis8 e g, c a fis b 
  b gis e a4 gis8 gis4 
}


baixo = \relative c {
  r8 e g e c' r4 b8 
  a fis b b, e4 r4. e8 a g fis d g4. fis16 e c'4 b8 c b a 
  g fis e g a fis b a 
  gis e a a, e'2 
  r8 e g e c' r4 b8 
  a fis b b, e4 r4. e8 a g fis d g4. fis16 e c'4 b8 c b a 
  g fis e g a fis b a 
  gis e a a, e'2 
  e8 dis dis e e fis g e 
  c cis d4 g,2 
  r8 g'4 fis16 e fis8 d g fis 
  gis ais b g e f fis4 
  b,2 r8 e g e 
  c' r4 b8 a fis b a 
  gis e a a, e'2 
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