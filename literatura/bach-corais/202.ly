
\version "2.10.33"

\header {
  title = "202 - O wir armen Sünder"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key d \major
}

soprano = \relative c {
  a''4 a a a 
  b2 a 
  g4 fis e e 
  d1 
  a'4 a a a 
  b2 g 
  b4 b c b 
  a1 
  a4 a a a 
  d2 a4 a 
  b b a a 
  g1 
  a4 a a a 
  a2 fis 
  g4 fis e4. d8 
  d1 
  a'2 b 
  c1 
  a2 gis 
  a1 
  d2. e4 
  a,2 b 
  cis1 
  a2. gis4 
  a1 
  a4. g8 fis4 g 
  e2 d 
}


alto = \relative c {
  fis'4 g fis8 g a4. g16 fis g2 fis4 
  e4. d4 cis16 b cis4 
  a1 
  d4 cis8 d e cis d e 
  fis g fis4 e2 
  g4 gis a4. gis8 
  e1 
  fis4 fis8 e fis g a2 g4 fis fis 
  e8 dis e4 e d8 c 
  b1 
  e8 cis d e fis4 fis 
  e8 g fis e e dis16 cis dis4 
  e d8 d cis16 b cis4 d8 
  a1 
  fis'2 f4 e 
  e f8 g a4 g2 f4 e2 
  e1 
  b'2. a8 g 
  fis8*5 gis8 a4 
  gis2. cis,2 d8 e fis4 e8 d 
  e1 
  cis8 d e4. d8 d4. cis16 b cis4 a2 
}


tenor = \relative c {
  d'4 e e d 
  d2 d8*5 cis16 b a4 b a8 g 
  fis1 
  fis4 e a8 g fis4. e8 b'4 b2 
  e4 e e8 a, f' e 
  cis1 
  d4 d8 cis d e fis e 
  d c d4 d d8 c 
  b a g4. fis16 e fis4 
  g1 
  e8 g fis e d a' d4 
  d8 cis c4 b2 
  b4 b b8 g e a 
  fis1 
  a4 d2 c8 b 
  a4 g f e 
  d d'2 c8 b 
  cis1 
  fis,4 e8 fis g4 e 
  fis8 gis a2 fis4 
  cis' b8 a gis fis gis4 
  a b8 cis d2. d4 cis b 
  a16*9 b16 c4 b16 a 
  b8 e,4 fis16 g fis2 
}


baixo = \relative c {
  d4. cis8 d e fis d 
  g4 g, d'2 
  e4 fis g a8 a, 
  d1 
  d4 a8 b cis a d cis 
  dis e4 dis8 e2 
  e8 d c b a f d e 
  a1 
  d8 e fis g fis e d c 
  b a b cis d4 d 
  g8 fis e d c cis d dis 
  e1 
  cis8 a b cis d e fis g 
  a4 a, b2 
  e,8 g b a g e a4 
  d,1 
  d'2 gis, 
  a2. b8 c 
  d4 b e2 
  a,1 
  b2. cis4 
  d2 dis 
  e f 
  fis b, 
  a1 
  fis'4 cis d g, 
  gis a d,2 
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