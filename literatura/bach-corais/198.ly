
\version "2.10.33"

\header {
  title = "198 - Christus, der uns selig macht"
  composer = "J. S. Bach"
}

global =  {
  \time 4/4 
  \key a \minor
}

soprano = \relative c {
  e''4 e e e 
  d c b2 
  a4 gis a b8 c 
  d4 c b2 
  a4 b c8 b a4 
  a8 g f4 e2 
  d4 cis d e8 f 
  g4 f e2 
  a4 a a g 
  f e d2 
  g4 a b c 
  d e d c 
  b2 a4 b 
  c8 b a4 a8 g f4 
  e2 d4 cis 
  d e8 f g4 a 
  g f e2 
}


alto = \relative c {
  gis''8 a b gis a4 a 
  a8 e e4 e2 
  c8 d e4. fis8 gis a 
  b4. a8 a4 gis 
  a8 g f4 g4. f8 
  e4. d8 cis2 
  d8 g, a4 a8 b cis d 
  e4. d8 cis2 
  c4 f4. e16 d e4. d4 cis8 d2 
  b8 e4 d8 d4 e 
  f8 g4 a g8 g4 
  g2 e8 fis g4 
  g a8 g f e d4 
  d cis d8 a ais g 
  a b c d e4 f4. e4 d16 c b2 
}


tenor = \relative c {
  b'4 e8 d c d e c4 b a8 a4 gis 
  a b c d8 e 
  f e e4 e2 
  c4 d c4. d8 
  a4 a a2 
  f8 d e4 f g8 a 
  ais a a4 a2 
  a8 ais c4 c4. ais8 
  a4. a16 g f2 
  g8 c4 d16 c b8 d g, c4 b8 c e f4. e8 
  d2 c4 d 
  c4. cis8 d4 a 
  a2 a4 g8 e 
  f4 g c c16*7 ais16 a8 b16 a gis2 
}


baixo = \relative c {
  e8 fis gis e a b c a 
  fis gis a a, e'2 
  f4 e8 d c4 b8 a4 gis8 a c e2 
  f8 e d4 e f 
  cis d a2 
  ais4 a8 g f4 e8 d4 cis8 e f a2 
  f8 g a ais c4. cis8 
  d4 a d,2 
  e'4 fis g8 f e4 
  d8 g c,4. b8 c e 
  g2 a4 g8 f 
  e4 f8 e d e f g 
  a2 f4 e 
  d c4. ais8 a f 
  c'4 d e2 
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